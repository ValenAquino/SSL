%code top{
	#include <stdio.h>
	#include "scanner.h"
}

%code provides {
	void yyerror(const char *);
	extern int errlex;
	extern int yynerrs;
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

programa : encabezado lista_sentencia FIN_PROG {if (yynerrs || errlex) YYABORT; else YYACCEPT;}
         ;

encabezado : PROGRAMA IDENTIFICADOR {printf("Programa: %s\n", $IDENTIFICADOR);}
           ;

lista_sentencia : sentencia
                | sentencia lista_sentencia
                ;
      
sentencia : LEER '('lista_identificador')'';' {printf("Leer\n");}   
          | ESCRIBIR '('lista_expresion')'';' {printf("Escribir\n");} 
          | ENTERO IDENTIFICADOR';' {printf("Entero %s\n", $IDENTIFICADOR);}
          | IDENTIFICADOR ASIGNACION expresion';' {printf("Asignacion \n");}
          | error ';'
          ;
          
lista_identificador : IDENTIFICADOR
                    | lista_identificador',' IDENTIFICADOR 
                    ;

lista_expresion : expresion
                | lista_expresion',' expresion 
                ;

expresion : termino 
  	  | expresion '+' termino {printf("Suma\n");}
  	  | expresion '-' termino {printf("Resta\n");}
  	  ;

termino : operando
        | termino '*' operando {printf("Multiplicacion\n");}
        | termino '/' operando {printf("División\n");}
        | termino '%' operando {printf("Modulo\n");}
        ;
        
operando : literal
         | '-' literal %prec NEG {printf("Inversión\n");}
         ;
         
literal : IDENTIFICADOR 
        | CONSTANTE 
        | '(' expresion ')' {printf("ParEntesis\n");} ;
%%

int errlex = 0;

void yyerror(const char *s){
		printf("línea #%d  %s\n", yylineno, s);
}
