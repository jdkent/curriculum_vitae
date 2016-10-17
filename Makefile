BUILD=build
AUXS=$(BUILD)/pr.aux $(BUILD)/conf.aux $(BUILD)/post.aux $(BUILD)/talk.aux \
	 $(BUILD)/mthd.aux $(BUILD)/code.aux
BBLS=$(BUILD)/pr.bbl $(BUILD)/conf.bbl $(BUILD)/post.bbl $(BUILD)/talk.bbl \
	 $(BUILD)/mthd.bbl $(BUILD)/code.bbl

all: $(BUILD)/cv.pdf

$(BUILD)/cv.pdf: $(BBLS)
	pdflatex -output-directory=$(BUILD) cv
	pdflatex -output-directory=$(BUILD) cv
	touch $^ $@

$(AUXS): cv.tex self.bib cvbib.bst
	pdflatex -output-directory=$(BUILD) cv

%.bbl: %.aux
	bibtex $<

cvbib.bst: cvbib.dbj
	latex $<

upload: $(BUILD)/cv.pdf
	touch $(BUILD)/.nojekyll
	git -C $(BUILD) init
	git -C $(BUILD) checkout -b gh-pages
	git -C $(BUILD) add cv.pdf .nojekyll
	git -C $(BUILD) commit -m 'PDF build'
	git -C $(BUILD) remote add origin `git remote get-url --push origin`
	git -C $(BUILD) push origin gh-pages --force
	rm -rf $(BUILD)/.git

clean:
	rm $(BUILD)/*.pdf $(AUXS) $(BBLS) $(BUILD)/*.log \
		$(BUILD)/*.out $(BUILD)/*.blg
