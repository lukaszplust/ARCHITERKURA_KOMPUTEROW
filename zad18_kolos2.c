#include <stdio.h>

wchar_t* ASCII_na_UTF16(char znaki[], int n);

int main()
{
    char* znaki = "abcdefghij";
    wchar_t wskaznik = ASCII_na_UTF16(znaki, 10);

    return 0;
}
