hclplot <- function(pal, collapse = NULL, maxchroma = NULL, xlab = NULL, ylab = NULL, main = NULL, ...) {
  
  HCL <- coords(as(hex2RGB(pal), "polarLUV"))[, c("H", "C", "L")]

  ## FIXME: put into separate function
  if(nrow(HCL) > 1L) {
    for(i in 2L:nrow(HCL)) {
      if ( any(is.na(HCL[(i-1L):i,])) ) next
      d <- HCL[i, "H"] - HCL[i - 1L, "H"]
      if (abs(d) > 320) HCL[i, "H"] <- HCL[i, "H"] - sign(d) * 360
      if (abs(HCL[i, "H"]) >  360) HCL[1L:i, "H"] <- HCL[1L:i, "H"] - sign(HCL[i, "H"]) * 360
    }

    # (2) Smoothing hue values in batches where chroma is very low
    idx <- which(HCL[, "C"] < 8)
    if (length(idx) == nrow(HCL)) {
      HCL[,"H"] <- mean(HCL[,"H"])
    } else if (length(idx) > 0L) {
      ## pre-smooth hue
      n <- nrow(HCL)
      if(n >= 49L) {
        HCL[, "H"] <- 1/3 * (
          HCL[c(rep.int(1L, 2L), 1L:(n - 2L)), "H"] +
          HCL[c(rep.int(1L, 1L), 1L:(n - 1L)), "H"] +
          HCL[                   1L:n,         "H"])
      }
      idxs <- split(idx, cumsum(c(1, diff(idx)) > 1))
      s <- 1L
      while(length(idxs) > 0L) {
        e <- if(s %in% idxs[[1L]]) {
          if(length(idxs) > 1L) idxs[[2L]] - 1L else n
        } else {
               if(n %in% idxs[[1L]]) n else round(mean(range(idxs[[1L]])))
        }
        io <- split(s:e, s:e %in% idx)
        if (length(io) == 2L & sum(!is.na(HCL[io[["FALSE"]],"H"])) > 0) {
          HCL[io[["TRUE"]], "H"] <- stats::spline(io[["FALSE"]], HCL[io[["FALSE"]], "H"],
            xout = io[["TRUE"]], method = "natural")$y
        }
        idxs[[1L]] <- NULL
        s <- e + 1L
      }
    }
  }

  if(is.null(collapse)) collapse <- if(abs(diff(range(HCL[, 3L], na.rm = TRUE))) < 5) "luminance" else "hue"
  collapse <- match.arg(collapse, c("hue", "luminance"))
  if(is.null(maxchroma)) maxchroma <- pmax(100, pmin(180, ceiling(max(HCL[, "C"], na.rm = TRUE)/20) * 20))

  ## FIXME: strange palettes need other interpolation/smoothing or better warning
  switch(collapse,
    "hue" = {
      nd <- expand.grid(C = 0:maxchroma, L = 0:100)
      if(diff(range(HCL[, "H"], na.rm = TRUE)) < 5) {
        nd$H <- mean(HCL[, "H"], na.rm = TRUE)
	if(is.null(main)) main <- paste("Hue =", round(nd$H[1L]))
      } else {
        m <- lm(H ~ C + L, data = as.data.frame(HCL))
	if(summary(m)$sigma > 7.5) warning("cannot approximate H well as a linear function of C and L")
        nd$H <- predict(m, nd)
	if(is.null(main)) main <- paste("Hue = [", round(min(nd$H, na.rm = TRUE)), ", ", round(max(nd$H, na.rm = TRUE)), "]", sep = "")
      }
      HCL2 <- hex(polarLUV(H = nd$H, C = nd$C, L = nd$L), fixup = FALSE)
      HCL2[nd$L < 1 & nd$C > 0] <- NA
      if(is.null(xlab)) xlab <- "Chroma"
      if(is.null(ylab)) ylab <- "Luminance"
      plot(0, 0, type = "n", xlim = c(0, maxchroma), ylim = c(0, 100), xaxs = "i", yaxs = "i",
        xlab = xlab, ylab = ylab, main = main)
      points(nd$C, nd$L, col = HCL2, pch = 19, cex = 3)
      points(HCL[, 2:3], pch = 21, bg = pal, cex = 2, type = "o")
    },
    "luminance" = {
      nd <- expand.grid(H = 0:180 * 2, C = 0:maxchroma)
      if(diff(range(HCL[, "L"], na.rm = TRUE)) < 5) {
        nd$L <- mean(HCL[, "L"], na.rm = TRUE)
	if(is.null(main)) main <- paste("Luminance =", round(nd$L[1L]))
      } else {
        m <- lm(L ~ C + H, data = as.data.frame(HCL))
	if(summary(m)$sigma > 7.5) warning("cannot approximate L well as a linear function of H and C")
        nd$L <- predict(m, nd)
        nd$L <- pmin(100, pmax(0, nd$L))
	if(is.null(main)) main <- paste("Luminance = [", round(min(nd$L, na.rm = TRUE)), ", ", round(max(nd$L, na.rm = TRUE)), "]", sep = "")
      }
      HCL2 <- hex(polarLUV(H = nd$H, C = nd$C, L = nd$L), fixup = FALSE)
      HCL2[nd$L < 1 & nd$C > 0] <- NA

      plot(0, 0, type = "n", axes = FALSE, xlab = "",ylab = "", main = main,
        xlim = c(-maxchroma, maxchroma), ylim = c(-maxchroma, maxchroma), asp = 1)
      xpos <- function(h, c) cos(h * pi/180) * c
      ypos <- function(h, c) sin(h * pi/180) * c
      points(xpos(nd$H, nd$C), ypos(nd$H, nd$C), col = HCL2, pch = 19, cex = 3)
      lines(xpos(0:360, maxchroma), ypos(0:360, maxchroma))
      
      axes <- TRUE ## FIXME: export as argument?
      if(axes) {
	if(is.null(xlab)) xlab <- "Chroma"
        if(is.null(ylab)) ylab <- "Hue"
        at.c <- if(maxchroma >= 150) 0:3 * 50 else 0:3 * 25
        at.h <- 0:6 * 60
        lines(c(0, maxchroma), c(0, 0))
        text(at.c, rep(-7, length(at.c)), at.c)
        text(50, -14, xlab)
        rect(at.c, 0, at.c, -3)
        if(0 %in% at.h | 360 %in% at.h) {
          lines(xpos(0, maxchroma + c(0, 3)), ypos(0, maxchroma + c(0, 3)))
          text(xpos(0, maxchroma + 7), ypos(0, maxchroma + 7), 0, pos = 3)
          text(xpos(0, maxchroma + 7), ypos(0, maxchroma + 7), 360, pos = 1)
          text(xpos(0, maxchroma + 16), ypos(0, maxchroma + 16), ylab)
        }
        at.h <- at.h[at.h > 0 & at.h < 360]
        for(hue in at.h) {
          text(xpos(hue, maxchroma + 7), ypos(hue, maxchroma + 7), hue)
          lines(xpos(hue, maxchroma + c(0, 3)), ypos(hue, maxchroma + c(0, 3)))
        }
      }
      points(xpos(HCL[, "H"], HCL[, "C"]), ypos(HCL[, "H"], HCL[, "C"]),
        pch = 21, bg = pal, cex = 2, type = "o")
    }
  )

  invisible(HCL)
}