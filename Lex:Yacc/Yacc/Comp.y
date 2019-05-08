%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token TYPEDEF EXTERN STATIC AUTO REGISTER INLINE RESTRICT
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
MONDA: MULTIMONDA | MONDA MULTIMONDA |MONDA error|;

MULTIMONDA: Declaracion | Condicionals | ESfline | Varuse | Shiwtchline | Declaracion SALTO {column++;};

Condicionals:Whileline | Ifline | Doesline | Forline;
Whileline: WHILE '('Condicion')''{'MONDA'}';
Ifline: IF '('Condicion')''{'MONDA'}'| IF '('Condicion')''{'MONDA'}'ELSE'{'MONDA'}';
Doesline: DO '{'MONDA'}' WHILE '('Condicion')';

Shiwtchline: SWITCH '('IDENTIFIER')''{'Caseline'}';
Caseline: Caos DEFAULT ':' MONDA BREAKK | Caos; 
Caos: CINT | CCHAR | CFLOAT;
BREAKK: BREAK ';' |;
CINT: CASE INTVALUE ':' MONDA BREAKK CINT |;
CCHAR: CASE CHARVALUE ':' MONDA BREAKK CCHAR |;
CFLOAT: CASE FLOATVALUE ':' MONDA BREAKK CFLOAT |;

Forline: FOR '(' AUXfor IDENTIFIER '=' HYDRA ';' IDENTIFIER Cond_type HYDRA ';' IDENTIFIER ForPACK ')' '{'MONDA'}';
HYDRA: IDENTIFIER | INTVALUE;
AUXfor: INT | ;
ForPACK: INC_OP | DEC_OP | '+' HYDRA | '-' HYDRA;

Condicion: Condicion Cond_Mod Condicion | '~(' Condicion ')' | Tundra Cond_type Tundra;
Tundra: IDENTIFIER | INTVALUE | CHARVALUE | FLOATVALUE;
Cond_type: LE_OP | GE_OP | EQ_OP | NE_OP | '<' | '>';
Cond_Mod: OR_OP | AND_OP;

ESF:PRINTF | SCANF ;
ESfline: ESF '(' CHARVALUE ',' Tundra ')' ';';

Varuse:IDENTIFIER IDPACK ';';
IDPACK: INC_OP | DEC_OP | '=' OPERAR | '=' CHARVALUE;
OPERAR: OPERAR Operation OPERAR | '(' OPERAR ')' | INTVALUE | FLOATVALUE | IDENTIFIER ;
Operation: '+' | '-' | '/' | '*';

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