AUXS=pr.aux conf.aux post.aux talk.aux mthd.aux code.aux
BBLS=pr.bbl conf.bbl post.bbl talk.bbl mthd.bbl code.bbl

all: cv.pdf

cv.pdf: $(BBLS)
	pdflatex cv
	pdflatex cv

$(AUXS): cv.tex self.bib
	pdflatex cv

$(BBLS): %.bbl: %.aux
	bibtex $<

clean:
	rm *.pdf *.aux *.bbl *.log *.out *.blg
