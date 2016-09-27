AUXS=pr.aux conf.aux post.aux talk.aux mthd.aux code.aux
BBLS=pr.bbl conf.bbl post.bbl talk.bbl mthd.bbl code.bbl

all: cv.pdf

cv.pdf: $(BBLS)
	pdflatex cv
	pdflatex cv
	touch $(AUXS) $(BBLS) cv.pdf

$(AUXS): cv.tex self.bib cvbib.bst
	pdflatex cv

$(BBLS): %.bbl: %.aux
	bibtex $<

cvbib.bst: cvbib.dbj
	latex $<

clean:
	rm *.pdf *.aux *.bbl *.log *.out *.blg
