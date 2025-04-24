# LaTeX flags
#LATEXFLAGS = -interaction=nonstopmode
LATEXFLAGS = -shell-escape -interaction=nonstopmode -file-line-error --output-directory=auxiliary
texengine:= lualatex
#texengine:= xelatex

# LaTeX sourcecode of slides
SRC = hdr
FIGDIR = figures
PDFREADER = zathura

%.pdf: %.tex
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	mv auxiliary/$(basename $(notdir $@)).pdf $(basename $(notdir $@)).pdf
	notify-send -t 2500 "Makefile latex" "Compiler $< en pdf est fini."

quick: hdr.tex
	$(texengine) $(LATEXFLAGS) $<
	mv auxiliary/$(basename $(notdir ${SRC})).pdf $(basename $(notdir ${SRC})).pdf

hdr.pdf: hdr.tex
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	biber auxiliary/$(basename $(notdir $@))
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	#$(texengine) $(LATEXFLAGS) $<
	mv auxiliary/$(basename $(notdir $@)).pdf $(basename $(notdir $@)).pdf
	notify-send -t 2500 "Makefile latex" "Compiler $< en pdf est fini."

%-full-silent: %.tex  
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	echo "2e run"
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	biber auxiliary/$*
	echo "3e run"
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	echo "4e run"
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	#echo "5e run"
	#$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	mv auxiliary/$*.pdf $*.pdf
	notify-send -t 1000 "Makefile latex" "Compiler $< en pdf est fini."

%-full: %.tex  
	$(texengine) $(LATEXFLAGS) $<
	$(texengine) $(LATEXFLAGS) $<
	biber auxiliary/$*
	$(texengine) $(LATEXFLAGS) $<
	$(texengine) $(LATEXFLAGS) $<
	$(texengine) $(LATEXFLAGS) $<
	mv auxiliary/$*.pdf $*.pdf
	notify-send -t 1000 "Makefile latex" "Compiler $< en pdf est fini."

final: hdr-cv.pdf
	cp hdr-cv.pdf ../../Envoi-04février2024/HDR-FournierSniehotta-ManuscritCV.pdf

hdr-cv.pdf: hdr.pdf Appendices/cv-rfs.pdf 
	pdftk hdr.pdf dump_data output hdr-temp.txt
	pdftk hdr.pdf cat 1-r2 output hdr-temp.pdf
	pdftk hdr-temp.pdf Appendices/cv-rfs.pdf cat output hdr-cv-temp.pdf
	pdftk hdr-cv-temp.pdf update_info hdr-temp.txt output hdr-cv.pdf
	rm hdr-temp.pdf hdr-cv-temp.pdf hdr-temp.txt

clean:		
		rm -f *.log *.out *.ps *.nav *.snm *.dvi *.nlo 
		rm -f auxiliary/*

tidy:		
		rm -f *.aux *.log *.out *.ps *.toc *.nav *.snm *.dvi *.blg *.bbl *.nlo *.mtc* *.brf *.maf *.tdo
		rm -f Chapters/*.aux Appendices/*.aux preamble/*.aux

preview:
	echo -e "awful.tag.viewmore({tags[1][6],awful.tag.selected(1)})" | awesome-client
	$(PDFREADER) $(SRC).pdf

these_complete:
	pdflatex $(LATEXFLAGS) $(SRC).tex
	pdflatex $(LATEXFLAGS) $(SRC).tex
	#bibtex auxiliary/$(SRC)
	biber auxiliary/$(SRC)
	pdflatex $(LATEXFLAGS) $(SRC).tex
	pdflatex $(LATEXFLAGS) $(SRC).tex
	mv auxiliary/$(SRC).pdf $(SRC).pdf

#figures:
#	load_makefile ../Calculs/Makefile 
#
figures:
	make -C $(FIGDIR) figures
