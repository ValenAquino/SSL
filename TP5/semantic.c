#include <stdio.h>
#include <string.h>
#include "parser.h"
#include "semantic.h"
#include "symbol.h"

char buffer[100];
char temp[30];
int errsemtc = 0;
int temp_num = 1;
const int bytes = 4;

void inicio(char *nom_prog) {
	printf("Load rtlib, %s\n", nom_prog);
}

void fin(void) {
	printf("Exit,\n");
}

int entero(char *id) {
	if(!existe(id)) {
		agregar(id);
		printf("Reserve %s,%d\n", id,bytes);	
		return 0;		
	}
	else {
		sprintf(buffer,"Error semántico: identificador %s ya declarado", id);
		errsemtc++; 
		yyerror(buffer);
		return 1;
	}
}

void asignar(char* id, char* expr) {
	printf("Store %s,%s \n", expr, id);
}

void leer(char* id) {
	printf("Read %s,Integer\n", id);
}

void escribir(char* id) {
	printf("Write %s,Integer\n", id);
}

char* new_temp(void) {
	sprintf(temp,"Temp@%d",temp_num);
  	temp_num++;
  	return strdup(temp);
}

char* gen_inf(char* A, char *OP, char* B) {
	char* temp = new_temp(); 
	entero(temp);	
	printf("%s %s,%s,%s\n", OP, A, B, temp);

	return temp;
}

char* inv(char* literal){
  	char* temp = new_temp(); 
  	entero(temp);
	printf("INV %s,%s,%s\n", literal, "", temp);
	return temp;
}

int id_no_declarado(char* id){
	if(!existe(id)){
		sprintf(buffer,"Error semántico: identificador %s no declarado", id);
		errsemtc++; 
		yyerror(buffer);
		return 1;
	}
	else
		return 0;
}
