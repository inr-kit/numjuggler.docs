# Reduced list of modes

The modes described in ``mode.rst`` were added as needed while working on 
the ITER nuclear analyses. Here it is analysed, whether the modes provide 
excessive features.

## ``wrap``
Renaming surfaces to larger numbers can result in increased line length needed for 
the cell geometry description. This can lead to exceeding the 80 characters limit.
The ``wrap`` mode was introduced to tackle this problem. It is implemented as a separate
step in order to provide the user possibility to compare the input files and check only
the differences due to renaming.

This mode has no options.

## ``renum``

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

## ``


