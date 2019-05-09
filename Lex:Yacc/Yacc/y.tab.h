/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IDENTIFIER = 258,
    INC_OP = 259,
    DEC_OP = 260,
    LE_OP = 261,
    GE_OP = 262,
    EQ_OP = 263,
    NE_OP = 264,
    AND_OP = 265,
    OR_OP = 266,
    ADD_ASSIGN = 267,
    SUB_ASSIGN = 268,
    MUL_ASSIGN = 269,
    DIV_ASSIGN = 270,
    LIBRERIA = 271,
    NEGA = 272,
    INLINE = 273,
    MAIN = 274,
    INCLUDE = 275,
    CHAR = 276,
    INT = 277,
    FLOAT = 278,
    VOID = 279,
    CHARVALUE = 280,
    FLOATVALUE = 281,
    INTVALUE = 282,
    CASE = 283,
    DEFAULT = 284,
    IF = 285,
    ELSE = 286,
    SWITCH = 287,
    WHILE = 288,
    FOR = 289,
    GOTO = 290,
    CONTINUE = 291,
    BREAK = 292,
    RETURN = 293,
    DO = 294,
    PRINTF = 295,
    SCANF = 296
  };
#endif
/* Tokens.  */
#define IDENTIFIER 258
#define INC_OP 259
#define DEC_OP 260
#define LE_OP 261
#define GE_OP 262
#define EQ_OP 263
#define NE_OP 264
#define AND_OP 265
#define OR_OP 266
#define ADD_ASSIGN 267
#define SUB_ASSIGN 268
#define MUL_ASSIGN 269
#define DIV_ASSIGN 270
#define LIBRERIA 271
#define NEGA 272
#define INLINE 273
#define MAIN 274
#define INCLUDE 275
#define CHAR 276
#define INT 277
#define FLOAT 278
#define VOID 279
#define CHARVALUE 280
#define FLOATVALUE 281
#define INTVALUE 282
#define CASE 283
#define DEFAULT 284
#define IF 285
#define ELSE 286
#define SWITCH 287
#define WHILE 288
#define FOR 289
#define GOTO 290
#define CONTINUE 291
#define BREAK 292
#define RETURN 293
#define DO 294
#define PRINTF 295
#define SCANF 296

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
