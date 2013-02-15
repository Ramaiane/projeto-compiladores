#include <stdlib.h>
#include <stdio.h>
#include "node.h"

Node *
create_node()
{
	return (Node *) calloc(1, sizeof(Node));
}

int
free_node(Node *node)
{
	if (!node)
		return -1;

	free(node);
	
	return 0;
}

int
print_node(Node *node)
{
	if (!node)
		return -1;

	printf("NOME: [%s]\t\tTIPO: [%d]\t\tTAMANHO: [%d]\n", node->name, node->type, node->size);

	return 0;
}

int
print_node_file(Node *node, FILE* arq)
{
	if (!node)
		return -1;
	int result = 0;
	result = fprintf(arq, "NOME: [%s]\t\t\tTIPO: [%d]\t\t\tTAMANHO: [%d bytes]\n", node->name, node->type, node->size);

	return 0;
}

