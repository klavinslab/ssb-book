NAME = ssb
BIBTEX = bibtex
LATEX = latex
DVIPS = dvips -j0 -tletter -Ppdf # -p =9 -n 8
DVIPDF = dvipdf
PS2PDF = ps2pdf -dMaxSubsetPct=100 -dCompatibilityLevel=1.2 -dSubsetFonts=true -dEmbedAllFonts=true
FILES = $(NAME).tex intro.tex odes.tex mak.tex singular.tex mathematica.tex in-vivo.tex in-vitro.tex composition.tex

all: ps pdf

dvi: $(NAME).dvi

ps: $(NAME).ps

pdf: $(NAME).pdf

simp: $(NAME).tex
	$(LATEX) $(NAME).tex

$(NAME).aux: $(FILES) refs.bib
	$(LATEX) $(NAME).tex

$(NAME).bbl: $(NAME).aux refs.bib
	$(BIBTEX) $(NAME)

$(NAME).dvi: $(NAME).aux $(NAME).bbl
	$(LATEX) $(NAME).tex
	$(LATEX) $(NAME).tex

$(NAME).ps: $(NAME).dvi
	$(DVIPS) $(NAME).dvi -o $(NAME).ps

$(NAME).pdf: $(NAME).ps
	$(PS2PDF) $(NAME).ps  

clean:
	rm -f *.dvi *.ps *.pdf *.bbl *.blg *.log *.aux *~ 

cite:
	$(LATEX) $(NAME).tex | grep Citation | awk '{print $$4}'

