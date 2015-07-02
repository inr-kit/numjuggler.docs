# see http://stackoverflow.com/questions/12343428/latex-reference-and-makefile

.DELETE_ON_ERROR:

.PHONY: examples

command = pdflatex -shell-escape

slides.pdf: slides.tex 
	$(command) slides 
	while grep 'Rerun to get ' slides.log; do $(command) slides ; done

slides.tex: slides.md preamble.tex examples
	# generate tex with pandoc
	pandoc -t beamer slides.md -H preamble.tex -B b_preamble.tex -o raw_slides.tex
	# hand-made modifications to tex:
	sed "1s/ignorenonframetext,/8pt/" raw_slides.tex | sed 's/\\titlepage/\\maketitle/' > slides.tex

examples:
	$(MAKE) -C examples

clean:
	-rm *.aux
	-rm *.log
	-rm *.nav
	-rm *.out
	-rm *.pdf
	-rm *.snm
	-rm *.toc
	-rm *.vrb
	-rm *.pyg
	-rm raw*.tex

clean-examples:
	$(MAKE) -C examples clean
