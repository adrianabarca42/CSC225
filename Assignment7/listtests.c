/*
 * Tests functions for linked lists.
 * CSC 225, Assignment 7
 * Given tests, Winter '20
 */

#include <stddef.h>
#include <assert.h>
#include "list.h"

/* test01empty: Tests empty lists. */
void test01empty() {
    List *lst = lstcreate();

    assert(lst != NULL);
    assert(lst->head == NULL);
    assert(lst->size == 0);

    lstdestroy(lst);
}

/* test02add: Tests adding to lists. */
void test02add() {
    List *lst = lstcreate();
    int data1 = 1, data2 = 2;

    lstadd(lst, 0, &data1);
    lstadd(lst, 1, &data2);

    assert(lst->head != NULL);
    assert(lst->head->data == &data1);
    assert(lst->head->next->data == &data2);
    assert(lst->head->next->next == NULL);
    assert(lst->size == 2);

    lstdestroy(lst);
}

/* test03remove: Tests removing from lists. */
void test03remove() {
    List *lst = lstcreate();
    int data1 = 1, data2 = 2;

    lstadd(lst, 0, &data1);
    lstadd(lst, 1, &data2);
    lstremove(lst, 0);

    assert(lst->head != NULL);
    assert(lst->head->data == &data2);
    assert(lst->head->next == NULL);
    assert(lst->size == 1);

    lstdestroy(lst);
}

int main(void) {
    test01empty();
    test02add();
    test03remove();

    return 0;
}
