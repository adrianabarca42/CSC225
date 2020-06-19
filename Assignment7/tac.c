/*
 * Prints user input in reverse.
 * CSC 225, Assignment 7
 * Given code, Winter '20
 * NOTE: Do not alter this file.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "list.h"

#define MAXLENGTH 128

int main(void) {
    /* Assume no lines are longer than MAXLENGTH. */
    char buffer[MAXLENGTH];

    /* Create an empty list. */
    List *lst = lstcreate();

    /* Read one line at a time from user input. */
    while (fgets(buffer, MAXLENGTH, stdin) != NULL) {
        /* Dynamically allocate enough memory for the line. */
        char *data = (char *)malloc(sizeof(char) * (strlen(buffer) + 1));

        /* Copy the line into the dynamically allocated memory. */
        strcpy(data, buffer);

        /* Add the line to the beginning of the list. */
        lstadd(lst, 0, data);
    }

    /* Iterate over the list. */
    while (lstsize(lst) > 0) {
        /* Remove a line from the beginning of the list. */
        char *data = lstremove(lst, 0);

        /* Print out the line. */
        fputs(data, stdout);

        /* Deallocate the memory for the line. */
        free(data);
    }

    /* Destroy the list. */
    lstdestroy(lst);

    return 0;
}
