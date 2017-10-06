srcdir  = .

main = $(notdir $(shell pwd))
figs = $(wildcard figs/*)

pdf : $(main).pdf
.PHONY: pdf

%.pdf: %.tex ../common.tex $(figs)
	texfot pdflatex -shell-escape $(main).tex

clean :
	rm -rf *.pdf *.aux *.out *.log _minted*
