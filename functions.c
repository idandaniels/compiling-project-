#include <stdio.h>
#include <stdlib.h>
#include "structs.h"
#include "functions.h"

extern int yylex();

Data* first;
Data* current;
int i=-1;

void init()
{
	int j;
	first = malloc(sizeof(Data));
	current = first;
	for (j =0 ; j<10; j++)
	{
		current->tokens[j].lexeme = NULL;
	}
	current->next = NULL;
}

void back_token(){
	if(i == 0){
		if(current->prev == NULL) {
			printf("You are already at the first element in the linked list");
						}
		else {
		printf("***\n***\n***\nGoing to prev item in list %d\n***\n***\n",i);
			current = current->prev;
			i = 9;
			printf("Now im %d",i);
			}
		}
	else {
		
		i--;
	}
		
}

void next_token(){
	next_in_dataStructure();
	if(current->tokens[i].lexeme != NULL)
	{
		printf("FROM NEXT TOKEN FUNC the token is: %s\n",current->tokens[i].lexeme );
	}
	else 
	{
		if (yylex() == -1)
		{
			create_and_store_token("EOF",-1,yylineno);
		}
	}
	
}

void create_and_store_token(char* lex, int typeOfToken, int yylineno){
	int j =0;
	char* newlexeme;
	printf("from create_and_store %s\n",lex);
	newlexeme = (char*)malloc(sizeof(lex)+1);
	for (j=0 ; j<sizeof(lex); j++)
	{
		newlexeme[j] = lex[j];
	}
	newlexeme[j] = '\0';
	
	printf("this is the new lexeme: %s",newlexeme);
	if (current == NULL)
		{
			printf("NULL");
		}
	else {
	current->tokens[i].lexeme = newlexeme;
	current->tokens[i].tokenType = typeOfToken;
	current->tokens[i].lineNum = yylineno;
	printf("saved value are lexeme:%s tokentype: %d linenum: %d\n", current->tokens[i].lexeme, current->tokens[i].tokenType, current->tokens[i].lineNum);
	}
}

void print_struct(){
	int j=0;
	Data* local_head = first;
	printf("All the items in the data structure are: \n");
	while(local_head->tokens[j].lexeme != NULL)
	{
		printf("%s\n", local_head->tokens[j].lexeme);
		j++;
		if (j==10)
		{
			j=0;
			local_head = local_head->next;
		}
	}
}

void next_in_dataStructure(){
int j;
if(i==9)
{
	i=0;
	if(current->next == NULL)
	{
		current->next = malloc(sizeof(Data));
		current->next->prev = current;
		for (j=0;j<10;j++)
		{
			current->next->tokens[j].lexeme = NULL;
		}
	}
	current = current->next;
}
else{
	i++;
	}
}