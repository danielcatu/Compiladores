#!/bin/bash
clear
lex puta.l
yacc -d Sin.y
cc y.tab.c lex.yy.c