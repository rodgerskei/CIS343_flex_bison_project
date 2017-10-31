%{
/*
 * Lex file for Zoomjoystrong graphics program.
 * Date: 10/27/17
 * Author: Keith Rodgers
 */

	#include <stdio.h>
	#include <stdlib.h>
	#include "zoomjoystrong.tab.h"
	int fileno(FILE *stream);
%}

%option noyywrap

%%
;			{ return END_STATEMENT; }
end 			{ return END; }
point			{ return POINT; }
line			{ return LINE; }
circle			{ return CIRCLE; }
rectangle		{ return RECTANGLE; }
set_color		{ return SET_COLOR; }
[0-9]+			{ yylval.ival=atoi(yytext); return INT;  }
[0-9]\.[0-9]+		{ yylval.fval=atof(yytext); return FLOAT;  }
[ \t]			;
\n			;
%%
