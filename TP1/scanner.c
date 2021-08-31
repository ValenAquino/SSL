#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "scanner.h"

struct scan get_token(){
    struct scan lexema;
    short i = 0;
    char caracter;

    for(int i = 0; i<100; i++)
        lexema.cadena[i] = '\0';

    caracter = getchar();

    while(isspace(caracter)) // así elimino todos los espacios de golpe
        caracter = getchar();

    if(feof(stdin)){
        lexema.token = FDT;
        return lexema;
    }

    if(caracter == ','){
        lexema.cadena[0] = caracter;
        lexema.token = SEP;
        return lexema;
    }

    while (caracter != ',' && caracter != ' ' && !feof(stdin)){ // unifico la cad 
        lexema.cadena[i] = caracter;
        i++;
        caracter = getchar();
        if(caracter == '\n') {
            lexema.token = CAD;
            return lexema;
            }
    }
    ungetc(caracter, stdin);
    lexema.token = CAD;
    return lexema;
}