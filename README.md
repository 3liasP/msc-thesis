# Tampere University theses using LaTeX

This repository contains a template for writing BSc and MSc (Tech) theses in Tampere University using the LaTeX system. The styles used try to match the official Word template as closely as possible (or is worth the while).

## Compilation

This template makes use of both `biblatex` and `glossaries` packages, and therefore needs a non-standard compilation sequence. The following should do the trick, as long as your main project file is named `main.tex`.

```
pdflatex main.tex
makeindex -s main.ist -t main.glg -o main.gls main.glo
biber main
pdflatex main.tex
pdflatex main.tex
```

## Usage notes

Go ahead and try to compile the template as is. The finished PDF file contains some directions for using the templates. More helpful instructions can be found in the files as comments.

This template is developed and maintained in Overleaf, and checked to compile under TeX Live 2020 (should also compile with up-to-date MikTeX). Please check your LaTeX distribution version and install the newest versions of the following packages if you run into issues while compiling.

* `pdfx`, `ìnputenc`, `babel`, `csquotes`, `hyperref`
* `fontenc`, `helvet`
* `geometry`, `fancyhdr`, `setspace`, `parskip`, `xcolor`, `titlesec`, `titletoc`
* `enumitem`, `graphicx`, `caption`, `listings`, `pdfpages`, `datetime2`
* `biblatex`, `glossaries`
* `accsupp`, `axessibility`, `pdfcomment`

You can find the template in [Overleaf](https://www.overleaf.com/read/bvvsnpvqvtst) as well. This is, however, the development version and more likely to be unstable or even broken!

## Bugs and improvements

Please use the **Issues** dialogue above if you have found something in the template that needs fixing, or if you have a suggestion for improvement. If you instead have something to ask about the template (clarifications on how to use it, how to accomplish something, etc.), please post your question to **Discussions**. Be sure to use the Q&A category.

All feedback (preferably in English, Finnish works too) is most welcome!

## Version history

See the [`CHANGELOG`](./CHANGELOG.md) file for what has been changed in the
past. The first commit to this Git repository corresponds to the tag `v2.0`,
so versions before that are not accessible.

## Contributing

To contribute to the project, read the guidelines in the file
[`CONTRIBUTING.md`](./CONTRIBUTING.md).
