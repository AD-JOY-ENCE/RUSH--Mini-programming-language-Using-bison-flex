Mini Programming Language - README 
Overview 

This is a simple mini programming language implemented using Flex and Bison. 
It supports: - Variable declarations (int, float, char, string) - Arithmetic calculations using CAL keyword - Printing strings using print - Simple if-else statements (integers only) 

              +++++++How to Run+++++++++
1. Make sure you have Flex and Bison installed. 
2. Open a terminal in the project directory. 
3. Run the following commands:
   
bison -d code.y                  
flex code.l                      
# Generate parser code 
# Generate lexer code 
gcc -o app code.tab.c lex.yy.c   # Compile 
app.exe 

# Run the program 
                +++++++++How to Use++++++++++ 
1. Declare Variables 
int x = 5; 
float y = 2.5; 
char c = 'A'; 
string s = "hello"; 
2. Perform Calculations 
CAL 5 + 3 * 2; 
CAL x + y; 
3. Print Strings 
print "Hello World"; 
4. Use If-Else (Integers only) 
if (5 > 2) print 10 else print 20; 
Note: Every statement must end with a semicolon ;. 
Example Program 
int x = 10; 
float y = 3.5; 
CAL 10 + 3.5; 
print "Calculation complete!"; 
if (10 > 5) print 1 else print 0; 
Expected Output: 
x = 10 
y = 3.50 
Result: 13.50 
Calculation complete! 
Result: 1 
Notes 
• All arithmetic operations are supported: +, -, *, /. 
• Comparisons supported in expressions: >, <, >=, <=, ==, !=. 
• Variables in arithmetic must be declared before use. 
• The language currently does not support float or string variables in if-else.
