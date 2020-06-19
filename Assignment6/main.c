/*
 * Recursively computes Fibonacci numbers.
 * CSC 225, Assignment 6
 * Given code, Winter '20
 * TODO: Complete this file.
 */
#include <stdio.h>
#include "fib.h"

int main(void) {
    int c;
    printf("Enter an integer: ");
    scanf("%d", &c);
    printf("f(%d) = %d\n", c, fib(c));
    return 0;

}
