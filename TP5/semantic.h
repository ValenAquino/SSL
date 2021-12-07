#ifndef SEMANTIC_H_INCLUDED
#define SEMANTIC_H_INCLUDED

void inicio(char *);

void fin(void);

int entero(char*);

void asignar(char*, char*);

void leer(char*);

void escribir(char*);

char* new_temp(void);

char* gen_inf(char*,char,char*);

char* inv(char*);

int id_no_declarado(char*);

#endif // SEMANTIC_H_INCLUDED
