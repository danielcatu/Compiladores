%{
#include<stdio.h>
#include <ctype.h>
#include "y.tab.h"
%}

/*Rules*/
Declaracion {Token}" "+[a-z][a-z0-9]*(","?[a-z][a-z0-9]*)*
Token   "int"|"float"|"char"
Variable [a-z][a-z0-9]*
Float   ([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)? 
int   ([0-9]+)([eE][-+]?[0-9]+)? 
char   .*
Operator   "+"|"-"|"*"|"/"|"^" 
Logicos   "&&"|"||"|"~"
cc   "\""
Varchar   {cc}{char}{cc}
Clave   "if"|"else"|"for"|"while"|"do"|"switch"|"scanf"|"printf"|"main"|"void"|case" "+[1-9][0-9]+?:
Ifin   "{"|"}"
Simbolos   "("|")"|","|";"

%x C_COMMENT
%%

"//"{char} {}

" && " {fprintf(yyout,"Op-and= %s ",yytext);return(AND_OP);}
" || " {fprintf(yyout,"Op-or= %s ",yytext);return(OR_OP);}
"~"  {fprintf(yyout,"Op-no= %s ",yytext);return('~');}
"=" {fprintf(yyout,"Op-asig= %s ",yytext);return('=');}
"==" {fprintf(yyout,"igual= %s ",yytext);return(EQ_OP);}
"<=" {fprintf(yyout,"Menor-igual= %s ",yytext);return(LE_OP);}
">=" {fprintf(yyout,"Mayor-igual= %s ",yytext);return(GE_OP);}
"!=" {fprintf(yyout,"Diferente= %s ",yytext); return(NE_OP);}
"<" {fprintf(yyout,"Menor= %s ",yytext);return('<');}
">" {fprintf(yyout,"Mayor= %s ",yytext);return('>');}

{Varchar} { 
fprintf(yyout,"Cte cadena= %s ",yytext);return(STRING_LITERAL);
}

"if"			{ fprintf(yyout,"IF",yytext); return(IF); }
"else"			{ fprintf(yyout,"ELSE",yytext); return(ELSE); }
"for"			{ fprintf(yyout,"FOR",yytext); return(FOR); }
"while"			{ fprintf(yyout,"WHILE",yytext); return(WHILE); }
"do"			{ fprintf(yyout,"DO",yytext); return(DO); }
"switch"		{ fprintf(yyout,"SWITCH",yytext); return(SWITCH); }
"void"			{ fprintf(yyout,"VOID",yytext); return(VOID); }
"case"			{ fprintf(yyout,"CASE",yytext); return(CASE); }
"float"			{ return(FLOAT); }
"int"			{ return(INT); }
"char"			{ return(CHAR); }

{Ifin} {
    switch((char)*yytext)
    {
        case '{':
        fprintf(yyout,"Inicio= %s ",yytext);return('{');
        break;
        case '}':
        fprintf(yyout,"Fin= %s ",yytext);return('}');
        break;
    }
}

{Simbolos} {
    switch((char)*yytext)
    {
        case '(':fprintf(yyout,"Parent-a= %s ",yytext);return('(');
        break;
        case ')':fprintf(yyout,"Parent-c= %s ",yytext);return(')');
        break;
        case ',':fprintf(yyout,"Coma= %s ",yytext);return(',');
        break;
        case ';':fprintf(yyout,"Punto-coma= %s ",yytext);return(';');
        break;
    }
}

{Operator} {
    switch((char)*yytext)
    {
    case '+':fprintf(yyout,"Op-sum= %s ",yytext);return('+');
    break;
    case '-':fprintf(yyout,"Op-sust= %s ",yytext);return('-');
    break;
    case '*':fprintf(yyout,"Op-mult= %s ",yytext);return('*');
    break;
    case '/':fprintf(yyout,"Op-div= %s ",yytext);return('/');
    break;
    case '^':fprintf(yyout,"Op-exp= %s ",yytext);return('^');
    break;
    }
}

{Variable} {
    add_word(yytext,0);
    fprintf(yyout,"Id= %s ",yytext);return(IDENTIFIER);
}


{Float} {
 fprintf(yyout,"Cte real= %s ",yytext); return(CONSTANT);
}

{int} {
fprintf(yyout,"Cte entera= %s ",yytext); return(CONSTANT);
}

"/*"            { BEGIN(C_COMMENT); }
<C_COMMENT>"*/" { BEGIN(INITIAL); }
<C_COMMENT>.    

" " //nada

.*$" " {fprintf(yyout,"Unknown Word= %s ",yytext);}

%%

/*call the yywrap function*/
int yywrap()
{
return 1;
}

int main()
{   
   extern FILE *yyin, *yyout; 
   char file_name[25];
   printf("Enter name of a file you wish to see\n");
   gets(file_name);
 
	yyin = fopen(file_name, "r"); 
    if(yyin == NULL) /* open failed */{ 
     fprintf(yyout,"error");
     exit(1);
     }
	yyout = fopen("salida.txt", "w");
     if(yyout == NULL) /* open failed */{ 
     fprintf(yyout,"error");
     exit(1);
     }
	yylex(); 
    fprintf(yyout,"\nTabla de Identificadores \n");
    add_word("",1);
    printf("Acabo");
	return 0; 
} 
/* define a linked list of words and types */

struct word {
      char *word_name;
      struct word *next;
      };
struct word *word_list; /* first element in word list */
extern void *malloc() ;

int 
add_word(char *word,int a)
{      struct word *wp;
      if(lookup_word(word,a) != 0) {
      return 0;      
      }      
    /* word not there, allocate a new entry and link it on the list */      
    wp = (struct word *) malloc(sizeof(struct word)); 
    wp->next = word_list; 
    /* have to copy the word itself as well */
    wp->word_name = (char *) malloc(strlen(word)+1);
    strcpy(wp->word_name, word);
    word_list = wp;
    return 1;/* it worked */
    }

    int
    lookup_word(char *word,int a){
    struct word *wp = word_list;
    
    /* search down the list looking for the word */
      for(; wp; wp = wp->next) {
          int jj=0;
        if(a==1){
            fprintf(yyout,"Id= %s; ",wp->word_name);
            if(jj==5){
                fprintf(yyout,"\n");
                jj=0;
            }
        }    
        if(strcmp(wp->word_name, word) == 0) 
        return 1;
       }      
       return 0;      /* not found */
}