%{
#include<stdio.h>

%}
/*Rules*/
Variable       [a-z][a-z0-9]*
Float    ([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)?
Numerico {int}|{Float}
int [0-9]+
char [a-zA-Z]+
Operator "+"|"-"|"*"|"/"|"^" 
Comparadores "=="|"<="|">="|"!="|"<"|">"
Logicos "&&"|"||"
cc "\""
Varchar {Variable}("="{cc}{char}{cc})?
Varint {Variable}("="{int})?
Varfloat {Variable}("="{Float})?
Comparandonum {Numerico}{Comparadores}{Numerico}
Comparandochar {char}{Comparadores}{char}
Comparador ("if"|"while")"("{Comparandonum}(" "{Logicos}" "{Comparandonum})*"){"\n*"}"
Comparadorchar ("if"|"while")"("{Comparandochar}(" "{Logicos}" "{Comparandochar})*")"
Inout ("printf"|"scanf")"("{cc}{char}{cc}","{Variable}");"
Type "char "{Varchar}(","{Varchar})*";"|"int "{Varint}(","{Varint})*";"|"float "{Varfloat}(","{Varfloat})*";"
comment ^[ \t]*"/*".*"*/"[ \t]*\n
%{
    char oper ;
%}


%%

{Comparador} {printf("Correcto HP=%s ",yytext);} 
{Operator} {
    oper=(char)*yytext;
    eval();
}
{Type} {printf("Correcto HP=%s ",yytext);
}
{Variable} {
    add_word(yytext);
}
%%


eval(){
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
int main()
{
      yylex();
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
add_word(char *word)
{      struct word *wp;
      if(lookup_word(word) != 0) {
      printf("!!! warning: word %s already defined \n", word);
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
    lookup_word(char *word){
    struct word *wp = word_list;
    
    /* search down the list looking for the word */
      for(; wp; wp = wp->next) {
        if(strcmp(wp->word_name, word) == 0) 
        return 1;
       }      
       return 0;      /* not found */
}

