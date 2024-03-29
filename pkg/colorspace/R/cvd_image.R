#' Graphical User Interface to Check Images for Color Constraints
#'
#' A graphical user interface (GUI) to check an existing jpg/png image for (possible)
#' color constraints. The image will be converted to protanope vision, deuteranope vision,
#' and a desaturated version (monochromatic vision).
#' Allows a rapid check whether the colors used in the image show some
#' constraints with respect to color deficiency or color blindness.
#'
#' @param file If not set, an interactive GUI will be started. If \code{x} is of type
#'    \code{character} it has to be the full path to an image of type png or jpg/jpeg.
#'    The image will be converted and stored on disc, no GUI.
#' @param overwrite \code{logical}. Only used if \code{file} is provided. Allow the
#'    function to overwrite files on disc if they exist.
#' @param shiny.trace \code{logical}. Can be set to \code{TRUE} for more verbose
#'    output when the GUI is started (development flag). 
#' @author Reto Stauffer, Claus O. Wilke, Achim Zeileis
#' @rdname cvd_emulator
#' @references Zeileis A, Fisher JC, Hornik K, Ihaka R, McWhite CD, Murrell P, Stauffer R, Wilke CO (2020).
#' \dQuote{colorspace: A Toolbox for Manipulating and Assessing Colors and Palettes.}
#' \emph{Journal of Statistical Software}, \bold{96}(1), 1--49. \doi{10.18637/jss.v096.i01}
#' @export
cvd_emulator <- function(file, overwrite = FALSE, shiny.trace = FALSE) {

   # If input 'file' is missing: start interactive GUI
   if ( missing(file) ) {
      # Requirements for shiny application
      stopifnot(requireNamespace("shiny"), requireNamespace("shinyjs"))
      appDir <- system.file("cvdemulator", package = "colorspace")
      if (appDir == "")
         stop("Could not find cvdemulator app directory. Try re-installing `colorspace`.", call. = FALSE)
      # Start shiny
      options(shiny.trace = shiny.trace)
      pal <- shiny::runApp(appDir, display.mode = "normal", quiet = TRUE )

   # Do not start shiny: convert and save images on disc
   } else {
      is_img <- check_image_type(file)
      if ( ! is_img$png & ! is_img$jpg )
         stop(sprintf("Image \"%s\" is neither png nor jpg/jpeg. Stop.", file))
      types <- c("deutan","protan","tritan","desaturate")
      outfiles <- sprintf("%s/%s_%s", dirname(file), types,basename(file))
      # If overwrite is FALSE: check if files exist and stop if.
      if ( ! overwrite ) {
         for ( ofile in outfiles ) {
            if ( file.exists(ofile) )
               stop(sprintf(paste("Output file \"%s\" exists.",
                            "Please remove the image manually or call",
                            "cvd_emulator(\"%s\", overwrite = TRUE)"),
                            ofile, file))
         }
      }
      # Read image
      if ( is_img$png ) {
         in.img <- png::readPNG(file)
      } else {
         in.img <- jpeg::readJPEG(file)
      }
      # Convert and save image
      for ( type in types ) {
         outfile <- sprintf("%s/%s_%s",dirname(file),type,basename(file))
         cat(sprintf("Convert %-15s -> %s\n",type,outfile))
         out.img <- cvd_image(in.img, type, outfile) 
      }
   }
}

# Check Image Type Based on suffix
#
# Checking image file type based on image file name. Used to decide
# which package has to be used to read an image from disc (\code{png}/\code{jpeg}).
#
# @param x, \code{string} containing (full) path to image.
# @return Returns a \code{list} with two elements. Each can take
#    \code{TRUE} or \code{FALSE}. If image is of type \code{png}
#    \code{png=TRUE}, if image is of type \code{jpg/jpeg} \code{jpg=TRUE}.
#    If non of both, both will be \code{FALSE}. Method is not case sensitive.
check_image_type <- function( x ) {
   ## Identify file type (suffix)
   tail1 <- function(x) x[length(x)]
   suffix  <- tolower(tail1(strsplit(basename(x),"\\.")[[1]]))
   list("png" = suffix == "png",
        "jpg" = suffix %in% c("jpeg","jpg"))
}

# The convert function used
#' Convert Colors of an Image
#'
#' Used in \code{cvd_emulator}. Takes an image object and converts
#' the colors using \code{\link{deutan}}, \code{\link{protan}},
#' \code{\link{tritan}}, \code{\link{desaturate}} functions. The image
#' will be written to disc as a PNG file.
#'
#' @param img \code{character} or \code{array} as returned by \code{readPNG} and \code{readJPEG}
#'    of size \code{height x width x depth}. The depth coordinate contains
#'    R/G/B and alpha if given (png). In case of a single character string \code{img}
#'    has to be the full path to an image of type png or jpg/jpeg.
#' @param type \code{string} name of the function which will be used to
#'    convert the colors (\code{deutan}, \code{protan}, \code{tritan}, \code{desaturate}).
#'    If set to \code{original} the image will be written as is.
#' @param file \code{string} with (full) path to resulting image. Has to
#'    be a png image name.
#' @param severity numeric. Severity of the color vision defect, a number between 0 and 1.
#' @param linear logical. Should the color vision deficiency transformation be applied to the
#' linearized RGB coordinates (default)? If \code{FALSE}, the transformation is applied to the
#' gamma-corrected sRGB coordinates (which was the default up to version 2.0-3 of the package).
cvd_image <- function(img, type, file, severity = 1, linear = TRUE) {

   # read image if necessary
   if(is.character(img) && length(img) == 1L) {
     img_type <- check_image_type(img)
     if (!img_type$png & !img_type$jpg) stop(sprintf("Image \"%s\" is neither png nor jpg/jpeg.", img))
     img <- if (img_type$png) png::readPNG(img) else jpeg::readJPEG(img)
   }

   # optionally save original colors
   if (type == "original") {
      png::writePNG(img, target = file)
      return(TRUE)
   }

   # otherwise set up sRGB object, carry out cvd emulation, write back
   RGB <- matrix(as.numeric(img[,,1L:3L]), ncol = 3L, dimnames = list(NULL, c("R", "G", "B")))
   RGB <- colorspace::sRGB(RGB)
   RGB <- do.call(type, list(col = RGB, severity = severity, linear = linear))
   RGB <- colorspace::coords(RGB)
   img[,,1L] <- matrix(RGB[,"R"], dim(img)[1L], dim(img)[2L])
   img[,,2L] <- matrix(RGB[,"G"], dim(img)[1L], dim(img)[2L])
   img[,,3L] <- matrix(RGB[,"B"], dim(img)[1L], dim(img)[2L])
   png::writePNG(img, target = file)
   return(TRUE)
}
