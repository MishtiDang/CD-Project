%{ #include<stdio.h>
  #include<math.h>
  #include<stdlib.h>
  int yylex(void);
  void yyerror(char *);
%}

//YYLVAL will take all values as double
%union {
    double du;
}

%token <du> SIN COS TAN POW LOG LPAR RPAR E SQRT NUMBER
%type <du> expr

//precedence
%left '+' '-'
%left '*' '/'
%%

//grammar
// log(expr1)(expr2) -> log(base)(a)
program : LOG LPAR expr RPAR LPAR expr RPAR {
              if($3==1)
              {
                printf("Log cannot be calculated for base = 1\n");

              }
              printf("\n    (     %f    )    (    %f    )\n",$3,$6);
                double val=log($6)/log($3);

                printf("\nlog (      expr       )    (       expr       )\n\n");
                printf("\nlog (     %f    )    (    %f    ) = %f \n\n",$3,$6,log($6)/log($3));

                printf("%f",val);
                return 0;
              } |

//(expr1)^(expr2)
 LPAR expr RPAR POW LPAR expr RPAR {
      printf("\n    (     %f    ) ^ (    %f    )\n",$2,$6);

      printf("\n    (      expr       ) ^ (       expr       )\n\n");
      double val=pow($2,$6);
      printf("\n    (     %f    )  ^  (    %f    ) = %f \n\n",$2,$6,val);
      return 0; } |

//sin(expr)
 SIN LPAR expr RPAR { printf("\nsin (    %f    )",$3);
                      printf("\nsin (       expr       )");
                      printf("\nsin(%f) = %f",$3,sin(($3*3.14)/180));
                      return 0; } |

 //cos(expr)
 COS LPAR expr RPAR { printf("\ncos (    %f    )",$3);
                      printf("\ncos (       expr       )");
                      printf("\ncos(%f) = %f",$3,cos(($3*3.14)/180));
                      return 0; } |

 //tan(expr)
 TAN LPAR expr RPAR { printf("\ntan (    %f    )",$3);
                      printf("\ntan (       expr       )");
                      printf("\ntan(%f) = %f",$3,tan(($3*3.14)/180));
                      return 0; } |
 //e^(expr)
 E POW LPAR expr RPAR {
                        printf("\n e^(    %f    )",$4);
                        printf("\n e^(       expr       )");
                        /* printf("\ne^(%f) = %f",$3,pow(exp,$4)); */
                        return 0;
                      } |
//sqrt(expr)
 SQRT LPAR expr RPAR {
                       double val;
                       printf("\n sqrt(    %f    )",$3);
                       printf("\n sqrt(       expr     )");
                       val=pow($3,0.5);
                       printf("\nsqrt(%f) = %f",$3,val);
                       return 0;
                    } |

//expr
  expr  { printf("%f",$1); return 0; } //calculates normal expressions
;

expr:
NUMBER {$$ = $1; } |
E {$$ = M_E; } |
expr '+' expr {printf("     %f+%f ",$1,$3); $$ = $1 + $3;}; |
expr '-' expr {printf("     %f-%f ",$1,$3); $$ = $1 - $3;} |
expr '/' expr {printf("     %f/%f ",$1,$3); $$ = $1 / $3;} |
expr '*' expr {printf("     %f*%f ",$1,$3); $$ = $1 * $3;}
;

%%
void yyerror(char *s) {
  fprintf(stderr,"%s\n",s);
}

int main() {
  yyparse();
  return 0;
}
