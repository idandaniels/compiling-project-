%option noyywrap
%option yylineno
%{
//#include<stdio.h>
#include "parser.c"
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
{num}          { create_and_store_token(yytext, 1, yylineno) ; return;}
{id}		{ create_and_store_token(yytext, 2, yylineno) ; return;}
{real}		{ create_and_store_token(yytext, 5, yylineno) ; return;}
{add}		{ create_and_store_token(yytext, 3, yylineno) ; return;} 
{mult}		{ create_and_store_token(yytext, 4, yylineno) ; return;}
{any}		{ create_and_store_token(yytext, 6, yylineno) ; return;}
"_"{id}*_?	{printf("ID cant begin with an underscore %s\n",yytext); void back_token(); return;}
{id}"_"		{printf("ID cant end with an underscore %s\n", yytext); void back_token(); return;}
(.*["__+"].*)   {printf("Illegal operation %s\n",yytext); void back_token(); return;}
{num}{id}	{printf(" ID cant begin with a number %s\n", yytext); void back_token(); return;}
{L}		{ create_and_store_token(yytext, 7, yylineno) ; return;}
{LE}		{ create_and_store_token(yytext, 8, yylineno) ; return;}
{EE}		{ create_and_store_token(yytext, 9, yylineno) ; return;}
{NE}		{ create_and_store_token(yytext, 10, yylineno) ; return;}
{G}		{ create_and_store_token(yytext, 11, yylineno) ; return;}
{GE}		{ create_and_store_token(yytext, 12, yylineno) ; return;}
{open_brackets}  { create_and_store_token(yytext, 13, yylineno) ; return;}
{close_brackets} { create_and_store_token(yytext, 14, yylineno) ; return;}
{semi_colon}     { create_and_store_token(yytext, 15, yylineno) ; return;}
{colon}          { create_and_store_token(yytext, 16, yylineno) ; return;}
{start}          { create_and_store_token(yytext, 17, yylineno) ; return;}
{end_loop}       { create_and_store_token(yytext, 18, yylineno) ; return;}
{until}		 { create_and_store_token(yytext, 19, yylineno) ; return;}
{loop}           { create_and_store_token(yytext, 20, yylineno) ; return;}
{else_if}	 { create_and_store_token(yytext, 21, yylineno) ; return;}
{then}		 { create_and_store_token(yytext, 22, yylineno) ; return;}
{integer}	 { create_and_store_token(yytext, 23, yylineno) ; return;}
{type_real}	 { create_and_store_token(yytext, 24, yylineno) ; return;}
{else}		 { create_and_store_token(yytext, 25, yylineno) ; return;}
{if}		 { create_and_store_token(yytext, 26, yylineno) ; return;}
{end}		 { create_and_store_token(yytext, 27, yylineno) ; return;}
{program}	 { create_and_store_token(yytext, 28, yylineno) ; return;}
<<EOF>>		{ return -1;}

%%



int main()
{
	FILE *myfile;
	init();

	myfile = fopen("C:\\Flex Windows\\EditPlusPortable\\myfile.txt","r");
	if(!myfile){
		printf ( "Error file\n");
		return -1;
		}
		yyin = myfile;
		
		//while (current->tokens[i].tokenType != -1)
		//{
		//	next_token();
		//}
		//
		//printf("CHECK THIS: %s\n", current->tokens[1].lexeme); 
		//printf("Printing all tokens we have saved in the data structure: \n");
		//print_struct();

		parse_program();


		system("pause");
}
