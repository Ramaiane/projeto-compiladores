#include <stdlib.h>
#include <stdio.h>
#include "list.h"

List *
create_list()
{
	return (List *) calloc(1, sizeof(List));
}

int
free_list(List *list)
{
	Node *temp = NULL, *node = NULL;

	if (!list)
		return -1;

	temp = list->head;

	while (temp) {
		node = temp;
		temp = temp->next;
		free_node(node);
	}

	free(list);

	return 0;
}

int
initialize_list(List *list)
{
	if (!list)
		return -1;

	list->head = NULL;
	list->tail = NULL;

	return 0;
}

int
print_list(List *list)
{
	Node *temp = NULL;

	if (!list)
		return -1;


	printf("\t\t==== TABELA DE SÍMBOLOS ====\n\n");

	for (temp = list->head; temp; temp = temp->next)
	{
		print_node(temp);
	}

	printf("\n");

	return 0;

}

int
print_list_file(List *list)
{
	FILE * arq;
	arq = fopen("Tabela de Simbolos.txt", "wt");

	if (arq == NULL)
	{
		printf("Problemas na CRIACAO do arquivo\n");
		return -1;
	} 

	Node *temp = NULL;

	if (!list)
		return -1;


	fprintf(arq, "\t\t\t==== TABELA DE SÍMBOLOS ====\n\n");

	for (temp = list->head; temp; temp = temp->next)
	{
		print_node_file(temp, arq);
	}

	fprintf(arq, "\n");
	fclose(arq);
	return 0;

}

Node *
search(List *list, Node *node)
{
	if (!list)
		return (Node *) -1;

	Node *temp = create_node();

	for (temp = list->head; temp; temp = temp->next)
	{
		if(node->name == temp->name)
			return temp;
	}

	return NULL;

}

int
push_back(List *list, Node *node)
{
	if (!list)
		return -1;

	if (!list->head)
	{
		list->head = node;
		list->tail = node;
		list->tail->next = NULL;
	}
	

	Node * temp = create_node();
	temp = search(list, node);
	if (!temp)
	{
		list->tail->next = node;
		list->tail = node;
		node->next = NULL;
	} else
		{
			temp->name = node->name;
			temp->type = node->type;
			temp->size = node->size;
		}

	return 0;

}

int
pop_back(List *list)
{
	Node *temp = NULL;

	if (!list)
		return -1;

	temp = list->tail;

	if (!temp)
		return -1;

	list->tail = temp->prev;

	if (temp == list->head)
	{
		list->head = NULL;
	} else 
	{ 
		list->tail->next = NULL;
	}

	free_node(temp);
		
	return 0;
}





