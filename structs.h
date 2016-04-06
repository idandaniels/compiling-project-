
typedef struct Token{
	char* lexeme;
	int tokenType;
	int lineNum;
	} Token;
	
typedef struct Data{
	Token tokens[10];
	struct Data* next;
	struct Data* prev;
	} Data;


	void create_and_store_token(char* lex, int typeOfToken);
	void back_token();
	void next_in_dataStructure();
	void print_struct();