%{  #include<stdio.h>
    #include "y.tab.h"
    #include<stdlib.h>
    void yyerror(char *);
%}
%%

sin return SIN;
cos return COS;
tan return TAN;
"^" return POW;
log  return LOG;
"("  return LPAR;
")"   return RPAR;
"e" return E;
"sqrt" return SQRT;
[0-9]+\.*[0-9]* { yylval.du = atof(yytext); return NUMBER; }
[-/+*\n] return *yytext;
. yyerror("Incorrect symbol!");

%%
int yywrap(void)
{
  return 0;
}
