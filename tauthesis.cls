%% tauthesis.cls
%% Copyright 2023 Tampere University
%
% This work may be distributed and/or modified
% under the conditions of the LaTeX Project Public
% License, either version 1.3 of this license or
% (at your option) any later version.
%
% The latest version of this license is in
%   http://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX
% version 2005/12/01 or later.
%
% This work has the LPPL maintenance status `maintained'.
%
% The Current Maintainer of this work is
%
%   Santtu Söderholm <santtu.soderholm (at) tuni.fi>
%
% This work consists of the files tauthesis.cls.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{tauthesis}
[Thesis styles used in Tampere University]

\RequirePackage{ifluatex}

\ifluatex
  % Everything is fine and dandy.
\else
  \PackageError{tauthesis}{This class requires LuaLaTeX to compile}{Please compile your document with LuaLaTeX.}
  \expandafter\stop
\fi

% Load the expl3 package and l3keys2e module

\RequirePackage{expl3}

% Turn : and _ to normal letters that can be used in creating variables.
% Also makes whitespace insignificant.

\ExplSyntaxOn

% Turn @ into an acceptable variable name letter.

\makeatletter

% Define error message for use below.

\msg_new:nnnn
    { tauthesis }
    { unknown-mainlanguage }
    { Unknown~value~for~keyword~argument~mainlanguage. }
    { Valid~values~are~~'finnish'~and~'english'. }

\msg_new:nnnn
    { tauthesis }
    { unknown-fithesistype }
    { Unknown~value~for~keyword~argument~fithesistype. }
    { Valid~values~are~'kandidaatti',~'maisteri'~and~'diplomi'. }

\msg_new:nnnn
    { tauthesis }
    { unknown-enthesistype }
    { Unknown~value~for~keyword~argument~fithesistype. }
    { Valid~values~are~'bachelor'~and~'master'. }

% Settings based on language.

\newif\if@customcitation\@customcitationtrue
\newif\if@apacitation\@apacitationfalse

\newif\if@langenglish\@langenglishfalse
\newif\if@taunotdraftmode\@taunotdraftmodetrue
\newif\if@programs\@programsfalse

% Define keyword arguments for this class file using LaTeX3 syntax.

\tl_new:N \@tauthesis@enthesistype

\tl_new:N \@tauthesis@fithesistype

\tl_new:N \@tauthesis@thesistype

\tl_new:N \@tauthesis@school

\DeclareKeys[tauthesis]
{
    author.store = \@tauthesis@author,

    citationsorting.store = \@tauthesis@citationsorting,

    citationstyle.store = \@tauthesis@citationstyle,

    enfacultyname.store = \@tauthesis@enfacultyname,

    enkeywords.store = \@tauthesis@enkeywords,

    enprogrammename.store = \@tauthesis@enprogrammename,

    ensubtitle.store = \@tauthesis@ensubtitle,

    enthesistype .choice:,

    enthesistype / bachelor .code:n =
        \tl_set:Nn \@tauthesis@enthesistype {Bachelor's~thesis}
    ,

    enthesistype / master .code:n =
        \tl_set:Nn \@tauthesis@enthesistype {Master's~thesis}
    ,

    enthesistype / unknown .code:n =
        \msg_error:nneee
            { tauthesis }
            { unknown-enthesistype }
            { enthesistype }     % Name of key.
            { bachelor, master } % Valid choices
            { \exp_not:n {#1} }  % Invalid choice given
    ,

    entitle.store = \@tauthesis@entitle,

    examiners.store = \@tauthesis@examiners,

    fifacultyname.store = \@tauthesis@fifacultyname,

    fikeywords.store = \@tauthesis@fikeywords,

    fiprogrammename.store = \@tauthesis@fiprogrammename,

    fisubtitle.store = \@tauthesis@fisubtitle,

    fithesistype .choice:,

    fithesistype / kandidaatti .code:n =
        \tl_set:Nn \@tauthesis@fithesistype {Kandidaatintyö}
    ,

    fithesistype / maisteri .code:n =
        \tl_set:Nn \@tauthesis@fithesistype {Pro~gradu~-tutkielma}
    ,

    fithesistype / diplomi .code:n =
        \tl_set:Nn \@tauthesis@fithesistype {Diplomityö}
    ,

    fithesistype / unknown .code:n =
        \msg_error:nneee
            { tauthesis }
            { unknown-fithesistype }
            { fithesistype }                   % Name of key.
            { kandidaatti, maisteri, diplomi } % Valid choices
            { \exp_not:n {#1} }                % Invalid choice given
    ,

    fititle.store = \@tauthesis@fititle,

    mainlanguage .choice:,

    mainlanguage / finnish .code:n = {
        \newcommand{\@mainlanguage}{finnish}
        \newcommand{\@otherlanguage}{english}
        \newcommand{\@tauthesis@mainlanguage}{finnish}
        \newcommand{\@abstractname}{Tiivistelmä}
        \newcommand{\@otherabstractname}{Abstract}
        \newcommand{\@university}{Tampereen~yliopisto}
        \newcommand{\@otheruniversity}{Tampere~University}
        \newcommand{\@keywordname}{Avainsanat}
        \newcommand{\@otherkeywordname}{Keywords}
        \newcommand{\@prefacename}{Alkusanat}
        \newcommand{\@originalitytext}{\@finoriginalitytext}
        \newcommand{\@otheroriginalitytext}{\@engoriginalitytext}
        \newcommand{\@logofile}{figures/tau-logo-fin-eng.eps}
        \newcommand{\@aidisclaimertitle}{Tekoälyn~käyttö~tässä~työssä}
        \newcommand{\@aidisclaimerfile}{tex/tekoalyn-kaytto.tex}
        \newcommand{\@yestextcmd}{Kyllä}
        \newcommand{\@notextcmd}{Ei}
        \tl_set:Nn \@tauthesis@school {Tampereen~yliopisto}
        \tl_set:Nn \@tauthesis@thesistype {\tl_use:N\@tauthesis@fithesistype}
        \@langenglishfalse
    },

    mainlanguage / english .code:n = {
        \newcommand{\@mainlanguage}{english}
        \newcommand{\@otherlanguage}{finnish}
        \newcommand{\@tauthesis@mainlanguage}{english}
        \newcommand{\@abstractname}{Abstract}
        \newcommand{\@otherabstractname}{Tiivistelmä}
        \newcommand{\@university}{Tampere~University}
        \newcommand{\@otheruniversity}{Tampereen~yliopisto}
        \newcommand{\@keywordname}{Keywords}
        \newcommand{\@otherkeywordname}{Avainsanat}
        \newcommand{\@prefacename}{Preface}
        \newcommand{\@originalitytext}{\@engoriginalitytext}
        \newcommand{\@otheroriginalitytext}{\@finoriginalitytext}
        \newcommand{\@logofile}{figures/tau-logo-fin-eng.eps}
        \newcommand{\@aidisclaimertitle}{Use~of~artificial~intelligence~in~this~work}
        \newcommand{\@aidisclaimerfile}{tex/use-of-ai.tex}
        \newcommand{\@yestextcmd}{Yes}
        \newcommand{\@notextcmd}{No}
        \tl_set:Nn \@tauthesis@school {Tampere~University}
        \tl_set:Nn \@tauthesis@thesistype {\tl_use:N\@tauthesis@enthesistype}
        \@langenglishtrue
    },

    mainlanguage / unknown .code:n =
        \msg_error:nneee
            { tauthesis }
            { unknown-mainlanguage }
            { mainlanguage }     % Name of key.
            { finnish, english } % Valid choices
            { \exp_not:n {#1} }  % Invalid choice given
    ,

    subject.store = \@tauthesis@subject,
}

% Process the key--value arguments.

\ExplSyntaxOff

\ProcessKeyOptions[tauthesis]

% Inherit from the report document class.
% Use 12pt nonetheless and scale fonts back
% to make maths closer to actual font size.
\LoadClass[12pt, a4paper]{report}

% Font selection

\RequirePackage{fontspec}

\setmainfont[
  Path = fonts/Roboto/,
  Extension = .ttf,
  UprightFont = *-Regular,
  BoldFont = *-Bold,
  ItalicFont = *-Italic,
  BoldItalicFont = *-BoldItalic
]{Roboto}

\setmonofont[
    Path = fonts/FiraMono/,
    Extension = .ttf,
    BoldFont = *-Bold,
    MediumFont = *-Medium,
    UprightFont = *-Regular,
]{FiraMono}

\usepackage{unicode-math}

\setmathfont{STIXTwoMath-Regular.ttf}[
  Path = fonts/STIXTwo/
]

\usepackage{newunicodechar}

% Check to see if this font is installed system-wide
\IfFontExistsTF{NotoSansSymbols2}{%
% One person has this installed system-wide
    \newfontfamily\fallbackfont{NotoSansSymbols2}
}{
    % If not, load it from the file
    \newfontfamily\fallbackfont{NotoSansSymbols2}[
        Path = fonts/NotoSansSymbols2/, % Specify the path to the font file
        Extension = .ttf,  % Specify the file extension if needed
        UprightFont = *-Regular,
    ]
}

\newunicodechar{☒}{{\fallbackfont ☒}}
\newunicodechar{☐}{{\fallbackfont ☐}}

%%%%% PACKAGES AND RELATED DEFINITIONS %%%%%

% Page geometry and heading handling
\RequirePackage[
    top=2.5cm,
    bottom=2.5cm,
    left=4cm,
    right=2cm
]{geometry}
\special{papersize={210mm,297mm}}
\RequirePackage{fancyhdr}
\RequirePackage[explicit]{titlesec}
\RequirePackage{titletoc}
\RequirePackage{tocloft}
\RequirePackage{setspace}
\RequirePackage{parskip}
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{listings}

\setstretch{1.213}
\setlength{\headheight}{14.5pt}

\newlength\chapterspace
\setlength\chapterspace{0.4cm}
\newlength\chapterindent
\setlength\chapterindent{0.5in}

% Try to prevent large figures appearing
% by themselves without any text. Be
% careful not to make \floatpagefraction
% larger than \topfraction.
\renewcommand{\topfraction}{0.85}        % default 0.7
\renewcommand{\textfraction}{0.1}        % default 0.2
\renewcommand{\floatpagefraction}{0.75}

% Define the header and footer content.

\pagestyle{fancyplain}
\fancyhf{}
\rhead{\thepage}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0pt}

% Define chapter and section heading styles.

\setcounter{secnumdepth}{2}
\setcounter{tocdepth}{2}

% Chapter
\titleformat
    {\chapter}[block]{\raggedright\bf\fontsize{21pt}{12pt}\selectfont%
    \parshape %
    2 %
    0pt \linewidth %
    \chapterindent \dimexpr\linewidth-\chapterindent}
    {\makebox[\chapterindent][l]{\thechapter.}}{0em}
    {\fancyhf{}\rhead{\thepage}\textsc{#1}}
\titleformat
    {name=\chapter, numberless}
    {\raggedright\bf\fontsize{21pt}{12pt}\selectfont}{}{0em}
    {\fancyhf{}\rhead{\thepage}\textsc{#1}}
\titlespacing{\chapter}{0em}{42pt}{42pt}
\titlespacing{name=\chapter, numberless}{0em}{18pt}{18pt}

% Section
\titleformat
    {\section}[block]{\raggedright\bf\fontsize{17pt}{12pt}\selectfont%
    \parshape %
    2 %
    0pt \linewidth %
    \chapterindent \dimexpr\linewidth-\chapterindent}
    {\makebox[\chapterindent][l]{\thesection}}{0em}{\textsc{#1}}
\titleformat
    {name=\section, numberless}
    {\raggedright\bf\fontsize{17pt}{12pt}\selectfont}{}{0em}{\textsc{#1}}
\titlespacing{\section}{0em}{18pt}{12pt}
\titlespacing{name=\section, numberless}{0em}{18pt}{12pt}

% Subsection
\titleformat
    {\subsection}[block]{\raggedright\bf\fontsize{13pt}{12pt}\selectfont%
    \parshape %
    2 %
    0pt \linewidth %
    \chapterindent \dimexpr\linewidth-\chapterindent}
    {\makebox[\chapterindent][l]{\thesubsection}}{0em}{\textsc{#1}}
\titleformat
    {name=\subsection, numberless}
    {\raggedright\bf\fontsize{13pt}{12pt}\selectfont}{}{0em}{\textsc{#1}}
\titlespacing{\subsection}{0em}{18pt}{12pt}
\titlespacing{name=\subsection, numberless}{0em}{18pt}{12pt}

% Subsubsection
%\titleformat
%    {\subsubsection}{\raggedright\bf\normalsize}
%    {\thesubsubsection}{\chapterspace}{\textsc{#1}}
\titleformat
    {name=\subsubsection, numberless}
    {\raggedright\bf\normalsize}{}{0em}{\textsc{#1}}
\titlespacing{\subsubsection}{0em}{18pt}{12pt}
\titlespacing{name=\subsubsection, numberless}{0em}{18pt}{12pt}

% Language support for Finnish and English
\RequirePackage[\@otherlanguage, main=\@mainlanguage]{babel}
\RequirePackage{csquotes}

% Powerful color package
\RequirePackage{xcolor}
\RequirePackage{colortbl}
\definecolor{taupurple}{RGB}{78,0,148}

% Date and time handling
\RequirePackage[en-GB,finnish]{datetime2}
\DTMlangsetup[en-GB,finnish]{showdayofmonth=false}

% Smart bibliography handling
\RequirePackage
    [backend=biber,
    citestyle=\@tauthesis@citationstyle,
    bibstyle=\@tauthesis@citationstyle,
    sorting=\@tauthesis@citationsorting,]{biblatex}

\DefineBibliographyStrings{finnish}{%
    bibliography = {Lähteet},
    references = {Lähteet},
    andothers = {ym\adddot}
}
\DefineBibliographyStrings{english}{%
    bibliography = {References},
    references = {References}
}

\if@apacitation
    \DeclareLanguageMapping{english}{english-apa}
\fi

\let\bibLaTeXPrintBibliography\printbibliography

\RenewDocumentCommand\emph{m}{\textit{\color{taupurple}#1}}

\RenewDocumentCommand\printbibliography{O{}}{%
    % This is needed or titles will be colored taupurple in the bibliography.
    \RenewDocumentCommand\emph{m}{\textit{\color{black}##1}}%
    \bibLaTeXPrintBibliography[#1]%
}

% Graphics inclusion and drawing
\RequirePackage{graphicx}

% Caption formatting
\RequirePackage
    [labelfont={bf,color=taupurple},
    labelsep=colon]{caption}

\renewcommand{\arraystretch}{1.25}

% Code listing handling
\if@programs
    \RequirePackage{listings}
    % textcl=true courtesy of Mika Kuitula
    \lstset{texcl=true, captionpos=b, commentstyle=\tt}
\fi

% List of symbols and abbreviations
\RequirePackage[automake, nonumberlist, nopostdot]{glossaries}

\if@langenglish
    \newcommand{\@glossaryname}{List of Symbols and Abbreviations}
    \newcommand{\@appendixname}{Appendix}
\else
    \newcommand{\@glossaryname}{Lyhenteet ja merkinnät}
    \newcommand{\@appendixname}{Liite}
\fi

\newlength\glsnamewidth
\newglossarystyle{taulong}{%
    \setglossarystyle{long}%
    \renewenvironment{theglossary}{%
      \tablehead{}%
      \tabletail{}%
      \begin{longtable}{p{\glsnamewidth}p{\glsdescwidth}}%
    }{%
      \end{longtable}%
    }%
    \renewcommand{\glossentry}[2]{%
    \raggedright
    \glsentryitem{##1}\glstarget{##1}{\glossentryname{##1}} &
    \glossentrydesc{##1}\glspostdescription\space ##2\tabularnewline
    }%
}

% Table of contents formatting

\RequirePackage{titletoc}

\def\myChapterFontSize{12pt}
\def\mySectionFontSize{12pt}
\def\mySubSectionFontSize{12pt}
\def\mySubSubSectionFontSize{12pt}

\def\myChapterIndent{0em}
\def\mySectionIndent{1em}
\def\mySubSectionIndent{2em}
\def\mySubSubSectionIndent{3em}

\def\myChapterNumberWidth{2em}
\def\mySectionNumberWidth{2em}
\def\mySubSectionNumberWidth{3.2em}
\def\mySubSubSectionNumberWidth{3.7em}

\def\mySectionNumberWidth{3em}

\def\myToCPageNumberSize{10pt}

\cftsetindents{chapter}{\myChapterIndent}{\myChapterNumberWidth}
\cftsetindents{section}{\mySectionIndent}{\mySectionNumberWidth}
\cftsetindents{subsection}{\mySubSectionIndent}{\mySubSectionNumberWidth}
\cftsetindents{subsubsection}{\mySubSubSectionIndent}{\mySubSubSectionNumberWidth}

\lstset{texcl=true, captionpos=b, commentstyle=\tt}

\if@langenglish
    \addto\captionsenglish{%
        \renewcommand{\contentsname}{Contents}%
        \renewcommand{\listfigurename}{List of Figures}%
        \renewcommand{\listtablename}{List of Tables}%
    }
    \renewcommand{\lstlistlistingname}{List of Programs and Algorithms}
\else
    \addto\captionsfinnish{%
        \renewcommand{\contentsname}{Sisällys}%
        \renewcommand{\listfigurename}{Kuvaluettelo}%
        \renewcommand{\listtablename}{Taulukkoluettelo}%
        \renewcommand{\figurename}{Kuvio}%
    }
    \renewcommand{\lstlistlistingname}{Ohjelma- ja algoritmiluettelo}
\fi

\titlecontents
    {part}
    [0pt]
    {\bf}%
    {\thecontentslabel}{}{\hfill\contentspage}

\newlistof[section]{listing}{lol}{\lstlistlistingname}

\contentsuse{lstlisting}{lol}

% Adjust style of content listings' titles.

\renewcommand{\cfttoctitlefont}{\scshape\bf\LARGE}

\renewcommand{\cftloftitlefont}{\scshape\bf\LARGE}

\renewcommand{\cftlottitlefont}{\scshape\bf\LARGE}

\renewcommand{\cftloltitlefont}{\scshape\bf\LARGE}

% Adjust spacing before and after ToC titles.

\NewDocumentCommand\tocspacing{}{8pt}

\setlength{\cftaftertoctitleskip}{\tocspacing}

\setlength{\cftafterloftitleskip}{\tocspacing}

\setlength{\cftafterlottitleskip}{\tocspacing}

\setlength{\cftafterloltitleskip}{\tocspacing}

% Adjust spacing between ToC items.

\setlength{\cftbeforesecskip}{\tocspacing}

\setlength{\cftbeforesubsecskip}{\tocspacing}

\setlength{\cftbeforesubsubsecskip}{\tocspacing}

% Redefine ToC entries to use small caps, just like the titles themselves, with specific font sizes.

\renewcommand{\cftchapfont}{\fontsize{\myChapterFontSize}{14pt}\selectfont\scshape}
\renewcommand{\cftchappagefont}{\fontsize{\myToCPageNumberSize}{14pt}\selectfont\scshape}

\renewcommand{\cftsecfont}{\fontsize{\mySectionFontSize}{12pt}\selectfont\scshape}
\renewcommand{\cftsecpagefont}{\fontsize{\myToCPageNumberSize}{12pt}\selectfont\scshape}

\renewcommand{\cftsubsecfont}{\fontsize{\mySubSectionFontSize}{11pt}\selectfont\scshape}
\renewcommand{\cftsubsecpagefont}{\fontsize{\myToCPageNumberSize}{\myToCPageNumberSize}\selectfont\scshape}

\renewcommand{\cftsubsubsecfont}{\fontsize{\mySubSubSectionFontSize}{\myToCPageNumberSize}\selectfont\scshape}
\renewcommand{\cftsubsubsecpagefont}{\fontsize{\myToCPageNumberSize}{\myToCPageNumberSize}\selectfont\scshape}

% Add dots also at the chapter level.

\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}

\if@langenglish
    \addto\captionsenglish{%
        \renewcommand{\contentsname}{Contents}%
        \renewcommand\listfigurename{List of Figures}%
        \renewcommand{\listtablename}{List of Tables}%
    }
    \renewcommand{\appendixname}{\textsc{Appendix}}
    \if@programs
        \renewcommand{\lstlistlistingname}{List of Programs and Algorithms}
    \fi
\else
    \addto\captionsfinnish{%
        \renewcommand{\contentsname}{Sisällysluettelo}%
        \renewcommand\listfigurename{Kuvaluettelo}%
        \renewcommand{\listtablename}{Taulukkoluettelo}%
    }
    \renewcommand{\appendixname}{\textsc{Liite}}
    \if@programs
        \renewcommand{\lstlistlistingname}{Ohjelma- ja algoritmiluettelo}
    \fi
\fi

% Define appendix title style inside of the appendices environment.

\newenvironment{appendices}{%
\setcounter{chapter}{0}
\renewcommand{\thechapter}{\Alph{chapter}}
\renewcommand{\theHchapter}{\Alph{chapter}}

\titleformat
    {\chapter}
    {\raggedright\LARGE\scshape\bf%
    \parshape %
    2 %
    0pt \linewidth %
    \chapterindent \dimexpr\linewidth-\chapterindent}
    {{\scshape\appendixname~\thechapter:}}
    {\chapterspace}
    {\fancyhf{}\cfoot{\thepage}{\scshape##1}}

\titlecontents%
    {chapter}%
    [0pt]%
    {\vspace{8.5pt}}%
    {\scshape\fontsize{\myChapterFontSize}{14pt}\selectfont\appendixname~\thecontentslabel:\hspace{\chapterspace}}%
    {}%
    {\titlerule*[0.7pc]{.}\fontsize{\myToCPageNumberSize}{14pt}\selectfont\contentspage}
}{}

% Also adjust lists of figures and tables and listings.

\renewcommand{\cftfigfont}{\fontsize{\mySectionFontSize}{12pt}\selectfont}

\renewcommand{\cftfigpagefont}{\fontsize{\myToCPageNumberSize}{12pt}\selectfont}

\renewcommand{\cfttabfont}{\fontsize{\mySectionFontSize}{12pt}\selectfont}

\renewcommand{\cfttabpagefont}{\fontsize{\myToCPageNumberSize}{12pt}\selectfont}

% Renew the list if listings command such that we can modify how the listing entries appear.

\let\origlstlistoflistings\lstlistoflistings

\renewcommand{\lstlistoflistings}{%
  \begingroup
    \renewcommand{\lstlisting}[2]{%
        \@dottedtocline
            {1}
            {\mySectionIndent}
            {\mySectionNumberWidth}
            {\fontsize{\mySectionFontSize}{12pt}\selectfont##1}
            {\fontsize{\myToCPageNumberSize}{12pt}\selectfont##2}
    }
    \origlstlistoflistings
    \endgroup
}

\renewcommand{\cftlistingfont}{\fontsize{24pt}{12pt}\selectfont}

\renewcommand{\cftlistingpagefont}{\fontsize{10pt}{12pt}\selectfont}

% Flexible list modifications
\RequirePackage{enumitem}

\setlist{itemsep=-3pt, labelindent=1.27cm}

% Image alt texts
\RequirePackage{pdfcomment}

% Automated math alt texts.
\ifluatex
    % Do nothing for now, as the axessibility package does not support lualatex.
    % See pull request https://github.com/integr-abile/axessibility/pull/23
    % for details.
\else
    \RequirePackage[accsupp]{axessibility}
\fi

% Text hyperlinking
\RequirePackage{hyperref}

\hypersetup{
    colorlinks=true,
    linkcolor=taupurple,
    citecolor=taupurple,
    urlcolor=blue,
    filecolor=magenta
}

%\RequirePackage{url}
\urlstyle{same}

%%%%% COMMAND DEFINITIONS %%%%%

% Functional language selection
\newcommand{\xselectlanguage}[1]{%
  \begingroup\edef\x{\endgroup
    \noexpand\selectlanguage{#1}}\x
}

% \title command
\renewcommand{\title}[2]{%
    \gdef\@title{#1}
    \gdef\@othertitle{#2}
}
\renewcommand{\@title}[1]{
    \@latex@warning@no@line{No \noexpand\title given.}
}
\newcommand{\@othertitle}[1]{
    \@latex@warning@no@line{No \noexpand\othertitle given.}
}

% \subtitle command
\newcommand{\subtitle}[2]{%
    \gdef\@subtitle{#1}
    \gdef\@othersubtitle{#2}
}
\newcommand{\@subtitle}[1]{
    \@latex@warning@no@line{No \noexpand\subtitle given.}
}
\newcommand{\@othersubtitle}[1]{
    \@latex@warning@no@line{No \noexpand\othersubtitle given.}
}

% \thesistype command
\newcommand{\thesistype}[2]{
    \gdef\@thesistype{#1}
    \gdef\@otherthesistype{#2}
}
\newcommand{\@thesistype}[1]{%
    \@latex@warning@no@line{No \noexpand\thesistype given.}
}
\newcommand{\@otherthesistype}[1]{%
    \@latex@warning@no@line{No \noexpand\otherthesistype given.}
}

% \facultyname command
\newcommand{\facultyname}[2]{
    \gdef\@facultyname{#1}
    \gdef\@otherfacultyname{#2}
}
\newcommand{\@facultyname}[1]{
    \@latex@warning@no@line{No \noexpand\facultyname given.}
}
\newcommand{\@otherfacultyname}[1]{
    \@latex@warning@no@line{No \noexpand\otherfacultyname given.}
}

% \examiner command
\if@langenglish
    \newcommand{\@examinername}{Examiners}
\else
    \newcommand{\@examinername}{Tarkastajat}
\fi

\newcommand{\examiner}[2][\@examinername]{
    \gdef\@finalexaminername{#1}
    \gdef\@givenexaminer{#2}
}
\newcommand{\@examiner}[2]{
    #1: #2
}

% \finishdate command
\newcommand{\finishdate}[3]{
    \gdef\@finishyear{#1}
    \gdef\@finishmonth{#2}
    \gdef\@finishday{#3}
}
\newcommand{\@finishyear}[1]{
    \@latex@warning@no@line{No \noexpand\finishyear given.}
}
\newcommand{\@finishmonth}[1]{
    \@latex@warning@no@line{No \noexpand\finishmonth given.}
}
\newcommand{\@finishday}[1]{
    \@latex@warning@no@line{No \noexpand\finishday given.}
}

% \programmename command
\newcommand{\programmename}[2]{
    \gdef\@programmename{#1}
    \gdef\@otherprogrammename{#2}
}
\newcommand{\@programmename}[1]{
    \@latex@warning@no@line{No \noexpand\programmename given.}
}
\newcommand{\@otherprogrammename}[1]{
    \@latex@warning@no@line{No \noexpand\otherprogrammename given.}
}

% \keywords command
\newcommand{\keywords}[2]{
    \gdef\@keywords{#1}
    \gdef\@otherkeywords{#2}
}
\newcommand{\@keywords}[1]{
    \@latex@warning@no@line{No \noexpand\keywords given.}
}
\newcommand{\@otherkeywords}[1]{
    \@latex@warning@no@line{No \noexpand\otherkeywords given.}
}

% \frontmatter command
\newcommand{\frontmatter}{
    \clearpage
    \pagenumbering{roman}
    \setcounter{page}{0}
}

% \mainmatter command
\newcommand{\mainmatter}{
    \clearpage
    \pagenumbering{arabic}
    \setcounter{page}{1}
}

% Originality texts
\newcommand{\@finoriginalitytext}{%
Tämän julkaisun alkuperäisyys on tarkastettu Turnitin Originality -ohjelmalla.
}
\newcommand{\@engoriginalitytext}{%
The originality of this thesis has been checked using the Turnitin Originality service.
}

% Make the title
\renewcommand\maketitle{
    \thispagestyle{empty}
    \vspace*{-1.88cm}\hspace*{-2.7cm}\includegraphics[height=2.57cm]{\@logofile}
    \par\medskip
    \vspace{102pt}
    {\raggedleft\Large\@author\par}
    \vspace{42pt}
    {\raggedleft\bf\LARGE\color{taupurple}%
        \textsc{\@title}\par}
    {\raggedleft\Large\color{taupurple}%
        \@subtitle\par}
    \vfill
    {\raggedleft%
        \@tauthesis@thesistype\\%
        \@tauthesis@school\\%
        \@facultyname\\%
        %\@examiner{\@finalexaminername}{\@givenexaminer}\\%
        \DTMDisplaydate%
            {\the\year}%
            {\the\month}%
            {\the\day}{-1}%
    \par}
    \vspace{42pt}
    \clearpage
}

% Make the abstracts
\renewcommand{\abstract}[1]{
    \clearpage
    \chapter*{\abstractname}
    \begin{spacing}{1.000}
    {\small
        \setlength{\parindent}{0pt}
        \setlength{\parskip}{0pt}
        \noindent\@author\par
        \@title: \@subtitle\par
        \noindent\@thesistype\par
        \noindent\@university\par
        \noindent\@programmename\par
        \noindent\DTMDisplaydate%
            {\the\year}%
            {\the\month}%
            {\the\day}{-1}\par
        \noindent\makebox[\linewidth]{\color{taupurple}\rule{\linewidth}{1.5pt}}\par
        \vspace{0.5\baselineskip}
        \input{#1}\par
        \bigskip
        \noindent\textbf{\@keywordname:} \@keywords\par
        \bigskip
        \noindent\@originalitytext
    \par}
    \end{spacing}
    \clearpage
}
\newcommand{\otherabstract}[1]{
    \clearpage
    \xselectlanguage{\@otherlanguage}
    \chapter*{\@otherabstractname}
    \begin{spacing}{1.000}
    {\small
        \setlength{\parindent}{0pt}
        \setlength{\parskip}{0pt}
        \noindent\@author\par
        \@othertitle: \@othersubtitle\par
        \noindent\@otherthesistype\par
        \noindent\@otheruniversity\par
        \noindent\@otherprogrammename\par
        \noindent\DTMDisplaydate%
            {\the\year}%
            {\the\month}%
            {\the\day}{-1}\par
        \noindent\makebox[\linewidth]{\color{taupurple}\rule{\linewidth}{1.5pt}}\par
        \vspace{0.5\baselineskip}
        \input{#1}\par
        \bigskip
        \noindent\textbf{\@otherkeywordname:} \@otherkeywords\par
        \bigskip
        \noindent\@otheroriginalitytext
    \par}
    \end{spacing}
    \xselectlanguage{\@mainlanguage}
}

% Make the preface
\newcommand{\preface}[2]{
    \clearpage
    \chapter*{\@prefacename}
    \noindent\input{#1}\par
    \bigskip
    \DTMlangsetup[en-GB,finnish]{showdayofmonth=true}
    \noindent#2,
    \DTMdisplaydate%
        {\the\year}%
        {\the\month}%
        {\the\day}{-1}\par
    \bigskip
    \noindent\@author
    \clearpage
}

%%% ISO-19005 compliant document (pdf/A-2b)

%% Choose title langauge in the metadata that is written to the PDF.

\def\@tauthesis@title{%
    \if@langenglish%
        \@tauthesis@entitle%
    \else%
        \@tauthesis@fititle%
    \fi%
}

\def\@tauthesis@subtitle{%
    \if@langenglish%
        \@tauthesis@ensubtitle%
    \else%
        \@tauthesis@fisubtitle%
    \fi%
}

% Other commands.

\NewDocumentCommand\yesbox{}{☒}

\NewDocumentCommand\nobox{}{☐}

\NewDocumentCommand\aitickbox{s}{
    \IfBooleanTF{#1}{
        \begin{quote}
            \indent\yesbox\hspace{1ex}\@yestextcmd
            \linebreak
            \indent\nobox\hspace{1ex}\@notextcmd
        \end{quote}
    }{
        \begin{quote}
            \indent\nobox\hspace{1ex}\@yestextcmd
            \linebreak
            \indent\yesbox\hspace{1ex}\@notextcmd
        \end{quote}
    }
}

\NewDocumentEnvironment{aidisclaimer}{s+b}{
    \clearpage
    \chapter*{\@aidisclaimertitle}
    \if@langenglish
        Artificial intelligence (AI) has been used in generating this work:
    \else
        Opinnäytteessäni on käytetty tekoälysovelluksia:
    \fi
    \IfBooleanTF{#1}{
        \aitickbox *
        #2
    }{
        \aitickbox
    }
}{
    \if@langenglish

        \section*{Acknowledgement of risks}

        I hereby acknowledge, that as the author of this work, I am fully
        responsible for the contents presented in this thesis. This includes
        the parts that were generated by an AI, in part or in their entirety. I
        therefore also acknowledge my responsibility in the case, where use of
        AI has resulted in ethical guidelines being breached.

    \else

        \section*{Riskien tiedostaminen}

        Olen tietoinen siitä, että olen täysin vastuussa koko opinnäytteeni
        sisällöstä, mukaan lukien osat, joiden tuottamisessa on hyödynnetty
        tekoälyä, ja hyväksyn vastuun mahdollisista tästä seuranneista
        eettisten ohjeiden rikkomuksista.
    \fi
    \clearpage
}

\NewDocumentCommand\aidisclaimerinclusioncmd{}{
    \input{\@aidisclaimerfile}
}

% Place PDF metadata into an external main.xmpdata file.

\begin{filecontents*}[overwrite]{\jobname.xmpdata}
\Title{\@tauthesis@title: \@tauthesis@subtitle}
\Author{\@tauthesis@author}
\Language{\@tauthesis@mainlanguage}
\Keywords{\@tauthesis@fikeywords, \@tauthesis@enkeywords}
\Subject{\@tauthesis@subject}
\end{filecontents*}

%% Load the data from the metadata file with pdfx.

\if@taunotdraftmode
    \RequirePackage[a-2b,mathxmp]{pdfx}
    \catcode30=12
\fi

\makeatother

\endinput
