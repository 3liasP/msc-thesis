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
\newif\if@ieeecitation\@ieeecitationfalse

\newif\if@langenglish\@langenglishfalse
\newif\if@taunotdraftmode\@taunotdraftmodetrue
\newif\if@programs\@programsfalse


\int_new:N\@tauthesis@fithesistypeint
\int_new:N\@tauthesis@enthesistypeint

\int_new:N\@tauthesis@bachelorsthesistypeint
\int_new:N\@tauthesis@mastersthesistypeint
\int_new:N\@tauthesis@phdthesistypeint

\int_set:Nn\@tauthesis@bachelorsthesistypeint{1}
\int_set:Nn\@tauthesis@mastersthesistypeint{2}
\int_set:Nn\@tauthesis@phdthesistypeint{3}


\tl_set:Nn\@tauthesis@bindingoffsetwidth {0.5cm}

% Define keyword arguments for this class file using LaTeX3 syntax.

\DeclareKeys[tauthesis]
{
    author.store = \@tauthesis@author,

    citationsorting.store = \@tauthesis@citationsorting,

    citationstyle.store = \@tauthesis@citationstyle,

    enfacultyname.store = \@tauthesis@enfacultyname,

    enkeywords.store = \@tauthesis@enkeywords,

    enprogrammename.store = \@tauthesis@enprogrammename,

    ensubtitle .code:n = {
        \tl_if_blank:nTF
            {#1}
            {\newcommand{\@tauthesis@ensubtitle@joiner}{}}
            {\newcommand{\@tauthesis@ensubtitle@joiner}{:~}}
        \newcommand{\@tauthesis@ensubtitle}{#1}
    },

    enthesistype .choice:,

    enthesistype / bachelor .code:n =
        \tl_set:Nn\@tauthesis@enthesistype {Bachelor's~thesis}
        \tl_set:Nn\@tauthesis@innermargin {4cm}
        \tl_set:Nn\@tauthesis@outermargin {2cm}
        \tl_set:Nn\@tauthesis@topmargin {2.5cm}
        \tl_set:Nn\@tauthesis@bottommargin {2.5cm}
        \tl_set:Nn\@tauthesis@papersize {a4paper}
        \tl_set:Nn\@tauthesis@paperwidth {210mm}
        \tl_set:Nn\@tauthesis@paperheight {297mm}
        \tl_set:Nn\@tauthesis@logoxoffset {-3.8cm}
        \tl_set:Nn\@tauthesis@logoyoffset {-3.1cm}
        \int_set:Nn\@tauthesis@enthesistypeint {\int_use:N\@tauthesis@bachelorsthesistypeint}
    ,

    enthesistype / master .code:n =
        \tl_set:Nn\@tauthesis@enthesistype {Master's~thesis}
        \tl_set:Nn\@tauthesis@innermargin {4cm}
        \tl_set:Nn\@tauthesis@outermargin {2cm}
        \tl_set:Nn\@tauthesis@topmargin {2.5cm}
        \tl_set:Nn\@tauthesis@bottommargin {2.5cm}
        \tl_set:Nn\@tauthesis@papersize {a4paper}
        \tl_set:Nn\@tauthesis@paperwidth {210mm}
        \tl_set:Nn\@tauthesis@paperheight {297mm}
        \tl_set:Nn\@tauthesis@logoxoffset {-3.8cm}
        \tl_set:Nn\@tauthesis@logoyoffset {-3.1cm}
        \int_set:Nn\@tauthesis@enthesistypeint {\int_use:N\@tauthesis@mastersthesistypeint}
    ,

    enthesistype / doctor .code:n =
        \tl_set:Nn\@tauthesis@enthesistype {Doctoral~dissertation}
        \tl_set:Nn\@tauthesis@innermargin {2cm}
        \tl_set:Nn\@tauthesis@outermargin {2cm}
        \tl_set:Nn\@tauthesis@topmargin {2cm}
        \tl_set:Nn\@tauthesis@bottommargin {3cm}
        \tl_set:Nn\@tauthesis@papersize {b5paper}
        \tl_set:Nn\@tauthesis@paperwidth {176mm}
        \tl_set:Nn\@tauthesis@paperheight {250mm}
        \tl_set:Nn\@tauthesis@logoxoffset {-1.9cm}
        \tl_set:Nn\@tauthesis@logoyoffset {-2.7cm}
        \int_set:Nn\@tauthesis@enthesistypeint {\int_use:N\@tauthesis@phdthesistypeint}
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

    fisubtitle .code:n = {
        \tl_if_blank:nTF
            {#1}
            {\newcommand{\@tauthesis@fisubtitle@joiner}{}}
            {\newcommand{\@tauthesis@fisubtitle@joiner}{:~}}
        \newcommand{\@tauthesis@fisubtitle}{#1}
    },

    fithesistype .choice:,

    fithesistype / kandidaatti .code:n =
        \tl_set:Nn\@tauthesis@fithesistype {Kandidaatintyö}
        \tl_set:Nn\@tauthesis@innermargin {4cm}
        \tl_set:Nn\@tauthesis@outermargin {2cm}
        \tl_set:Nn\@tauthesis@topmargin {2.5cm}
        \tl_set:Nn\@tauthesis@bottommargin {2.5cm}
        \tl_set:Nn\@tauthesis@papersize {a4paper}
        \tl_set:Nn\@tauthesis@paperwidth {210mm}
        \tl_set:Nn\@tauthesis@paperheight {297mm}
        \tl_set:Nn\@tauthesis@logoxoffset {-3.8cm}
        \tl_set:Nn\@tauthesis@logoyoffset {-3.1cm}
        \int_set:Nn\@tauthesis@fithesistypeint {\int_use:N\@tauthesis@bachelorsthesistypeint}
    ,

    fithesistype / maisteri .code:n =
        \tl_set:Nn\@tauthesis@fithesistype {Pro~gradu~-tutkielma}
        \tl_set:Nn\@tauthesis@innermargin {4cm}
        \tl_set:Nn\@tauthesis@outermargin {2cm}
        \tl_set:Nn\@tauthesis@topmargin {2.5cm}
        \tl_set:Nn\@tauthesis@bottommargin {2.5cm}
        \tl_set:Nn\@tauthesis@papersize {a4paper}
        \tl_set:Nn\@tauthesis@paperwidth {210mm}
        \tl_set:Nn\@tauthesis@paperheight {297mm}
        \tl_set:Nn\@tauthesis@logoxoffset {-3.8cm}
        \tl_set:Nn\@tauthesis@logoyoffset {-3.1cm}
        \int_set:Nn\@tauthesis@fithesistypeint {\int_use:N\@tauthesis@mastersthesistypeint}
    ,

    fithesistype / diplomi .code:n =
        \tl_set:Nn\@tauthesis@fithesistype {Diplomityö}
        \tl_set:Nn\@tauthesis@innermargin {4cm}
        \tl_set:Nn\@tauthesis@outermargin {2cm}
        \tl_set:Nn\@tauthesis@topmargin {2.5cm}
        \tl_set:Nn\@tauthesis@bottommargin {2.5cm}
        \tl_set:Nn\@tauthesis@papersize {a4paper}
        \tl_set:Nn\@tauthesis@paperwidth {210mm}
        \tl_set:Nn\@tauthesis@paperheight {297mm}
        \tl_set:Nn\@tauthesis@logoxoffset {-3.8cm}
        \tl_set:Nn\@tauthesis@logoyoffset {-3.1cm}
        \int_set:Nn\@tauthesis@fithesistypeint {\int_use:N\@tauthesis@mastersthesistypeint}
    ,

    fithesistype / tohtori .code:n =
        \tl_set:Nn\@tauthesis@fithesistype {Väitöskirja}
        \tl_set:Nn\@tauthesis@innermargin {2cm}
        \tl_set:Nn\@tauthesis@outermargin {2cm}
        \tl_set:Nn\@tauthesis@topmargin {2cm}
        \tl_set:Nn\@tauthesis@bottommargin {3cm}
        \tl_set:Nn\@tauthesis@papersize {b5paper}
        \tl_set:Nn\@tauthesis@paperwidth {176mm}
        \tl_set:Nn\@tauthesis@paperheight {250mm}
        \tl_set:Nn\@tauthesis@logoxoffset {-1.9cm}
        \tl_set:Nn\@tauthesis@logoyoffset {-2.7cm}
        \int_set:Nn\@tauthesis@fithesistypeint {\int_use:N\@tauthesis@phdthesistypeint}
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
        \newcommand{\@tauthesis@mainlanguage}{finnish}
        \newcommand{\@tauthesis@tauthesis@mainlanguage}{finnish}
        \newcommand{\@tauthesis@abstractfile}{frontmatter/tiivistelma.tex}
        \newcommand{\@tauthesis@abstractname}{Tiivistelmä}
        \newcommand{\@tauthesis@university}{Tampereen~yliopisto}
        \newcommand{\@tauthesis@keywordname}{Avainsanat}
        \newcommand{\@tauthesis@prefacename}{Alkusanat}
        \newcommand{\@tauthesis@originalitytext}{\@finoriginalitytext}
        \newcommand{\@tauthesis@logofile}{figures/tau-logo-fin-eng.eps}
        \newcommand{\@tauthesis@aidisclaimertitle}{Tekoälyn~käyttö~tässä~työssä}
        \newcommand{\@tauthesis@aidisclaimerfile}{frontmatter/tekoalyn-kaytto.tex}
        \newcommand{\@tauthesis@yestextcmd}{Kyllä}
        \newcommand{\@tauthesis@notextcmd}{Ei}

        \newcommand{\@tauthesis@title}{\@tauthesis@fititle}
        \newcommand{\@tauthesis@subtitle}{\@tauthesis@fisubtitle}
        \newcommand{\@tauthesis@thesistype}{\@tauthesis@fithesistype}
        \newcommand{\@tauthesis@facultyname}{\@tauthesis@fifacultyname}
        \newcommand{\@tauthesis@programmename}{\@tauthesis@fiprogrammename}
        \newcommand{\@tauthesis@keywords}{\@tauthesis@fikeywords}
        \newcommand{\@tauthesis@subtitle@joiner}{\@tauthesis@fisubtitle@joiner}

        \newcommand{\@tauthesis@otherabstractfile}{frontmatter/abstract.tex}
        \newcommand{\@tauthesis@otherabstractname}{Abstract}
        \newcommand{\@tauthesis@otherfacultyname}{\@tauthesis@enfacultyname}
        \newcommand{\@tauthesis@otherkeywordname}{Keywords}
        \newcommand{\@tauthesis@otherkeywords}{\@tauthesis@enkeywords}
        \newcommand{\@tauthesis@otherlanguage}{english}
        \newcommand{\@tauthesis@otheroriginalitytext}{\@engoriginalitytext}
        \newcommand{\@tauthesis@otherprogrammename}{\@tauthesis@enprogrammename}
        \newcommand{\@tauthesis@othersubtitle}{\@tauthesis@ensubtitle}
        \newcommand{\@tauthesis@othersubtitle@joiner}{\@tauthesis@ensubtitle@joiner}
        \newcommand{\@tauthesis@otherthesistype}{\@tauthesis@enthesistype}
        \newcommand{\@tauthesis@othertitle}{\@tauthesis@entitle}
        \newcommand{\@tauthesis@otheruniversity}{Tampere~University}

        \newcommand{\@tauthesis@publicationname}{Julkaisu}
        \newcommand{\@tauthesis@publicationplural}{Julkaisut}
        \newcommand{\@tauthesis@listpublicationname}{Alkuperäisjulkaisut}
        \newcommand{\@tauthesis@copyrighttext}{%
            Artikkeleiden~käyttöön~väitöskirjan~osana~on~saatu~kustantajan~lupa.%
        }
        \newcommand{\@tauthesis@authorcontributionname}{Kirjoittajan~osuus}

        \newcommand{\@tauthesis@firstprinttext}{%
            Tämä~ja~seuraava~sivu
            korvataan~painossa~nimiösivuilla.
        }
        \newcommand{\@tauthesis@lastprinttext}{%
            Tämä~ja~edellinen~sivu
            korvataan~painossa~nimiösivuilla.
        }
        \newcommand{\@tauthesis@librarytext}{%
            Tälle~sivulle~lisätään~kirjastossa
            sarjan~numero,~ISBN-~ja~ISSN-numerot.
        }


        \@langenglishfalse
    },

    mainlanguage / english .code:n = {
        \newcommand{\@tauthesis@mainlanguage}{english}
        \newcommand{\@tauthesis@tauthesis@mainlanguage}{english}
        \newcommand{\@tauthesis@abstractfile}{frontmatter/abstract.tex}
        \newcommand{\@tauthesis@abstractname}{Abstract}
        \newcommand{\@tauthesis@university}{Tampere~University}
        \newcommand{\@tauthesis@keywordname}{Keywords}
        \newcommand{\@tauthesis@prefacename}{Preface}
        \newcommand{\@tauthesis@originalitytext}{\@engoriginalitytext}
        \newcommand{\@tauthesis@logofile}{figures/tau-logo-fin-eng.eps}
        \newcommand{\@tauthesis@aidisclaimertitle}{Use~of~artificial~intelligence~in~this~work}
        \newcommand{\@tauthesis@aidisclaimerfile}{frontmatter/use-of-ai.tex}
        \newcommand{\@tauthesis@yestextcmd}{Yes}
        \newcommand{\@tauthesis@notextcmd}{No}

        \newcommand{\@tauthesis@title}{\@tauthesis@entitle}
        \newcommand{\@tauthesis@subtitle}{\@tauthesis@ensubtitle}
        \newcommand{\@tauthesis@subtitle@joiner}{\@tauthesis@ensubtitle@joiner}
        \newcommand{\@tauthesis@thesistype}{\@tauthesis@enthesistype}
        \newcommand{\@tauthesis@facultyname}{\@tauthesis@enfacultyname}
        \newcommand{\@tauthesis@programmename}{\@tauthesis@enprogrammename}
        \newcommand{\@tauthesis@keywords}{\@tauthesis@enkeywords}

        \newcommand{\@tauthesis@otherabstractfile}{frontmatter/tiivistelma.tex}
        \newcommand{\@tauthesis@otherabstractname}{Tiivistelmä}
        \newcommand{\@tauthesis@otherfacultyname}{\@tauthesis@fifacultyname}
        \newcommand{\@tauthesis@otherkeywordname}{Avainsanat}
        \newcommand{\@tauthesis@otherkeywords}{\@tauthesis@fikeywords}
        \newcommand{\@tauthesis@otherlanguage}{finnish}
        \newcommand{\@tauthesis@otheroriginalitytext}{\@finoriginalitytext}
        \newcommand{\@tauthesis@otherprogrammename}{\@tauthesis@fiprogrammename}
        \newcommand{\@tauthesis@othersubtitle}{\@tauthesis@fisubtitle}
        \newcommand{\@tauthesis@othersubtitle@joiner}{\@tauthesis@fisubtitle@joiner}
        \newcommand{\@tauthesis@otherthesistype}{\@tauthesis@fithesistype}
        \newcommand{\@tauthesis@othertitle}{\@tauthesis@fititle}
        \newcommand{\@tauthesis@otheruniversity}{Tampereen~yliopisto}

        \newcommand{\@tauthesis@publicationname}{Publication}
        \newcommand{\@tauthesis@publicationplural}{Publications}
        \newcommand{\@tauthesis@listpublicationname}{Original publications}
        \newcommand{\@tauthesis@copyrighttext}{%
            Publication~reprinted~with~the~permission~of~the~copyright~holders.%
        }
        \newcommand{\@tauthesis@authorcontributionname}{Author's~contribution}

        \newcommand{\@tauthesis@firstprinttext}{%
            This~and~the~following~page
            will~be~replaced~in~the~printing~house.
        }
        \newcommand{\@tauthesis@lastprinttext}{%
            This~and~the~preceding~page
            will~be~replaced~in~the~printing~house.
        }
        \newcommand{\@tauthesis@librarytext}{%
            The~series,~ISBN~and~ISSN~numbers
            are~added~on~this~page~in~the~library.
        }


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

% Check that thesis types match.

\msg_new:nnn { tauthesis } { thesis_types_match } { Thesis~types~match. }

\msg_new:nnn { tauthesis } { thesis_types_dont_match } { Finnish~and~English~thesis~types~do~not~match! }

% Process the key--value arguments.

\ProcessKeyOptions[tauthesis]

\int_compare:nTF
    { \@tauthesis@fithesistypeint == \@tauthesis@enthesistypeint }
    { \msg_info:nn { tauthesis } { thesis_types_match } }
    { \msg_error:nn { tauthesis } { thesis_types_dont_match } }

\newcommand{\mainmatter}{
    \int_compare:nTF
        {\@tauthesis@fithesistypeint < \@tauthesis@phdthesistypeint}
        {\clearpage}
        {\cleardoublepage}

    \int_compare:nTF
        {\@tauthesis@fithesistypeint = \@tauthesis@phdthesistypeint}
        {
            \newcounter{temp}
            \setcounter{temp}{\value{page}}
        }
        {
            % Do nothing.
        }
    \pagenumbering{arabic}
    \int_compare:nTF
        {\@tauthesis@fithesistypeint = \@tauthesis@phdthesistypeint}
        {
            \setcounter{page}{\value{temp}}
        }
        {
            % Do nothing.
        }
}

\ExplSyntaxOff

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

\RequirePackage{mathtools} % This should be loaded before unicode-math.

\RequirePackage{unicode-math}

\setmathfont{STIXTwoMath-Regular.ttf}[
  Path = fonts/STIXTwo/
]

\RequirePackage{newunicodechar}

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
    \@tauthesis@papersize,
    top=\@tauthesis@topmargin,
    bottom=\@tauthesis@bottommargin,
    left=\@tauthesis@innermargin,
    right=\@tauthesis@outermargin,
]{geometry}
\special{papersize={\@tauthesis@paperwidth,\@tauthesis@paperheight}}
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
\ExplSyntaxOn
    \int_compare:nTF
        {
            \@tauthesis@fithesistypeint
            =
            \@tauthesis@phdthesistypeint
        }
        {
            \cfoot{\thepage}
        }
        {
            \rhead{\thepage}
        }
\ExplSyntaxOff
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
\RequirePackage[\@tauthesis@otherlanguage, main=\@tauthesis@mainlanguage]{babel}
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
    sorting=\@tauthesis@citationsorting,
    defernumbers,
]{biblatex}

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

\def\myToCPageNumberSize{10pt}

\cftsetindents{chapter}{\myChapterIndent}{\myChapterNumberWidth}
\cftsetindents{section}{\mySectionIndent}{\mySectionNumberWidth}
\cftsetindents{subsection}{\mySubSectionIndent}{\mySubSectionNumberWidth}
\cftsetindents{subsubsection}{\mySubSubSectionIndent}{\mySubSubSectionNumberWidth}

\lstset{texcl=true, captionpos=b, commentstyle=\tt}

\titlecontents
    {part}
    [0pt]
    {\bf}%
    {\thecontentslabel}{}{\hfill\contentspage}

\newlistof[section]{listing}{lol}{\lstlistlistingname}

\contentsuse{lstlisting}{lol}

% Adjust style of content listings' titles.

\renewcommand{\cfttoctitlefont}{\scshape\bf\fontsize{21pt}{0pt}\selectfont}

\renewcommand{\cftloftitlefont}{\scshape\bf\fontsize{21pt}{0pt}\selectfont}

\renewcommand{\cftlottitlefont}{\scshape\bf\fontsize{21pt}{0pt}\selectfont}

\renewcommand{\cftloltitlefont}{\scshape\bf\fontsize{21pt}{0pt}\selectfont}

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
        \renewcommand{\contentsname}{\scshape Contents}%
        \renewcommand\listfigurename{\scshape List of Figures}%
        \renewcommand{\listtablename}{\scshape List of Tables}%
    }
    \renewcommand{\appendixname}{\textsc{Appendix}}
    \if@programs
        \renewcommand{\lstlistlistingname}{\scshape List of Programs and Algorithms}
    \fi
\else
    \addto\captionsfinnish{%
        \renewcommand{\contentsname}{\scshape Sisällys}%
        \renewcommand\listfigurename{\scshape Kuvaluettelo}%
        \renewcommand{\listtablename}{\scshape Taulukkoluettelo}%
    }
    \renewcommand{\appendixname}{\textsc{Liite}}
    \if@programs
        \renewcommand{\lstlistlistingname}{\scshape Ohjelma- ja algoritmiluettelo}
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

% \frontmatter command
\newcommand{\frontmatter}{
    \clearpage
    \pagenumbering{roman}
    \setcounter{page}{0}
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
    \vspace*{\@tauthesis@logoyoffset}
    \hspace*{\@tauthesis@logoxoffset}
    \includegraphics[width=8cm]{\@tauthesis@logofile}
    \par\medskip
    \vspace{102pt}
    {\raggedleft\fontsize{20pt}{0pt}\selectfont\@tauthesis@author\par}
    \vspace{2cm}
    {\raggedleft\bf\fontsize{25pt}{0pt}\selectfont\color{taupurple}%
        \textsc{\@tauthesis@title}\par}
    \vspace{1cm}
    {\raggedleft\scshape\fontsize{20pt}{0pt}\selectfont\color{taupurple}%
        \@tauthesis@subtitle\par}
    \vfill
    {\raggedleft%
        \@tauthesis@thesistype\\%
        \@tauthesis@university\\%
        \@tauthesis@facultyname\\%
        \DTMDisplaydate%
            {\the\year}%
            {\the\month}%
            {\the\day}{-1}%
    \par}
    \vspace{42pt}
    \clearpage
}

% Make the abstracts
\renewcommand{\abstract}{
    \clearpage
    \chapter*{\@tauthesis@abstractname}
    \begin{spacing}{1.000}
    {\small
        \setlength{\parindent}{0pt}
        \setlength{\parskip}{0pt}
        \noindent\@tauthesis@author\par
        \@tauthesis@title\@tauthesis@subtitle@joiner\@tauthesis@subtitle\par
        \noindent\@tauthesis@thesistype\par
        \noindent\@tauthesis@university\par
        \noindent\@tauthesis@programmename\par
        \noindent\DTMDisplaydate%
            {\the\year}%
            {\the\month}%
            {\the\day}{-1}\par
        \noindent\makebox[\linewidth]{\color{taupurple}\rule{\linewidth}{1.5pt}}\par
        \vspace{0.5\baselineskip}
        \input{\@tauthesis@abstractfile}\par
        \bigskip
        \noindent\textbf{\@tauthesis@keywordname:} \@tauthesis@keywords\par
        \bigskip
        \noindent\@tauthesis@originalitytext
    \par}
    \end{spacing}
    \clearpage
}
\newcommand{\otherabstract}{
    \clearpage
    \xselectlanguage{\@tauthesis@otherlanguage}
    \chapter*{\@tauthesis@otherabstractname}
    \begin{spacing}{1.000}
    {\small
        \setlength{\parindent}{0pt}
        \setlength{\parskip}{0pt}
        \noindent\@tauthesis@author\par
        \@tauthesis@othertitle\@tauthesis@othersubtitle@joiner\@tauthesis@othersubtitle\par
        \noindent\@tauthesis@otherthesistype\par
        \noindent\@tauthesis@otheruniversity\par
        \noindent\@tauthesis@otherprogrammename\par
        \noindent\DTMDisplaydate%
            {\the\year}%
            {\the\month}%
            {\the\day}{-1}\par
        \noindent\makebox[\linewidth]{\color{taupurple}\rule{\linewidth}{1.5pt}}\par
        \vspace{0.5\baselineskip}
        \input{\@tauthesis@otherabstractfile}\par
        \bigskip
        \noindent\textbf{\@tauthesis@otherkeywordname:} \@tauthesis@otherkeywords\par
        \bigskip
        \noindent\@tauthesis@otheroriginalitytext
    \par}
    \end{spacing}
    \xselectlanguage{\@tauthesis@mainlanguage}
}

% Make the preface
\newcommand{\preface}[2]{
    \clearpage
    \chapter*{\@tauthesis@prefacename}
    \noindent\input{#1}\par
    \bigskip
    \DTMlangsetup[en-GB,finnish]{showdayofmonth=true}
    \noindent#2,
    \DTMdisplaydate%
        {\the\year}%
        {\the\month}%
        {\the\day}{-1}\par
    \bigskip
    \noindent\@tauthesis@author
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
            \indent\yesbox\hspace{1ex}\@tauthesis@yestextcmd
            \linebreak
            \indent\nobox\hspace{1ex}\@tauthesis@notextcmd
        \end{quote}
    }{
        \begin{quote}
            \indent\nobox\hspace{1ex}\@tauthesis@yestextcmd
            \linebreak
            \indent\yesbox\hspace{1ex}\@tauthesis@notextcmd
        \end{quote}
    }
}

\NewDocumentEnvironment{aidisclaimer}{s+b}{
    \clearpage
    \chapter*{\@tauthesis@aidisclaimertitle}
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
    \input{\@tauthesis@aidisclaimerfile}
}

\newlength\publistlabelwidth
\settowidth{\publistlabelwidth}{\@tauthesis@publicationname8888}
\addtolength{\publistlabelwidth}{\parindent}

\defbibenvironment{thisdissertationstyle}
    {\list
        {\printtext[labelnumberwidth]{%
            \printfield{labelprefix}%
            \printfield{labelnumber}}}
        {\settowidth{\labelnumberwidth}{\@tauthesis@publicationname8888}%
            \setlength{\labelwidth}{\labelnumberwidth}%
            \setlength{\leftmargin}{\labelwidth}%
            \setlength{\labelsep}{\biblabelsep}%
            \addtolength{\leftmargin}{\labelsep}%
            \setlength{\itemsep}{\bibitemsep}%
            \setlength{\parsep}{\bibparsep}}%
        \renewcommand*{\makelabel}[1]{##1\hss}}
    {\endlist}
    {\item}

\newlist{publikeenumerate}{enumerate}{1}
\setlist[publikeenumerate,1]{label={\@tauthesis@publicationname{} \Roman*}, wide=0pt, widest=99, leftmargin=\publistlabelwidth, labelsep=*, itemsep=\bibitemsep}

% Make the list of publications
\newcommand{\listofpublications}{
    \begin{refsection}
    \begin{refcontext}[labelprefix=\@tauthesis@publicationname\addspace, sorting=none]
    \nocite{*}
    \emergencystretch=2em
    \setlength{\bibitemsep}{8.5pt}
    \DeclareFieldFormat{labelnumber}{\ifinteger{##1}{\RN{##1}}{##1}}
    \DeclareFieldFormat{labelnumberwidth}{##1}
    \printbibliography[%
        title=\@tauthesis@listpublicationname,%
        keyword=thisdissertation,%
        env=thisdissertationstyle]
    \end{refcontext}
    \end{refsection}
    \settowidth{\labelnumberwidth}{888}
}

% Make the author's contribution
\newcommand{\authorcontribution}{
    \section*{\large\@tauthesis@authorcontributionname}
    \input{frontmatter/authorcontribution.tex}
    \cleardoublepage
}


% The \publicationmatter command
\newcommand{\publicationmatter}{
    \pagebreak
    \fancyhf{}
    \addtocontents{toc}{\protect\setcounter{tocdepth}{-10}}
    \part*{\@tauthesis@publicationplural}
    \thispagestyle{empty}
    \addtocontents{toc}{\protect\setcounter{tocdepth}{3}}
    % APA related fixes
    \if@apacitation
        \newcommand*{\apablx@ifnotfinalname}{%
            \ifboolexpr{
                test {\ifnumless{\value{listcount}}{\value{liststop}}}
                or
                test \ifmorenames
            }
        }
        \newcommand*{\apablx@ifrevnameappcomma}[2]{%
            \ifdefvoid{##1}
            {\ifdefvoid{##2}}
            {\@secondoftwo}
            {\@secondoftwo}
            {\apablx@ifnotfinalname}%
        }
        \renewbibmacro*{name:apa:family-given}[5]{%
            \ifuseprefix{
                \usebibmacro
                    {name:delim}
                    {##4##1}%
                \usebibmacro
                    {name:hook}
                    {##4##1}%
                \ifdefvoid
                    {##4}
                    {}
                    {%
                        \mkbibnameprefix{##4}\isdot%
                        \ifprefchar{}{\bibnamedelimc}
                    }%
                 \mkbibnamefamily{##1}\isdot%
                 \ifdefvoid{##2}
                    {}
                    {
                        \revsdnamepunct\bibnamedelimd\mkbibnamegiven{##3}\isdot%
                        \ifthenelse
                            {\value{uniquename}>1}
                            {\bibnamedelimd\mkbibbrackets{##2}}
                            {}
                    }%
                \ifdefvoid
                    {##5}
                    {}
                    {\addcomma\bibnamedelimd\mkbibnamesuffix{##5}\isdot}%
                    \apablx@ifrevnameappcomma
                        {##2}
                        {##5}
                        {\addcomma}
                        {}
            }
            {
                \usebibmacro{name:delim}{##1}%
                \usebibmacro{name:hook}{##1}%
                \mkbibnamefamily{##1}\isdot
                \ifboolexpe
                    {%
                        test {\ifdefvoid{##2}}
                        and
                        test {\ifdefvoid{##4}}
                    }
                    {}
                    {\revsdnamepunct}%
                \ifdefvoid
                    {##2}
                    {}
                    {
                        \bibnamedelimd\mkbibnamegiven{##3}%
                        \ifthenelse
                            {\value{uniquename}>1}
                            {\bibnamedelimd\mkbibbrackets{##2}}
                            {}
                    }%
                \ifdefvoid
                    {##4}
                    {}
                    {%
                        \bibnamedelimc\mkbibnameprefix{##4}%
                        \ifprefchar{}{\bibnamedelimc}
                    }%
                \ifdefvoid
                    {##5}
                    {}
                    {\addcomma\bibnamedelimd\mkbibnamesuffix{##5}\isdot}%
                \apablx@ifrevnameappcomma
                    {##2}
                    {##5}
                    {\addcomma}
                    {}
                }
        }
        \renewcommand*{\intitlepunct}{\space}
    \fi
    \if@ieeecitation
        \DeclareFieldFormat[article,periodical]{volume}{\bibstring{jourvol}\addnbspace##1}
    \fi
    \DeclareFieldFormat[article,inbook,incollection,inproceedings,patent,thesis,unpublished]{title}{##1\isdot}
}

% Make the publication title pages.
\newcounter{publication}
\setcounter{publication}{0}

\DeclareCiteCommand{\thisdissertation}{
    %\cleardoublepage
    \thispagestyle{empty}
    \refstepcounter{publication}
    \addcontentsline{toc}{chapter}{\fontsize{\myChapterFontSize}{12pt}\selectfont\@tauthesis@publicationname{} \Roman{publication}}
    \hspace*{0pt}\vfill
    {\centering\LARGE\scshape
        \MakeUppercase{\@tauthesis@publicationname}\\
        \Roman{publication}
    \par}
    \vspace{42pt}
    \label{publication-\thepublication}
}{%
  {\centering\textbf{\usebibmacro{title}}\par}%
  \medskip
  {\centering\nopunct%
  \printnames[][-\value{listtotal}]{author}\par}%
  \bigskip
  {\centering\small%
  \ifentrytype{article}{%
  \usebibmacro{journal+issuetitle}%
  \usebibmacro{byeditor+others}%
  \usebibmacro{note+pages}%
  }{}%
  \if@apacitation
  \ifentrytype{inbook}{%
  \usebibmacro{in:}%
  \usebibmacro{editor+trans}%
  \usebibmacro{maintitle+booktitle}%
  \printlist{publisher}%
  }{}
  \else
  \ifentrytype{incollection}{%
  \usebibmacro{in:}%
  \usebibmacro{maintitle+booktitle}%
  \usebibmacro{byeditor+others}%
  \printfield{edition}%
  \iffieldundef{maintitle}
    {\printfield{volume}%
     \printfield{part}}{}%
  \printfield{volumes}%
  \usebibmacro{series+number}%
  \printfield{note}%
  \usebibmacro{publisher+location+date}%
  \usebibmacro{chapter+pages}%
  }{}%
  \fi
  \usebibmacro{addendum+pubstate}\par}%
  {\centering\small\nopunct%
  \usebibmacro{doi+eprint+url}\par}%
}{}{
    \bigskip
    {\centering\textbf{\@tauthesis@copyrighttext}\par}
    \vfill\hspace*{0pt}
    \clearpage
    \thispagestyle{empty}
    \cleardoublepage
}

\newlength{\@includewidth}
\newlength{\@includeheight}
\newlength{\@onept}
\setlength{\@onept}{1pt}

\newlength{\@widthratio}
\newlength{\@heightratio}

\newlength{\@truepaperwidth}
\setlength{\@truepaperwidth}{%
    \@tauthesis@paperwidth-\@tauthesis@bindingoffsetwidth%
}

\RequirePackage{pdfpages}

\NewDocumentCommand{\nonFreePublication}{mm}{
    \thisdissertation{#1}
    \includepdf[%
        pages=-,
        width=\@truepaperwidth,
        height=\paperheight,
        keepaspectratio]{#2}
    \cleardoublepage
}


\if@langenglish
    \NewDocumentCommand\@tauthesis@licensedUnder{m}{This work is licensed under #1}
\else
    \NewDocumentCommand\@tauthesis@licensedUnder{m}{Tämä työ on lisensoitu lisenssin #1 mukaisesti}
\fi

\NewDocumentCommand\licensedPublication{mmm}{
    \renewcommand{\@tauthesis@copyrighttext}{\@tauthesis@licensedUnder{#3}}
    \thisdissertation{#1}
    \includepdf[%
        pages=-,
        width=\@truepaperwidth,
        height=\paperheight,
        keepaspectratio]{#2}
    \cleardoublepage
}

% Place PDF metadata into an external main.xmpdata file.

\begin{filecontents*}[overwrite]{\jobname.xmpdata}
\Title{\@tauthesis@title\@tauthesis@subtitle@joiner\@tauthesis@subtitle}
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
