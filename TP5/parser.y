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
%precedence INV

%%

programa : encabezado lista_sentencia FIN_PROG {fin();} {if (yynerrs || errlex || errsemtc) YYABORT; else YYACCEPT;}
         ;

encabezado : PROGRAMA IDENTIFICADOR {inicio($2);}
           ;

lista_sentencia : sentencia
                | sentencia lista_sentencia
                ;
      
sentencia : LEER '('lista_identificador')'';'
          | ESCRIBIR '('lista_expresion')'';'
          | ENTERO IDENTIFICADOR';' {if(entero($2)) YYERROR;}
          | identificador "<<" expresion';' {asignar($1, $3);}
          | error ';'
          ;
          
lista_identificador : identificador {leer($1);}
                    | lista_identificador',' identificador {leer($3);}
                    ;

lista_expresion : expresion {escribir($1);}
                | lista_expresion',' expresion {escribir($3);}
                ;

expresion : termino 
  	  | expresion '+' termino {$$ = gen_inf($1, "ADD", $3);}
  	  | expresion '-' termino {$$ = gen_inf($1, "SUB", $3);}
  	  ;

termino : operando
        | termino '*' operando {$$ = gen_inf($1, "MUL", $3);}
        | termino '/' operando {$$ = gen_inf($1, "DIV", $3);}
        | termino '%' operando {$$ = gen_inf($1, "MOD", $3);}
        ;
        
operando : literal
         | '-'literal %prec INV {$$ = inv($2);}
         ;
         
literal : identificador 
        | CONSTANTE 
        | '(' expresion ')' {$$ = $2;}
        ;

identificador: IDENTIFICADOR {if(id_no_declarado($1)) YYERROR;}
             ;

%%

int errlex = 0;

void yyerror(const char *s){
		printf("línea #%d  %s\n", yylineno, s);
}
