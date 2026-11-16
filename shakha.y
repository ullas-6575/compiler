%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);
void print_token_summary(FILE *f);     /* defined in shakha.l */

extern int yylineno;
extern FILE *yyin, *yyout;

int syntax_errors = 0;

/* Statement counters, printed at the end */
int stmt_decl = 0, stmt_assign = 0, stmt_print = 0, stmt_ret = 0;
int stmt_if = 0, stmt_elif = 0, stmt_else = 0;
int stmt_while = 0, stmt_loop = 0, stmt_func = 0;
%}

%union {
    long   ival;
    double fval;
    char  *sval;
}

%token <sval> IDENT STRING_LIT
%token <ival> INT_LIT
%token <fval> FLOAT_LIT
%token DHORO DEF RET YADI NAHOLE_YADI NAHOLE JOTOKKHON LOOP DEKHO
%token SATYA MITHYA
%token TY_INT TY_FLT TY_STR TY_BOOL TY_ARR
%token EQ NE LE GE AND OR NOT

/* Lowest precedence first, highest last */
%left OR
%left AND
%right NOT
%nonassoc EQ NE '<' '>' LE GE
%left '+' '-'
%left '*' '/' '%'
%right UMINUS
%left '['

%define parse.error verbose

%%

program
    : stmts
    ;

stmts
    : /* empty */
    | stmts stmt
    ;

stmt
    : DHORO IDENT '=' expr '$'                              { stmt_decl++; }
    | IDENT '=' expr '$'                                    { stmt_assign++; }
    | expr '$'
    | DEKHO '(' expr ')' '$'                                { stmt_print++; }
    | RET expr '$'                                          { stmt_ret++; }
    | RET '$'                                               { stmt_ret++; }
    | YADI '(' expr ')' ':' stmts ';' elif_list else_part   { stmt_if++; }
    | JOTOKKHON '(' expr ')' ':' stmts ';'                  { stmt_while++; }
    | LOOP '(' IDENT ',' expr ',' expr ')' ':' stmts ';'    { stmt_loop++; }
    | DEF IDENT '(' params ')' ':' stmts ';'                { stmt_func++; }
    | error '$'                                             { yyerrok; }
    ;

elif_list
    : /* empty */
    | elif_list NAHOLE_YADI '(' expr ')' ':' stmts ';'      { stmt_elif++; }
    ;

else_part
    : /* empty */
    | NAHOLE ':' stmts ';'                                  { stmt_else++; }
    ;

params
    : /* empty */
    | id_list
    ;

id_list
    : IDENT
    | id_list ',' IDENT
    ;

args
    : /* empty */
    | arg_list
    ;

arg_list
    : expr
    | arg_list ',' expr
    ;

type_kw
    : TY_INT
    | TY_FLT
    | TY_STR
    | TY_BOOL
    | TY_ARR
    ;

expr
    : INT_LIT
    | FLOAT_LIT
    | STRING_LIT
    | SATYA
    | MITHYA
    | IDENT
    | IDENT '(' args ')'                    /* function or library call */
    | type_kw '(' expr ')'                  /* cast: sankhya(...), doshomik(...) */
    | '[' args ']'                          /* array literal */
    | expr '[' expr ']'                     /* indexing */
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | expr '%' expr
    | expr '<' expr
    | expr '>' expr
    | expr LE expr
    | expr GE expr
    | expr EQ expr
    | expr NE expr
    | expr AND expr
    | expr OR expr
    | NOT expr
    | '-' expr %prec UMINUS
    | '(' expr ')'
    ;

%%

void yyerror(const char *s) {
    syntax_errors++;
    fprintf(yyout, "SYNTAX ERROR - LINE %d: %s\n", yylineno, s);
}

int main(int argc, char **argv) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s input.txt\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        fprintf(stderr, "Cannot open %s\n", argv[1]);
        return 1;
    }

    yyout = fopen("output.txt", "w");
    if (!yyout) {
        fprintf(stderr, "Cannot create output.txt\n");
        fclose(yyin);
        return 1;
    }

    fprintf(yyout, "Syntax analysis of %s\n\n", argv[1]);

    yyparse();

    fprintf(yyout, "\nSTATEMENT SUMMARY\n");
    fprintf(yyout, "Variable declarations : %d\n", stmt_decl);
    fprintf(yyout, "Assignments           : %d\n", stmt_assign);
    fprintf(yyout, "Print statements      : %d\n", stmt_print);
    fprintf(yyout, "Return statements     : %d\n", stmt_ret);
    fprintf(yyout, "If statements         : %d\n", stmt_if);
    fprintf(yyout, "Else-if blocks        : %d\n", stmt_elif);
    fprintf(yyout, "Else blocks           : %d\n", stmt_else);
    fprintf(yyout, "While loops           : %d\n", stmt_while);
    fprintf(yyout, "Counted loops         : %d\n", stmt_loop);
    fprintf(yyout, "Function definitions  : %d\n", stmt_func);

    print_token_summary(yyout);

    if (syntax_errors == 0)
        fprintf(yyout, "\nPARSE RESULT: SUCCESS\n");
    else
        fprintf(yyout, "\nPARSE RESULT: FAILED with %d syntax error(s)\n", syntax_errors);

    fclose(yyin);
    fclose(yyout);

    printf("Syntax analysis completed. Results stored in output.txt\n");
    return syntax_errors ? 1 : 0;
}