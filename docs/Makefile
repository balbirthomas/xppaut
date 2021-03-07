docs:
	latex xpp_doc
	latex xpp_doc
	latex xpp_doc
	dvips -o xpp_doc.ps xpp_doc
	ps2pdf xpp_doc.ps
	latex xpp_sum
	latex xpp_sum
	dvips -o xpp_sum.ps xpp_sum
	ps2pdf xpp_sum.ps
	latex install.tex
	latex install.tex
	dvips -o install.ps install
	ps2pdf install.ps

clean:
	$(RM) *.aux *.log *.toc *.dvi *.out *.ps
