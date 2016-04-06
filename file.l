%option noyywrap
%option yylineno
%{
#include<stdio.h>
#include "structs.h"
//#define YY_DECL extern "C" int yylex()
%}



add "+"
mult "*"
L <
LE <=
EE ==  
NE !=
G >
GE >=
id [a-zA-Z]([a-zA-Z0-9]|_[a-zA-Z0-9])*
num [0-9]+
real {num}"."{num}
any . 


%%

[ \t\n]         ;
{num}          { create_and_store_token(yytext, 1) ; return;}
{id}		{ create_and_store_token(yytext, 2) ; return;}
{real}		{ create_and_store_token(yytext, 5) ; return;}
{add}		{ create_and_store_token(yytext, 3) ; return;} 
{mult}		{ create_and_store_token(yytext, 4) ; return;}
{any}		{ create_and_store_token(yytext, 6) ; return;}
"_"{id}*_?	{printf("ID cant begin with an underscore %s\n",yytext); void back_token(); return;}
{id}"_"		{printf("ID cant end with an underscore %s\n", yytext); void back_token(); return;}
(.*["__+"].*)   {printf("Illegal operation %s\n",yytext); void back_token(); return;}
{num}{id}	{printf(" ID cant begin with a number %s\n", yytext); void back_token(); return;}
{L}		{ create_and_store_token(yytext, 7) ; return;}
{LE}		{ create_and_store_token(yytext, 8) ; return;}
{EE}		{ create_and_store_token(yytext, 9) ; return;}
{NE}		{ create_and_store_token(yytext, 10) ; return;}
{G}		{ create_and_store_token(yytext, 11) ; return;}
{GE}		{ create_and_store_token(yytext, 12) ; return;}


%%

Data* first;
Data* current;
int i=0;

void create_and_store_token(char* lex, int typeOfToken){
	printf("from create_and_store %s\n",lex);
	if (current == NULL)
		{
			printf("NULL");
		}
	else {
	current->tokens[i].lexeme = lex;
	current->tokens[i].tokenType = typeOfToken;
	current->tokens[i].lineNum = yylineno;
	printf("saved value are lexeme:%s tokentype: %d linenum: %d\n", current->tokens[i].lexeme, current->tokens[i].tokenType, current->tokens[i].lineNum);
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

void next_token(){
next_in_dataStructure();
if(current->tokens[i].lexeme != NULL){
	printf("FROM NEXT TOKEN FUNC the token is: %s\n",current->tokens[i].lexeme );
		}
else {
	
yylex();	
	}

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

int main()
{
	int j;
	first = malloc(sizeof(Data));
	current = first;
	for (j =0 ; j<10; j++)
	{
		current->tokens[j].lexeme = NULL;
	}
	current->next = NULL;
	

	FILE *myfile = fopen("C:\\Flex Windows\\EditPlusPortable\\myfile.txt","r");
	if(!myfile){
		printf ( "Error file\n");
		return -1;
		}
		yyin = myfile;
		for(j=0; j<12; j++)
		{
			next_token();
			printf("the current token is %s\n", current->tokens[i].lexeme);
			printf("Done printing token\n");

		}
		printf("======\n======\nNOW GOING BACK\n=====\n======\n");
		for(j=0;j<7;j++)
		{
			back_token();
			
			printf("Done printing token\n");
		}
		printf("Stopped going back\n");
		printf("the current token is %d\n", current->tokens[i].lineNum);
		next_token();
		printf("---------after next token------\n");
		printf("the current token is %d\n", current->tokens[i].lineNum);
		printf("Done printing token\n");


		system("pause");
}