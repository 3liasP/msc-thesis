# LaTeX root file configuration
# This file tells LaTeX Workshop that main.tex is always the root file
$pdf_mode = 4; # Use lualatex
$lualatex = 'lualatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$clean_ext = 'auxlock nav snm vrb brf nlo nls run.xml bcf xmpdata';