# LaTeX flags
#LATEXFLAGS:= -shell-escape --output-directory=auxiliary
#LATEXFLAGS = -shell-escape -interaction=nonstopmode -file-line-error --output-directory=auxiliary
LATEXFLAGS = -shell-escape --output-directory=auxiliary
texengine:= lualatex
.PHONY: %-full

# LaTeX sourcecode of slides
SRC = hdr
FIGDIR = figures
PDFREADER = zathura

%.pdf: %.tex
	$(texengine) $(LATEXFLAGS) $<
	#$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	mv auxiliary/$(basename $(notdir $@)).pdf pdf/$*.pdf
	notify-send -t 2500 "Makefile latex" "Compiler $< en pdf est fini."

%.pdf-silent: %.tex
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	#mv auxiliary/$(basename $(notdir $@)).pdf pdf/$(basename $(notdir $@)).pdf
	mv auxiliary/$(basename $(notdir $@)).pdf pdf/$*.pdf
	notify-send -t 2500 "Makefile latex" "Compiler $< en pdf est fini."

%-full: %.tex  
	$(texengine) $(LATEXFLAGS) $<
	$(texengine) $(LATEXFLAGS) $<
	biber auxiliary/$*
	$(texengine) $(LATEXFLAGS) $<
	$(texengine) $(LATEXFLAGS) $<
	mv auxiliary/$*.pdf pdf/$*.pdf
	notify-send -t 1000 "Makefile latex" "Compiler $< en pdf est fini."

%-full-silent: %.tex  
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	biber auxiliary/$*
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	$(texengine) $(LATEXFLAGS) $< | grep -i ".*:[0-9]*:.*\|warning"
	mv auxiliary/$*.pdf pdf/$*.pdf
	notify-send -t 1000 "Makefile latex" "Compiler $< en pdf est fini."


foo:
	notify-send -t 1000 "coucou" -u critical

clean:		
		rm -f *.aux *.log *.out *.ps *.toc *.nav *.snm *.dvi *.blg *.bbl *.nlo *.mtc* *.brf *.maf *.tdo
		rm -f auxiliary/*
