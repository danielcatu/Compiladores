#!/bin/bash
clear
yacc -d sintactico.y
flex lexico.l
cc lex.yy.c y.tab.c