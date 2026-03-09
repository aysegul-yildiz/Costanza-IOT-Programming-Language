%option yylineno

NEW_LINE			    \n
RUN				        run
PRINT				    print
FOR 				    for
WHILE				    while
RETURN			        return
FUNCTION_WORD			function
BOOLEAN			        true|false
GET_TEMP			    getTemperature
GET_HUM			        getHumidity
GET_AP			        getAirPressure
GET_AQ			        getAirQuality
GET_LIGHT		        getLight
GET_SOUND			    getSound
SWITCH_ON			    switchOn
SWITCH_OFF			    switchOff
GET_TIME			    getTime
SEND_INT			    sendInt
RECEIVE_INT		        receiveInt
CONNECT_URL		        conectToURL
TO				        to
FROM				    from
ASSIGN_OP			    \<\-
FUNCTION_CALL		    \<\<
FUNCT_DEC_SIGN          \>\>
FUNCTION                {FUNCTION_WORD}{FUNCT_DEC_SIGN}
START_COMMENT        	\<\*
END_COMMENT        	    \*\>    
COMMENT 			    {LESS_SIGN}\*[^*]*\*{GREAT_SIGN}
LB 				        \{
RB 				        \}
SLB				        \[
SRB				        \]
SWITCH			        s1|s2|s3|s4|s5|s6|s7|s8|s9|s10
PLUS_SIGN			    \+
MINUS_SIGN			    \-
DIVID_SIGN			    \/
MULT_SIGN			    \*
MOD_SIGN			    \%
POW_SIGN			    \^
ELIF				    elif
IF				        if
ELSE				    else
LP 				        \(
RP 				        \)
OR_SIGN			        \|\|
QUOTE			        \"
AND_SIGN			    \&\&
NOTEQUAL_SIGN          	not\=
EQUAL_SIGN			    \=\=
GREATEQUAL_SIGN		    \>\=
LESSEQUAL_SIGN		    \<\=
LESS_SIGN			    \<
GREAT_SIGN			    \>
NOT                 	not
COMMA			        \,
INCREMENT			    \+\+
DECREMENT			    \-\-
SEPARATOR			    \%\%
SYMBOLS			        [\!\&\?\\\.\_\|\#\:\=]
ID				        {LOW_ABC}({ABC_DIGIT}|\_)*
LOW_ABC			        [a-z]
UP_ABC			        [A-Z]
DIGIT				    [0-9]
ABC_DIGIT			    {ABC}|{DIGIT}
ABC				        {LOW_ABC}|{UP_ABC}
INT_POS			        ({DIGIT})*
INT_NEG			        {MINUS_SIGN}{INT_POS}
INT				        {INT_POS}|{INT_NEG}
DOUBLE			        {INT}(\.{INT_POS}+)?
WORD				    {ABC}+
URL 				    (https?|ftp):\/\/[a-zA-Z0-9\-_\.]+\.[a-zA-Z]{2,}(\/[a-zA-Z0-9\-_\.\/\?=&]*)?
STRING			        (\")({ABC_DIGIT}{SPACE}?|{SYMBOLS}{SPACE}?)*(\")
SPACE           		[ \t\r\n]+


%%

{RUN}				    { return(RUN); }
{PRINT}			        { return(PRINT); }
{LB} 				    { return(LB ); }
{RB} 				    { return(RB ); }
{SLB} 				    { return(SLB ); }
{SRB} 				    { return(SRB ); }
{ASSIGN_OP}			    { return(ASSIGN_OP ); }
{SWITCH}			    { return(SWITCH ); }
{PLUS_SIGN}			    { return(PLUS_SIGN ); }
{MINUS_SIGN}		    { return(MINUS_SIGN ); }
{DIVID_SIGN}			{ return(DIVID_SIGN ); }
{MULT_SIGN}			    { return(MULT_SIGN ); }
{MOD_SIGN}			    { return(MOD_SIGN ); }
{POW_SIGN}			    { return(POW_SIGN ); }
{IF}				    { return(IF ); }
{ELSE}				    { return(ELSE ); }
{ELIF}			    	{ return(ELIF ); }
{LP} 				    { return(LP ); }
{RP} 				    { return(RP ); }
{QUOTE} 			    { return(QUOTATION ); }
{AND_SIGN}			    { return(AND_SIGN ); }
{OR_SIGN}			    { return(OR_SIGN ); }
{NOTEQUAL_SIGN}		    { return(NOTEQUAL_SIGN ); }
{EQUAL_SIGN}		    { return(EQUAL_SIGN ); }
{LESS_SIGN}			    { return(LESS_SIGN ); }
{GREAT_SIGN}		    { return(GREAT_SIGN ); }
{GREATEQUAL_SIGN}	    { return(GREATEQUAL_SIGN ); }
{LESSEQUAL_SIGN}	    { return(LESSEQUAL_SIGN ); }
{NOT}				    { return(NOT);}
{FUNCTION}			    { return(FUNCTION ); }
{FUNCTION_CALL}		    { return(FUNCTION_CALL ); }
{COMMA}			        { return(COMMA ); }
{COMMENT}			    { return(COMMENT ); }
{URL}      			    { return(URL ); }
{INCREMENT}		        { return(INCREMENT ); }
{DECREMENT}		        { return(DECREMENT ); }
{SEPARATOR}		        { return(SEPARATOR ); }
{FOR}				    { return(FOR ); }
{WHILE}			        { return(WHILE ); }
{RETURN}			    { return(RETURN ); }
{BOOLEAN}			    { return(BOOLEAN ); }
{GET_TEMP}			    { return(GET_TEMP ); }
{GET_HUM}			    { return(GET_HUM ); }
{GET_AP}			    { return(GET_AP ); }
{GET_AQ}			    { return(GET_AQ ); }
{GET_LIGHT}			    { return(GET_LIGHT ); }
{GET_SOUND}		        { return(GET_SOUND ); }
{SWITCH_ON}		        { return(SWITCH_ON ); }
{SWITCH_OFF}		    { return(SWITCH_OFF ); }
{GET_TIME}			    { return(GET_TIME ); }
{SEND_INT}			    { return(SEND_INT ); }
{RECEIVE_INT}		    { return(RECEIVE_INT ); }
{CONNECT_URL}		    { return(CONNECT_URL); }
{TO}				    { return(TO ); }
{FROM}			        { return(FROM ); }
{INT}			    	{ yylval = atoi(yytext); return(INT ); }
{DOUBLE}			    { return(DOUBLE ); }
{ID}				    { return(ID ); }
{STRING}			    { return(STRING ); }
{NEW_LINE}			    { return(NEW_LINE);  }
{SPACE}	 		        {/* Ignore whitespace */}


%%
int yywrap(){
return 1;
}