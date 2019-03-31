%{
#include<stdio.h>

%}
/*Rules*/
Variable       [a-z][a-z0-9]*
Float    [0-9]+"."[0-9]+
int [0-9]+
char [a-zA-Z]+
Operator "+"|"-"|"*"|"/"|"^" 
Comparadores ["=="|"<="|">="|"!="|"<"|">"]
Logicos ["&&"|"||"]
cc "\""
Varchar {Variable}("="{cc}{char}{cc})?
Varint {Variable}("="{int})?
Varfloat {Variable}("="{Float})?
Type "char "{Varchar}(","{Varchar})*";"|"int "{Varint}(","{Varint})*";"|"float "{Varfloat}(","{Varfloat})*";"

%{
    char oper ;
%}

%%

{Operator} {
    oper=(char)*yytext;
    switch(oper)
    {
        case '+':printf("Op-sum= %s ",yytext);
        break;
        case '-':printf("Op-sust= %s ",yytext);
        break;
        case '*':printf("Op-mult= %s ",yytext);
        break;
        case '/':printf("Op-div= %s ",yytext);
        break;
    }
}
{Type} {printf("Correcto HP=%s ",yytext);
}

%%


int yylex(void);

void main(void)
{
        yylex();
}