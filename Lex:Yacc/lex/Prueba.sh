#!/bin/bash
lex Compilador.l
cc lex.yy.c -ll
./a.out