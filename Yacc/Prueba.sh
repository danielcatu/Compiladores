#!/bin/bash
rm a.out &
rm lex.yy.c &
rm y.tab.c &
rm y.tab.h &
clear &&
yacc -d Comp.y &&
flex Comp.l &&
cc lex.yy.c y.tab.c &&
./a.out 
