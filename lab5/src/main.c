#include <iostream>
#include <stdio.h>
#include <cstring>

char* remove_duplicates_(char* str) {
    size_t len = strlen(str);
    char* result = (char*) malloc(len + 1);
    size_t i = 0;
    size_t j = 0;

    while(i < len) {
        if (str[i] != str[i+1]) {
            result[j++] = str[i];
        } else {
            char current[256] = {str[i]};
            size_t k = 0;

            while(str[i] == str[i+1]){
                current[++k] = str[i+1];
                ++i;
            }

            if (str[i+1] != '#'){
                j += k;
                strcat(result, current);
                result[++j] = str[i+1];
            } else {
                ++i;
            }
        }
        ++i;
    }

    return result;
}

extern "C" char * remove_duplicates(size_t size, char * str);

int main() {
    char str[] = "abcd# abcdef aaa# bbbb# bbbb c# aaa bbbb abcdaaa#   # kakkkakkkk#ak";
    // char should_be[] = "abcd# abcdef   bbbb c# aaa bbbb abcd kakkkaak";
    remove_duplicates(strlen(str), str);

    // printf("%s\n", result);
    // if (strcmp(result, should_be)) {
    //     std::cout << "False\n";
    // } else {
    //     std::cout << "True\n";
    // }

    // free(result);

    return 0;
}