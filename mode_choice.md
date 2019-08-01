# Reduced list of modes

The modes described in ``mode.rst`` were added as needed while working on 
the ITER nuclear analyses. Here it is analysed, whether the modes provide 
excessive features.

Here is the list of modes -- candidates for removal:

    * ``rems``
    * ``remc``
    * ``uexp``
    * ``split``
    * ``mdupl``, ``matan``, ``msimp`` can be merged to a single mode or moved to an "analysis"


There are modes, used to get information or simplify the existing input. The
other modes are used to perform different steps necessary for concationation.
It will be instructive to attribute all the modes in one or several groups.


## ``wrap`` improve, check
Renaming surfaces to larger numbers can result in increased line length needed for 
the cell geometry description. This can lead to exceeding the 80 characters limit.
The ``wrap`` mode was introduced to tackle this problem. It is implemented as a separate
step in order to provide the user possibility to compare the input files and check only
the differences due to renaming. 

This mode has no options.

## ``renum`` concat, extract

Options: 
```
    --map: str, ''
    --log: str, ''
    'i' in -c, -s, -m or -u: use indexing
    -c, -s, -m -u, t: value to be added to the original numbers
```
The ``-c``, ``-s`` etc. options were implemented first. They simply
provide the integers to be added to the original numbers.

The ``--map`` option was introduced in order to provide possibility to rename a
subset of cells, surfaces etc. This option provides the same ... as -c, -s etc,
except the ``'i'`` indexing.


## ``info`` information

No options. The output can be used as a basis for the map file for subsequent renum.

## ``rems`` format

Removes multiple spaces in the meaningfull parts of the input. 

Within the current paradigm of "change as less as needed" this mode is not
needed. One can consider another way to simplyfy "before and after" comparison:
First, format the original input file to a specified format and ensure that the
renumbered input file has the same format. 

## ``remc`` format
Removes all external comment lines (i.e. comment lines that are located between cards).

This mode is used only to provide more convenient way to compare input files. It cannot
detect some parts of the cell that were commented out temprarily. Thus, this is candidate 
for removal.

## ``uexp`` concat
Adds explicit ``u=0`` to the cells. The range of cells can be specified with optional 
argument ``-c``. A nonzero universe can be added if given in ``-u`` option.

This mode is used in the paradigm "one change in one step". But usually used with the following
renumbering of the universes, thus can be "attached" to universe renumbering.

## ``split`` concat, extract
Splits the input file into files containing separate blocks. This mode is used in the paradigm "one change at one step", but is usually
used for inserting a model into another input file. Thus, can be replaced with an ``insert`` mode (not yet implemented) that
takes over several steps, like ``split``, ``renum``, add comments etc. 

## ``mdupl`` improve
Removes the material cards with material number used previously (i.e. if there are several 
material cards with the same number, only the first one remains, all others are removed).

This mode is used usually after concatenating two models, that were prepared and tested 
separately and thus must have all description, including the same material cards. 

The mode is not necessary if the ``insert`` mode is implemented.

## ``matan`` improve
Compare all materials with each other and list possible duplicates.

This mode is not necessary for model concatenation, but for potential reduction of
the memory use. This option can be moved to an "analysis" mode (not implemented yet). 

Modes ``mdupl`` and ``matan`` can be merged. 


## ``msimp`` check

Simplify material cards. Isotopic compositions for all material cards are replaced
with trivial ``1001 1.0``. This mode is used in order to reduce the model size for e.g.
plotting, when actual material compositions are not relevant.


## ``sdupl`` improve

Remove duplicate or close surfaces. 


## ``extr`` concat, check, extract

Extract cards necessary to represent cells specified in
the ``-c`` option, including surfaces and materials.

Alternatively, one can specify cell names in the
``--map`` file, or by universe in ``-u``.

## ``nogq`` improve
Replace GQ surfaces with transformed cylinders. 

Used options: ``-t`` to specify the 1-st transformation
number (can be deduced fro mthe input file)  and ``-c``
to comment out or remove the original GQ cards. 


## ``count`` information
Get information about how many surfaces are used to describe each cell. 

Option ``-s`` sets the minimal number of surfaces that triggers output. 

## ``nofill`` concat, check, extract
Removes ``fill=`` keywords. Used option: ``-u``. 

## ``fillempty`` concat
Add ``fill=`` keywords to void cells. Used options: ``-u``, ``--map``, ``-m``.

## ``matinfo`` information
Print out material info (which cells fills and at what density). Optionally, use mctal
with stohastic calculation of volumes to calculate total masses.

## ``uinfo`` information

## ``impinfo`` information, checks
Return a list of cells iwth zero importance. 

## ``sinfo`` information

## ``vsource``
Generate data cards (sdef; for tally card see ``tallies`` below) for
calculation of cell volumes. 

The result of calculations can be used in ``matinfo``.


## ``tallies``

Geenrate tally card for vol. calculation in all cells. Must be used together wit ``vsource``. 

## ``addgeom``

## ``merge``

## ``remu``

## ``zrotate``

## ``annotate``

## ``getc``


