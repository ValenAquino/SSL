#include <stdio.h>
#include "scanner.h"

int main(){
    freopen("entrada.txt", "r", stdin);
    struct scan lexema;

    while(!feof(stdin)){
    lexema = get_token();
    switch (lexema.token){ 
        case CAD:
            printf("Cadena: %s \n", lexema.cadena);
            break;
        case SEP:
            printf("Separador: %c \n", lexema.cadena[0]);
            break;
        case FDT:   
            printf("Fin De Texto: \n");
            break;
        default:
            break;
        }
    }
    return 0;
}