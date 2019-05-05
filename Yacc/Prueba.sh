#!/bin/bash
clear
yacc -d Comp.y
flex Comp.l
cc lex.yy.c y.tab.c
./a.out