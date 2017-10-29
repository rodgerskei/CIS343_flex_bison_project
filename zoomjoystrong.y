%{
/*
 * Yacc file for Zoomjoystrong graphics program.
 * Date: 10/27/17
 * Author: Keith Rodgers
 */
#include<stdio.h>
#include<stdlib.h>
int yylex();
int yyerror(char * s);
%}
%union {
  int ival;
  float fval;
  char* sval;
}
%token END
%token END_STATEMENT
%token POINT
%type<ival> POINT
%token LINE
%type<ival> LINE
%token CIRCLE
%token RECTANGLE
%type<ival> RECTANGLE
%token SET_COLOR
%type<ival> SET_COLOR
%token <ival> INT
%token FLOAT
%type<fval> FLOAT
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
          ;
point: POINT INT INT END_STATEMENT
;
line: LINE INT INT INT INT END_STATEMENT
;
circle: CIRCLE INT INT INT END_STATEMENT
;
rectangle: RECTANGLE INT INT INT INT END_STATEMENT
;
set_color: SET_COLOR INT INT INT END_STATEMENT {
    if(($2 > 255) || ($3 > 255) || ($4 > 255)) {
       printf("INvalid: Exceeded color limit");
    }
}
;
%%
int main(int argc, char** argv[]){
  yyparse();
  return 0;
}
int yyerror(char * s){
  return fprintf(stderr, "YACC: %s\n", s);
}