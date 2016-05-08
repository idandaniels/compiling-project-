#include <stdio.h>
#include "functions.c"

bool match(int typeOfToken){
	next_token();
	if(current->tokens[i].tokenType == typeOfToken){
		return 1;
	}
	else{
		back_token();
		return 0;
	}
}

bool parse_program(){
	
	next_token();
	switch(current->tokens[i].tokenType)
	{
		case 28:
			printf("program");
			parse_declerations();
			break;
	}
	
}

bool parse_declerations(){
	 parse_decleration();
	if(match(15)){
		if (!parse_declerations())
		{
			back_token();
			return 1;
		}
	}
	else {return 0;}
}

bool parse_dcleration(){
	parse_variable_list();
	if(!match(16)){
		printf("I cant find semi-colon \n");
		return 0;
	}
	parse_type();
}

bool parse_type(){
	next_token();
	switch(current->tokens[i].tokenType){
		case(1):
			printf("int \n");
			break;
		case(3):
			printf("real \n");
			break;
		default:
			printf("error in parse_type function \n");
	}
}

bool parse_variable_list(){
	if (parse_variable())
	{
		if(match(29))
		{
			return parse_variable_list();
		}
		else {return 1;}
	}
	return 0;
}

bool parse_variable(){
	if(match(2)){
		next_token();
		switch(current->tokens[i].tokenType){
			case 13:
				if(match(1)){
				if(match(14)){
					return 1;
				}
				}
				return 0;
				break;
		}
		default:
			back_token();
			return 1;
	}
}

bool parse_statements(){
	parse_statement();
	if(match(15)){
		if(!parse_statements()){
			back_token();
			return 1;
		}
	}
	else { return 0; }
}

bool parse_statement(){
	parse_receiver();
}

bool parse_reciever(){
	if(match(2)){
		next_token();
		switch(current->tokens[i].tokenType){
			case 13:
				if(parse_expression()){
					if(match(14)){
						return 1;
					}
				}
				return 0;
				break;
			default:
				back_token();
			return1;
		}
	}
}

bool parse_expression(){
	next_token();
	switch(current->tokens[i].tokenType){
		case 1:
			printf("Number \n");
			break;
		case 2:
			next_token();
			switch(current->tokens[i].tokenType){
				case 13:
					if(parse_expression()){
						if(match(14)){
							return 1;
						}
				}
				return 0;
				break;
				case 3:
				case 4:
					next_token();
					if(parse_expression()){
						return 1;
				}
				return 0;
				break;
		}
	}
}


bool parse_condition(){
	parse_expression();
	next_token();
	switch(current->tokens[i].tokenType){
		case 7:
		case 8:
		case 9:
		case 10:
		case 11:
		case 12:
			if(parse_expression()){
				return 1;
		}
		back_token();
		return 0;
	}
	default:
	return 1;
}


