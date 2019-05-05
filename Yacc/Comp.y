%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME

%token TYPEDEF EXTERN STATIC AUTO REGISTER INLINE RESTRICT
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token CHARVALUE FLOATVALUE INTVALUE
%token BOOL COMPLEX IMAGINARY
%token STRUCT UNION ENUM ELLIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%start MONDA
%%

MONDA: Declaracion | MONDA Declaracion;

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
extern int column;

int main()
{
    yyparse();
    return 0;
}
yyerror(char const *s)
{
	fflush(stdout);
	fprintf("\n%*s\n%*s\n", column, "^", column, s);
}