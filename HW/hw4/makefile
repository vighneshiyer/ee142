srcdir  = .

main = $(notdir $(shell pwd))
figs = $(wildcard figs/*)

pdf : $(main).pdf #$(main)_solution.pdf
.PHONY: pdf

#	pdflatex -shell-escape "\newif\ifsolution \solutiontrue \input{$*}"

#%_solution.pdf: %.tex ../common.tex $(figs)
#	pdflatex -shell-escape -jobname=$*_solution "\def \issolution {1} \input{$*}"

%.pdf: %.tex ../common.tex $(figs)
	pdflatex -shell-escape "\def \issolution {0} \input{$*}"

clean :
	rm -rf *.pdf *.aux *.out *.log _minted*
