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
%
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
\int_new:N\@tauthesis@licentiatethesistypeint
\int_new:N\@tauthesis@doctoralthesistypeint

\int_set:Nn\@tauthesis@bachelorsthesistypeint{1}
\int_set:Nn\@tauthesis@mastersthesistypeint{2}
\int_set:Nn\@tauthesis@licentiatethesistypeint{3}
\int_set:Nn\@tauthesis@doctoralthesistypeint{4}

\tl_new:N\@tauthesis@mainlanguage

\bool_new:N\@tauthesis@includePublications

\bool_new:N\@tauthesis@includeListOfFigures

\bool_new:N\@tauthesis@includeListOfTables

\bool_new:N\@tauthesis@includeListOfListings

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

    enthesistype / licentiate .code:n =
        \tl_set:Nn\@tauthesis@enthesistype {Licentiate~Thesis}
        \tl_set:Nn\@tauthesis@innermargin {2cm}
        \tl_set:Nn\@tauthesis@outermargin {2cm}
        \tl_set:Nn\@tauthesis@topmargin {2cm}
        \tl_set:Nn\@tauthesis@bottommargin {3cm}
        \tl_set:Nn\@tauthesis@papersize {b5paper}
        \tl_set:Nn\@tauthesis@paperwidth {176mm}
        \tl_set:Nn\@tauthesis@paperheight {250mm}
        \tl_set:Nn\@tauthesis@logoxoffset {-1.9cm}
        \tl_set:Nn\@tauthesis@logoyoffset {-2.7cm}
        \int_set:Nn\@tauthesis@enthesistypeint {\int_use:N\@tauthesis@licentiatethesistypeint}
    ,

    enthesistype / doctor .code:n =
        \tl_set:Nn\@tauthesis@enthesistype {Doctoral~Dissertation}
        \tl_set:Nn\@tauthesis@innermargin {2cm}
        \tl_set:Nn\@tauthesis@outermargin {2cm}
        \tl_set:Nn\@tauthesis@topmargin {2cm}
        \tl_set:Nn\@tauthesis@bottommargin {3cm}
        \tl_set:Nn\@tauthesis@papersize {b5paper}
        \tl_set:Nn\@tauthesis@paperwidth {176mm}
        \tl_set:Nn\@tauthesis@paperheight {250mm}
        \tl_set:Nn\@tauthesis@logoxoffset {-1.9cm}
        \tl_set:Nn\@tauthesis@logoyoffset {-2.7cm}
        \int_set:Nn\@tauthesis@enthesistypeint {\int_use:N\@tauthesis@doctoralthesistypeint}
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

    fithesistype / lisensiaatti .code =
        \tl_set:Nn\@tauthesis@fithesistype {Lisensiaatintyö}
        \tl_set:Nn\@tauthesis@innermargin {2cm}
        \tl_set:Nn\@tauthesis@outermargin {2cm}
        \tl_set:Nn\@tauthesis@topmargin {2cm}
        \tl_set:Nn\@tauthesis@bottommargin {3cm}
        \tl_set:Nn\@tauthesis@papersize {b5paper}
        \tl_set:Nn\@tauthesis@paperwidth {176mm}
        \tl_set:Nn\@tauthesis@paperheight {250mm}
        \tl_set:Nn\@tauthesis@logoxoffset {-1.9cm}
        \tl_set:Nn\@tauthesis@logoyoffset {-2.7cm}
        \int_set:Nn\@tauthesis@fithesistypeint {\int_use:N\@tauthesis@licentiatethesistypeint}
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
        \int_set:Nn\@tauthesis@fithesistypeint {\int_use:N\@tauthesis@doctoralthesistypeint}
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

    includeListOfFigures .bool_set:N = \@tauthesis@includeListOfFigures,

    includeListOfFigures .default:n = true,

    includeListOfFigures .initial:n = false,

    includeListOfTables .bool_set:N = \@tauthesis@includeListOfTables,

    includeListOfTables .default:n = true,

    includeListOfTables .initial:n = false,

    includeListOfListings .bool_set:N = \@tauthesis@includeListOfListings,

    includeListOfListings .default:n = true,

    includeListOfListings .initial:n = false,

    includePublications .bool_set:N = \@tauthesis@includePublications,

    includePublications .default:n = true,

    includePublications .initial:n = false,

    mainlanguage .choice:,

    mainlanguage / finnish .code:n = {
        \tl_set:Nn\@tauthesis@mainlanguage{finnish}
        \newcommand{\@tauthesis@abstractfile}{frontmatter/tiivistelma.tex}
        \newcommand{\@tauthesis@abstractname}{Tiivistelmä}
        \newcommand{\@tauthesis@university}{Tampereen~yliopisto}
        \newcommand{\@tauthesis@keywordname}{Avainsanat}
        \newcommand{\@tauthesis@prefacename}{Alkusanat}
        \newcommand{\@tauthesis@originalitytext}{\@finoriginalitytext}
        \newcommand{\@tauthesis@logofile}{images/tau-logo-fin.eps}
        \newcommand{\@tauthesis@logofile@alttext}{Tampereen yliopiston logo.}
        \newcommand{\@tauthesis@aidisclaimertitle}{Tekoälyn~käyttö~tässä~työssä}
        \newcommand{\@tauthesis@aidisclaimerfile}{frontmatter/tekoalyn-kaytto.tex}
        \newcommand{\@tauthesis@yestextcmd}{Kyllä}
        \newcommand{\@tauthesis@notextcmd}{Ei}
        \newcommand{\@tauthesis@keywords}{\@tauthesis@fikeywords}
        \newcommand{\@tauthesis@title}{\@tauthesis@fititle}
        \newcommand{\@tauthesis@subtitle}{\@tauthesis@fisubtitle}
        \newcommand{\@tauthesis@thesistype}{\@tauthesis@fithesistype}
        \newcommand{\@tauthesis@facultyname}{\@tauthesis@fifacultyname}
        \newcommand{\@tauthesis@programmename}{\@tauthesis@fiprogrammename}
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
        \newcommand{\@glossaryname}{Lyhenteet ja merkinnät}
        \newcommand{\@appendixname}{Liite}

        \NewDocumentCommand\@tauthesis@listoflistingstitle{}{\textsc{Ohjelma-~ja~algoritmiluettelo}}

        \NewDocumentCommand\@tauthesis@licensedUnder{m}{Tämä~työ~on~lisensoitu~lisenssin~##1~mukaisesti}

        \@langenglishfalse
    },

    mainlanguage / english .code:n = {
        \tl_set:Nn\@tauthesis@mainlanguage{english}
        \newcommand{\@tauthesis@abstractfile}{frontmatter/abstract.tex}
        \newcommand{\@tauthesis@abstractname}{Abstract}
        \newcommand{\@tauthesis@university}{Tampere~University}
        \newcommand{\@tauthesis@keywordname}{Keywords}
        \newcommand{\@tauthesis@prefacename}{Preface}
        \newcommand{\@tauthesis@originalitytext}{\@engoriginalitytext}
        \newcommand{\@tauthesis@logofile}{images/tau-logo-eng.eps}
        \newcommand{\@tauthesis@logofile@alttext}{Tampere University logo.}
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
        \newcommand{\@tauthesis@listpublicationname}{Original~publications}
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

        \newcommand{\@glossaryname}{List of Symbols and Abbreviations}
        \newcommand{\@appendixname}{Appendix}

        \NewDocumentCommand\@tauthesis@listoflistingstitle{}{\textsc{List~of~Programs~and~Algorithms}}

        \NewDocumentCommand\@tauthesis@licensedUnder{m}{This~work~is~licensed~under~##1}

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

% The above settings will not actually exist until this is called.

\ProcessKeyOptions[tauthesis]

% Now that the settings are known, we make a few more conditional decisions.

\int_compare:nTF {
    \@tauthesis@fithesistypeint
    ==
    \@tauthesis@enthesistypeint
} {
    \msg_info:nn { tauthesis } { thesis_types_match }
} {
    \msg_error:nn { tauthesis } { thesis_types_dont_match }
}

% Print serial number page for doctoral theses.


\DeclareDocumentCommand\@tauthesis@maketitle{}{
    \thispagestyle{empty}
    \vspace*{\@tauthesis@logoyoffset}
    \hspace*{\@tauthesis@logoxoffset}
    \includegraphics[width=8cm,alt={\@tauthesis@logofile@alttext}]{\@tauthesis@logofile}
    \par\medskip
    \vspace{102pt}
    {\raggedleft\fontsize{20pt}{0pt}\selectfont\@tauthesis@author\par}
    \vspace{2cm}
    {\raggedleft\bf\fontsize{25pt}{25pt}\selectfont\color{taupurple}%
        \textsc{\@tauthesis@title}\par}
    \vspace{1cm}
    {\raggedleft\scshape\fontsize{20pt}{20pt}\selectfont\color{taupurple}%
        \@tauthesis@subtitle\par}
    \vfill
    \begin{center}
    \color{red}
        \ExplSyntaxOn
        \int_compare:nTF{
            \@tauthesis@fithesistypeint
            >=
            \@tauthesis@doctoralthesistypeint
        }{
            \textbf{
                \tl_if_eq:NnTF{
                    \@tauthesis@mainlanguage
                }{
                    finnish
                }{
                    Tämä~ja~seuraava~sivu~korvataan~painotalossa.
                }{
                    This~and~the~following~page~will~be~replaced~at~the~printing~house.
                }
            }
        }{
            % Do not show printing house text for thesis types lower than doctoral thesis.
        }
        \ExplSyntaxOff
    \end{center}
    \vfill
    {\raggedleft%
        \@tauthesis@thesistype\\%
        \@tauthesis@facultyname\\%
        \DTMDisplaydate%
            {\the\year}%
            {\the\month}%
            {\the\day}{-1}%
    \par}
    \vspace{42pt}
    \clearpage
}

\NewDocumentCommand\serialNumberPage{}{
    \clearpage
    \begin{center}
        \null\vfill
        \tl_if_eq:NnTF{
            \@tauthesis@mainlanguage
        }{
            finnish
        }{
            Kirjasto~lisää~tälle~sivulle~työn~sarja-,~ISSN-~ja~ISBN-numerot.
        }{
            Library~will~add~the~thesis~series-,~ISSN-~and~ISBN~numbers~onto~this~page.
        }
        \vfill
        \begingroup\color{red}
            \textbf{
                \tl_if_eq:NnTF{
                    \@tauthesis@mainlanguage
                }{
                    finnish
                }{
                    Tämä~ja~edellinen~sivu~korvataan~painotalossa.
                }{
                    This~and~the~preceding~page~will~be~replaced~at~the~printing~house.
                }
            }
        \endgroup
    \end{center}
    \vfill
}

% Only include the serial number page if we are actually writing a doctoral thesis.

\int_compare:nTF{
    \@tauthesis@fithesistypeint
    <
    \@tauthesis@doctoralthesistypeint
}{
    \RenewDocumentCommand\serialNumberPage{}{\clearpage\pagenumbering{roman}}
}{
    % Keep the command as-is.
}

\newcommand{\mainmatter}{
    \int_compare:nTF
        {
            \@tauthesis@fithesistypeint
            <
            \@tauthesis@licentiatethesistypeint
        }
        {\clearpage}
        {\cleardoublepage}

    \int_compare:nTF
        {
            \@tauthesis@fithesistypeint
            >=
            \@tauthesis@licentiatethesistypeint
        }
        {
            \newcounter{temp}
            \setcounter{temp}{\value{page}}
        }
        {
            % Do nothing.
        }
    \pagenumbering{arabic}
    \int_compare:nTF
        {
            \@tauthesis@fithesistypeint
            >=
            \@tauthesis@licentiatethesistypeint}
        {
            \setcounter{page}{\value{temp}}
        }
        {
            % Do nothing.
        }
}

% Turn off LaTeX3 syntax, so packages relying on LaTeX2e do not break when they are loaded.

\ExplSyntaxOff

% Inherit from the report document class.
% Use 12pt nonetheless and scale fonts back
% to make maths closer to actual font size.
\LoadClass[12pt, a4paper]{report}

\RenewDocumentCommand\maketitle{}{\@tauthesis@maketitle}

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
    UprightFont = *-Regular,
]{FiraMono}

\RequirePackage{mathtools} % This should be loaded before unicode-math.

\RequirePackage{unicode-math}

\setmathfont{STIXTwoMath-Regular.ttf}[
  Path = fonts/STIXTwo/
]

\RequirePackage{newunicodechar}

% Create fallback symbols for the AI discpaimer page checkboxes.

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
\lstset{texcl=true, captionpos=b, commentstyle=\tt}

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
            >=
            \@tauthesis@licentiatethesistypeint
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

\ExplSyntaxOn

\int_compare:nTF {
    \@tauthesis@fithesistypeint
    >
    \@tauthesis@mastersthesistypeint
}{
    \def\@tauthesis@chapterFontSize{18pt}
    \def\@tauthesis@sectionFontSize{15pt}
    \def\@tauthesis@subSectionFontSize{13pt}
    \def\@tauthesis@subSubSectionFontSize{12pt}
}{
    \def\@tauthesis@chapterFontSize{21pt}
    \def\@tauthesis@sectionFontSize{18pt}
    \def\@tauthesis@subSectionFontSize{15pt}
    \def\@tauthesis@subSubSectionFontSize{13pt}
}

\ExplSyntaxOff

\def\@tauthesis@spaceBetweenNumberAndTitle{0em}

% Customize chapter titles
\titleformat{\chapter}[hang]
    {\raggedright\normalfont\scshape\bfseries\fontsize{\@tauthesis@chapterFontSize}{\@tauthesis@chapterFontSize}\selectfont}
    {\thechapter}
    {\@tauthesis@spaceBetweenNumberAndTitle}
    {~#1} % Include the chapter title text

% Adjust spacing around chapter titles
\titlespacing*{\chapter}
    {0pt} % Left margin
    {0pt} % Space above
    {20pt} % Space below

% Customize unnumbered chapter titles
\titleformat{name=\chapter,numberless}[hang]
    {\raggedright\normalfont\scshape\bfseries\fontsize{\@tauthesis@chapterFontSize}{\@tauthesis@chapterFontSize}\selectfont}
    {}
    {\@tauthesis@spaceBetweenNumberAndTitle}
    {#1} % Include the unnumbered chapter title text

% Adjust spacing around unnumbered chapter titles
\titlespacing*{name=\chapter,numberless}
    {0pt} % Left margin
    {0pt} % Space above
    {20pt} % Space below

% Customize section titles
\titleformat{\section}
    {\raggedright\normalfont\scshape\bfseries\fontsize{\@tauthesis@sectionFontSize}{\@tauthesis@sectionFontSize}\selectfont}
    {\thesection}
    {\@tauthesis@spaceBetweenNumberAndTitle}
    {~#1} % Include the section title text

% Customize unnumbered section titles
\titleformat{name=\section,numberless}
    {\raggedright\normalfont\scshape\bfseries\fontsize{\@tauthesis@sectionFontSize}{\@tauthesis@sectionFontSize}\selectfont}
    {}
    {\@tauthesis@spaceBetweenNumberAndTitle}
    {#1} % Include the unnumbered section title text

% Customize subsection titles
\titleformat{\subsection}
    {\raggedright\normalfont\scshape\bfseries\fontsize{\@tauthesis@subSectionFontSize}{\@tauthesis@subSectionFontSize}\selectfont}
    {\thesubsection}
    {\@tauthesis@spaceBetweenNumberAndTitle}
    {~#1} % Include the subsection title text

% Customize unnumbered subsection titles
\titleformat{name=\subsection,numberless}
    {\raggedright\normalfont\scshape\bfseries\fontsize{\@tauthesis@subSectionFontSize}{\@tauthesis@subSectionFontSize}\selectfont}
    {}
    {\@tauthesis@spaceBetweenNumberAndTitle}
    {#1} % Include the unnumbered subsection title text

% Customize subsubsection titles
\titleformat{\subsubsection}
    {\raggedright\normalfont\scshape\bfseries\fontsize{\@tauthesis@subSubSectionFontSize}{\@tauthesis@subSubSectionFontSize}\selectfont}
    {\thesubsubsection}
    {\@tauthesis@spaceBetweenNumberAndTitle}
    {~#1} % Include the subsubsection title text

% Customize unnumbered subsubsection titles
\titleformat{name=\subsubsection,numberless}
    {\raggedright\normalfont\scshape\bfseries\fontsize{11}{\@tauthesis@subSubSectionFontSize}\selectfont}
    {}
    {\@tauthesis@spaceBetweenNumberAndTitle}
    {#1} % Include the unnumbered subsubsection title text

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

% List of symbols and abbreviations
\RequirePackage[automake, nonumberlist, nopostdot]{glossaries}

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

\def\@tauthesis@tocChapterFontSize{13pt}
\def\@tauthesis@tocSectionFontSize{13pt}
\def\@tauthesis@tocSubSectionFontSize{13pt}
\def\@tauthesis@tocSubSubSectionFontSize{13pt}

\def\@tauthesis@tocChapterIndent@{0em}
\def\@tauthesis@tocSectionIndent{1em}
\def\@tauthesis@tocSubSectionIndent{2em}
\def\@tauthesis@tocSubSubSectionIndent{3em}

\def\myChapterNumberWidth{2em}
\def\mySectionNumberWidth{2em}
\def\mySubSectionNumberWidth{3.2em}
\def\mySubSubSectionNumberWidth{3.7em}

\def\@tauthesis@tocPageNumberSize{13pt}

\cftsetindents{chapter}{\@tauthesis@tocChapterIndent@}{\myChapterNumberWidth}
\cftsetindents{section}{\@tauthesis@tocSectionIndent}{\mySectionNumberWidth}
\cftsetindents{subsection}{\@tauthesis@tocSubSectionIndent}{\mySubSectionNumberWidth}
\cftsetindents{subsubsection}{\@tauthesis@tocSubSubSectionIndent}{\mySubSubSectionNumberWidth}

\lstset{texcl=true, captionpos=b, commentstyle=\tt}

\titlecontents
    {part}
    [0pt]
    {\bf}%
    {\thecontentslabel}{}{\hfill\contentspage}

\RenewDocumentCommand\lstlistlistingname{}{\@tauthesis@listoflistingstitle}

\newlistof[section]{listing}{lol}{\@tauthesis@listoflistingstitle}

\contentsuse{listing}{lol}

% Adjust style of content listings' titles.

\renewcommand{\cfttoctitlefont}{\scshape\bf\fontsize{\@tauthesis@chapterFontSize}{\@tauthesis@chapterFontSize}\selectfont}

\renewcommand{\cftloftitlefont}{\scshape\bf\fontsize{\@tauthesis@chapterFontSize}{\@tauthesis@chapterFontSize}\selectfont}

\renewcommand{\cftlottitlefont}{\scshape\bf\fontsize{\@tauthesis@chapterFontSize}{\@tauthesis@chapterFontSize}\selectfont}

\renewcommand{\cftloltitlefont}{\scshape\bf\fontsize{\@tauthesis@chapterFontSize}{\@tauthesis@chapterFontSize}\selectfont}

% Adjust spacing before and after ToC titles.

\NewDocumentCommand\tocTitleSpacing{}{1cm}

\setlength{\cftaftertoctitleskip}{\tocTitleSpacing}

\setlength{\cftafterloftitleskip}{\tocTitleSpacing}

\setlength{\cftafterlottitleskip}{\tocTitleSpacing}

\setlength{\cftafterloltitleskip}{\tocTitleSpacing}

% Adjust spacing between ToC items.

\NewDocumentCommand\tocItemSpacing{}{10pt}

\setlength{\cftbeforesecskip}{\tocItemSpacing}

\setlength{\cftbeforesubsecskip}{\tocItemSpacing}

\setlength{\cftbeforesubsubsecskip}{\tocItemSpacing}

% Add space between items in the list of figures, tables and listings.

\setlength{\cftbeforefigskip}{\tocItemSpacing}

\setlength{\cftbeforetabskip}{\tocItemSpacing}

\setlength{\cftbeforelistingskip}{\tocItemSpacing}

% Redefine ToC entries to use small caps, just like the titles themselves, with specific font sizes.

\renewcommand{\cftchapfont}{\fontsize{\@tauthesis@tocChapterFontSize}{\@tauthesis@sectionFontSize}\selectfont\scshape}
\renewcommand{\cftchappagefont}{\fontsize{\@tauthesis@tocPageNumberSize}{\@tauthesis@sectionFontSize}\selectfont\scshape}

\renewcommand{\cftsecfont}{\fontsize{\@tauthesis@tocSectionFontSize}{\@tauthesis@tocSectionFontSize}\selectfont\scshape}
\renewcommand{\cftsecpagefont}{\fontsize{\@tauthesis@tocPageNumberSize}{\@tauthesis@tocPageNumberSize}\selectfont\scshape}

\renewcommand{\cftsubsecfont}{\fontsize{\@tauthesis@tocSubSectionFontSize}{\@tauthesis@tocSubSubSectionFontSize}\selectfont\scshape}
\renewcommand{\cftsubsecpagefont}{\fontsize{\@tauthesis@tocPageNumberSize}{\@tauthesis@tocPageNumberSize}\selectfont\scshape}

\renewcommand{\cftsubsubsecfont}{\fontsize{\@tauthesis@tocSubSubSectionFontSize}{\@tauthesis@tocPageNumberSize}\selectfont\scshape}
\renewcommand{\cftsubsubsecpagefont}{\fontsize{\@tauthesis@tocPageNumberSize}{\@tauthesis@tocPageNumberSize}\selectfont\scshape}

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

\newenvironment{appendices}{
    \setcounter{chapter}{0}
    \renewcommand{\thechapter}{\Alph{chapter}}
    \renewcommand{\theHchapter}{\Alph{chapter}}

    % Customize chapter titles
    \titleformat{\chapter}[hang]
        {\raggedright\normalfont\scshape\bfseries\fontsize{\@tauthesis@chapterFontSize}{22}\selectfont}
        {\scshape\appendixname~\thechapter:}
        {1ex}
        {##1} % Include the chapter title text

    \titlecontents%
        {chapter}%
        [0pt]%
        {\vspace{8.5pt}}%
        {\raggedright\scshape\fontsize{\@tauthesis@tocChapterFontSize}{\@tauthesis@sectionFontSize}\selectfont\appendixname~\thecontentslabel:~}%
        {}%
        {\titlerule*[0.7pc]{.}\fontsize{\@tauthesis@tocPageNumberSize}{\@tauthesis@tocPageNumberSize}\selectfont\contentspage}

}{}

% Also adjust lists of figures and tables and listings.

\renewcommand{\cftfigfont}{\fontsize{\@tauthesis@tocSectionFontSize}{\@tauthesis@tocSectionFontSize}\selectfont}

\renewcommand{\cftfigpagefont}{\fontsize{\@tauthesis@tocPageNumberSize}{\@tauthesis@tocPageNumberSize}\selectfont}

\renewcommand{\cfttabfont}{\fontsize{\@tauthesis@tocSectionFontSize}{\@tauthesis@tocSectionFontSize}\selectfont}

\renewcommand{\cfttabpagefont}{\fontsize{\@tauthesis@tocPageNumberSize}{\@tauthesis@tocPageNumberSize}\selectfont}

% Renew the list if listings command such that we can modify how the listing entries appear.

\let\origlstlistoflistings\lstlistoflistings

\renewcommand{\lstlistoflistings}{%
    \begingroup
        \renewcommand{\l@lstlisting}[2]{%
            \@dottedtocline
                {1}
                {\@tauthesis@tocSectionIndent}
                {\mySectionNumberWidth}
                {\fontsize{\@tauthesis@tocSectionFontSize}{\@tauthesis@tocSectionFontSize}\selectfont##1}
                {\fontsize{\@tauthesis@tocPageNumberSize}{\@tauthesis@tocPageNumberSize}\selectfont##2}
        }
        \origlstlistoflistings
    \endgroup
}

\renewcommand{\cftlistingfont}{\fontsize{\@tauthesis@chapterFontSize}{\@tauthesis@chapterFontSize}\selectfont}

\renewcommand{\cftlistingpagefont}{\fontsize{\@tauthesis@tocPageNumberSize}{\@tauthesis@tocPageNumberSize}\selectfont}

% Flexible list modifications
\RequirePackage{enumitem}

\setlist{itemsep=-3pt, labelindent=1.27cm}

\urlstyle{same}

%%%%% COMMAND DEFINITIONS %%%%%

% Functional language selection
\newcommand{\xselectlanguage}[1]{%
  \begingroup\edef\x{\endgroup
    \noexpand\selectlanguage{#1}}\x
}

\NewDocumentCommand\titlepagematter{}{
    \clearpage
    \pagenumbering{gobble}
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

% Make the abstracts
\renewcommand{\abstract}{
    \clearpage
    \chapter*{\@tauthesis@abstractname}
        \begingroup
            \setlength{\parindent}{0pt}
            \setlength{\parskip}{3pt}
            \fontsize{11pt}{13pt}\selectfont
            \def\metaSep{2pt}
            \noindent\@tauthesis@author\\[\metaSep]
            \@tauthesis@title\@tauthesis@subtitle@joiner\@tauthesis@subtitle\\[\metaSep]
            \noindent\@tauthesis@thesistype\\[\metaSep]
            \noindent\@tauthesis@university\\[\metaSep]
            \noindent\@tauthesis@programmename\\[\metaSep]
            \noindent\DTMDisplaydate%
                {\the\year}%
                {\the\month}%
                {\the\day}{-1}
            \par
            \makebox[\linewidth]{\color{taupurple}\rule{\linewidth}{1.5pt}}
            \par
            \vspace*{\parskip}
            \input{\@tauthesis@abstractfile}\par
            \medskip
            \begin{minipage}{\linewidth}
                \textbf{\@tauthesis@keywordname:}
                \@tauthesis@keywords
            \end{minipage}
            \par
            \medskip
            \begin{minipage}{\linewidth}
                \@tauthesis@originalitytext
            \end{minipage}
        \endgroup
    \clearpage
}
\newcommand{\otherabstract}{
    \clearpage
    \xselectlanguage{\@tauthesis@otherlanguage}
    \chapter*{\@tauthesis@otherabstractname}
    \begingroup
        \setlength{\parindent}{0pt}
        \setlength{\parskip}{3pt}
        \fontsize{11pt}{13pt}\selectfont
        \def\metaSep{2pt}
        \noindent\@tauthesis@author\\[\metaSep]
        \@tauthesis@othertitle\@tauthesis@othersubtitle@joiner\@tauthesis@othersubtitle\\[\metaSep]
        \noindent\@tauthesis@otherthesistype\\[\metaSep]
        \noindent\@tauthesis@otheruniversity\\[\metaSep]
        \noindent\@tauthesis@otherprogrammename\\[\metaSep]
        \noindent\DTMDisplaydate%
            {\the\year}%
            {\the\month}%
            {\the\day}{-1}
        \par
        \noindent\makebox[\linewidth]{\color{taupurple}\rule{\linewidth}{1.5pt}}
        \par
        \vspace*{\parskip}
        \input{\@tauthesis@otherabstractfile}\par
        \medskip
        \begin{minipage}{\linewidth}
        \textbf{\@tauthesis@otherkeywordname:}
        \@tauthesis@otherkeywords
        \end{minipage}
        \par
        \medskip
        \begin{minipage}{\linewidth}
        \@tauthesis@otheroriginalitytext
        \end{minipage}
    \endgroup
    \xselectlanguage{\@tauthesis@mainlanguage}
}

% Make the preface
\newcommand{\preface}[1]{
    \clearpage
    \chapter*{\@tauthesis@prefacename}
    \noindent\input{frontmatter/preface.tex}\par
    \bigskip
    \DTMlangsetup[en-GB,finnish]{showdayofmonth=true}
    \noindent#1,
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

% Make the author's contribution
\newcommand{\authorcontribution}{
    \section*{\large\@tauthesis@authorcontributionname}
    \input{frontmatter/authorcontribution.tex}
    \cleardoublepage
}

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
    \authorcontribution
}


% The \publicationmatter command
\newcommand{\publicationmatter}{
    \pagebreak
    \fancyhf{}
    \addtocontents{toc}{\protect\setcounter{tocdepth}{-10}}
    \part*{\MakeUppercase\@tauthesis@publicationplural}
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
    \addcontentsline{toc}{chapter}{\fontsize{\@tauthesis@tocChapterFontSize}{\@tauthesis@tocChapterFontSize}\selectfont\@tauthesis@publicationname{} \Roman{publication}}
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

% Disable publication-related commands if thesis type below
% doctoral thesis or publications manually disables via
% disabled via class input argument.

\ExplSyntaxOn

\bool_if:nTF{
    \@tauthesis@includePublications
}{
    \int_compare:nTF {
        \@tauthesis@fithesistypeint
        >=
        \@tauthesis@licentiatethesistypeint
    } {
        \relax
    } {
        \RenewDocumentCommand\publicationmatter{}{\relax}
        \RenewDocumentCommand\listofpublications{}{\relax}
        \RenewDocumentCommand\nonFreePublication{mm}{\relax}
        \RenewDocumentCommand\licensedPublication{mmm}{\relax}
    }
}{
    \RenewDocumentCommand\publicationmatter{}{\relax}
    \RenewDocumentCommand\listofpublications{}{\relax}
    \RenewDocumentCommand\nonFreePublication{mm}{\relax}
    \RenewDocumentCommand\licensedPublication{mmm}{\relax}
}

\ExplSyntaxOff

% Disable lists of figures and such with bachelor's theses.
% Ideally this would have been done by saving custom counter
% values to LaTeX aux files and reading them, but this is an initial solution for now.

\ExplSyntaxOn

\newlength\tableOfContentsTitleRaise
\setlength\tableOfContentsTitleRaise{-2cm}

\NewDocumentCommand\tableOfContents{}{
    \clearpage
    \vspace*{\tableOfContentsTitleRaise}
    \tableofcontents
}


\NewDocumentCommand\listOfFigures{}{
    \clearpage
    \vspace*{\tableOfContentsTitleRaise}
    \listoffigures
}

\NewDocumentCommand\listOfTables{}{
    \clearpage
    \vspace*{\tableOfContentsTitleRaise}
    \listoftables
}

\NewDocumentCommand\listOfListings{}{
    \clearpage
    \vspace*{\tableOfContentsTitleRaise}
    \lstlistoflistings
}


\int_compare:nTF {
    \@tauthesis@fithesistypeint
    >=
    \@tauthesis@mastersthesistypeint
} {
    \bool_if:nTF{
        \@tauthesis@includeListOfFigures
    }{
        \relax
    }{
        \RenewDocumentCommand\listOfFigures{}\relax
    }
    \bool_if:nTF{
        \@tauthesis@includeListOfTables
    }{
        \relax
    }{
        \RenewDocumentCommand\listOfTables{}\relax
    }
    \bool_if:nTF{
        \@tauthesis@includeListOfListings
    }{
        \relax
    }{
        \RenewDocumentCommand\listOfListings{}\relax
    }
} {
    \RenewDocumentCommand\listOfFigures{}\relax
    \RenewDocumentCommand\listOfTables{}\relax
    \RenewDocumentCommand\listOfListings{}\relax
}

\ExplSyntaxOff


% Place PDF metadata into an external main.xmpdata file.

% \begin{filecontents*}[overwrite]{\jobname.xmpdata}
% \Title{\@tauthesis@title\@tauthesis@subtitle@joiner\@tauthesis@subtitle}
% \Author{\@tauthesis@author}
% \Language{\@tauthesis@mainlanguage}
% \Keywords{\@tauthesis@fikeywords, \@tauthesis@enkeywords}
% \Subject{\@tauthesis@subject}
% \end{filecontents*}

%% Load the data from the metadata file with pdfx.

\PassOptionsToPackage{hyperref}{pdfa}

% \RequirePackage[a-2b,mathxmp]{pdfx}
% \catcode30=12

\RequirePackage{hyperref}

\ExplSyntaxOn
\tl_if_eq:NnTF{
    \@tauthesis@mainlanguage
}{
    finnish
}{
    \hypersetup{
        colorlinks=true,
        linkcolor=taupurple,
        citecolor=taupurple,
        urlcolor=blue,
        filecolor=magenta,
        pdftitle = {\@tauthesis@fititle},
        pdfauthor={\@tauthesis@author},
        pdfsubject={\@tauthesis@subject},
        pdfkeywords={\@tauthesis@fikeywords},
    }
}{
    \hypersetup{
        colorlinks=true,
        linkcolor=taupurple,
        citecolor=taupurple,
        urlcolor=blue,
        filecolor=magenta,
        pdftitle = {\@tauthesis@entitle},
        pdfauthor={\@tauthesis@author},
        pdfsubject={\@tauthesis@subject},
        pdfkeywords={\@tauthesis@enkeywords\@tauthesis@enkeywords},
    }
}
\ExplSyntaxOff

\makeatother

\endinput
