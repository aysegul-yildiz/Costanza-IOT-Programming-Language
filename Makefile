CC = gcc
LEX = lex
YACC = yacc

#paths
SRC_DIR = src
EXAMPLES_DIR = examples

#executable name
TARGET = parser
all: $(TARGET)

$(TARGET): $(SRC_DIR)/CS315_S24_Team1.lex $(SRC_DIR)/CS315_S24_Team1.yacc
	$(LEX) $(SRC_DIR)/CS315_S24_Team1.lex
	$(YACC) $(SRC_DIR)/CS315_S24_Team1.yacc
	$(CC) -o $(TARGET) y.tab.c

clean:
	-rm -f $(TARGET) lex.yy.c *.tab.c *.tab.h *.output
