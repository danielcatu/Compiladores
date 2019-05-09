%token IDENTIFIER   
%token INC_OP DEC_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN

%token LIBRERIA NEGA INLINE MAIN INCLUDE
%token CHAR INT FLOAT VOID
%token CHARVALUE FLOATVALUE INTVALUE
%token CASE DEFAULT IF ELSE SWITCH WHILE FOR GOTO CONTINUE BREAK RETURN DO PRINTF SCANF

%start INCLINE

%{
extern int column;
%}

%%
MODA: MODA MULTIMODA | MODA error | ;

MULTIMODA: Declaracion | Condicionals | ESfline | Varuse  ;

Condicionals:Whileline | Ifline | Doesline | Forline | Shiwtchline ;

Whileline: WHILE '('Condicion')''{'MODA'}';
Condicion: Condicion Cond_Mod Condicion | NEGA Condicion ')' | FLOINT Cond_type FLOINT | CHARDRA Cond_type CHARDRA ;
FLOINT: IDENTIFIER | INTVALUE | FLOATVALUE;
Cond_type: LE_OP | GE_OP | EQ_OP | NE_OP | '<' | '>';
Cond_Mod: OR_OP | AND_OP;

Ifline: IF '('Condicion')''{'MODA'}'| IF '('Condicion')''{'MODA'}' ELSE '{'MODA'}';

Doesline: DO '{'MODA'}' WHILE '('Condicion')';

Shiwtchline: SWITCH '('IDENTIFIER')''{'Caseline'}';
Caseline: Caos DEFAULT ':' MODA BREAKK | Caos; 
Caos: CINT | CCHAR | CFLOAT;
BREAKK: BREAK ';' |;
CINT: CASE INTVALUE ':' MODA BREAKK CINT |;
CCHAR: CASE CHARVALUE ':' MODA BREAKK CCHAR |;
CFLOAT: CASE FLOATVALUE ':' MODA BREAKK CFLOAT |;

Forline: FOR '(' AUXfor IDENTIFIER '=' HYDRA ';' IDENTIFIER Cond_type HYDRA ';' var1  ')' '{'MODA'}';
var1:IDENTIFIER ForPACK | error;
HYDRA: IDENTIFIER | INTVALUE;
CHARDRA: IDENTIFIER | CHARVALUE;
AUXfor: INT | ;
ForPACK: INC_OP | DEC_OP | Assing IDENTIFIER '+' HYDRA | Assing IDENTIFIER '-' HYDRA;

ESfline: ESF '(' CHARVALUE ',' FLOINT ')' ';';
ESF:PRINTF | SCANF ;

Varuse:IDENTIFIER IDPACK ';'| IDENTIFIER ';';
IDPACK: INC_OP | DEC_OP | Assing OPERAR | '=' CHARVALUE;
OPERAR: OPERAR Operation OPERAR | '(' OPERAR ')' | INTVALUE | FLOATVALUE | IDENTIFIER ;
Operation: '+' | '-' | '/' | '*';
Assing: ADD_ASSIGN | SUB_ASSIGN | MUL_ASSIGN | DIV_ASSIGN | '=';

INCLINE: INCLUDE LIBRERIA INCLINE | MAIS |;
MAIS: VOID MAIN  '('DEIZI')''{'MODA'}';
DEIZI: SELECTOR IDENTIFIER Dizi2 |;
Dizi2: ',' SELECTOR IDENTIFIER Dizi2 |;
SELECTOR: INT | CHAR | FLOAT;

Declaracion: Dechar | Deint | Defloat;
Dechar:CHAR Dechar2';';
Dechar2:Dechar3 | Dechar3 ',' Dechar2;
Dechar3: IDENTIFIER '=' CHARVALUE | IDENTIFIER;
Deint:INT Deint2';';
Deint2:Deint3 | Deint3 ',' Deint2;
Deint3: IDENTIFIER '=' INTVALUE | IDENTIFIER;
Defloat:FLOAT Defloat2';';
Defloat2:Defloat3 | Defloat3 ',' Defloat2;
Defloat3: IDENTIFIER '=' FLOATVALUE | IDENTIFIER;

 
%%
#include <stdio.h>

extern char yytext[];

int main( int argc, char *argv[] )
{
   extern FILE *yyin, *yyout; 
   if( argc == 2 ) {
	yyin = fopen(argv[1], "r"); 
    if(yyin == NULL) /* open failed */{ 
     fprintf(yyout,"error");
     exit(1);
     }
	yyout = fopen("salida.txt", "w");
     if(yyout == NULL) /* open failed */{ 
     fprintf(yyout,"error");
     exit(1);
     }
	yyparse(); 
     printf("Bien. \n");
   }
   else if( argc > 2 ) {
      printf("Too many arguments supplied.\n");
   }
   else {
      printf("One argument expected.\n");
   }

    return 0;
}

yyerror(char *s)
{
    fprintf(stderr, " line %d: %s\n", column, s);
}