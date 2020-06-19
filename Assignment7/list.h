/*
 * Defines structures and prototypes for a linked list.
 * CSC 225, Assignment 7
 * Given code, Winter '20
 * NOTE: Do not alter this file.
 */

/* Node: Represents a single element in a linked list. */
typedef struct Node {
    void *data;
    struct Node *next;
} Node;

/* List: Represents a linked list. */
typedef struct List {
    Node *head;
    int size;
} List;

List *lstcreate();
void lstdestroy(List *);
int lstsize(List *);
void *lstget(List *, int);
int lstset(List *, int, void *);
int lstadd(List *, int, void *);
void *lstremove(List *, int);
List *lstreverse(List *);
