%{
/*
 * Yacc file for Zoomjoystrong graphics program.
 * Date: 10/27/17
 * Author: Keith Rodgers
 */

#include<stdio.h>
#include<stdlib.h>
#include "zoomjoystrong.h"
int yylex();
int yyerror(char *s);
extern char* yytext;
%}

%union {
  int ival;
  float fval;
}

%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR
%token <ival>INT
%token FLOAT

%%
program: statement_list END END_STATEMENT
;
statement_list: statement statement_list
              | statement
              ;
statement : point
          | line
          | circle
          | rectangle
          | set_color
          | end
          ;
point: POINT INT INT END_STATEMENT{
  if(($2 > WIDTH) || ($3 > HEIGHT)){
  yyerror("Invalid points.\n");
  }
  else {
    point($2, $3);
  }
}
;
line: LINE INT INT INT INT END_STATEMENT{
  if(($2 > WIDTH) || ($3 > HEIGHT) || ($4 > WIDTH) || ($5 > HEIGHT)){
  printf("Invalid point");
  }
  else {
    line($2, $3, $4, $5);
  }
}
;
circle: CIRCLE INT INT INT END_STATEMENT{
  if(($2 > WIDTH) || ($3 > HEIGHT)){
  printf("Invalid point");
  }
  else {
    circle($2, $3, $4);
  }
}
;
rectangle: RECTANGLE INT INT INT INT END_STATEMENT{
  if(($2 > WIDTH) || ($3 > HEIGHT) || ($4 > WIDTH) || ($5 > HEIGHT)){
  printf("Invalid point");
  }
  else {
    rectangle($2, $3, $4, $5);
  }
}
;
set_color: SET_COLOR INT INT INT END_STATEMENT {
  if(($2 > 255) || ($3 > 255) || ($4 > 255)) {
    printf("Invalid: Exceeded color limit");
  }
  else {
    set_color($2, $3, $4);
  }
}
;
end: END END_STATEMENT{
finish();
exit(0);
}
;
%%

int main(int argc, char** argv){
  setup();
  yyparse();
  return 0;
}

int yyerror(char *s){
  printf("TOKEN: %s\n", yytext);
  fprintf(stderr, "YACC: %s\n", s);
  return 0;
}
