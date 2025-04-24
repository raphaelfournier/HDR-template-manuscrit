\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{thesisart}[2008/07/16 Articles made from thesis chapters]

\LoadClassWithOptions{article}

%\RequirePackage{thesis}

\let\chaptertitle=\title
\newcommand{\introformatting}{%
  \maketitle
  \tableofcontents\bigskip
}

\newcommand{\outroformatting}{
  \appendix
% HERE SET UP YOUR BIBLIOGRAPHY
% Here's how you do it with biblatex:
  \printbibliography[heading=bibnumbered]
}

\author{Tikitu de Jager}
\date{Draft of thesis chapter (\today)}

% Set up cross-referencing to other chapters (chap list needs to be kept up
% to date, sigh). Also need to keep .aux files current (by compiling
% thesis.tex, otherwise the chapter refs don't come out right). Ifthenelse
% suggested by Adam Reeve (thanks!), to avoid a warning about multiple includes
% of the same document (you will need to \RequirePackage{ifthen} in thesis.sty).

\RequirePackage{xr}
\ifthenelse{\equal{\jobname}{\detokenize{introduction}}}{}{\externaldocument{../introduction/content}}
\ifthenelse{\equal{\jobname}{\detokenize{experiment}}}{}{\externaldocument{../experiment/content}}
