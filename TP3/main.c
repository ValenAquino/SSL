#include "scanner.h"

int main(){
	int TOKEN;
	char *tok_name[] = {"Fin de archivo","Programa","Entero","Leer","Escribir","Fin del Programa","Asignacion","Identificador","Constante"};
	
	do{
		TOKEN = yylex();
		if(TOKEN <= ASIGNACION)
			printf("Token: %s\n",tok_name[TOKEN]); // Muestro el TOKEN 

		else {
			if(TOKEN == IDENTIFICADOR || TOKEN == CONSTANTE)
				printf("Token: %s\tlexema: %s\n",tok_name[TOKEN],yytext); // Muestro token y lexema
			else
				printf("Token: \'%c\'\n",TOKEN); // Si es solo un caracter el TOKEN, muestro ese caracter
		}
	} while(TOKEN != FDT);
        
	return 0;		
}
