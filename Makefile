.PHONY: help pdf tex tex2pdf

BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)/source
OUTPUTDIR=$(BASEDIR)/output
STYLEDIR=$(BASEDIR)/style

help:
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make pdf                         generate a PDF file                '
	@echo '   make tex                         generate a Latex file              '
	@echo '                                                                       '
	@echo 'get local templates with: pandoc -D latex/html/etc                     '
	@echo 'or generic ones from: https://github.com/jgm/pandoc-templates          '

pdf:
	pandoc --verbose \
	--include-in-header="$(STYLEDIR)"/preamble.tex \
	metadata.yaml "$(INPUTDIR)"/*.md \
	--template="$(STYLEDIR)/template.tex" \
	-V fontsize=12pt \
	-V papersize:a4paper \
	-V documentclass=report \
	--filter pandoc-crossref \
	-o $(OUTPUTDIR)/thesis.pdf

tex:
	pandoc --verbose --wrap=none \
	--include-in-header="$(STYLEDIR)"/preamble.tex \
	metadata.yaml "$(INPUTDIR)"/*.md \
	--template="$(STYLEDIR)/template.tex" \
	-V fontsize=12pt \
	-V papersize:a4paper \
	-V documentclass=report \
	--filter pandoc-crossref \
	-s -o $(OUTPUTDIR)/thesis.tex

tex2pdf:
	pdflatex -output-directory="$(OUTPUTDIR)" thesis.tex
	pdflatex -output-directory="$(OUTPUTDIR)" thesis.tex
	rm "$(OUTPUTDIR)"/thesis.{aux,log,out,toc}