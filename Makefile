buaathesis.cls:
	xelatex buaathesis.dtx
	xelatex buaathesis.ins

bachelor: buaathesis.cls
	xelatex sample-bachelor.tex
	-biber  sample-bachelor.aux
	xelatex sample-bachelor.tex
	xelatex sample-bachelor.tex

master: buaathesis.cls
	xelatex sample-master.tex
	-biber  sample-master.aux
	xelatex sample-master.tex
	xelatex sample-master.tex

kaitireport: buaathesis.cls
	xelatex sample-kaitireport.tex
	-biber  sample-kaitireport.aux
	xelatex sample-kaitireport.tex
	xelatex sample-kaitireport.tex

clean:
	find . -name '*.aux' -print0 | xargs -0 rm -rf
	rm -rf *.lof *.log *.lot *.out *.toc *.bbl *.blg *.thm

depclean: clean
	rm -rf *.pdf
