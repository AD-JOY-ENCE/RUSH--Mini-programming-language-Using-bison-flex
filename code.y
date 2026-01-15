%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
%}

%union {
    int iVal;
    float fVal;
    char cVal;
    char* str;
}

%token <iVal> INT
%token <fVal> FLOAT
%token <cVal> CHAR
%token <str> ID
%token <str> STRING
%token '>' '<' GE LE EQ NEQ INT_TYPE FLOAT_TYPE CHAR_TYPE PRINT IF ELSE STRING_TYPE CAL EXIT_CMD

%left '+' '-'
%left '*' '/'
%left '>' '<' GE LE EQ NEQ

%type <fVal> expr
%type <iVal> condition

%%

program:
    program statement
  | statement
  ;

statement:
    declaration ';'
  | print_stmt ';'
  | if_stmt ';'
  | EXIT_CMD ';'  { printf("Exiting the program...\n"); exit(0); }
  ;

declaration:
    INT_TYPE ID '=' expr { printf("%s = %d\n", $2, (int)$4); free($2); }
  | FLOAT_TYPE ID '=' expr { printf("%s = %.2f\n", $2, $4); free($2); }
  | CHAR_TYPE ID '=' CHAR { printf("%s = '%c'\n", $2, $4); free($2); }
  | STRING_TYPE ID '=' STRING { printf("%s = %s\n", $2, $4); free($2); free($4); }
  ;

print_stmt:
    CAL expr               { printf("Result: %.2f\n", $2); }
  | PRINT STRING             { printf("%s\n", $2); free($2); }
  ;

if_stmt:
    IF '(' condition ')' PRINT INT ELSE PRINT INT
        {
            if ($3) {
                printf("Result: %d\n", $6);
            } else {
                printf("Result: %d\n", $9);
            }
        }
    ;

condition:
    INT '>' INT { $$ = ($1 > $3); }
    | INT '<' INT { $$ = ($1 < $3); }
    | INT GE INT { $$ = ($1 >= $3); }
    | INT LE INT { $$ = ($1 <= $3); }
    | INT EQ INT { $$ = ($1 == $3); }
    | INT NEQ INT { $$ = ($1 != $3); }
    ;
expr:
    expr '+' expr                { $$ = $1 + $3; }
  | expr '-' expr                { $$ = $1 - $3; }
  | expr '*' expr                { $$ = $1 * $3; }
  | expr '/' expr                { $$ = $1 / $3; }
  | expr '>' expr                { $$ = $1 > $3; }
  | expr '<' expr                { $$ = $1 < $3; }
  | expr GE expr                 { $$ = $1 >= $3; }
  | expr LE expr                 { $$ = $1 <= $3; }
  | expr EQ expr                 { $$ = $1 == $3; }
  | expr NEQ expr                { $$ = $1 != $3; }
  | INT                          { $$ = (float)$1; }
  | FLOAT                        { $$ = $1; }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "\nError: %s\n", s);
}

int main() {
    printf("Welcome to Our Mini Programming Language!\n");
    printf("Instructions:\n");
    printf("1. Declare variables: int x = 5; float y = 2.5; char c = 'A';\n");
    printf("2. Calculate: cal x + y; cal x - y; cal x * y; cal x / y;\n");
    printf("3. Print string: print \"Hello\";\n");
    printf("4. If-else: if (5>2) print 10 else print 20;\n");
    printf("5. Type 'exit;' to terminate the program.\n");
    printf("Remember to end each statement with a semicolon (;)\n\n");
    printf("Enter your code:\n");

    while (1) {
        if (yyparse() != 0) {
            printf(" There was an error in your code. Try again! \n\n"); 
        }
    }

    return 0;
}
