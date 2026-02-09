%% screenplay.cls — Final Draft–style LaTeX screenplay class
%% with pre-production annotation support
%%
%% Usage:
%%   \documentclass{screenplay}                  % clean shooting script
%%   \documentclass[preproduction]{screenplay}   % annotated pre-production draft
%%
%% Author: Claude (Anthropic) — 2026
%% License: MIT
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{screenplay}[2026/02/08 v1.0 Screenplay class with pre-production annotations]

% ============================================================
% OPTIONS
% ============================================================

\newif\if@preproduction\@preproductionfalse
\DeclareOption{preproduction}{\@preproductiontrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\LoadClass[12pt]{article}

% ============================================================
% PACKAGES
% ============================================================

\RequirePackage[
  top=1in, bottom=1in, left=1.5in, right=1in,
  headheight=15pt
]{geometry}
\RequirePackage[T1]{fontenc}
\RequirePackage{courier}         % Courier font family
\renewcommand{\rmdefault}{pcr}   % Set Courier as the default roman font
\renewcommand{\sfdefault}{pcr}   % Sans-serif also Courier (screenplay is mono)
\renewcommand{\ttdefault}{pcr}   % Monospace also Courier
\RequirePackage{xcolor}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{enumitem}
\RequirePackage{ifthen}
\RequirePackage{xstring}
\RequirePackage{marginnote}
\RequirePackage{etoolbox}
\RequirePackage{longtable}
\RequirePackage{booktabs}
\RequirePackage{hyperref}
\RequirePackage{environ}         % for \NewEnviron
\RequirePackage{paracol}         % for dual dialogue columns
\RequirePackage{setspace}        % line spacing
\RequirePackage{soul}            % line-breakable highlighting

% Font is set via the courier package above (Courier, 12pt).
% For Courier Prime or other OpenType fonts, replace
% the courier/fontenc setup with fontspec (requires LuaLaTeX/XeLaTeX).

% ============================================================
% PAGE STYLE
% ============================================================

\pagestyle{fancy}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\fancyhead[R]{\thepage.}
\fancypagestyle{plain}{\fancyhf{}\fancyhead[R]{\thepage.}}
\fancypagestyle{titlepage}{\fancyhf{}\renewcommand{\headrulewidth}{0pt}}

% Line spacing: single-spaced (standard screenplay)
\singlespacing

% No paragraph indent for screenplay (we handle indentation per element)
\setlength{\parindent}{0pt}
\setlength{\parskip}{11pt}  % one blank line between elements
\raggedright                 % screenplays use left-aligned (ragged right) text

% ============================================================
% ANNOTATION COLORS
% ============================================================

\definecolor{propcolor}{HTML}{FFF176}       % Yellow
\definecolor{shotcolor}{HTML}{90CAF9}       % Blue
\definecolor{camcolor}{HTML}{CE93D8}        % Purple
\definecolor{lightingcolor}{HTML}{FFB74D}   % Orange
\definecolor{sfxcolor}{HTML}{A5D6A7}        % Green
\definecolor{vfxcolor}{HTML}{EF9A9A}        % Red
\definecolor{wardrobecolor}{HTML}{F48FB1}   % Pink
\definecolor{setnotecolor}{HTML}{80CBC4}    % Teal

% Revision page colors
\definecolor{revblue}{HTML}{D6EAF8}
\definecolor{revpink}{HTML}{FADBD8}
\definecolor{revyellow}{HTML}{FEF9E7}
\definecolor{revgreen}{HTML}{D5F5E3}
\definecolor{revgoldenrod}{HTML}{FDEBD0}
\definecolor{revbuff}{HTML}{FAE5D3}
\definecolor{revsalmon}{HTML}{F5B7B1}
\definecolor{revcherry}{HTML}{FADBD8}
\definecolor{revtan}{HTML}{F6DDCC}

% ============================================================
% REVISION SUPPORT
% ============================================================

\newcommand{\@revisioncolor}{white}  % default: no color
\newcommand{\@revisionmark}{}
\newcommand{\@revisionnumber}{}
\newcommand{\@revisiondate}{}

% \revisioncolor{pink} — sets page background
\newcommand{\revisioncolor}[1]{%
  \renewcommand{\@revisioncolor}{rev#1}%
}

% \revisioninfo{number}{date}
\newcommand{\revisioninfo}[2]{%
  \renewcommand{\@revisionnumber}{#1}%
  \renewcommand{\@revisiondate}{#2}%
}

% \revised{text} — shows text with asterisk in right margin
\newcommand{\revised}[1]{%
  #1\marginpar{\hfill\textbf{*}}%
}

% Apply page background color
\newif\if@hasrevcolor\@hasrevcolorfalse
\let\@orig@revisioncolor\revisioncolor
\renewcommand{\revisioncolor}[1]{%
  \@hasrevcolortrue
  \renewcommand{\@revisioncolor}{rev##1}%
}

\AddToHook{shipout/background}{%
  \if@hasrevcolor
    \put(0,-\paperheight){%
      \colorbox{\@revisioncolor}{\makebox[\paperwidth]{\vbox to \paperheight{}}}%
    }%
  \fi
}

% ============================================================
% SCENE COUNTER & SLUGLINE
% ============================================================

\newcounter{scenenumber}
\setcounter{scenenumber}{0}

% Internal: track current scene label for breakdown logging
\newcommand{\@currentscene}{0}

% \slugline[label]{INT./EXT.}{LOCATION}{TIME}
% Label is optional; if omitted, auto-increments.
\newcommand{\slugline}[4][]{%
  \ifthenelse{\equal{#1}{}}{%
    \stepcounter{scenenumber}%
    \edef\@currentscene{\thescenenumber}%
  }{%
    \renewcommand{\@currentscene}{#1}%
  }%
  \vspace{\parskip}%
  \noindent%
  \makebox[0pt][r]{\textbf{\@currentscene}\hspace{2.5em}}%
  \textbf{\MakeUppercase{#2} \MakeUppercase{#3} --- \MakeUppercase{#4}}%
  \hfill\textbf{\@currentscene}%
  \par\nopagebreak%
}

% ============================================================
% SCREENPLAY ELEMENTS
% ============================================================

% ACTION — full width
\newcommand{\action}[1]{%
  \par{\setlength{\parindent}{0pt}\noindent #1\par}%
}

% CHARACTER CUE — centered, uppercase
% Optional extension: (V.O.), (O.S.), (CONT'D)
\newcommand{\character}[2][]{%
  \par\vspace{0.5\parskip}%
  {\centering
    \MakeUppercase{#2}%
    \ifthenelse{\equal{#1}{}}{}{ (#1)}\par}%
  \nopagebreak\vspace{-\parskip}%
}

% DIALOGUE — indented block (2.5in from left edge, 2.0in from right edge per standard)
\newcommand{\dialogue}[1]{%
  \par\nopagebreak%
  \noindent\hspace*{1in}%
  \begin{minipage}[t]{4in}%
    #1%
  \end{minipage}%
  \par%
}

% PARENTHETICAL
\newcommand{\paren}[1]{%
  \par\nopagebreak%
  \noindent\hspace*{1.6in}%
  \begin{minipage}[t]{2.5in}%
    (#1)%
  \end{minipage}%
  \par\nopagebreak\vspace{-\parskip}%
}

% TRANSITION — right-aligned
\newcommand{\trans}[1]{%
  \par%
  \hfill\MakeUppercase{#1}%
  \par%
}

% DUAL DIALOGUE — side by side
\newcommand{\dualdia}[4]{%
  % #1=CharA, #2=DialogueA, #3=CharB, #4=DialogueB
  \par\vspace{0.5\parskip}%
  \noindent
  \begin{minipage}[t]{0.45\linewidth}%
    {\centering\MakeUppercase{#1}\par}%
    #2%
  \end{minipage}%
  \hfill
  \begin{minipage}[t]{0.45\linewidth}%
    {\centering\MakeUppercase{#3}\par}%
    #4%
  \end{minipage}%
  \par%
}

% ============================================================
% TITLE PAGE
% ============================================================

\newcommand{\@screentitle}{}
\newcommand{\@screenauthor}{}
\newcommand{\@screencontact}{}
\newcommand{\@screendraftinfo}{}

\newcommand{\screentitle}[1]{\renewcommand{\@screentitle}{#1}}
\newcommand{\screenauthor}[1]{\renewcommand{\@screenauthor}{#1}}
\newcommand{\screencontact}[1]{\renewcommand{\@screencontact}{#1}}
\newcommand{\screendraftinfo}[1]{\renewcommand{\@screendraftinfo}{#1}}

\newcommand{\maketitlepage}{%
  \thispagestyle{titlepage}%
  \begin{center}%
    \vspace*{2.5in}%
    {\underline{\textbf{\@screentitle}}}\\[2\baselineskip]%
    Written by\\[0.5\baselineskip]%
    \@screenauthor%
    \ifthenelse{\equal{\@screendraftinfo}{}}{}{%
      \\[\baselineskip]%
      \@screendraftinfo%
    }%
  \end{center}%
  \vfill%
  \noindent\@screencontact%
  \newpage%
}

% ============================================================
% BREAKDOWN LOG FILE (aux mechanism)
% ============================================================

\newwrite\breakdownfile
\AtBeginDocument{%
  \if@preproduction
    \immediate\openout\breakdownfile=\jobname.breakdown%
  \fi
}
\AtEndDocument{%
  \if@preproduction
    \immediate\closeout\breakdownfile%
  \fi
}

% Internal: write one entry to the breakdown log
% #1=category tag, #2=text
% Writes as \breakdownentry{scene}{category}{item} for safe re-reading
\newcommand{\@logbreakdown}[2]{%
  \if@preproduction
    \begingroup
      % Neutralize annotation and formatting commands to prevent nested expansion
      \let\prop\@firstofone
      \let\wardrobe\@firstofone
      \let\shot\@firstofone
      \let\cam\@firstofone
      \let\lighting\@firstofone
      \let\sfx\@firstofone
      \let\vfx\@firstofone
      \let\setnote\@firstofone
      \let\textit\@firstofone
      \let\textbf\@firstofone
      \def\_{\string\_}%
      \immediate\write\breakdownfile{%
        \string\breakdownentry{\@currentscene}{#1}{#2}%
      }%
    \endgroup
  \fi
}

% ============================================================
% ANNOTATION COMMANDS
% ============================================================
%
% TWO BEHAVIORS:
%   "text-preserving" — in clean mode, text remains (props, wardrobe)
%   "text-removing"   — in clean mode, text vanishes (shot, cam, etc.)
%
% When annotations are nested (e.g. \prop inside \setnote), inner
% annotations render as plain text with their tag to avoid recursive
% \hl calls which cause soul "Reconstruction failed" errors.

% Helper: redefine all annotations to plain-text versions (no \hl)
% for use inside an outer \hl call.
\newcommand{\@setupinnerannot}{%
  \def\prop##1{##1\textsuperscript{\,\tiny\sffamily P}}%
  \def\wardrobe##1{##1\textsuperscript{\,\tiny\sffamily W}}%
  \def\shot##1{##1\textsuperscript{\,\tiny\sffamily S}}%
  \def\cam##1{##1\textsuperscript{\,\tiny\sffamily C}}%
  \def\lighting##1{##1\textsuperscript{\,\tiny\sffamily L}}%
  \def\sfx##1{##1\textsuperscript{\,\tiny\sffamily X}}%
  \def\vfx##1{##1\textsuperscript{\,\tiny\sffamily V}}%
  \def\setnote##1{##1\textsuperscript{\,\tiny\sffamily D}}%
}

% --- Text-Preserving Annotations ---

% \prop{item} — yellow highlight
\newcommand{\prop}[1]{%
  \if@preproduction
    \@logbreakdown{PROP}{#1}%
    \begingroup\@setupinnerannot
    {\sethlcolor{propcolor}\hl{#1}}\textsuperscript{\,\tiny\sffamily P}%
    \endgroup
  \else
    #1%
  \fi
}

% \wardrobe{item} — pink highlight
\newcommand{\wardrobe}[1]{%
  \if@preproduction
    \@logbreakdown{WARDROBE}{#1}%
    \begingroup\@setupinnerannot
    {\sethlcolor{wardrobecolor}\hl{#1}}\textsuperscript{\,\tiny\sffamily W}%
    \endgroup
  \else
    #1%
  \fi
}

% --- Text-Removing Annotations ---

% \shot{type} — blue highlight
\newcommand{\shot}[1]{%
  \if@preproduction
    \@logbreakdown{SHOT}{#1}%
    \begingroup\@setupinnerannot
    {\sethlcolor{shotcolor}\hl{#1}}\textsuperscript{\,\tiny\sffamily S}%
    \endgroup
  \else
    \unskip\ignorespaces
  \fi
}

% \cam{movement} — purple highlight
\newcommand{\cam}[1]{%
  \if@preproduction
    \@logbreakdown{CAM}{#1}%
    \begingroup\@setupinnerannot
    {\sethlcolor{camcolor}\hl{#1}}\textsuperscript{\,\tiny\sffamily C}%
    \endgroup
  \else
    \unskip\ignorespaces
  \fi
}

% \lighting{description} — orange highlight
\newcommand{\lighting}[1]{%
  \if@preproduction
    \@logbreakdown{LIGHTING}{#1}%
    \begingroup\@setupinnerannot
    {\sethlcolor{lightingcolor}\hl{#1}}\textsuperscript{\,\tiny\sffamily L}%
    \endgroup
  \else
    \unskip\ignorespaces
  \fi
}

% \sfx{description} — green highlight
\newcommand{\sfx}[1]{%
  \if@preproduction
    \@logbreakdown{SFX}{#1}%
    \begingroup\@setupinnerannot
    {\sethlcolor{sfxcolor}\hl{#1}}\textsuperscript{\,\tiny\sffamily X}%
    \endgroup
  \else
    \unskip\ignorespaces
  \fi
}

% \vfx{description} — red highlight
\newcommand{\vfx}[1]{%
  \if@preproduction
    \@logbreakdown{VFX}{#1}%
    \begingroup\@setupinnerannot
    {\sethlcolor{vfxcolor}\hl{#1}}\textsuperscript{\,\tiny\sffamily V}%
    \endgroup
  \else
    \unskip\ignorespaces
  \fi
}

% \setnote{description} — teal highlight
\newcommand{\setnote}[1]{%
  \if@preproduction
    \@logbreakdown{SET}{#1}%
    \begingroup\@setupinnerannot
    {\sethlcolor{setnotecolor}\hl{#1}}\textsuperscript{\,\tiny\sffamily D}%
    \endgroup
  \else
    \unskip\ignorespaces
  \fi
}

% Register annotation commands with soul so they are treated as atomic
% units inside \hl{} (prevents "Reconstruction failed" with nesting)
\soulregister\prop{1}
\soulregister\wardrobe{1}
\soulregister\shot{1}
\soulregister\cam{1}
\soulregister\lighting{1}
\soulregister\sfx{1}
\soulregister\vfx{1}
\soulregister\setnote{1}

% ============================================================
% PRE-PRODUCTION LEGEND
% ============================================================

\newcommand{\preprodlegend}{%
  \if@preproduction
    \par\noindent\textbf{PRE-PRODUCTION ANNOTATION LEGEND}\par
    \vspace{0.5\baselineskip}
    \noindent
    \begin{tabular}{@{}llll@{}}
      \colorbox{propcolor}{\strut\,\textsuperscript{\tiny\sffamily P}\,Prop\,}
      & \colorbox{shotcolor}{\strut\,\textsuperscript{\tiny\sffamily S}\,Shot\,}
      & \colorbox{camcolor}{\strut\,\textsuperscript{\tiny\sffamily C}\,Camera\,}
      & \colorbox{lightingcolor}{\strut\,\textsuperscript{\tiny\sffamily L}\,Lighting\,} \\[4pt]
      \colorbox{sfxcolor}{\strut\,\textsuperscript{\tiny\sffamily X}\,SFX\,}
      & \colorbox{vfxcolor}{\strut\,\textsuperscript{\tiny\sffamily V}\,VFX\,}
      & \colorbox{wardrobecolor}{\strut\,\textsuperscript{\tiny\sffamily W}\,Wardrobe\,}
      & \colorbox{setnotecolor}{\strut\,\textsuperscript{\tiny\sffamily D}\,Set Note\,} \\
    \end{tabular}
    \par\vspace{\baselineskip}
    \noindent\begin{sloppypar}\textit{Highlighted annotations are visible in
    pre-production mode only. Items marked P and W preserve their text in
    clean mode; all others are removed.}\end{sloppypar}
    \par\vspace{\baselineskip}
    \hrule
    \vspace{\baselineskip}
  \fi
}

% ============================================================
% BREAKDOWN TABLE (reads the .breakdown file)
% ============================================================

% \printbreakdown — outputs a formatted table from the logged entries
% This requires TWO compilation passes (like \tableofcontents).
\newcommand{\printbreakdown}{%
  \if@preproduction
    \newpage
    \begin{center}
      \textbf{\large SCENE BREAKDOWN}
    \end{center}
    \vspace{\baselineskip}
    {%
      \small
      % Define how each entry renders inside the table
      \def\breakdownentry##1##2##3{##1 & ##2 & ##3 \\}%
      \noindent
      \begin{longtable}{@{}p{0.8cm}p{2cm}p{10cm}@{}}
        \toprule
        \textbf{Sc.} & \textbf{Category} & \textbf{Item} \\
        \midrule
        \endhead
        \bottomrule
        \endfoot
        \IfFileExists{\jobname.breakdown}{%
          \input{\jobname.breakdown}%
        }{}%
      \end{longtable}
    }%
  \fi
}

% We also provide a simpler raw-text breakdown reader
% that lists entries line by line (more robust fallback)
\newcommand{\printbreakdownraw}{%
  \if@preproduction
    \newpage
    \begin{center}
      \textbf{\large SCENE BREAKDOWN}
    \end{center}
    \vspace{\baselineskip}
    \noindent\begin{sloppypar}\textit{%
      The full machine-readable breakdown is in
      \texttt{\jobname.breakdown}.
      Below is a formatted summary.%
    }\end{sloppypar}
    \vspace{\baselineskip}

    {%
      \small
      % Neutralize annotation commands for safe re-reading
      \let\prop\@firstofone
      \let\wardrobe\@firstofone
      \let\shot\@firstofone
      \let\cam\@firstofone
      \let\lighting\@firstofone
      \let\sfx\@firstofone
      \let\vfx\@firstofone
      \let\setnote\@firstofone
      \let\textit\@firstofone
      % Define how each entry renders as a simple line
      \def\breakdownentry##1##2##3{%
        \par\noindent\textbf{Sc.~##1} \quad [\textbf{##2}] \quad ##3%
      }%
      \IfFileExists{\jobname.breakdown}{%
        \input{\jobname.breakdown}%
      }{%
        \textit{(No breakdown data --- compile twice.)}%
      }%
    }
  \fi
}

% ============================================================
% CONVENIENCE: CONTINUED / MORE
% ============================================================

% (CONTINUED) at bottom of page, CONTINUED: at top — handled by
% the standard screenplay convention. Providing manual commands:
\newcommand{\continued}{%
  \par\vfill\noindent\MakeUppercase{(continued)}\newpage%
  \noindent\MakeUppercase{continued:}\par%
}

\newcommand{\moremark}{%
  \par\begin{center}(MORE)\end{center}%
}

% ============================================================
% NOTES / COMMENTS (non-printing unless preproduction)
% ============================================================

\newcommand{\scriptnote}[1]{%
  \if@preproduction
    \par\noindent
    \fcolorbox{black}{yellow!20}{\parbox{\dimexpr\linewidth-2\fboxsep-2\fboxrule}{%
      \small\textbf{NOTE:} #1%
    }}%
    \par%
  \fi
}

% ============================================================
% HYPERREF CONFIG
% ============================================================

\hypersetup{
  colorlinks=false,
  pdfborder={0 0 0},
}

\endinput
