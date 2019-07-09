# numjuggler.docs
Documentation for https://github.com/inr-kit/numjuggler 

# Documentation current state
Up to version 2.23.17 (july 2016) the development in numjuggler was
consistently followed by keeping updated the help messages called with
``--help`` and ``-h`` command line options. Apart from this, the basic usage was
explained at the X-th INM. The more recent numjuggler's development, since
version 2.23.17, was neither followed by the documentation update nor
thoroughly tested. There were many modifications toward more functionality,
however, these changes were only applied to a small set of problems and the new
execution modes of numjuggler were not documented. 

The following table shows the current (version 2.42a.27, July 2019) set of
modes, implemented in numjuggler, and whether they are documented:

    | Mode        | Where documented   |
    |-------------|--------------------|
    |``info``     | ``-h mode``        |
    |``remh``     |  ``-h mode``, ext  |
    |``remrp``    |  ext               |
    |``cdens``    |                    |
    |``tallies``  |``-h mode``         |
    |``addgeom``  |``-h mode``         |
    |``merge``    |``-h mode``         |
    |``uexp``     |``-h mode``         |
    |``wrap``     |``-h mode``         |
    |``rems``     |``-h mode``         |
    |``remc``     |``-h mode``         |
    |``split``    |``-h mode``         |
    |``matan``    |``-h mode``         |
    |``mdupl``    |``-h mode``         |
    |``mnew``     |                    |
    |``sdupl``    |``-h mode``         |
    |``msimp``    |``-h mode``         |
    |``remu``     |``-h mode``         |
    |``combinec`` |                    |
    |``zrotate``  |``-h mode``         |
    |``annotate`` |``-h mode``         |
    |``getc``     |``-h mode``         |
    |``extr``     |``-h mode``         |
    |``nogq``     | -h mode, ext       |
    |``nogq2``    | ext                |
    |``count``    |``-h mode``         |
    |``nofill``   |``-h mode``         |
    |``matinfo``  |``-h mode``         |
    |``uinfo``    |``-h mode``         |
    |``impinfo``  |``-h mode``         |
    |``sinfo``    |``-h mode``         |
    |``minfo``    |``-h mode``         |
    |``vsource``  |``-h mode``         |
    |``fillempty``|``-h mode``         |
    |``renum``    |``-h mode``         |
    |-------------|--------------------|

In the above table, ``-h mode`` means that a short information about the mode
is given in the file
[help/mode.rst](https://github.com/inr-kit/numjuggler/blob/master/help/mode.rst)
that is printed out when `numjuggler is executed with ``-h mode``.  "ext" means
a presentation or a pdf report that can be found in `numjuggler.docs` repo.

The [help](https://github.com/inr-kit/numjuggler/tree/master/help) folder
contains some more information.  This folder is assumed to be the central place
containing help, which can be accessed via the ``-h`` commmand line option, as
well as from the web-interface of the repository, but currently lacks the help
topics. 

Concluding the above: almost all modes are at least shortly described. Detailed
information about the modes is, however, missing. The command line help system
is implemented, but lacks the content.  The general purpose, the concept of
numjuggler, tutorial(s) and other introductory materials are available only as
pdf presentations and are outdated. 

# Possible improvements to the documentation

## Complete the command line help
Detailed information about each mode should be placed to the
[help](https://github.com/inr-kit/numjuggler/tree/master/help) folder. This
will be available both from the command line (via ``-h``) and on the web.

## Tutorials
Write tutorials showing different scenarios of the numjuggler usage. For
example, in a dedicated folder in this repo. For example:

    * How to rename some cells in the input file
    * How to integrate a stand-alone model into e.g. C-model
    * How to install numjugglero

The tutorials can be hardcoded or generated with CI tools (CI -- continuous
integration. Each time the numjuggler code in the repo is updated, a script is
called that runs all commands in the tutorials and generates the output files
with the new version of numjuggler). The latter is more dificult to implement,
but provides a kind of tests and ensures that the tutorial content is up to
date with the current version of numjuggler. 

# Futher improvements
Currenlty, there are no tests or input and output examples to test the updates in numjugller. 
Such tests
 
