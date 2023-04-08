#include <iostream>
#include <stdio.h>
#include <cstring>

extern "C" void print_result(char * str) {
    char should_be[] = "abcd# abcdef   bbbb c# aaa bbbb abcd kakkkaak";

    printf("%s\n", str);
    if (strcmp(str, should_be)) {
        std::cout << "False\n";
    } else {
        std::cout << "True\n";
    }
}