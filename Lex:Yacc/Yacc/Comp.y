%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token TYPEDEF EXTERN STATIC LIBRERIA NEGA INLINE MAIN INCLUDE
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token CHARVALUE FLOATVALUE INTVALUE
%token BOOL COMPLEX IMAGINARY SALTO
%token STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE FOR GOTO CONTINUE BREAK RETURN DO PRINTF SCANF

%start MONDA

%{
extern int column;
%}

%%
MONDA: MULTIMONDA | MONDA MULTIMONDA | MONDA error | | xerror ;

MULTIMONDA: Declaracion | Condicionals | ESfline | Varuse | Declaracion SALTO {column++;} | xerror ;

Condicionals:Whileline | Ifline | Doesline | Forline | Shiwtchline | xerror ;

Whileline: WHILE '('Condicion')''{'MONDA'}'| xerror ;
Ifline: IF '('Condicion')''{'MONDA'}'| IF '('Condicion')''{'MONDA'}'ELSE'{'MONDA'}'| xerror ;

Doesline: DO '{'MONDA'}' WHILE '('Condicion')'| xerror ;

Shiwtchline: SWITCH '('IDENTIFIER')''{'Caseline'}'| xerror ;
Caseline: Caos DEFAULT ':' MONDA BREAKK | Caos| xerror ; 
Caos: CINT | CCHAR | CFLOAT| xerror ;
BREAKK: BREAK ';' || xerror ;
CINT: CASE INTVALUE ':' MONDA BREAKK CINT || xerror ;
CCHAR: CASE CHARVALUE ':' MONDA BREAKK CCHAR || xerror ;
CFLOAT: CASE FLOATVALUE ':' MONDA BREAKK CFLOAT || xerror ;

Forline: FOR '(' AUXfor IDENTIFIER '=' HYDRA ';' IDENTIFIER Cond_type HYDRA ';' IDENTIFIER ForPACK ')' '{'MONDA'}' | xerror| xerror ;
val1:IDENTIFIER ForPACK| error| xerror ;
HYDRA: IDENTIFIER | INTVALUE| xerror ;
CHARDRA: IDENTIFIER | CHARVALUE| xerror ;
AUXfor: INT | | xerror ;
ForPACK: INC_OP | DEC_OP | '+' HYDRA | '-' HYDRA| xerror ;

Condicion: Condicion Cond_Mod Condicion | NEGA Condicion ')' | FLOINT Cond_type FLOINT | CHARDRA Cond_type CHARDRA | xerror ;
FLOINT: IDENTIFIER | INTVALUE | FLOATVALUE| xerror ;
Cond_type: LE_OP | GE_OP | EQ_OP | NE_OP | '<' | '>'| xerror ;
Cond_Mod: OR_OP | AND_OP| xerror ;

ESfline: ESF '(' CHARVALUE ',' FLOINT ')' ';'| xerror ;
ESF:PRINTF | SCANF | xerror ;

Varuse:IDENTIFIER IDPACK ';'| xerror ;
IDPACK: INC_OP | DEC_OP | '=' OPERAR | '=' CHARVALUE| xerror ;
OPERAR: OPERAR Operation OPERAR | '(' OPERAR ')' | INTVALUE | FLOATVALUE | IDENTIFIER | xerror ;
Operation: '+' | '-' | '/' | '*'| xerror ;

INCLINE: INCLUDE LIBRERIA INCLINE | MAIS |INCLINE error || xerror ;
MAIS: VOID MAIN  '('DEIZI')''{'MONDA'}'|  error MONDA| xerror ;
viud:error VOID MAIN | xerror ;
DEIZI: SELECTOR IDENTIFIER Dizi2 || xerror ;
Dizi2: ',' SELECTOR IDENTIFIER Dizi2 || xerror ;
SELECTOR: INT | CHAR | FLOAT| xerror ;

Declaracion: Dechar | Deint | Defloat| xerror ;
Dechar:CHAR Dechar2';'| xerror ;
Dechar2:Dechar3 | Dechar3 ',' Dechar2| xerror ;
Dechar3: IDENTIFIER '=' CHARVALUE | IDENTIFIER| xerror ;
Deint:INT Deint2';'| xerror ;
Deint2:Deint3 | Deint3 ',' Deint2| xerror ;
Deint3: IDENTIFIER '=' INTVALUE | IDENTIFIER| xerror ;
Defloat:FLOAT Defloat2';'| xerror ;
Defloat2:Defloat3 | Defloat3 ',' Defloat2| xerror ;
Defloat3: IDENTIFIER '=' FLOATVALUE | IDENTIFIER| xerror ;

 xerror: IDENTIFIER xerror | CONSTANT xerror | STRING_LITERAL xerror | SIZEOF
 xerror | PTR_OP xerror | INC_OP xerror | DEC_OP xerror | LEFT_OP xerror | RIGHT_OP xerror | LE_OP xerror | GE_OP xerror | EQ_OP xerror | NE_OP
 xerror | AND_OP xerror | OR_OP xerror | MUL_ASSIGN xerror | DIV_ASSIGN xerror | MOD_ASSIGN xerror | ADD_ASSIGN
 xerror | SUB_ASSIGN xerror | LEFT_ASSIGN xerror | RIGHT_ASSIGN xerror | AND_ASSIGN
 xerror | XOR_ASSIGN xerror | OR_ASSIGN xerror | TYPE_NAME
 xerror | TYPEDEF xerror | EXTERN xerror | STATIC xerror | LIBRERIA xerror | NEGA xerror | INLINE xerror | MAIN xerror | INCLUDE
 xerror | CHAR xerror | SHORT xerror | INT xerror | LONG xerror | SIGNED xerror | UNSIGNED xerror | FLOAT xerror | DOUBLE xerror | CONST xerror | VOLATILE xerror | VOID
 xerror | CHARVALUE xerror | FLOATVALUE xerror | INTVALUE
 xerror | BOOL xerror | COMPLEX xerror | IMAGINARY xerror | SALTO
 xerror | STRUCT xerror | UNION xerror | ENUM xerror | ELLIPSIS
 xerror | CASE xerror | DEFAULT xerror | IF xerror | ELSE xerror | SWITCH xerror | WHILE xerror | FOR xerror | GOTO xerror | CONTINUE xerror | BREAK xerror | RETURN xerror | DO xerror | PRINTF xerror | SCANF  xerror
 | error;
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
    fprintf(yyout,"\nTabla de Identificadores \n");
    printf("Exitoooooooo..... PARA SERVIRTE \n");
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