%code top{
	#include <stdio.h>
	#include "scanner.h"
	
	#include "symbol.h" // added
	#include "semantic.h" // added
}
 
%code provides {
	void yyerror(const char *);
	extern int errlex;
	extern int yynerrs;
	
	extern int errsemtc; // added
}

%define api.value.type{char *}

%defines "parser.h"					
%output "parser.c"

%start programa
%define parse.error verbose

%token FDT PROGRAMA ENTERO LEER ESCRIBIR FIN_PROG IDENTIFICADOR CONSTANTE
%token ASIGNACION "<<"

%left  '-'  '+'
%left  '*'  '/'
%precedence NEG

%%

programa : encabezado lista_sentencia FIN_PROG {fin();} {if (yynerrs || errlex) YYABORT; else YYACCEPT;}
         ;

encabezado : PROGRAMA IDENTIFICADOR {inicio($2);}
           ;

lista_sentencia : sentencia
                | sentencia lista_sentencia
                ;
      
sentencia : LEER '('lista_identificador')'';'
          | ESCRIBIR '('lista_expresion')'';'
          | ENTERO IDENTIFICADOR';' {if(entero($2)) YYERROR;}
          | IDENTIFICADOR ASIGNACION expresion';' {asignar($1, $3);}
          | error ';'
          ;
          
lista_identificador : IDENTIFICADOR {leer($1);}
                    | lista_identificador',' IDENTIFICADOR {leer($3);}
                    ;

lista_expresion : expresion {escribir($1);}
                | lista_expresion',' expresion {escribir($3);}
                ;

expresion : termino 
  	  | expresion '+' termino {$$ = gen_inf($1, '+', $3);}
  	  | expresion '-' termino {$$ = gen_inf($1, '-', $3);}
  	  ;

termino : operando
        | termino '*' operando {$$ = gen_inf($1, '*', $3);}
        | termino '/' operando {$$ = gen_inf($1, '/', $3);}
        | termino '%' operando {$$ = gen_inf($1, '%', $3);}
        ;
        
operando : literal
         | '-'literal %prec NEG {$$ = inv($2);}
         ;
         
literal : IDENTIFICADOR {id_no_declarado($1);}
        | CONSTANTE 
        | '(' expresion ')' {$$ = $2;}
        ;
%%

int errlex = 0;

void yyerror(const char *s){
		printf("línea #%d  %s\n", yylineno, s);
}
