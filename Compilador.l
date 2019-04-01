%{
#include<stdio.h>
#include <ctype.h>
%}

/*Rules*/
Declaracion {Token}" "*[a-z][a-z0-9]*
Token   "int"|"float"|"char"
Variable [a-z][a-z0-9]*
Float   ([0-9]*\.[0-9]+)([eE][-+]?[0-9]+)? 
int   [0-9]+
char   .*
Operator   "+"|"-"|"*"|"/"|"^" 
Comparadores   "="|"=="|"<="|">="|"!="|"<"|">"
Logicos   "&&"|"||"|"~"
cc   "\""
Varchar   {cc}{char}{cc}
Clave   "if"|"else"|"for"|"while"|"do"|"switch"|"scanf"|"printf"|"main"|"void"
Ifin   "{"|"}"
Simbolos   "("|")"|","|";"

%x C_COMMENT
%%
" && " fprintf(yyout,"Op-and= %s ",yytext);
" || " fprintf(yyout,"Op-or= %s ",yytext);
"~"  fprintf(yyout,"Op-no= %s ",yytext);
"=" fprintf(yyout,"Op-asig= %s ",yytext);
"==" fprintf(yyout,"igual= %s ",yytext);
"<=" fprintf(yyout,"Menor-igual= %s ",yytext);
">=" fprintf(yyout,"Mayor-igual= %s ",yytext);
"!=" fprintf(yyout,"Diferente= %s ",yytext);
"<" fprintf(yyout,"Menor= %s ",yytext);
">" fprintf(yyout,"Mayor= %s ",yytext);

{Varchar} {
fprintf(yyout,"Cte cadena= %s ",yytext);
}

{Clave} {
    int i=0;
      while(yytext[i]) {
      fprintf(yyout,"%c",toupper(yytext[i]));
      i++;
   }
   fprintf(yyout," ");
}

{Ifin} {
    switch((char)*yytext)
    {
        case '{':fprintf(yyout,"Inicio= %s ",yytext);
        break;
        case '}':fprintf(yyout,"Fin= %s ",yytext);
        break;
    }
}

{Simbolos} {
    switch((char)*yytext)
    {
        case '(':fprintf(yyout,"Parent-a= %s ",yytext);
        break;
        case ')':fprintf(yyout,"Parent-c= %s ",yytext);
        break;
        case ',':fprintf(yyout,"Coma= %s ",yytext);
        break;
        case ';':fprintf(yyout,"Punto-coma= %s ",yytext);
        break;
    }
}

{Operator} {
    switch((char)*yytext)
    {
    case '+':fprintf(yyout,"Op-sum= %s ",yytext);
    break;
    case '-':fprintf(yyout,"Op-sust= %s ",yytext);
    break;
    case '*':fprintf(yyout,"Op-mult= %s ",yytext);
    break;
    case '/':fprintf(yyout,"Op-div= %s ",yytext);
    break;
    case '^':fprintf(yyout,"Op-exp= %s ",yytext);
    break;
    }
}

{Declaracion} {
      int i=0;
     int h=0;
      while(yytext[i] ) {
          if(yytext[i] == ' '){
              h=i+1;
          }
          if(h==0){
              fprintf(yyout,"%c",toupper(yytext[i]));
          }
                
            i++;
         }
   fprintf(yyout," ");
int b= (i-h)-1;

char *cadena;
cadena = malloc(b);

 i=h;

    int j=0;
      while(yytext[i]) {
        cadena[j]=yytext[i];  
        j++;
        i++;
     }

  add_word(cadena);
  fprintf(yyout,"Id= %s ",cadena);
}

{Variable} {
if(add_word(yytext)==0){
    fprintf(yyout,"Id= %s ",yytext);
} else {
   fprintf(yyout,"Unknown Word= %s ",yytext);  
}
}

{Float} {
 fprintf(yyout,"Cte real= %s ",yytext);
}

{int} {
fprintf(yyout,"Cte entera= %s ",yytext);
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
	yyin = fopen("Input.txt", "r"); 
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

