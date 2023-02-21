# ---------------------------------------------------------------------------
# List of Files to be processed

RNW_SOURCES=slides

# ---------------------------------------------------------------------------

.PHONY: clean distclean

all: slides

slides: $(RNW_SOURCES:=.pdf) clean

script: $(RNW_SOURCES:=.R)

# ---------------------------------------------------------------------------
# Generic rules for creating files

%.tex: %.Rnw
	echo "knitr::knit('$<')" | R --no-save --no-restore --no-site-file --no-init-file

%.pdf: %.tex
	pdflatex $<
	pdflatex $<
	pdflatex $<

%.R: %.Rnw
	echo "knitr::purl('$<')" | R --no-save --no-restore --no-site-file --no-init-file

# ---------------------------------------------------------------------------
# Clear working space

clean:
	rm -f *~ Rplots.* *.aux *.log *.nav *.out *.snm *.toc *.vrb
	rm -rf figure/
	rm -f $(RNW_SOURCES:=.tex)

distclean: clean
	rm -f $(RNW_SOURCES:=.pdf)
	rm -f $(RNW_SOURCES:=.R)

# ---------------------------------------------------------------------------
