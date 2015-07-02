% Python Command Line Tool to Rename Cells, Surfaces, Universes and Materials in MCNP Input Files
% A. Travleev, 
% 02.07.2015

# Introduction 

## Problem statement
Approach to create complex MCNP model: develop parts, check, integrate.

This approach is followed, for example, to develop the ‘C-Lite’ MCNP model of
ITER, where semi-detailed representation of the component latest designs is
developed by several organizations. 

Approach is straightforward, but:

- error-prone: some operations can be done only manually, 

- tedious: model preparation can require several iterations
 

## What modifications are needed?

MCNP input files undergo several modifications before can be integrated into common model:

- Add universe number to "real world" cells, e.g. ``u=5``

- find free number ranges in the common model

- rename cells, surfaces, materials etc. 

- wrap long lines, if necessary

## Our tool:

To facilitate this otherwise tedious work, we have developed a tool with following features:

- Preserve input file structure, including comments and line wrapping.
  Introduced changes can be controlled by generic  tools, like ``diff``
  or ``vimdiff``.

- Different mapping rules can be applied to different ranges of numbers. Thus,
  one can change only a subset of numbers, or ultimately specify new numbers to
  each cell/surface/material.

- If necessary, lines in the renumbered input file can be wrapped to obey the
  80 characters limit.

- A log file containing all substitutions can be used as an input to perform
  reverse change. This is useful to verify results: the input file obtained by
  the reverse renumbering should be identical to the original input file.

- The tool is written in Python and is cross-platform. Its command line
  interface can be run on a remote machine with terminal access and does not
  require Python knowledge.

# Examples

## Specify renaming rules in command line  {.fragile}

In the command line one can specify values to be added to cell, surface,
universe and material numbers.

\inputminted[frame=single,fontfamily=tt,fontsize=\normalsize]{bash}{examples/ex1.sh}

- ``numjuggler`` is the tool name,
- ``orig.inp`` is the original input file
- ``r1.inp`` is the modified input file

## Result  {.fragile}

\begin{columns}
    \column{0.5\textwidth}
    orig.inp:
    \inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/orig.inp}
    \column{0.5\textwidth}
    r1.inp:
    \inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/r1.inp}
\end{columns}

- Input file structure is preserved, when possible
- Cells and surfaces are recognized in some data cards (see f4 tally)


## Number by appearence in input file  {.fragile}

Special syntax can be used to specify that elements (cells, surfaces,
materials)  are numbered by increasing numbers, in the order they appear in
input file.

\inputminted[frame=single,fontfamily=tt,fontsize=\normalsize]{bash}{examples/ex2.sh}

## Result  {.fragile}

\begin{columns}
    \column{0.5\textwidth}
    orig.inp:
    \inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/orig.inp}
    \column{0.5\textwidth}
    r2.inp
    \inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/r2.inp}
\end{columns}

## Get information  {.fragile}
Command line option ``--mode info``: inquire information about what number
(ranges) are already used  (Default mode is ``--mode renum``, therefore not
specified in previous examples).

\inputminted[frame=single,fontfamily=tt,fontsize=\normalsize]{bash}{examples/ex3.sh}

## Result
``r3.txt``:
\inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/r3.txt}

Its output not an input file, but text containing: 

- Total amount of cells, surfaces etc.
- list of ranges and single numbers used in input
- Free slot length between ranges

## Specify renaming rules in external  file {.fragile}
Renaming rules can be read from an external file with ``--map`` option.

Opposite to the ``-c``, ``-s``, ``-m`` and ``-u`` options, in the external file one can
specify **different** rules for **different** ranges.  Ultimately, all new
cell, surface, material or universe names can be given explicitly.


\inputminted[frame=single,fontfamily=tt,fontsize=\normalsize]{bash}{examples/ex4.sh}

``map4.txt``:
\inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/map4.txt}

- output of ``--mode info`` option (previous slide) can be used as template for this file.
- Format detailed description by ``numjuggler -h map``

## Results {.fragile} 
\begin{columns}
    \column{0.5\textwidth}
    orig.inp:
    \inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/orig.inp}
    \column{0.5\textwidth}
    r4.inp
    \inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/r4.inp}
\end{columns}

- Some elements are not implemented yet (tallies, transformations)
- Implicit zero universe is not changed (see next)

## Add explict ``u=0`` {.fragile}
Option ``--mode uexp`` adds explicit ``u=0`` to cells without ``u`` keyword. 

This can be useful when combining several input files into one model using
universes. When cells have explicit ``u=0`` entries, they can be renumbered in
usual (see previous slides) ways.

\inputminted[frame=single,fontfamily=tt,fontsize=\normalsize]{bash}{examples/ex5.sh}

## Result  {.fragile}
\begin{columns}
    \column{0.5\textwidth}
    orig.inp:
    \inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/orig.inp}
    \column{0.5\textwidth}
    r5.inp 
    \inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/r5.inp}
\end{columns}

## Wrap long lines {.fragile}
Option ``--mode wrap`` wraps lines in the MCNP input file to fit the 80-chars limit. 

Only meaningful line parts are wrapped: if a line exceed 80 characters due to
comments (any entries after "$" or "&"), it is not wrapped.

\inputminted[frame=single,fontfamily=tt,fontsize=\normalsize]{bash}{examples/ex6.sh}

``or2.inp``:
\inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/or2.inp}

## Result  {.fragile}

After renaming, file ``r6L.inp``:
\inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/r6L.inp}

After wrapping, file ``r6s.inp``:
\inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/r6s.inp}

Note, wrapping is not done automatically, user must specify ``--mode wrap`` in a
separate run (to preserve input file structure for comparison)


## Reverse renumbering {.fragile}
The ``--log`` option generates log file where all number substitutions are
stored. It can be used as a map file to perform reverse renaming. 

This can be used to verify the tool: input after reverse renaming must be equal
to the original one.

\inputminted[frame=single,fontfamily=tt,fontsize=\normalsize]{bash}{examples/ex7.sh}

``log7.inp``:
\inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/log7.txt}

## Results

\begin{columns}
    \column{0.34\textwidth}
    orig.inp:
    \inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/orig.inp}
    \column{0.34\textwidth}
    r7.inp: 
    \inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/r7.inp}
    \column{0.34\textwidth}
    rev7.inp: 
    \inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{examples/rev7.inp}
\end{columns}

# Concluding remarks 

## Potential application to C-Lite

- Extreme scenario:

    + Distribute C-lite as empty envelopes together with a set of model parts of
      several complexity. User builds dedicated model, whith detailed model parts
      in regions of interest and with simplified model parts in other regions.

    + Get rid of numbering policies: let user decide how elements are numbered.

    + Requires further development

- Moderate scenario:

    + Apply for model integration, e.g. in current and upcoming task orders

    + mature enough, but lacks user feedback


## Binding to Python

- Classes and functions defined in ``numjuggler`` package can be used in Python scripts: mapping rules can be arbitrarily complex.

- MCNP input file parser can be used for other purposes


## Availability

On github, [github.com/inr-kit/numjuggler](https://github.com/inr-kit/numjuggler), one can find: 

- Source files for further development, or

- Distribution package to install and use, and 

- Installation instructions.

# Thank you for your attention!
