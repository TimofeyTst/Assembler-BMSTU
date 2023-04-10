#include <iostream>
#include <stdio.h>
#include <cstring>

extern "C" void print_result(char * str) {
    char should_be[] = "abcd# abcdef   bbbb c# aaa bbbb abcd kakkkaak";
    printf("Удаленные последовательности: \n");
    printf("%s\n", str);
    if (strcmp(str, should_be)) {
        printf("False\n");
    } else {
        printf("True\n");
    }
}