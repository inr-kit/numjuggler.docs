
EXpy=$(wildcard ex*.py)
EXout=$(EXpy:.py=.out)

all: r1.inp r2.inp r3.txt r4.inp r5.inp r6s.inp r7.inp 

r1.inp: ex1.sh orig.inp
	ex1.sh

r2.inp: ex2.sh orig.inp
	ex2.sh

r3.txt: ex3.sh orig.inp
	ex3.sh

r4.inp: ex4.sh orig.inp map4.txt
	ex4.sh

r5.inp: ex5.sh orig.inp 
	ex5.sh

r6s.inp: or2.inp ex6.sh
	ex6.sh

r7.inp: ex7.sh orig.inp
	ex7.sh > ex7.diff

.PHONY: clean

clean: 
	-rm r*.inp 
	-rm r*.txt 
	-rm log7.txt ex7.diff
