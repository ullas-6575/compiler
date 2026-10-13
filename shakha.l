%{
#include <stdio.h>
#include <string.h>

int line_no = 1;

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

%%

\n {
    line_no++;
}

"#"[^\n]* {
    fprintf(yyout, "COMMENT DETECTED - LINE %d\n", line_no);
    comment_count++;
}
"/*"([^*]|\*+[^*/])*\*+"/" {
    fprintf(yyout, "MULTI-LINE COMMENT DETECTED - LINE %d\n", line_no);
    comment_count++;

 for (int i = 0; yytext[i] != '\0'; i++) {
        if (yytext[i] == '\n')
            line_no++;
    }
   }

 /* error : no closing */ 
"/*" {
    fprintf(yyout, "UNTERMINATED COMMENT - LINE %d\n", line_no);
    symbol_count++;
}
"dhoro" {
    fprintf(yyout, "VARIABLE DECLARATION DETECTED - LINE %d\n", line_no);
    keyword_count++;
}

"def" {
    fprintf(yyout, "FUNCTION DEFINITION DETECTED - LINE %d\n", line_no);
    function_count++;
}

"ret" {
    fprintf(yyout, "RETURN STATEMENT DETECTED - LINE %d\n", line_no);
    function_count++;
}

"yadi" {
    fprintf(yyout, "IF CONDITION DETECTED - LINE %d\n", line_no);
    control_count++;
}
"nahole_yadi" {
    fprintf(yyout, "ELSE-IF CONDITION DETECTED - LINE %d\n", line_no);
    control_count++;
}

"nahole" {
    fprintf(yyout, "ELSE CONDITION DETECTED - LINE %d\n", line_no);
    control_count++;
}

"jotokkhon" {
    fprintf(yyout, "WHILE LOOP DETECTED - LINE %d\n", line_no);
    control_count++;
}

"loop" {
    fprintf(yyout, "FOR LOOP DETECTED - LINE %d\n", line_no);
    control_count++;
}

"dekho" {
    fprintf(yyout, "OUTPUT FUNCTION DETECTED - LINE %d\n", line_no);
    function_count++;
}

"cin" {
    fprintf(yyout, "INPUT FUNCTION DETECTED: cin - LINE %d\n", line_no);
    function_count++;
}

"satya" {
    fprintf(yyout, "TRUE VALUE DETECTED - LINE %d\n", line_no);
    keyword_count++;
}

"mithya" {
    fprintf(yyout, "FALSE VALUE DETECTED - LINE %d\n", line_no);
    keyword_count++;
}

"and" {
    fprintf(yyout, "LOGICAL AND OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

"or" {
    fprintf(yyout, "LOGICAL OR OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

"not" {
    fprintf(yyout, "LOGICAL NOT OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

"sankhya" {
    fprintf(yyout, "INTEGER DATA TYPE DETECTED - LINE %d\n", line_no);
    datatype_count++;
}

"doshomik" {
    fprintf(yyout, "FLOAT DATA TYPE DETECTED - LINE %d\n", line_no);
    datatype_count++;
}

"lekha" {
    fprintf(yyout, "STRING DATA TYPE DETECTED - LINE %d\n", line_no);
    datatype_count++;
}

"jukti" {
    fprintf(yyout, "BOOLEAN DATA TYPE DETECTED - LINE %d\n", line_no);
    datatype_count++;
}

"talika" {
    fprintf(yyout, "ARRAY DATA TYPE DETECTED - LINE %d\n", line_no);
    datatype_count++;
}

"sort" {
    fprintf(yyout, "LIBRARY FUNCTION DETECTED: sort - LINE %d\n", line_no);
    function_count++;
}

"push_back" {
    fprintf(yyout, "LIBRARY FUNCTION DETECTED: push_back - LINE %d\n", line_no);
    function_count++;
}

"binary_search" {
    fprintf(yyout, "LIBRARY FUNCTION DETECTED: binary_search - LINE %d\n", line_no);
    function_count++;
}

"replace" {
    fprintf(yyout, "LIBRARY FUNCTION DETECTED: replace - LINE %d\n", line_no);
    function_count++;
}

"len" {
    fprintf(yyout, "LIBRARY FUNCTION DETECTED: len - LINE %d\n", line_no);
    function_count++;
}

"==" {
    fprintf(yyout, "EQUAL OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

"!=" {
    fprintf(yyout, "NOT EQUAL OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

"<=" {
    fprintf(yyout, "LESS OR EQUAL OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

">=" {
    fprintf(yyout, "GREATER OR EQUAL OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

"+" {
    fprintf(yyout, "ADDITION OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

"-" {
    fprintf(yyout, "SUBTRACTION OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

"*" {
    fprintf(yyout, "MULTIPLICATION OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

"/" {
    fprintf(yyout, "DIVISION OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

"%" {
    fprintf(yyout, "MODULO OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

"<" {
    fprintf(yyout, "LESS THAN OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

">" {
    fprintf(yyout, "GREATER THAN OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

"=" {
    fprintf(yyout, "ASSIGNMENT OPERATOR DETECTED - LINE %d\n", line_no);
    operator_count++;
}

[0-9]+\.[0-9]+ {
    fprintf(yyout, "FLOAT LITERAL DETECTED - LINE %d\n", line_no);
    literal_count++;
}

[0-9]+ {
    fprintf(yyout, "INTEGER LITERAL DETECTED - LINE %d\n", line_no);
    literal_count++;
}

\"[^\"\n]*\" {
    fprintf(yyout, "STRING LITERAL DETECTED - LINE %d\n", line_no);
    literal_count++;
}

[A-Za-z_\200-\377][A-Za-z0-9_\200-\377]* {
    fprintf(yyout, "IDENTIFIER DETECTED: %s - LINE %d\n", yytext, line_no);
    userdefined_count++;
}

"$" {
    fprintf(yyout, "STATEMENT TERMINATOR DETECTED - LINE %d\n", line_no);
    symbol_count++;
}

":" {
    fprintf(yyout, "BLOCK START (COLON) DETECTED - LINE %d\n", line_no);
    symbol_count++;
}

";" {
    fprintf(yyout, "BLOCK END (SEMICOLON) DETECTED - LINE %d\n", line_no);
    symbol_count++;
}

"(" {
    fprintf(yyout, "LEFT PARENTHESIS DETECTED - LINE %d\n", line_no);
    symbol_count++;
}

")" {
    fprintf(yyout, "RIGHT PARENTHESIS DETECTED - LINE %d\n", line_no);
    symbol_count++;
}

"[" {
    fprintf(yyout, "LEFT BRACKET DETECTED - LINE %d\n", line_no);
    symbol_count++;
}

"]" {
    fprintf(yyout, "RIGHT BRACKET DETECTED - LINE %d\n", line_no);
    symbol_count++;
}

"," {
    fprintf(yyout, "COMMA DETECTED - LINE %d\n", line_no);
    symbol_count++;
}

[ \t\r]+ {
}

. {
    fprintf(yyout, "UNKNOWN SYMBOL '%s' - LINE %d\n", yytext, line_no);
}

%%

int yywrap()
{
    return 1;
}

int main()
{
    yyin = fopen("input.txt", "r");
    yyout = fopen("output.txt", "w");

    if (yyin == NULL) {
        printf("Cannot open input.txt\n");
        return 1;
    }

    if (yyout == NULL) {
        printf("Cannot create output.txt\n");
        fclose(yyin);
        return 1;
    }

    yylex();

    fprintf(yyout, "\nTOKEN SUMMARY\n");
    fprintf(yyout, "Keywords              : %d\n", keyword_count);
    fprintf(yyout, "Data Types            : %d\n", datatype_count);
    fprintf(yyout, "Operators             : %d\n", operator_count);
    fprintf(yyout, "Control Statements    : %d\n", control_count);
    fprintf(yyout, "Functions             : %d\n", function_count);
    fprintf(yyout, "User Defined/IDs      : %d\n", userdefined_count);
    fprintf(yyout, "Literals              : %d\n", literal_count);
    fprintf(yyout, "Comments              : %d\n", comment_count);
    fprintf(yyout, "Symbols               : %d\n", symbol_count);

    fclose(yyin);
    fclose(yyout);

    printf("Lexical analysis completed.\n");
    printf("Results stored in output.txt\n");

    return 0;
}