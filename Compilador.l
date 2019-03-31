%{
#include<stdio.h>
%}
ID       [a-z][a-z0-9]*
Operator ["+"|"-"|"*"|"/"] 

%%
"*" printf("Op-mult= %s ",yytext);
"+" printf("Op-sum= %s ",yytext);
"-" printf("Op-sust= %s ",yytext);
"/" printf("Op-div= %s ",yytext);
"^" printf("Op-exp= %s ",yytext);
"=" printf("Op-asign= %s ",yytext);
"(" printf("Parent-a= %s ",yytext);
")" printf("Parent-c= %s ",yytext);
"," printf("Coma= %s ",yytext);
"int" printf("INT Id=",yytext);
"char" printf("CHAR Id=",yytext);
"float" printf("FLOAT Id=",yytext);
"==" printf("igual= %s ",yytext);
"<=" printf("Menor-igual= %s ",yytext);
">=" printf("Mayor-igual= %s ",yytext);
"!=" printf("Diferente= %s ",yytext);
"<" printf("Menor= %s ",yytext);
">" printf("Mayor= %s ",yytext);
" && " printf("Op-y= %s ",yytext);
" || " printf("Op-o= %s ",yytext);
"!"{ID} printf("Op-no= %s ",yytext);
"{" printf("Inicio= %s ",yytext);
"}" printf("Fin= %s ",yytext);
"/*"(.|\n)*?"*/"  /* no action: ignore multiline comments */
[a-zA-Z] printf("%c",yytext[0]- 32);
%%

int main(void){
    yylex();
    return 0;
}