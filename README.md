# Costanza-IOT-Programming-Language
Costanza is a programming language specifically designed for IoT (Internet of things) development. Developed as a team project for the CS 315, programming languages, course at Bilkent in 2024.

### The Team
Ayşegül Yıldız, Duru Solakoğlu, Erkan Can Arslan

### What Lex and yacc does?
The Lexical Analyzer (CS315_S24_Team1.lex) is responsible for the word-level parsing of the source code. It scans the input text character by character and groups them into meaningful tokens.
It uses Regular Expressions to identify keywords (like run, if, while), operators (like <- for assignment and << for function calls) and literals (integers, doubles, and strings).
Once a pattern is matched, Lex passes a token code to the Yacc parser. For example when it sees getTemperature, it identifies it as the GET_TEMP token. It filters out whitespaces and comments so the parser only deals with relevant logical units.

The Yacc Parser (CS315_S24_Team1.yacc) is the brain of the compiler. it takes the tokens provided by lex and checks if they follow the grammar rules (BNF) of costanza.
It ensures that a run block is opened with a {, contains valid statements and is followed by the %% separator if functions are declared.It handles operator precedence ensuring multiplication happens before addition and manages nested structures like if-else blocks and while loops. It defines the program's skeleton, ensuring that every user defined function has a valid parameter list and a properly enclosed body.

## How to run?
To build the Costanza parser, you need flex, bison (or yacc) and gcc installed. Run the following commands (or use the provided Makefile by typing make):
    - lex CS315_S24_Team1.lex
    - yacc CS315_S24_Team1.yacc
    - gcc -o parser y.tab.c

Costanza reads from standard input. You can run the parser by redirecting any of the test files into it:
    - ./parser < your_script.txt
    - ./parser < examples/smart-home-automation.txt (is in examples directory)

To remove the generated C files and the compiled executable:
    make clean
