#ifndef LIST_H
#define LIST_H

#include "node.h"

typedef struct list
{
	Node * head;
	Node * tail;
} List;

extern List *
create_list();

extern int
free_list(List *list);

extern int
initialize_list(List *list);

extern int
print_list(List *list);

extern int
print_list_file(List *list);

extern Node *
search(List *list, Node *node);

extern int
push_back(List *list, Node *node);

extern int
pop_back(List *list);


#endif
