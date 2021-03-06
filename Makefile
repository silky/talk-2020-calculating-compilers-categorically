TARG = compiling-gracefully

.PRECIOUS: %.tex %.pdf %.web

all: $(TARG).pdf

see: $(TARG).see

%.pdf: %.tex Makefile
	pdflatex $*.tex

# latex=latexmk -pdf -halt-on-error

# %.pdf: %.tex macros.tex bib.bib Makefile
# 	$(latex) $*.tex
# 	touch $@

# The previous rule always ran. Passing "-d" (debug) to make revealed that the
# PDFs were not getting updated by latexmk, so their prerequisites stay newer.
# Workaround: touch the PDF.

%.tex: %.lhs macros.tex formatting.fmt Makefile
	lhs2TeX -o $*.tex $*.lhs

showpdf = open -a Skim.app

%.see: %.pdf
	${showpdf} $*.pdf

clean:
	rm -f $(TARG).{tex,pdf,aux,nav,snm,ptb,log,out,toc}

web: web-token

STASH=conal@conal.net:/home/conal/web/talks
web: web-token

web-token: $(TARG).pdf
	scp $? $(STASH)
	touch $@
