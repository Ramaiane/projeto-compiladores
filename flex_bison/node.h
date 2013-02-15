#ifndef NODE_H
#define NODE_H

typedef struct node {
	char * name;
	int type;
	int size;
	
	struct node * next;
	struct node * prev;
	} Node;

extern Node *
create_node();

extern int
free_node(Node *node);

extern int
print_node(Node *node);

extern int
print_node_file(Node *node);

#endif
