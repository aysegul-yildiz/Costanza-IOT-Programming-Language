%{
#include <stdlib.h>
#include <stdlib.h>
int yylex(void);
void yyerror(char* s);
extern int yylineno;
%}

%token RUN
%token PRINT
%token LB
%token RB
%token SLB
%token SRB
%token ASSIGN_OP
%token SWITCH
%token PLUS_SIGN
%token MINUS_SIGN
%token MULT_SIGN
%token DIVID_SIGN
%token MOD_SIGN
%token POW_SIGN
%token IF
%token ELSE
%token ELIF
%token LP
%token RP
%token QUOTATION
%token OR_SIGN
%token AND_SIGN
%token NOTEQUAL_SIGN
%token EQUAL_SIGN
%token LESS_SIGN
%token GREAT_SIGN
%token GREATEQUAL_SIGN
%token LESSEQUAL_SIGN
%token NOT
%token COMMA
%token COMMENT
%token URL
%token INCREMENT
%token DECREMENT
%token SEPARATOR
%token FOR
%token WHILE
%token RETURN
%token FUNCTION
%token FUNCTION_CALL
%token BOOLEAN
%token GET_TEMP
%token GET_HUM
%token GET_AP
%token GET_AQ
%token GET_LIGHT
%token GET_SOUND
%token SWITCH_ON
%token SWITCH_OFF
%token GET_TIME
%token SEND_INT
%token RECEIVE_INT
%token CONNECT_URL
%token TO
%token FROM
%token INT
%token DOUBLE
%token ID
%token STRING
%token NEW_LINE

%%

program:				RUN  LB stmt_list RB SEPARATOR function_declarations
						;

stmt_list :				NEW_LINE
						| stmt 
						| stmt stmt_list 
						| error NEW_LINE {yyerrok;}
						;

stmt: 					matched
						| unmatched
						;

matched: 				IF LP logic_expr RP LB stmt_list RB ELSE LB stmt_list RB
						|nonconditional_stmt
						;

unmatched:				IF LP logic_expr RP LB stmt_list RB
						;

nonconditional_stmt: 	prim_functs 
						| COMMENT
						| assignment
						| arithmetic_op
						| loops
						| return_stmt
						| function_caller
						| print
						;

function_declarations:	
						| function_declaration function_declarations
						;

function_declaration:	FUNCTION ID LP param_list RP LB stmt_list RB
						;

function_caller:		FUNCTION_CALL ID LP param_list RP 
						| FUNCTION_CALL prim_functs 
						;

param_list:				 
						| term
						| term COMMA param_list
						;

loops:					for_loop
						| while_loop
						;		
		
for_loop : 				FOR LP assignment COMMA logic_expr COMMA for_count RP LB 
						stmt_list RB
						;

for_count:				arithmetic_op
						| ID INCREMENT 
						| ID DECREMENT
						;

while_loop: 			WHILE LP logic_expr RP LB stmt_list RB
						;

return_stmt: 			RETURN arithmetic_op
						| RETURN NEW_LINE
						;

assignment: 			ID ASSIGN_OP arithmetic_op
						| ID ASSIGN_OP function_caller
						| ID ASSIGN_OP array_init
						| ID ASSIGN_OP BOOLEAN
						| ID ASSIGN_OP SWITCH
						| ID ASSIGN_OP STRING
						;
logic_expr : 			 exprAND OR_SIGN logic_expr
			 			| exprAND 
						;

exprAND : 				 exprNOT AND_SIGN exprAND
						| exprNOT 
						;

exprNOT : 				NOT BOOLEAN 
						| exprEQ
						;

exprEQ : 				exprNEQ EQUAL_SIGN exprEQ
						| exprNEQ
						;

exprNEQ : 				exprLT NOTEQUAL_SIGN exprNEQ
						| exprLT
						;

exprLT : 				exprGT LESS_SIGN exprLT
						| exprGT
						;

exprGT : 				exprLE GREAT_SIGN exprGT
						| exprLE
						;

exprLE: 				exprGE LESSEQUAL_SIGN exprLE
						| exprGE
						;

exprGE : 				arithmetic_op GREATEQUAL_SIGN exprGE
						| arithmetic_op
						;

array_init :			LB var_inits RB | LB RB 
						;

var_inits : 			var_init
						| var_inits COMMA var_init
						;

var_init :				INT
						| ID 	
						| array_init
						;

arithmetic_op :	 		exprB PLUS_SIGN arithmetic_op
						| exprB MINUS_SIGN arithmetic_op
						| exprB
						;

exprB:		 			exprC MULT_SIGN exprB
						| exprC DIVID_SIGN exprB
						| exprC MOD_SIGN exprB
						| exprC
						;

exprC:					term POW_SIGN exprC
						| term
						;

term: 					INT
						| DOUBLE
						| ID
						| array_access
						;

array_access:			ID SLB arithmetic_op SRB
						;

prim_functs :			connect_URL
						| getTemperature 
						| getHumidity 
						| getAirPressure 
						| getAirQuality 
						| getLight 
						| getSound
						| getTime
						| switchOn 
						| switchOff 
						| send
						| receive
						;

connect_URL:			CONNECT_URL LP QUOTATION URL QUOTATION RP 
						;

getTemperature:			GET_TEMP LP RP
						;

getHumidity:			GET_HUM LP RP
						;

getAirPressure	:		GET_AP LP RP
						;

getAirQuality:			GET_AQ LP RP
						;

getLight:				GET_LIGHT LP RP	
						;

getSound:				GET_SOUND LP RP
						;

 getTime:				GET_TIME LP RP 
						;

switchOn:				SWITCH_ON LP SWITCH RP
						;

switchOff:				SWITCH_OFF LP SWITCH RP
						;

 send:					SEND_INT LP INT TO QUOTATION URL  QUOTATION	
						| SEND_INT LP ID TO QUOTATION URL  QUOTATION RP
						;

receive	:				RECEIVE_INT LP ID FROM QUOTATION URL QUOTATION RP
						;

 print:					PRINT LP STRING RP
						| PRINT LP ID RP
						;
%%
#include "lex.yy.c"
void yyerror(char *s) {
	fprintf(stdout, "line %d: %s\n", yylineno,s);
}

int main() {
	int error = yyparse();
	if (error == 0) {
		printf("Input program is valid.\n");
	}
 	return error;
}

