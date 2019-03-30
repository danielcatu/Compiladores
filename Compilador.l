%{
#include<stdio.h>
%}

%%
"*" printf("Op-mult= %s ",yytext);
"+" printf("Op-sum= %s ",yytext);
"-" printf("Op-sust= %s ",yytext);
"/" printf("Op-div= %s ",yytext);
"^" printf("Op-exp= %s ",yytext);
"<--" printf("Op-asign= %s ",yytext);
"(" printf("Parent-a= %s ",yytext);
")" printf("Parent-c= %s ",yytext);
"," printf("Coma= %s ",yytext);
"int" printf("INT Id= %s ",yytext);
"char" printf("CHAR Id= %s ",yytext);
"float" printf("FLOAT Id= %s ",yytext);
"=" printf("Igual= %s ",yytext);
"<=" printf("Menor-igual= %s ",yytext);
">=" printf("Mayor-igual= %s ",yytext);
"<>" printf("Diferente= %s ",yytext);
"<" printf("Menor= %s ",yytext);
">" printf("Mayor= %s ",yytext);
" "*.y." "* printf("Op-y= %s ",yytext);
" "*.o." "* printf("Op-o= %s ",yytext);
" "*.~." "* printf("Op-no= %s ",yytext);
[a-zA-Z]  printf("%c",yytext[0]- 32);
"/*"(.|\n)*?"*/"  /* no action: ignore multiline comments */

%%

int main(void){
    yylex();
    return 0;
}