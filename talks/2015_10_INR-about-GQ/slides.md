% GQ cards in McCad-generated MCNP input 
% A. Travleev, 
% 15.10.2015


# Evidence of the problem 

## 

![Comparison of volumes for a McCad-generated MCNP input file](figures/vol_old.pdf "Old volumes")

# Down to one cell

## CLoser look to the MCNP input file

\inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{figures/c24701}

From SpaceClaim: this is a cylinder r=1.20cm, h=1.6 cm, located about 10m from the origin. 

## How MCNP interpretes this cylinder

![Cell seems smaller than should be (extent 1.85)](figures/c24701.pdf "Cylinder plot")


## How we interprete this cylinder

\inputminted[frame=single,fontfamily=tt,fontsize=\scriptsize]{bash}{figures/c24ngq}

## model with C/Z card

![This cell seems okay](figures/c24ngq.pdf "Cylinder plot")

## Calculation of volumes  

Volumes of the cell, cc:

    MCNP GQ    : 7.0357 +-0.0000 (nps 1e9)    (-2.80 %)
    MCNP C/Z   : 7.2343 +-0.0000 (nps 1e9)    (-0.05 %)
    exact value: 7.2382  


## 

-- We can interprete GQ card better than MCNP !  

-- Really ? Why ?



## Parameters of the GQ card:

The `gq` card syntax:

    1   GQ      A B C D E F G H J K

Meaning:
$$
Ax^2 + By^2 + Cz^2 + Dxy + Eyz + Fxz + Gx + Hy + Jz + K = 0
$$

Example: cylinder with r = 1 cm, with axis || y-axis through the point x0 = 1000 cm on x-axis, these parameters are:

    A   B   C   D   E   F      G   H   J              K
    1   0   1   0   0   0  -2000   0   0   9.99999990e7 
                            -2x0             xo^2 - r^2 

Parameters must be specified with high precision!

# What can we do ?

## combination of ``cz`` or `c/z` cards with `tr` cards

  * Cylinder at z-axis in an auxiliary CS, rotated and translated with respect to the model CS:

~~~~
    1 1    cz    R
    ...
    tr1  x0 y0 z0   ...
~~~~


  * Cylinder parallel z-axis in an auxiliary CS, rotated with respect to the model CS:

~~~~
    2 2   c/z    x0 y0 R
    ...
    tr2  0  0  0   ...
~~~~

Combination of `c/z` and `tr` is preferable, since might require less `tr` cards.

# Back to volume comparison in complete model

## Improvement of geometry precision

![Volumes in the model with c/z cards](figures/vol_new.pdf "New volumes")

## Old result once again:

![Volumes in the model wiht GC cards](figures/vol_old.pdf "Old volumes")


## How can one convert all `GQ` to `c/z`



    numjuggler --mode nogq m1 > m2

This replaces `GQ` cards that represent cylinders. 

* Cones and other surface types not implemented (yet)
* Does not solve the problem completely, as one can see from the above results. Presumably, due to lacking precision of the original `GQ` parameters
* Depends on `numpy` package: a not-so-simple-to-install python package

## Some notes 

* Proposal:

    * Use floating point format for `GQ` cards in McCad

    * Implement into McCad `c/z` + `tr` representation of cylinders and cones. Single tool is better than two (McCad, than numjuggler)

* Application to another CAD-MCNP converters 

* `c/z` + `tr` makes input more readable

* Limitation: at most 999 `tr` cards per input (mcnp5)

* Improves lost particle rate !


