D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			([Ee][+-]?{D}+)
P                       ([Pp][+-]?{D}+)
FS			(f|F|l|L)
IS                      ((u|U)|(u|U)?(l|L|ll|LL)|(l|L|ll|LL)(u|U))

%{
#include <stdio.h>
#include "y.tab.h"
int column = 1;
void count(void);
%}

%x C_COMMENT
%%
"//"[^\n]*              { count();}
"/*"[^*/]*"*/"      { count();}//NUEVA COMENTARIO


"#include"			{ count(); return(INCLUDE); }
"main"			{ count(); return(MAIN); }
"break"			{ count(); return(BREAK); }
"case"			{ count(); return(CASE); }
"char"			{ count(); return(CHAR); }
"do"			{ count(); return(DO); }
"else"			{ count(); return(ELSE); }
"float"			{ count(); return(FLOAT); }
"for"			{ count(); return(FOR); }
"if"			{ count(); return(IF); }
"int"			{ count(); return(INT); }
"switch"		{ count(); return(SWITCH); }
"void"			{ count(); return(VOID); }
"while"			{ count(); return(WHILE); }
"printf"		{ count(); return(PRINTF); }
"scanf"			{ count(); return(SCANF); }


{L}({L}|{D})*		{ count(); return(IDENTIFIER); }
'(\\.|[^\\'\n])+'|\"(\\.|[^\\"\n])+\"	{ count(); return(CHARVALUE); }
[-+]?{D}+{E}?			{ count(); return(INTVALUE); }
[-+]?{D}*"."{D}+{E}? 	{ count(); return(FLOATVALUE); }
\<(\\.|[^\\"\n])*\>	{ count(); return(LIBRERIA); }

"+="			{ count(); return(ADD_ASSIGN); }
"-="			{ count(); return(SUB_ASSIGN); }
"*="			{ count(); return(MUL_ASSIGN); }
"/="			{ count(); return(DIV_ASSIGN); }
"++"			{ count(); return(INC_OP); }
"--"			{ count(); return(DEC_OP); }
"&&"			{ count(); return(AND_OP); }
"||"			{ count(); return(OR_OP); }
"<="			{ count(); return(LE_OP); }
">="			{ count(); return(GE_OP); }
"=="			{ count(); return(EQ_OP); }
"!="			{ count(); return(NE_OP); }
";"				{ count(); return(';'); }
("{"|"<%")		{ count(); return('{'); }
("}"|"%>")		{ count(); return('}'); }
","			{ count(); return(','); }
":"			{ count(); return(':'); }
"="			{ count(); return('='); }
"("			{ count(); return('('); }
"~(" 		{count(); return(NEGA);}
")"			{ count(); return(')'); }
("["|"<:")		{ count(); return('['); }
("]"|":>")		{ count(); return(']'); }
"."			{ count(); return('.'); }
"&"			{ count(); return('&'); }
"!"			{ count(); return('!'); }
"~"			{ count(); return('~'); }
"-"			{ count(); return('-'); }
"+"			{ count(); return('+'); }
"*"			{ count(); return('*'); }
"/"			{ count(); return('/'); }
"%"			{ count(); return('%'); }
"<"			{ count(); return('<'); }
">"			{ count(); return('>'); }
"^"			{ count(); return('^'); }
"|"			{ count(); return('|'); }
"?"			{ count(); return('?'); }
[ \t\v\n\f]		{ count(); }
.			{ /* Add code to complain about unmatched characters */ }

%%

int yywrap(void)
{
	return 1;
}



void count(void)
{
	int i;
	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
			column++;

	ECHO;
}


