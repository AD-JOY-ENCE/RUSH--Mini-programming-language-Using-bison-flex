%{
#include "code.tab.h"
#include <stdlib.h>
#include <string.h>
%}

%%

\"[^\"]*\"              { yylval.str = strdup(yytext + 1); yylval.str[strlen(yylval.str)-1] = '\0'; return STRING; }

"string"                { return STRING_TYPE; }
"int"                   { return INT_TYPE; }
"float"                 { return FLOAT_TYPE; }
"char"                  { return CHAR_TYPE; }
"print"                 { return PRINT; }
"if"                    { return IF; }
"else"                  { return ELSE; }
"cal"                   { return CAL; }
"exit"                  { return EXIT_CMD; }

[0-9]+\.[0-9]+          { yylval.fVal = atof(yytext); return FLOAT; }
[0-9]+                  { yylval.iVal = atoi(yytext); return INT; }
\'[a-zA-Z0-9]\'         { yylval.cVal = yytext[1]; return CHAR; }

[a-zA-Z_][a-zA-Z0-9_]*  { yylval.str = strdup(yytext); return ID; }

">="                    { return GE; }
"<="                    { return LE; }
"=="                    { return EQ; }
"!="                    { return NEQ; }
">"                     { return '>'; }
"<"                     { return '<'; }
"="                     { return '='; }
";"                     { return ';'; }
"("                     { return '('; }
")"                     { return ')'; }
"+"                     { return '+'; }
"-"                     { return '-'; }
"*"                     { return '*'; }
"/"                     { return '/'; }

[ \t\n]+                ;   // ignore whitespace
.                       { printf("Unknown char: %s\n", yytext); }

%%

int yywrap() { return 1; }
