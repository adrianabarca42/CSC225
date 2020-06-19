/*
 * Defines functions for a linked list.
 * CSC 225, Assignment 7
 * Given code, Winter '20
 */

#include <stdio.h>
#include <stdlib.h>
#include "list.h"

/* lstcreate: Creates an empty linked list. */
List *lstcreate() {
    /* TODO: Complete this function.
     *       Given: n/a
     *       Returns: A pointer to a dynamically allocated List structure */
    List *lst = (List *)malloc(sizeof(List));
    lst->head = NULL;
    lst->size = 0;
    return lst;
}

/* lstdestroy: Destroys an existing linked list. */
void lstdestroy(List *lst) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure
     *       Returns: n/a */
    Node *current = lst->head;
    Node *next;
    while (current != NULL) {
        next = current->next;
        free(current);
        current = next;
        }
    lst->head = NULL;
    free(lst);
}

/* lstsize: Computes the size of a linked list. */
int lstsize(List *lst) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure
     *       Returns: The size of that list */
    return lst->size;
}

/* lstget: Gets the element in a linked list at an index. */
void *lstget(List *lst, int idx) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure, an index
     *       Returns: A pointer to that element, NULL if none exists */
    int count = 0;
    void *ptr;
    Node *current = lst->head;
    if (idx < 0 || idx > lst->size - 1) {
        return NULL;
        }
    while (count < idx) {
        current = current->next;
        count += 1;
        }
    ptr = current->data;
    return ptr;
}

/* lstset: Sets the element in a linked list at an index. */
int lstset(List *lst, int idx, void *data) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure, an index, a pointer to data
     *       Returns: 0 on success, 1 if index not in bounds [0, size - 1] */
    int count = 0;
    Node *current = lst->head;
    if (idx < 0 || idx > lst->size - 1) {
        return 1;
        }
    while (count < idx) {
        current = current->next;
        count += 1;
        }
    current->data = data;
    return 0;
}

/* lstadd: Adds an element to a linked list at an index. */
int lstadd(List *lst, int idx, void *data) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure, an index, a pointer to data
     *       Returns: 0 on success, 1 if index not in bounds [0, size] */
    int count = 0;
    Node *NewNode = (Node *)malloc(sizeof(Node));
    if (data == NULL) {
        return 1;
        }
    if (lst->size == 0) {
        lst->head = NewNode;
        NewNode->data = data;
        NewNode->next = NULL;
        lst->size += 1;
        return 0;
        }
    if (idx >= 0 && idx <= lst->size) {
        Node *current = lst->head;
        Node *temp = NULL;
        NewNode->data = data;
        NewNode->next = NULL;
        while (count < idx-1) {
            current = current->next;
            count += 1;
            }
        if (current->next == NULL && idx != 0) {
            current->next = NewNode;
            lst->size += 1;
            return 0;
            }
        if (idx == 0) {
            temp = current;
            lst->head = NewNode;
            NewNode->next = temp;
            lst->size += 1;
            return 0;
            }
        temp = current->next;
        current->next = NewNode;
        NewNode->next = temp;
        lst->size += 1;
        return 0;
        }
    return 1;
}

/* lstremove: Removes an element from a linked list at an index. */
void *lstremove(List *lst, int idx) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure, an index
     *       Returns: A pointer to the removed element, NULL if none exists */
    int count = 0;
    void *ptr;
    Node *removed;
    Node *current = lst->head;
    if (idx < 0 || idx > lst->size - 1) {
        return NULL;
        }
    if (idx == 0) {
        removed = current;
        ptr = current->data;
        free(removed);
        lst->head = current->next;
        lst->size -= 1;
        return ptr;
        }
    while (count < idx - 1) {
        current = current->next;
        count += 1;
        }
    removed = current->next;
    ptr = current->next->data;
    current->next = current->next->next;
    free(removed);
    lst->size -= 1;
    return ptr;
}

 /*lstreverse: Creates a new linked list in reverse order. */ 
List *lstreverse(List *lst) {
    /* TODO: Complete this function.
     *       Given: A pointer to a List structure
     *       Returns: A pointer to a newly allocated List containing the
     *                same elements in reversed order */
    List *newlist = lstcreate(); 
    Node *current = lst->head;
    while (current != NULL) {
        lstadd(newlist, 0, current->data);
        current = current->next;
        }
    return newlist;
}

