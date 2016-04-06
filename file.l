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
program program
end end
if if
else else
type_real real
integer integer
then then
else_if else_if
loop loop
until until
end_loop end_loop
start start
colon :
semi_colon ";"
open_brackets "["
close_brackets "]"

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
{open_brackets}  { create_and_store_token(yytext, 13) ; return;}
{close_brackets} { create_and_store_token(yytext, 14) ; return;}
{semi_colon}     { create_and_store_token(yytext, 15) ; return;}
{colon}          { create_and_store_token(yytext, 16) ; return;}
{start}          { create_and_store_token(yytext, 17) ; return;}
{end_loop}       { create_and_store_token(yytext, 18) ; return;}
{until}		 { create_and_store_token(yytext, 19) ; return;}
{loop}           { create_and_store_token(yytext, 20) ; return;}
{else_if}	 { create_and_store_token(yytext, 21) ; return;}
{then}		 { create_and_store_token(yytext, 22) ; return;}
{integer}	 { create_and_store_token(yytext, 23) ; return;}
{type_real}	 { create_and_store_token(yytext, 24) ; return;}
{else}		 { create_and_store_token(yytext, 25) ; return;}
{if}		 { create_and_store_token(yytext, 26) ; return;}
{end}		 { create_and_store_token(yytext, 27) ; return;}
{program}	 { create_and_store_token(yytext, 28) ; return;}
<<EOF>>		{ return -1;}

%%

Data* first;
Data* current;
int i=-1;

void create_and_store_token(char* lex, int typeOfToken){
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
			create_and_store_token("EOF",-1);
		}
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

		while (current->tokens[i].tokenType != -1)
		{
			next_token();
		}
		
		//printf("CHECK THIS: %s\n", current->tokens[1].lexeme); 
		print_struct();


		system("pause");
}