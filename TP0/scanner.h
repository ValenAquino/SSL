#ifndef SCANNER_H_INCLUDED
#define SCANNER_H_INCLUDED

enum TOKEN{
    FDT,
    SEP,
    CAD
};

struct scan{
    char cadena[100];
    int token;
};

struct scan get_token();

#endif // SCANNER_H_INCLUDED