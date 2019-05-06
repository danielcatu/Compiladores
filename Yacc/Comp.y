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
%token POD POF POC

%start MONDA

%{
extern int column;
%}

%%
MONDA: MULTIMONDA | MONDA MULTIMONDA |;

MULTIMONDA: Declaracion | Condicionals | ESfline | Declaracion SALTO {column++;};

Condicionals:Whileline | Ifline | Doesline | For;
Whileline: WHILE '('Condicion')''{'MONDA'}';
Ifline: IF '('Condicion')''{'MONDA'}'| IF '('Condicion')''{'MONDA'}'ELSE'{'MONDA'}';
Doesline: DO '{'MONDA'}' WHILE '('Condicion')';
Shiwtchline: SWITCH '('IDENTIFIER')''{'Caseline'}';
For:FOR '(' AUX IDENTIFIER '=' HYDRA ';' IDENTIFIER Cond_type HYDRA ';' IDENTIFIER PACK ')' '{'MONDA'}';
HYDRA: IDENTIFIER | INTVALUE;
CHARDRA: IDENTIFIER | CHARVALUE;
FLOATDRA: IDENTIFIER | FLOATVALUE;
AUX: INT | ;
PACK: INC_OP | DEC_OP | '+' HYDRA | '-' HYDRA;
Caseline: Caseint | CaseChar | Casefloat | DEFAULT ':' | DEFAULT ':' BREAK ';';
Caseint: Caseint |CASE INTVALUE ':' MONDA BREAK';';
CaseChar: Caseint |CASE CHARVALUE ':' MONDA BREAK';';
Casefloat: Caseint |CASE FLOATVALUE ':' MONDA BREAK';';

Condicion: Condicion Cond_Mod Condicion | '~(' Condicion ')' | Posco Cond_type Posco;
Posco: IDENTIFIER | INTVALUE | CHARVALUE | FLOATVALUE;
Cond_type: LE_OP | GE_OP | EQ_OP | NE_OP;
Cond_Mod: OR_OP | AND_OP;

ESF:PRINTF | SCANF ;
ESfline: ESF '(' POD ',' HYDRA ')' ';' | ESF '(' POC ',' CHARDRA ')' ';' | ESF '(' POF ',' FLOATDRA ')' ';';
Indent:


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
	yyparse(); 
    fprintf(yyout,"\nTabla de Identificadores \n");
    printf("Exitoooooooo..... PARA SERVIRTE \n");
    return 0;
}

yyerror(char *s)
{
    fprintf(stderr, " line %d: %s\n", column, s);
}