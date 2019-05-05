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

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%start MONDA

%{
extern int column;
%}

%%
MONDA: MINIMONDA | MONDA MINIMONDA;

MINIMONDA: Declaracion | Condicionals | SALTO {column ++;};

Condicionals: Validcon '('Condicion')''{''}' | Validcon '('Condicion')''{'MONDA'}';
Validcon: WHILE | IF ;

Condicion: Condicion Cond_Mod Condicion | "~(" Condicion ')' | Posco Cond_type Posco;
Posco: IDENTIFIER | INTVALUE | CHARVALUE | FLOATVALUE;
Cond_type: LE_OP | GE_OP | EQ_OP | NE_OP;
Cond_Mod: OR_OP | AND_OP;

Declaracion: Dechar | Deint | Defloat;
Dechar:CHAR Dechar2';';
Dechar2:Dechar3 | Dechar3 ',' Dechar2;
Dechar3: IDENTIFIER '=' CHARVALUE | IDENTIFIER;
Deint:INT Deint2';';
Deint2:Deint3 | Deint3 ',' Deint2;
Deint3: IDENTIFIER '=' INTVALUE | IDENTIFIER;
Defloat:CHAR Defloat2';';
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
    printf("Acabo");
    return 0;
}

yyerror(char *s)
{
    fprintf(stderr, " line %d: %s\n", column, s);
}