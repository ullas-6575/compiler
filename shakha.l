%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "shakha.tab.h"

int keyword_count = 0;
int datatype_count = 0;
int operator_count = 0;
int control_count = 0;
int function_count = 0;
int userdefined_count = 0;
int literal_count = 0;
int comment_count = 0;
int symbol_count = 0;
%}

%option yylineno
%option noyywrap

%%

\n {
}

"#"[^\n]* {
    fprintf(yyout, "COMMENT DETECTED - LINE %d\n", yylineno);
    comment_count++;
}

"/*"([^*]|\*+[^*/])*\*+"/" {
    fprintf(yyout, "MULTI-LINE COMMENT DETECTED - LINE %d\n", yylineno);
    comment_count++;
}

/* Matches only when there is no closing */
"/*" {
    fprintf(yyout, "UNTERMINATED COMMENT - LINE %d\n", yylineno);
    symbol_count++;
}

"dhoro" {
    fprintf(yyout, "VARIABLE DECLARATION DETECTED - LINE %d\n", yylineno);
    keyword_count++;
    return DHORO;
}

"def" {
    fprintf(yyout, "FUNCTION DEFINITION DETECTED - LINE %d\n", yylineno);
    function_count++;
    return DEF;
}

"ret" {
    fprintf(yyout, "RETURN STATEMENT DETECTED - LINE %d\n", yylineno);
    function_count++;
    return RET;
}

"yadi" {
    fprintf(yyout, "IF CONDITION DETECTED - LINE %d\n", yylineno);
    control_count++;
    return YADI;
}

"nahole_yadi" {
    fprintf(yyout, "ELSE-IF CONDITION DETECTED - LINE %d\n", yylineno);
    control_count++;
    return NAHOLE_YADI;
}

"nahole" {
    fprintf(yyout, "ELSE CONDITION DETECTED - LINE %d\n", yylineno);
    control_count++;
    return NAHOLE;
}

"jotokkhon" {
    fprintf(yyout, "WHILE LOOP DETECTED - LINE %d\n", yylineno);
    control_count++;
    return JOTOKKHON;
}

"loop" {
    fprintf(yyout, "FOR LOOP DETECTED - LINE %d\n", yylineno);
    control_count++;
    return LOOP;
}

"dekho" {
    fprintf(yyout, "OUTPUT FUNCTION DETECTED - LINE %d\n", yylineno);
    function_count++;
    return DEKHO;
}

"satya" {
    fprintf(yyout, "TRUE VALUE DETECTED - LINE %d\n", yylineno);
    keyword_count++;
    return SATYA;
}

"mithya" {
    fprintf(yyout, "FALSE VALUE DETECTED - LINE %d\n", yylineno);
    keyword_count++;
    return MITHYA;
}

"and" {
    fprintf(yyout, "LOGICAL AND OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return AND;
}

"or" {
    fprintf(yyout, "LOGICAL OR OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return OR;
}

"not" {
    fprintf(yyout, "LOGICAL NOT OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return NOT;
}

"sankhya" {
    fprintf(yyout, "INTEGER DATA TYPE DETECTED - LINE %d\n", yylineno);
    datatype_count++;
    return TY_INT;
}

"doshomik" {
    fprintf(yyout, "FLOAT DATA TYPE DETECTED - LINE %d\n", yylineno);
    datatype_count++;
    return TY_FLT;
}

"lekha" {
    fprintf(yyout, "STRING DATA TYPE DETECTED - LINE %d\n", yylineno);
    datatype_count++;
    return TY_STR;
}

"jukti" {
    fprintf(yyout, "BOOLEAN DATA TYPE DETECTED - LINE %d\n", yylineno);
    datatype_count++;
    return TY_BOOL;
}

"talika" {
    fprintf(yyout, "ARRAY DATA TYPE DETECTED - LINE %d\n", yylineno);
    datatype_count++;
    return TY_ARR;
}

"sort" {
    fprintf(yyout, "LIBRARY FUNCTION DETECTED: sort - LINE %d\n", yylineno);
    function_count++;
    yylval.sval = strdup(yytext);
    return IDENT;
}

"push_back" {
    fprintf(yyout, "LIBRARY FUNCTION DETECTED: push_back - LINE %d\n", yylineno);
    function_count++;
    yylval.sval = strdup(yytext);
    return IDENT;
}

"binary_search" {
    fprintf(yyout, "LIBRARY FUNCTION DETECTED: binary_search - LINE %d\n", yylineno);
    function_count++;
    yylval.sval = strdup(yytext);
    return IDENT;
}

"replace" {
    fprintf(yyout, "LIBRARY FUNCTION DETECTED: replace - LINE %d\n", yylineno);
    function_count++;
    yylval.sval = strdup(yytext);
    return IDENT;
}

"len" {
    fprintf(yyout, "LIBRARY FUNCTION DETECTED: len - LINE %d\n", yylineno);
    function_count++;
    yylval.sval = strdup(yytext);
    return IDENT;
}

"==" {
    fprintf(yyout, "EQUAL OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return EQ;
}

"!=" {
    fprintf(yyout, "NOT EQUAL OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return NE;
}

"<=" {
    fprintf(yyout, "LESS OR EQUAL OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return LE;
}

">=" {
    fprintf(yyout, "GREATER OR EQUAL OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return GE;
}

"+" {
    fprintf(yyout, "ADDITION OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return '+';
}

"-" {
    fprintf(yyout, "SUBTRACTION OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return '-';
}

"*" {
    fprintf(yyout, "MULTIPLICATION OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return '*';
}

"/" {
    fprintf(yyout, "DIVISION OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return '/';
}

"%" {
    fprintf(yyout, "MODULO OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return '%';
}

"<" {
    fprintf(yyout, "LESS THAN OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return '<';
}

">" {
    fprintf(yyout, "GREATER THAN OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return '>';
}

"=" {
    fprintf(yyout, "ASSIGNMENT OPERATOR DETECTED - LINE %d\n", yylineno);
    operator_count++;
    return '=';
}

[0-9]+\.[0-9]+ {
    fprintf(yyout, "FLOAT LITERAL DETECTED - LINE %d\n", yylineno);
    literal_count++;
    yylval.fval = atof(yytext);
    return FLOAT_LIT;
}

[0-9]+ {
    fprintf(yyout, "INTEGER LITERAL DETECTED - LINE %d\n", yylineno);
    literal_count++;
    yylval.ival = atol(yytext);
    return INT_LIT;
}

\"[^\"\n]*\" {
    fprintf(yyout, "STRING LITERAL DETECTED - LINE %d\n", yylineno);
    literal_count++;
    yylval.sval = strdup(yytext);
    return STRING_LIT;
}

[A-Za-z_\200-\377][A-Za-z0-9_\200-\377]* {
    fprintf(yyout, "IDENTIFIER DETECTED: %s - LINE %d\n", yytext, yylineno);
    userdefined_count++;
    yylval.sval = strdup(yytext);
    return IDENT;
}

"$" {
    fprintf(yyout, "STATEMENT TERMINATOR DETECTED - LINE %d\n", yylineno);
    symbol_count++;
    return '$';
}

":" {
    fprintf(yyout, "BLOCK START (COLON) DETECTED - LINE %d\n", yylineno);
    symbol_count++;
    return ':';
}

";" {
    fprintf(yyout, "BLOCK END (SEMICOLON) DETECTED - LINE %d\n", yylineno);
    symbol_count++;
    return ';';
}

"(" {
    fprintf(yyout, "LEFT PARENTHESIS DETECTED - LINE %d\n", yylineno);
    symbol_count++;
    return '(';
}

")" {
    fprintf(yyout, "RIGHT PARENTHESIS DETECTED - LINE %d\n", yylineno);
    symbol_count++;
    return ')';
}

"[" {
    fprintf(yyout, "LEFT BRACKET DETECTED - LINE %d\n", yylineno);
    symbol_count++;
    return '[';
}

"]" {
    fprintf(yyout, "RIGHT BRACKET DETECTED - LINE %d\n", yylineno);
    symbol_count++;
    return ']';
}

"," {
    fprintf(yyout, "COMMA DETECTED - LINE %d\n", yylineno);
    symbol_count++;
    return ',';
}

[ \t\r]+ {
}

. {
    fprintf(yyout, "UNKNOWN SYMBOL '%s' - LINE %d\n", yytext, yylineno);
}

%%

/* Called by main() in shakha.y after parsing */
void print_token_summary(FILE *f) {
    fprintf(f, "\nTOKEN SUMMARY\n");
    fprintf(f, "Keywords              : %d\n", keyword_count);
    fprintf(f, "Data Types            : %d\n", datatype_count);
    fprintf(f, "Operators             : %d\n", operator_count);
    fprintf(f, "Control Statements    : %d\n", control_count);
    fprintf(f, "Functions             : %d\n", function_count);
    fprintf(f, "User Defined/IDs      : %d\n", userdefined_count);
    fprintf(f, "Literals              : %d\n", literal_count);
    fprintf(f, "Comments              : %d\n", comment_count);
    fprintf(f, "Symbols               : %d\n", symbol_count);
}