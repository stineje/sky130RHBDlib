%
% \subsection{The Class File}
%    \begin{macrocode}
%<!COPYRIGHT>
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{standalone}[%
%<!DATE>
%<!VERSION>
%<*DRIVER>
    2099/01/01 develop
%</DRIVER>
    Class to compile TeX sub-files standalone]
%    \end{macrocode}
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{If-Switches}
%
% \begin{macro}{\ifstandalone}
% This if-switch is defined by both the class and package. This class sets
% it to true while the package (loaded by the main document) sets it to false.
%    \begin{macrocode}
\newif\ifstandalone
\standalonetrue
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\ifstandalonebeamer}
% This if-switch is defined by both the class and package. This class sets
% it to true only if the |beamer| option was given. The package (loaded by the main document) sets it always to false.
%    \begin{macrocode}
\newif\ifstandalonebeamer
\standalonebeamerfalse
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\onlyifstandalone}
% Macro version of |\ifstandalone|. The |{ }| around the argument protects the content from the package etc. scanners.
%    \begin{macrocode}
\let\onlyifstandalone\@firstofone
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\IfStandalone}[2]{true clause}{false clause}
% Macro version of |\ifstandalone .. \else .. \fi|. The |{ }| around the argument protects the content from the package etc. scanners.
%    \begin{macrocode}
\let\IfStandalone\@firstoftwo
%    \end{macrocode}
% \end{macro}
%
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{Code for border values}
% The following macros are used to parse the \opt{border} option.
%
% \begin{macro}{\sa@border@left}
% \begin{macro}{\sa@border@right}
% \begin{macro}{\sa@border@top}
% \begin{macro}{\sa@border@margin}
%    \begin{macrocode}
\def\sa@border@left{0.50001bp}
\let\sa@border@right\sa@border@left
\let\sa@border@top\sa@border@left
\let\sa@border@bottom\sa@border@left
%    \end{macrocode}
% \end{macro}
% \end{macro}
% \end{macro}
% \end{macro}
%
%
% \begin{macro}{\rem@bp}
%    \begin{macrocode}
\def\rem@bp#1bp\relax#2\@nnil{#1}%
%    \end{macrocode}
% \end{macro}
%
%
% \begin{macro}{\default@bp}
%    \begin{macrocode}
\def\default@bp#1#2{%
    \begingroup
    \afterassignment\remove@to@nnil
    \dimen@ #2bp\relax\@nnil
    \expandafter
    \endgroup
    \expandafter
    \def\expandafter#1\expandafter{\the\dimen@}%
}
%    \end{macrocode}
% \end{macro}
%
%
% \begin{macro}{\sa@readborder}
%    \begin{macrocode}
\def\sa@readborder#1 #2 #3 #4 #5\@nnil{%
    \ifx\\#2#3#4\\%
        \default@bp\sa@border@left{#1}%
        \let\sa@border@right\sa@border@left
        \let\sa@border@top\sa@border@left
        \let\sa@border@bottom\sa@border@left
    \else
    \ifx\\#4\\%
        \default@bp\sa@border@left{#1}%
        \let\sa@border@right\sa@border@left
        \default@bp\sa@border@top{#2}%
        \let\sa@border@bottom\sa@border@top
    \else
        \default@bp\sa@border@left{#1}%
        \default@bp\sa@border@bottom{#2}%
        \default@bp\sa@border@right{#3}%
        \default@bp\sa@border@top{#4}%
    \fi\fi
}%
%    \end{macrocode}
% \end{macro}
%
% Define if-switches for TeX formats.
% This loads the corresponding packages if available, but falls back to some own code if they are not installed.
%    \begin{macrocode}
\expandafter\ifx\csname ShellEscape\endcsname\relax
    \IfFileExists{shellesc.sty}{
        \RequirePackage{shellesc}
        \@ifpackagelater{shellesc}{2016/04/29}{
        }{
            \protected\def\ShellEscape{\immediate\write18 }
        }
    }{
        \protected\def\ShellEscape{\immediate\write18 }
    }
\fi
\expandafter\ifx\csname ifluatex\endcsname\relax
    \IfFileExists{ifluatex.sty}{\@firstoftwo}{\@secondoftwo}{%
        \RequirePackage{ifluatex}
    }{
        \begingroup
        \expandafter\ifx\csname directlua\endcsname\relax
            \endgroup
            \expandafter\let\csname ifluatex\expandafter\endcsname\csname iffalse\endcsname
        \else
            \endgroup
            \expandafter\let\csname ifluatex\expandafter\endcsname\csname iftrue\endcsname
        \fi
    }
\fi
\expandafter\ifx\csname ifpdf\endcsname\relax
    \IfFileExists{ifpdf.sty}{\@firstoftwo}{\@secondoftwo}{%
        \RequirePackage{ifpdf}
    }{
        \begingroup
        \expandafter\ifx\csname pdfoutput\endcsname\relax
            \endgroup
            \expandafter\let\csname ifpdf\expandafter\endcsname\csname iffalse\endcsname
        \else
            \endgroup
            \ifnum\pdfoutput<1
                \expandafter\let\csname ifpdf\expandafter\endcsname\csname iffalse\endcsname
            \else
                \expandafter\let\csname ifpdf\expandafter\endcsname\csname iftrue\endcsname
            \fi
        \fi
    }
\fi
\expandafter\ifx\csname ifxetex\endcsname\relax
    \IfFileExists{ifxetex.sty}{\@firstoftwo}{\@secondoftwo}{%
        \RequirePackage{ifxetex}
    }{
        \begingroup
        \expandafter\ifx\csname XeTeXrevision\endcsname\relax
            \endgroup
            \expandafter\let\csname ifxetex\expandafter\endcsname\csname iffalse\endcsname
        \else
            \endgroup
            \expandafter\let\csname ifxetex\expandafter\endcsname\csname iftrue\endcsname
        \fi
    }
\fi
%    \end{macrocode}
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{Options}
%
%    \begin{macrocode}
\let\sa@classoptionslist\@classoptionslist
\RequirePackage{xkeyval}
\newif\ifsa@preview
\newif\ifsa@crop
\newif\ifsa@multi
\newif\ifsa@multido
\newif\ifsa@varwidth
\newif\ifsa@ignorerest
\newif\ifsa@ignoreempty
\newif\ifsa@tikz
\newif\ifsa@pstricks
\newif\ifsa@convert
\newif\ifsa@float
\newif\ifsa@math
\newif\ifsa@convert@perpage
%    \end{macrocode}
%
% The \cs{ifstandalonebeamer} switch is in the user-level.
% Wire the setter macros to the internal naming scheme, so that \Macro\sa@boolean can be used with it.
%    \begin{macrocode}
\let\sa@beamertrue\standalonebeamertrue
\let\sa@beamerfalse\standalonebeamerfalse
%    \end{macrocode}
%
% \begin{macro}{\sa@clsoption}
% Wrapper macro to define options.
%    \begin{macrocode}
\def\sa@clsoption{%
    \define@key{standalone.cls}%
}
%    \end{macrocode}
% \end{macro}
%
%
% \begin{key}{standalone.cls}{border}
% Sets the border around the content.
%    \begin{macrocode}
\sa@clsoption{border}{%
    \sa@readborder#1 {} {} {} {} \@nnil
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls}{margin}
% Alias for \opt{border}.
%    \begin{macrocode}
\sa@clsoption{margin}{%
    \sa@readborder#1 {} {} {} {} \@nnil
}
%    \end{macrocode}
% \end{key}
%
% \begin{macro}{\sa@boolean}[2]{name of if-switch}{`true' or `false'}
% Sets if-switches.
%    \begin{macrocode}
\def\sa@boolean#1#2{%
    \sa@boolorvalue{#1}{#2}%
        {\ClassError{standalone}{Invalid value '#2' for boolean key '#1'}{}}%
}
%    \end{macrocode}
% \end{macro}
%
%
% \begin{macro}{\sa@boolorvalue}[2]{name of if-switch}{`true', `false' or a value}{code to be executed if it is a value.}
% Sets if-switches.
%    \begin{macrocode}
\def\sa@boolorvalue#1#2{%
    \begingroup
    \edef\@tempa{#2}%
    \def\@tempb{true}%
    \ifx\@tempa\@tempb
        \endgroup
        \csname sa@#1true\endcsname
        \expandafter\@gobble
    \else
    \def\@tempb{false}%
    \ifx\@tempa\@tempb
        \endgroup
        \csname sa@#1false\endcsname
        \expandafter\expandafter
        \expandafter\@gobble
    \else
        \endgroup
        \expandafter\expandafter
        \expandafter\@firstofone
    \fi\fi
}
%    \end{macrocode}
% \end{macro}
%
%
%
%
% \begin{key}{standalone.cls}{preview}
% Boolean to control if \pkg{preview} package should be used.
%    \begin{macrocode}
\sa@clsoption{preview}[true]{%
    \sa@boolean{preview}{#1}%
    \ifsa@preview
        \setkeys{standalone.cls}{crop=false,float=false}%
    \fi
}
\sa@previewtrue
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls}{crop}
% Boolean to control if own code should be used.
% That code boxes the content and resizes the page to match the box dimensions.
%    \begin{macrocode}
\sa@clsoption{crop}[true]{%
    \sa@boolean{crop}{#1}%
    \ifsa@crop
        \setkeys{standalone.cls}{preview=false,float=false}%
    \fi
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls}{ignorerest}
% Boolean to control if all other code outside of specified environments should be explicit ignored.
% That code boxes the outside content and then than discards it.
%    \begin{macrocode}
\sa@clsoption{ignorerest}[true]{%
    \sa@boolean{ignorerest}{#1}%
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls}{ignoreempty}
% Boolean to control if empty boxes/pages should be ignored.
% This is intended mostly for the \opt{multi} option and currently only works with \opt{crop} but not with \opt{preview}.
%    \begin{macrocode}
\sa@clsoption{ignoreempty}[true]{%
    \sa@boolean{ignoreempty}{#1}%
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls}{multi}
% Boolean to control if multiple pages are used.
%    \begin{macrocode}
\sa@clsoption{multi}[true]{%
    \sa@boolorvalue{multi}{#1}{\sa@multitrue\AtBeginDocument{\standaloneenv{#1}}}%
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls}{multido}
% Boolean to control if the \Macro\multido macro from the \pkg{multido} package should be
% loaded and redefined to create a separate page per iteration automatically.
%    \begin{macrocode}
\sa@clsoption{multido}[true]{%
    \sa@boolean{multido}{#1}%
    \ifsa@multido
        \setkeys{standalone.cls}{multi=samultido}%
    \fi
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls}{math}
%    \begin{macrocode}
\sa@clsoption{math}[true]{%
    \sa@boolean{math}{#1}%
    \ifsa@math
        \setkeys{standalone.cls}{multi=true,ignoreempty=true,border=0.50001bp}%
    \fi
}
\AtBeginDocument{\ifsa@math\sa@math\fi}
%    \end{macrocode}
% \end{key}
%
% \begin{macro}{\sa@math}
% Enables a simple support for multiple math equations.
% Displaymath is typeset as in-text math but with \cs{displaystyle} in effect.
% This allows \Macro\(, \Macro\), \Macro\[ and \Macro\] as well as \env{math} and \env{displaymath}.
% To simply typeset multiple equations two environments \env{multimath} and \env{multidisplaymath}
% are defined which use \Macro\\ as a delimiter. Every equation will be placed on a tight page on its own.
% To allow a trailing \Macro\\ the \opt{ignoreempty} is automatically enabled.
%    \begin{macrocode}
\def\sa@math{%
    \standaloneenv{math}%
    \def\({\begingroup\math}%
    \def\){\endmath\endgroup}%
    \def\[{\(\displaystyle}%
    \def\]{\)}%
    \def\displaymath{\math\displaystyle}%
    \def\enddisplaymath{\endmath}%
    \newcommand*\multimathsep{%
        \endmath
        \math
        \let\\\multimathsep
    }%
    \newenvironment{multimath}{%
        \math
        \let\\\multimathsep
    }{%
        \endmath
    }%
    \newcommand*\multidisplaymathsep{%
        \endmath
        \math\displaystyle
        \let\\\multidisplaymathsep
    }%
    \newenvironment{multidisplaymath}{%
        \math\displaystyle
        \let\\\multidisplaymathsep
    }{%
        \endmath
    }%
}
%    \end{macrocode}
% \end{macro}
%
%
% \begin{key}{standalone.cls}{varwidth}
% Boolean to control if \pkg{varwidth} package should be used.
% If so the content will be placed in a \env{varwidth} environment to avoid extending it to the full line width if a
% paragraph break is inserted.
%
% The option is by default set to true if the \pkg{varwidth} package is available.
%    \begin{macrocode}
\sa@clsoption{varwidth}[true]{%
    \sa@boolorvalue{varwidth}{#1}{\sa@varwidthtrue\def\sa@width{#1}}%
    \ifsa@varwidth
        \def\sa@varwidth{\varwidth{\sa@width}}%
        \def\sa@endvarwidth{\endvarwidth}%
    \else
        \let\sa@varwidth\@empty
        \let\sa@endvarwidth\@empty
    \fi
}
\let\sa@varwidth\@empty
\let\sa@endvarwidth\@empty
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls}{tikz}
%    \begin{macrocode}
\sa@clsoption{tikz}[true]{%
    \sa@boolean{tikz}{#1}%
    \ifsa@tikz
        \setkeys{standalone.cls}{multi=tikzpicture,varwidth=false}%
    \fi
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls}{pstricks}
%    \begin{macrocode}
\sa@clsoption{pstricks}[true]{%
    \sa@boolean{pstricks}{#1}%
    \ifsa@pstricks
        \setkeys{standalone.cls}{multi=pspicture,varwidth=false}%
    \fi
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls}{beamer}
% Boolean to control if the \cls{beamer} class is used.
%
% If true sets the class to \cls{beamer} and switches \opt{preview} off.
% If false the default class is restored if the current class was \cls{beamer}.
%    \begin{macrocode}
\sa@clsoption{beamer}[true]{%
    \sa@boolean{beamer}{#1}%
    \ifstandalonebeamer
        \def\sa@class{beamer}%
        \setkeys{standalone.cls}{preview=false,crop=false,varwidth=false}%
    \else
        \begingroup
        \def\@tempa{beamer}%
        \ifx\@tempa\sa@class
            \endgroup
            \def\sa@class{article}%
        \else
            \endgroup
        \fi
    \fi
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls}{class}
%    \begin{macrocode}
\sa@clsoption{class}{%
    \def\sa@class{#1}%
}
\def\sa@class{article}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls}{float}
%    \begin{macrocode}
\sa@clsoption{float}[true]{%
    \sa@boolean{float}{#1}%
    \ifsa@float
        \let\@float\sa@origfloat
        \let\end@float\sa@origendfloat
    \else
        \ifx\@float\sa@nofloat\else
            \let\sa@origfloat\@float
        \fi
        \ifx\end@float\sa@endnofloat\else
            \let\sa@origendfloat\end@float
        \fi
        \let\@float\sa@nofloat
        \let\end@float\sa@endnofloat
    \fi
}
\def\sa@nofloat#1{%
    \def\@captype{#1}%
    \trivlist\item[]%
    \@ifnextchar[{%
        \begingroup
        \def\@tempa[####1]{%
            \endgroup
        }\@tempa
    }{}%
}
\def\sa@endnofloat{%
    \endtrivlist
}
%    \end{macrocode}
% \end{key}
%
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% \begin{key}{standalone.cls}{convert}
%    \begin{macrocode}
\sa@clsoption{convert}[]{%
    \setkeys{standalone.cls/convert}{true,#1}%
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls}{disable@convert}
%    \begin{macrocode}
\sa@clsoption{disable@convert}[]{%
    \typeout{Disable conversion}
    \sa@convertfalse
    \let\sa@converttrue\relax
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{macro}{\sa@convertoption}
% Wrapper to define \opt{convert} options.
%    \begin{macrocode}
\def\sa@convertoption{%
    \define@key{standalone.cls/convert}%
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\sa@convertvar}[2]{name}{initial value}
% Wrapper to define \opt{convert} variables.
%    \begin{macrocode}
\def\sa@convertvar#1#2{%
    \define@key{standalone.cls/convert}{#1}{%
        \@namedef{sa@convert@#1}{##1}%
    }%
    \@namedef{sa@convert@#1}{#2}%
}
%    \end{macrocode}
% \end{macro}
%
%
% \begin{key}{standalone.cls/convert}{true}
%    \begin{macrocode}
\sa@convertoption{true}[]{%
    \sa@converttrue
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls/convert}{false}
%    \begin{macrocode}
\sa@convertoption{false}[]{%
    \sa@convertfalse
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls/convert}{realmainfile}
%    \begin{macrocode}
\sa@convertoption{realmainfile}[]{%
    \RequirePackage{currfile-abspath}%
    \getmainfile
    \let\sa@convert@mainfile\themainfile
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls/convert}{png}
%    \begin{macrocode}
\sa@convertoption{png}[]{%
    \setkeys{standalone.cls/convert}{true,outext={.png}}%
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls}{png}
%    \begin{macrocode}
\sa@clsoption{png}[]{%
    \setkeys{standalone.cls/convert}{png,#1}%
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls/convert}{jpg}
%    \begin{macrocode}
\sa@convertoption{jpg}[]{%
    \setkeys{standalone.cls/convert}{true,outext={.jpg}}%
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls}{jpg}
%    \begin{macrocode}
\sa@clsoption{jpg}[]{%
    \setkeys{standalone.cls/convert}{jpg,#1}%
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls/convert}{gif}
%    \begin{macrocode}
\sa@convertoption{gif}[]{%
    \setkeys{standalone.cls/convert}{true,imagemagick,outext={.gif}}%
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls}{gif}
%    \begin{macrocode}
\sa@clsoption{gif}[]{%
    \setkeys{standalone.cls/convert}{gif,#1}%
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls/convert}{svg}
%    \begin{macrocode}
\sa@convertoption{svg}[]{%
    \setkeys{standalone.cls/convert}{true,inkscape,outext={.svg}}%
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls}{svg}
%    \begin{macrocode}
\sa@clsoption{svg}[]{%
    \setkeys{standalone.cls/convert}{svg,#1}%
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls/convert}{emf}
%    \begin{macrocode}
\sa@convertoption{emf}[]{%
    \setkeys{standalone.cls/convert}{true,inkscape,outext={.emf}}%
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls}{emf}
%    \begin{macrocode}
\sa@clsoption{emf}[]{%
    \setkeys{standalone.cls/convert}{emf,#1}%
}
%    \end{macrocode}
% \end{key}
%
%
% \begin{key}{standalone.cls/convert}{onfailure}
%    \begin{macrocode}
\sa@convertoption{onfailure}{%
    \begingroup
    \edef\@tempa{#1}%
    \def\@tempb{error}%
    \ifx\@tempa\@tempb
        \endgroup
        \let\sa@convert@failuremsg\ClassError
    \else
    \def\@tempb{warning}%
    \ifx\@tempa\@tempb
        \endgroup
        \let\sa@convert@failuremsg\ClassWarning
    \else
    \def\@tempb{info}%
    \ifx\@tempa\@tempb
        \endgroup
        \let\sa@convert@failuremsg\ClassInfo
    \else
    \def\@tempb{ignore}%
    \ifx\@tempa\@tempb
        \endgroup
        \def\sa@convert@failuremsg##1##2##3{}%
        \let\sa@convert@notfoundmsg\@gobbletwo
    \else
        \let\on@line\@empty
        \ClassError{standalone}{Invalid value '\@tempa' for the 'onfailure' option.\MessageBreak
                                Valid values: 'error', 'warning', 'info', 'ignore'}{}%
        \endgroup
    \fi\fi\fi\fi
}
\let\sa@convert@failuremsg\ClassWarning
\let\sa@convert@notfoundmsg\ClassWarning
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls/convert}{perpage}
% Boolean key to indicate to run the convert command once per page.
%    \begin{macrocode}
\sa@convertoption{perpage}[true]{%
    \sa@boolean{convert@perpage}{#1}%
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls/convert}{gsdevice}
%    \begin{macrocode}
\sa@convertoption{defgsdevice}{%
    \sa@defgsdevice#1\relax\relax
}
\def\sa@defgsdevice#1#2{%
    \@namedef{sa@gsdevice@#1}{#2}%
}
\@namedef{sa@gsdevice@.jpg}{jpeg}%
\@namedef{sa@gsdevice@.png}{png16m}%
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls/convert}{command}
%    \begin{macrocode}
\sa@convertoption{command}{%
    \def\sa@convert@command{#1}%
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls/convert}{pdf2svg}
%    \begin{macrocode}
\sa@convertoption{pdf2svg}[]{%
    \def\sa@convert@command{pdf2svg \infile\space\outfile}%
    \sa@convertvar{outext}{.svg}
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls/convert}{imagemagick}
%    \begin{macrocode}
\sa@convertoption{imagemagick}[]{%
    \def\sa@convert@command{\convertexe\space 
        -density \density\space
        -units PixelsPerInch 
        \infile\ifsa@convert@perpage[\prevpagenum]\fi\space
        -scene 1
        \ifx\size\empty\else -resize \size\fi\space
        -quality 90 \outfile}%
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls/convert}{ghostscript}
%    \begin{macrocode}
\sa@convertoption{ghostscript}[]{%
    \def\sa@convert@command{\gsexe\space -dSAFER -dBATCH -dNOPAUSE 
        \ifsa@convert@perpage-sPageList=\pagenum\fi\space
        -sDEVICE=\gsdevice\space
        -r\density\space 
        -sOutputFile=\outfile\space \infile
    }%
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls/convert}{ghostscript32}
%    \begin{macrocode}
\sa@convertoption{ghostscript32}[]{%
    \setkeys{standalone.cls/convert}{ghostscript,gsexe=\@nameuse{sa@convert@gsexe32}}%
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls/convert}{ghostscript64}
%    \begin{macrocode}
\sa@convertoption{ghostscript64}[]{%
    \setkeys{standalone.cls/convert}{ghostscript,gsexe=\@nameuse{sa@convert@gsexe64}}%
}
%    \end{macrocode}
% \end{key}
%
% \begin{key}{standalone.cls/convert}{inkscape}
%    \begin{macrocode}
\sa@convertoption{inkscape}[]{%
    \def\sa@convert@command{\inkscapeexe\space 
        --pdf-poppler \sa@inkscape@bgcolor\space
        --export-type="\expandafter\@gobble\outext"
        --pdf-page=\pagenum\space
        -o \outfile\space \infile}
    \sa@convert@perpagetrue
    \def\sa@multi@pagemark{\pagenum}%
}
\def\sa@inkscape@bgcolor{\ifx\sa@convert@bgcolor\@empty\else--actions="export-background:\sa@convert@bgcolor"\fi}
%    \end{macrocode}
% \end{key}
%
%    \begin{macrocode}
\sa@convertvar{latexoptions}{ -shell-escape \ifx\outputdir\empty\else-output-directory \sa@convert@quote\outputdir\sa@convert@quote\fi\space}
\sa@convertvar{subjobname}{\jobname}
\sa@convertvar{mainfile}{\jobname}
\sa@convertvar{quote}{}
\let\sa@convert@quote\relax
\sa@convertvar{size}{}
\sa@convertvar{inname}{\subjobname}
\sa@convertvar{infile}{\indir\inname\inext}
\sa@convertvar{outputdir}{}
\sa@convertvar{indir}{\outputdir}
\sa@convertvar{outdir}{\outputdir}
\sa@convertvar{outext}{.png}
\sa@convertvar{outname}{\inname}
\sa@convertvar{outfile}{\outdir\outname\ifsa@multi\sa@multi@pagemark\fi\outext}
\def\sa@multi@pagemark{-\percent0d}
\def\sa@convert@pagenum{1}
\sa@convertvar{density}{300}
\sa@convertvar{bgcolor}{}
\sa@convertvar{gsdevice}{%
    \expandafter\ifx\csname sa@gsdevice@\outext\endcsname\relax
        \expandafter\@gobble\outext
    \else
        \csname sa@gsdevice@\outext\endcsname
    \fi
}
\ifluatex
    \sa@convertvar{latex}{lualatex}
    \sa@convertvar{inext}{.pdf}
    \sa@convertvar{precommand}{}
    \setkeys{standalone.cls/convert}{ghostscript}
\else
\ifpdf
    \sa@convertvar{latex}{pdflatex}
    \sa@convertvar{inext}{.pdf}
    \sa@convertvar{precommand}{}
    \setkeys{standalone.cls/convert}{ghostscript}
\else
\ifxetex
    \sa@convertvar{latex}{xelatex}
    \sa@convertvar{inext}{.pdf}
    \sa@convertvar{precommand}{}
    \setkeys{standalone.cls/convert}{ghostscript}
\else
    \sa@convertvar{latex}{latex}
    \sa@convertvar{inext}{.ps}
    \sa@convertvar{precommand}{dvips \subjobname.dvi}
    \setkeys{standalone.cls/convert}{ghostscript}
\fi\fi\fi
%    \end{macrocode}
%
% Test for windows to set executable correctly.
%    \begin{macrocode}
\begingroup
\ifluatex
  \csname @tempswa\directlua{
      if os.type == "windows" then
        tex.sprint("true")
      else
        tex.sprint("false")
      end
    }\endcsname
\else
    \IfFileExists{/dev/null}{\@tempswafalse}{\@tempswatrue}%
\fi
\if@tempswa
    \endgroup
    \@namedef{sa@convert@gsexe32}{gswin32c}
    \@namedef{sa@convert@gsexe64}{gswin64c}
\else
    \endgroup
    \@namedef{sa@convert@gsexe32}{gs}
    \@namedef{sa@convert@gsexe64}{gs}
\fi
\sa@convertvar{gsexe}{\@nameuse{sa@convert@gsexe64}}
\sa@convertvar{convertexe}{magick convert}
\sa@convertvar{inkscapeexe}{inkscape}
%    \end{macrocode}
%
%
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{General macros}
%
% \begin{macro}{\standaloneenv}[1]{comma separated list if environment names}
% Loops over all environment names and calls \Macro\@standaloneenv on them.
%    \begin{macrocode}
\newcommand*\standaloneenv[1]{%
    \begingroup
    \edef\@tempa{\endgroup\noexpand\@for\noexpand\@tempa:=\zap@space#1 \@empty}%
    \@tempa\do{\expandafter\@standaloneenv\expandafter{\@tempa}}%
    \setkeys{standalone.cls}{multi}%
}
\@onlypreamble\standaloneenv
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\standaloneconfig}
% User level configuration macro.
%    \begin{macrocode}
\newcommand*{\standaloneconfig}{\setkeys{standalone.cls}}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\@standaloneenv}
% Default no-op version.
%    \begin{macrocode}
\let\@standaloneenv\@gobble
%    \end{macrocode}
% \end{macro}
%
% Counter to indicate if currently inside a standaloneenv.
%    \begin{macrocode}
\newcount\sa@internal
%    \end{macrocode}
%
% Counter for total number of pages/\opt{multi} environments.
%    \begin{macrocode}
\newcounter{sapage}
%    \end{macrocode}
%
% \begin{environment}{standalone}
% The \env{standalone} environment is defined by default to be without effect.
% The \cs{endstandalone} macro is set to |\relax|, so a redefinition with
% \cs{renewenvironment} in the configuration file is possible and also can later be detected.
%    \begin{macrocode}
\let\standalone\empty
\let\endstandalone\relax
%    \end{macrocode}
% \end{environment}
%
%
% \begin{macro}{\sa@width}
% Default value for \env{varwidth} width.
%    \begin{macrocode}
\def\sa@width{\linewidth}
%    \end{macrocode}
% \end{macro}
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{Load config file, process options and load class}
%
% Load configuration file.
%    \begin{macrocode}
\InputIfFileExists{standalone.cfg}{}{}
%    \end{macrocode}
%
% Process options as normal keys. Only unknown keys are set as global options.
%    \begin{macrocode}
\begingroup
\def\@tempa{\endgroup\setkeys*{standalone.cls}}
\expandafter\expandafter\expandafter\@tempa
\expandafter\expandafter\expandafter{\csname opt@standalone.cls\endcsname}
\let\@classoptionslist\XKV@rm
%    \end{macrocode}
%
% Disable keys which are only allowed as class options.
% The \opt{multi} option is still allowed inside the preamble.
%    \begin{macrocode}
\disable@keys{standalone.cls}{crop,preview,class,beamer,ignorerest}
\AtBeginDocument{%
    \disable@keys{standalone.cls}{multi}%
}
%    \end{macrocode}
%
%
% Loads the class given by the |class| option with the rest of the options.
%    \begin{macrocode}
\expandafter\expandafter\expandafter\LoadClass
\expandafter\expandafter\expandafter[%
\expandafter\@classoptionslist
\expandafter]\expandafter{\sa@class}
%    \end{macrocode}
%
%
%
% \subsubsection{Ignorerest Option}
%
% \begin{macro}{\sa@startignore}
% Starts to box everything if \opt{ignorerest} option is set to true.
% Afterwards the box is discarded so that the content is ignored.
%    \begin{macrocode}
\ifsa@ignorerest
    \def\sa@startignore{\sa@boxit}
\else
    \let\sa@startignore\relax
\fi
%    \end{macrocode}
% \end{macro}
%
%
% \begin{macro}{\sa@stopignore}
% Closes the ignore box if \opt{ignorerest} option is set to true.
%    \begin{macrocode}
\ifsa@ignorerest
    \def\sa@stopignore{\endsa@boxit}
\else
    \let\sa@stopignore\relax
\fi
%    \end{macrocode}
% \end{macro}
%
%
% \subsubsection{Multido Option}
%
%    \begin{macrocode}
\ifsa@multido
\RequirePackage{multido}
%    \end{macrocode}
%
% \begin{macro}{\multido@}
% Redefine the internal macro of \Macro\multido and friends to produce
% a seperate page for every iteration. This only affects the first level of \Macro\multido,
% i.e. nesting is supported. The definition is compatible with the \opt{ignorerest} option.
%    \begin{macrocode}
\let\sa@orig@multido@\multido@
\renewcommand{\multido@}[6]{%
  \sa@stopignore
  \sa@orig@multido@{#1}{#2}{#3}{#4}{#5}{%
    \sa@startignore
    \begin{samultido}%
      \let\multido@\sa@orig@multido@
      #6%
    \end{samultido}%
    \sa@stopignore
  }%
  \sa@startignore
}
%    \end{macrocode}
% \end{macro}
%
%    \begin{macrocode}
\fi
%    \end{macrocode}
%
% Load Lua\LaTeX{} compatibility packages.
%    \begin{macrocode}
\ifluatex
\RequirePackage{luatex85}
\RequirePackage{pdftexcmds}
\fi
%    \end{macrocode}
%
% Set correct quoting character for conversion option if none was set.
%    \begin{macrocode}
\ifsa@convert
\ifx\sa@convert@quote\relax
\begingroup
\@tempswafalse
%    \end{macrocode}
% If \Macro\pdftexbanner is not defined (XeLaTeX) the distribution can not
% be determined and double quotes are set to ensure proper operation under MiKTeX.
%    \begin{macrocode}
\expandafter\ifx\csname pdftexbanner\endcsname\relax
    \@tempswatrue
\else
%    \end{macrocode}
% Test if there is a `|MiKTeX|' in \Macro\pdftexbanner.
%    \begin{macrocode}
\def\MiKTeX{MiKTeX}
\@onelevel@sanitize\MiKTeX
\expandafter\def\expandafter\testmiktex\expandafter#\expandafter1\MiKTeX#2\relax{%
        \ifx\empty#2\empty
             \@tempswafalse
        \else
             \@tempswatrue
        \fi
}
\expandafter\expandafter
\expandafter\testmiktex\expandafter\pdftexbanner\MiKTeX\relax\relax

\fi
\expandafter
\endgroup
\if@tempswa
\def\sa@convert@quote{"}
\else
\def\sa@convert@quote{'}
\fi
\fi
\fi
%    \end{macrocode}
%
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{Varwidth Option}
%
%    \begin{macrocode}
\ifsa@varwidth
    \RequirePackage{varwidth}
\fi
%    \end{macrocode}
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{TikZ Option}
%
%    \begin{macrocode}
\ifsa@tikz
    \RequirePackage{tikz}
\fi
%    \end{macrocode}
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{pstricks Option}
%
%    \begin{macrocode}
\ifsa@pstricks
    \RequirePackage{pstricks}
\fi
%    \end{macrocode}
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{Preview Option}
%
% The \env{standalone} environment is redefined to use the |preview| environment as
% long it was not redefined in the configuration file.
%    \begin{macrocode}
\ifsa@preview
%    \end{macrocode}
%
% Note: The used options are in the config file.
%    \begin{macrocode}
\RequirePackage{preview}
\ifsa@multi\else
    \@ifundefined{endstandalone}{%
        \renewenvironment{standalone}
            {\preview\sa@varwidth}
            {\sa@endvarwidth\endpreview}
    }{}% TODO: Add info message?
\fi
%    \end{macrocode}
%
% Set Border
%    \begin{macrocode}
\def\PreviewBbAdjust{-\sa@border@left\space -\sa@border@bottom\space \sa@border@right\space \sa@border@top}%
%    \end{macrocode}
%
% \begin{macro}{\@standaloneenv}
% Preview version. Wrappes a \env{preview} environment around the original environment.
% Also adds the \env{varwidth} macros, which can be empty.
% These \env{varwidth} macros are the reason why \Macro\PreviewEnvironment is not used directly.
%    \begin{macrocode}
\def\@standaloneenv#1{%
    \expandafter\ifx\csname sa@orig@#1\endcsname\relax
        \expandafter\let\csname sa@orig@#1\expandafter\endcsname\csname #1\endcsname
        \expandafter\let\csname sa@orig@end#1\expandafter\endcsname\csname end#1\endcsname
    \fi
    \expandafter\def\csname #1\endcsname{%
        \ifnum\sa@internal=0
            \addtocounter{sapage}\@ne
            \preview
            \sa@varwidth
        \fi
        \advance\sa@internal\@ne
        \csname sa@orig@#1\endcsname
    }%
    \expandafter\def\csname end#1\endcsname{%
        \csname sa@orig@end#1\endcsname
        \advance\sa@internal\m@ne
        \ifnum\sa@internal=0
            \sa@endvarwidth
            \endpreview
        \fi
    }%
}%
%    \end{macrocode}
% \end{macro}
%
%    \begin{macrocode}
\fi
%    \end{macrocode}
%
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{Crop Option}
%
%    \begin{macrocode}
\ifsa@crop
%    \end{macrocode}
%
% Box register to save the content.
% \begin{macro}{\sa@box}
%    \begin{macrocode}
\newbox\sa@box
%    \end{macrocode}
% \end{macro}
%
% Set all normal page margins etc. to zero.
%    \begin{macrocode}
\pagestyle{empty}
\hoffset=-72.27pt
\voffset=-72.27pt
\topmargin=0pt
\headheight=0pt
\headsep=0pt
\marginparsep=0pt
\marginparwidth=0pt
\footskip=0pt
\marginparpush=0pt
\oddsidemargin=0pt
\evensidemargin=0pt
\topskip=0pt
\textheight=\maxdimen
%    \end{macrocode}
%
% \begin{macro}{\sa@boxit}
%    \begin{macrocode}
\def\sa@boxit{%
    \setbox\sa@box\hbox\bgroup\color@setgroup\sa@varwidth
}%
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\endsa@boxit}
%    \begin{macrocode}
\def\endsa@boxit{%
    \sa@endvarwidth\color@endgroup\egroup
}%
%    \end{macrocode}
% \end{macro}
%
%
%
% \begin{environment}{standalone}
% Redefine the \env{standalone} environment to box the content if \opt{multi} is off,
% in order to use the whole content as single page. If \opt{multi} and \opt{ignorerest} are on
% the content is also boxed, but later discarded. If only \opt{multi} is on the environment
% doesn't have to do anything.
%    \begin{macrocode}
\renewenvironment{standalone}{%
    \ifsa@multi
        \sa@startignore
    \else
        \sa@boxit
    \fi
}{%
    \ifsa@multi
        \sa@stopignore
    \else
        \endsa@boxit
        \sa@handlebox
    \fi
}
%    \end{macrocode}
% \end{environment}
%
%
% \begin{macro}{\@standaloneenv}
% If the \opt{ignorerest} option is used all content outside of \Macro\standaloneenv\relax-ironments is
% boxed and discarded. This requires such environments to close the box first and reopen it afterwards.
%    \begin{macrocode}
\ifsa@multi\else
    \sa@ignorerestfalse
\fi
\ifsa@ignorerest
    \def\@standaloneenv#1{%
        \expandafter\ifx\csname sa@orig@#1\endcsname\relax
            \expandafter\let\csname sa@orig@#1\expandafter\endcsname\csname #1\endcsname
            \expandafter\let\csname sa@orig@end#1\expandafter\endcsname\csname end#1\endcsname
        \fi
        \expandafter\def\csname #1\endcsname{%
            \ifnum\sa@internal=0
                \addtocounter{sapage}\@ne
                \edef\@tempa{\endgroup
                    \noexpand\endsa@boxit
                    \begingroup
                    \def\noexpand\@currenvir{\@currenvir}%
                    \def\noexpand\@currenvline{\@currenvline}%
                }%
                \@tempa
                \sa@boxit
            \fi
            \advance\sa@internal\@ne
            \csname sa@orig@#1\endcsname
        }%
        \expandafter\def\csname end#1\endcsname{%
            \csname sa@orig@end#1\endcsname
            \advance\sa@internal\m@ne
            \ifnum\sa@internal=0
                \endsa@boxit
                \sa@handlebox
                \aftergroup\sa@boxit
            \fi
        }%
    }%
\else
    \def\@standaloneenv#1{%
        \expandafter\ifx\csname sa@orig@#1\endcsname\relax
            \expandafter\let\csname sa@orig@#1\expandafter\endcsname\csname #1\endcsname
            \expandafter\let\csname sa@orig@end#1\expandafter\endcsname\csname end#1\endcsname
        \fi
        \expandafter\def\csname #1\endcsname{%
            \ifnum\sa@internal=0
                \addtocounter{sapage}\@ne
                \sa@boxit
            \fi
            \advance\sa@internal\@ne
            \csname sa@orig@#1\endcsname
        }%
        \expandafter\def\csname end#1\endcsname{%
            \csname sa@orig@end#1\endcsname
            \advance\sa@internal\m@ne
            \ifnum\sa@internal=0
                \endsa@boxit
                \sa@handlebox
            \fi
        }%
    }%
\fi
%    \end{macrocode}
% \end{macro}
%
%
% \begin{macro}{\sa@handlebox}
% Adds the border as part of the box dimensions and places the result
% using the output format dependent \Macro\sa@placebox macro.
%    \begin{macrocode}
\def\sa@handlebox{%
    \ifcase
        0%
        \ifsa@ignoreempty
            \ifdim\wd\sa@box=\z@
            \ifdim\ht\sa@box=\z@
            \ifdim\dp\sa@box=\z@
                1%
            \fi\fi\fi
        \fi
    \relax
    \sbox\sa@box{%
%    \end{macrocode}
% add left border
%    \begin{macrocode}
        \hskip\sa@border@left
%    \end{macrocode}
% add top border
%    \begin{macrocode}
        \@tempdima=\ht\sa@box
        \advance\@tempdima\sa@border@top\relax
        \ht\sa@box=\@tempdima
%    \end{macrocode}
% add bottom border
%    \begin{macrocode}
        \@tempdima=\dp\sa@box
        \advance\@tempdima\sa@border@bottom\relax
        \dp\sa@box=\@tempdima
%    \end{macrocode}
% Remove all depth, so that height=totalheight
%    \begin{macrocode}
        \raise\dp\sa@box
            \box\sa@box
%    \end{macrocode}
% add right border
%    \begin{macrocode}
        \hskip\sa@border@right
    }%
    \sa@placebox
    \fi
}
%    \end{macrocode}
% \end{macro}
%
%
% \begin{macro}{\sa@placebox}
% Define output dependent macro to place the content box together
% with the required resizing of the page.
%
% PDFLaTeX, LuaLaTeX and XeLaTeX can use all the same definition.
% DVI/PS Output requires a different definition.
%    \begin{macrocode}
\ifcase0%
    \ifpdf\else\ifluatex\else\ifxetex\else 1\fi\fi\fi
  \relax
    \def\sa@placebox{%
        \newpage
        \ifluatex
          \ifnum\luatexversion<85
            % LuaLaTeX < 0.85 does define the PDF-specific globals.
            \global\pdfpagewidth=\wd\sa@box
            \global\pdfpageheight=\ht\sa@box
          \else
            % LuaLaTeX >= 0.85 doesn't define the PDF-specific globals.
            \global\pagewidth=\wd\sa@box
            \global\pageheight=\ht\sa@box
          \fi
        \else
          % Not LuaLaTeX at all, so still need this.
          \global\pdfpagewidth=\wd\sa@box
          \global\pdfpageheight=\ht\sa@box
        \fi
        \global\paperwidth=\wd\sa@box
        \global\paperheight=\ht\sa@box
        \global\hsize=\wd\sa@box
        \global\vsize=\ht\sa@box
        \global\@colht=\ht\sa@box
        \global\@colroom=\ht\sa@box
        \noindent\usebox\sa@box
        \newpage
    }
  \else
    \def\sa@placebox{%
        \global\paperwidth=\wd\sa@box
        \global\paperheight=\ht\sa@box
        \global\@colht=\maxdimen
        \global\@colroom=\maxdimen
        \global\hsize=\maxdimen
        \global\vsize=\maxdimen
        \sa@papersize
        \ifsa@multi
        \begingroup
        \@tempdima0.99626\paperwidth
        \@tempdimb0.99626\paperheight
        \edef\@tempc{\strip@pt\@tempdima}%
        \edef\@tempd{\strip@pt\@tempdimb}%
        \advance\@tempdima by .998pt
        \advance\@tempdimb by .998pt
        \def\strip@float##1.##2\relax{##1}%
        \edef\@tempa{\expandafter\strip@float\the\@tempdima\relax}%
        \edef\@tempb{\expandafter\strip@float\the\@tempdimb\relax}%
        \special{ps::%
            \@percentchar\@percentchar PageBoundingBox: 0 0 \@tempa\space\@tempb^^J%
            \@percentchar\@percentchar HiResPageBoundingBox: 0 0 \@tempc\space\@tempd^^J%
            \@percentchar\@percentchar BeginPageSetup^^J%
            << /PageSize [\@tempc\space\@tempd]
            >> setpagedevice^^J%<<
            0 0 bop^^J%
            \@percentchar\@percentchar EndPageSetup}%
        \endgroup
        \fi
        \topskip=0pt
        \noindent\sa@ps@content
        \newpage
    }
%    \end{macrocode}
% \end{macro}
%
% Other macros required for PostScript output.
% They will redefine themselves to act differently for the very first page than for the remaining ones.
% \begin{macro}{\sa@ps@content}
%
% Simply place the box of the first page. Further pages need to be vertically adjusted because the
% reference point is still for the size of the first page.
%    \begin{macrocode}
\def\sa@ps@content{%
    \noindent\usebox\sa@box
    \global\def\sa@ps@content{%
        \@tempdima\sa@yoffset
        \advance\@tempdima-\topskip
        \dp\sa@box\z@
        \ht\sa@box\z@
        \noindent\lower\@tempdima\copy\sa@box
    }%
}
%    \end{macrocode}
% \end{macro}
%
%
% \begin{macro}{\sa@papersize}
% Declare official papersize as the size of the first page.
% Store offset and disable this macro for all further pages.
%    \begin{macrocode}
\def\sa@papersize{%
    \global\let\sa@papersize\relax
    \global\sa@yoffset=\paperheight
    \global\setbox\@begindvibox\vbox{%
        \special{papersize=\the\paperwidth,\the\paperheight}%
        \special{ps::%
            \@percentchar\@percentchar HiResBoundingBox: 0 0 \the\paperwidth\space\the\paperheight^^J%
        }%
        \unvbox\@begindvibox
        \special{papersize=\the\paperwidth,\the\paperheight}%
    }%
}
%    \end{macrocode}
% \end{macro}
%
% \begin{macro}{\sa@yoffset}
% Offset required to vertical adjust all further pages according to the first page.
%    \begin{macrocode}
\newlength\sa@yoffset
%    \end{macrocode}
% \end{macro}
%
% End of 'latex' clause
%    \begin{macrocode}
\fi
%    \end{macrocode}
%
% End of \opt{crop} option code.
%    \begin{macrocode}
\fi
%    \end{macrocode}
%
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{Beamer code}
%
%    \begin{macrocode}
\ifstandalonebeamer
%    \end{macrocode}
% \begin{environment}{standaloneframe}
% Front-end for the beamer |frame| environment. Parses all arguments
% the same way and calls it with an added option.
%    \begin{macrocode}
\newenvironment{standaloneframe}{%
  \@ifnextchar<%
    {\@standaloneframe}%
    {\@@standaloneframe{}}%
}{\end{frame}}%
\def\@standaloneframe<#1>{%
    \@@standaloneframe{<#1>}%
}
\def\@@standaloneframe#1{%
  \@ifnextchar[%]
    {\@@@standaloneframe{#1}}%
    {\@@@standaloneframe{#1}[]}%
}%
\def\@@@standaloneframe#1[{%
  \@ifnextchar<%
    {\@@@@standaloneframe{#1}[}%
    {\@@@@@@standaloneframe{#1}[}%
}%
\def\@@@@standaloneframe#1[#2]{%
  \@ifnextchar[%]
    {\@@@@@standaloneframe{#1}{#2}}%
    {\begin{frame}#1[#2][environment=standaloneframe]}%
}%
\def\@@@@@standaloneframe#1#2[#3]{%
    \begin{frame}#1[#2][environment=standaloneframe,#3]%
}%
\def\@@@@@@standaloneframe#1[#2]{%
    \begin{frame}#1[environment=standaloneframe,#2]%
}%
%    \end{macrocode}
% \end{environment}
%    \begin{macrocode}
\fi
%    \end{macrocode}
%
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{Conversion code}
%    \begin{macrocode}
\expandafter\ifx\csname sa@internal@run\endcsname\relax\else
    \AtEndDocument{%
        \immediate\write\@mainaux{\noexpand\@gobbletwo\noexpand\sa@multi@setnumpages{\arabic{sapage}}}%
    }
    \sa@convertfalse
\fi
\ifsa@convert
%    \end{macrocode}
%
% Disable \Macro\sa@convert@perpage if 'multi' option is not set.
%    \begin{macrocode}
\ifsa@multi\else
\sa@convert@perpagefalse
\fi
%    \end{macrocode}
%
%    \begin{macrocode}
\def\sa@convert@stop{\csname fi\endcsname\stop}%
\begingroup
\let\on@line\@gobble
%    \end{macrocode}
%
% \begin{macro}{\sa@convert}[1]{error message on failure}
% Conversion macro.
%    \begin{macrocode}
\def\sa@convert#1{%
    \IfFileExists{\outfile}{%
        \edef\filemodbefore{\csname pdf\ifluatex @\fi filemoddate\endcsname{\outfile}}%
    }{%
    \IfFileExists{\outname\outext}{%
        \edef\filemodbefore{\csname pdf\ifluatex @\fi filemoddate\endcsname{\outname\outext}}%
    }{%
    \IfFileExists{\outname-0\outext}{%
        \edef\filemodbefore{\csname pdf\ifluatex @\fi filemoddate\endcsname{\outname-0\outext}}%
    }{%
    \IfFileExists{\outname-1\outext}{%
        \edef\filemodbefore{\csname pdf\ifluatex @\fi filemoddate\endcsname{\outname-1\outext}}%
    }{%
        \def\filemodbefore{}%
    }}}}%
    \edef\@tempa{\jobname}%
    \edef\@tempb{\sa@convert@subjobname}%
    \@onelevel@sanitize\@tempa
    \@onelevel@sanitize\@tempb
    \@tempswafalse
    \ifx\@tempa\@tempb
        \@tempswatrue
        \edef\infile@filemodbefore{\csname pdf\ifluatex @\fi filemoddate\endcsname{\infile}}%
    \else
        \global\let\sa@convert@stop\relax
    \fi
    \ShellEscape{\sa@convert@latex\space\sa@convert@latexoptions\space
        -jobname \sa@convert@quote\sa@convert@subjobname\sa@convert@quote\space
        \sa@convert@quote\string\expandafter\string\def\string\csname\space
        sa@internal@run\string\endcsname{1}\string\input{\sa@convert@mainfile}\sa@convert@quote}%
%
    \def\sa@multi@numpages{0}%
    \begingroup
    \IfFileExists{\sa@convert@subjobname.aux}{\@tempswatrue}{\@tempswafalse}%
    \if@tempswa
      \newread\sa@read
      \def\@tempa##1\sa@multi@setnumpages##2##3\@nnil{%
        \def\@tempc{##2}%
        \ifx\@tempc\@nnil\else
          \gdef\sa@multi@numpages{##2}%
        \fi
      }%
      \endlinechar=\m@ne
      \immediate\openin\sa@read=\sa@convert@subjobname.aux\relax
      \loop\unless\ifeof\sa@read
        \read\sa@read to\@tempb
        \expandafter\@tempa\@tempb\sa@multi@setnumpages\@nil\@empty\@nnil
      \repeat
      \immediate\closein\sa@read
    \fi
    \endgroup
%
    \@tempcnta\sa@multi@numpages\relax
    \ifsa@convert@perpage
    \def\sa@multi@pagemark{-\pagenum}%
    \else
    \ifnum\@tempcnta=\z@
        \def\sa@multi@pagemark{}%
        \edef\sa@lastoutfile{\outfile}%
    \else
        \begingroup
        \def\sa@multi@pagemark{-\the\@tempcnta}%
        \xdef\sa@lastoutfile{\outfile}%
        \endgroup
        \@tempcntb\z@
        \loop\ifnum\@tempcnta>0
            \advance\@tempcntb\@ne
            \divide\@tempcnta by 10\relax
        \repeat
        \edef\sa@multi@pagemark{-\percent0\the\@tempcntb d}%
    \fi
    \fi
%
    \if@tempswa
        \edef\infile@filemodafter{\csname pdf\ifluatex @\fi filemoddate\endcsname{\infile}}%
        \ifx\infile@filemodbefore\infile@filemodafter
            \global\let\sa@convert@stop\relax
        \fi
    \fi
%    \end{macrocode}
%    \begin{macrocode}
    \edef\sa@convert@precommand{\sa@convert@precommand}%
    \ifx\sa@convert@precommand\@empty\else
		\message{Executing precommand:^^J\sa@convert@precommand^^J^^J}%
        \ShellEscape{\sa@convert@precommand}%
    \fi
    \ifsa@convert@perpage
      \begingroup
      \@tempcnta\sa@multi@numpages\relax
      \@tempcntb\z@
      \def\pagenum{\the\@tempcntb}%
      \loop\ifnum\@tempcntb<\@tempcnta
        \edef\prevpagenum{\pagenum}%
        \advance\@tempcntb\@ne
        \sa@execute@convert@command
        \sa@checkoutfile{\outfile}{#1}%    
      \repeat    
      \endgroup
    \else
      \sa@execute@convert@command
      \sa@checkoutfile{\sa@lastoutfile}{#1}%
    \fi
    \@tempswafalse
}
\def\sa@execute@convert@command{%
	\message{Executing command:^^J\sa@convert@command^^J^^J}%
    \ShellEscape{\sa@convert@command}%
}
\def\sa@checkoutfile#1#2{%
    \IfFileExists{#1}{%
        \edef\filemodafter{\csname pdf\ifluatex @\fi filemoddate\endcsname{#1}}%
        \ifx\filemodbefore\filemodafter
            \expandafter\ifx\csname pdf\ifluatex @\fi filemoddate\endcsname\relax\else
                \sa@convert@failuremsg{standalone}{#2}{}%
            \fi
        \else
            \typeout{Class standalone:^^JOutput written on #1.}%
        \fi
    }{%
        \sa@convert@failuremsg{standalone}{#2}{}%
    }%
}
%    \end{macrocode}
% \end{macro}
%
% Provide the internal macros to the user level.
%    \begin{macrocode}
\let\subjobname\sa@convert@subjobname
\let\mainfile\sa@convert@mainfile
\let\infile\sa@convert@infile
\let\inext\sa@convert@inext
\let\inname\sa@convert@inname
\let\indir\sa@convert@indir
\let\outdir\sa@convert@outdir
\let\outputdir\sa@convert@outputdir
\let\gsdevice\sa@convert@gsdevice
\let\convertexe\sa@convert@convertexe
\let\gsexe\sa@convert@gsexe
\let\inkscapeexe\sa@convert@inkscapeexe
\let\gsexe\sa@convert@gsexe
\let\density\sa@convert@density
\let\size\sa@convert@size
\let\outext\sa@convert@outext
\let\outname\sa@convert@outname
\let\outfile\sa@convert@outfile
\let\pagenum\sa@convert@pagenum
\let\percent\@percentchar
\let\quote\sa@convert@quote
%    \end{macrocode}
%
%
%    \begin{macrocode}
\edef\sa@shellescape{%
    \ifluatex
      \directlua{tex.write(status.shell_escape or 2)}%
    \else\ifxetex
      \the\shellescape
    \else
    \expandafter\ifx\csname pdfshellescape\endcsname\relax
      0%
    \else
      \the\pdfshellescape
    \fi\fi\fi
}%
\ifcase\sa@shellescape\relax% 0
    \sa@convert@failuremsg
        {standalone}{Shell escape disabled! Cannot convert file '\infile'.}{}%
    \global\let\sa@convert@stop\relax
\or% 1
    \sa@convert{Conversion unsuccessful!\MessageBreak 
                There might be something wrong with your\MessageBreak
                conversation software or the file permissions!}%
\else% 2 or 3
    \sa@convert{Conversion failed! Please ensure that shell escape\MessageBreak
                is enabled (e.g. use '-shell-escape').}%
\fi
\endgroup
%    \end{macrocode}
%    \begin{macrocode}
\expandafter\sa@convert@stop
\fi
%    \end{macrocode}
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \subsubsection{Document Environment in Sub-Files}
% This is done at the very end so that all used packages are already loaded.
% Just in case these try also to redefine the \env{document} environment.
%
% \begin{environment}{document}
% Adds own `after begin document' and `before end document` hooks.
%    \begin{macrocode}
\begingroup
\toks@\expandafter{%
    \document
    \sa@cls@afterbegindocument
}
\xdef\document{\the\toks@}%
\toks@\expandafter{%
    \expandafter
    \sa@cls@beforeenddocument
    \enddocument
}
\xdef\enddocument{\the\toks@}%
\endgroup
%    \end{macrocode}
% \end{environment}
%
%
% \begin{macro}{\sa@cls@afterbegindocument}
% \begin{macro}{\sa@cls@beforeenddocument}
% Hooks which add the \env{standalone} environment. Surrounding spaces
% are removed. This hooks are used (instead of calling the content directly in the above macros)
% to add the possibility to fine tune this later, e.g.\ in the configuration file.
%    \begin{macrocode}
\def\sa@cls@afterbegindocument{\standalone\ignorespaces}
\def\sa@cls@beforeenddocument{\ifhmode\unskip\fi\endstandalone}
%    \end{macrocode}
% \end{macro}
% \end{macro}
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
