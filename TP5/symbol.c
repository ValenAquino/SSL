#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#define MAX 120

char* tab_simbolos[MAX];
int primer_celda_libre = 0;

void agregar(char* cad) {
	if(primer_celda_libre < MAX) {
		tab_simbolos[primer_celda_libre] = cad; primer_celda_libre++;
	}
	else
		printf("La tabla de símbolos está llena");
}

int existe(char* cad) {
	for(int i = 0; i < primer_celda_libre; i++) {
		if (!strcmp(tab_simbolos[i], cad))
			return 1;	
	}
		
	return 0;
}
