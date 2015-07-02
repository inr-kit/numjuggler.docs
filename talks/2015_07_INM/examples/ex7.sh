# generate log
numjuggler -c 10 --log log7.txt      orig.inp > r7.inp
# apply log as map file
numjuggler --map log7.txt            r7.inp > rev7.inp
