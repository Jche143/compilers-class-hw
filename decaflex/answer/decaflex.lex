
%{

#include <iostream>
#include <cstdlib>

using namespace std;

enum {T_N_TOKEN, T_FUNC, T_PACKAGE, T_LCB, T_RCB, T_LPAREN, T_RPAREN, T_ID, 
      T_WHITESPACE, T_WHITESPACE_N, T_AND, T_ASSIGN, T_BOOLTYPE, T_BREAK, 
      T_COMMA, T_CHARCONSTANT, T_COMMENT, T_CONTINUE, T_DIV, T_DOT, T_ELSE, 
      T_EQ, T_EXTERN, T_FALSE, T_FOR, T_GEQ, T_GT, T_IF, T_INTCONSTANT, 
      T_INTTYPE, T_LEFTSHIFT, T_LEQ, T_LSB, T_LT, T_MINUS, T_MOD, T_MULT,
      T_NEQ, T_NOT, T_NULL, T_OR, T_PLUS, T_RIGHTSHIFT, T_RSB, T_SEMICOLON, 
      T_STRINGCONSTANT, T_STRINGTYPE, T_TRUE, T_VAR, T_VOID, T_WHILE, T_RETURN
      };

//注释处理
string& covert_newline(string &s){
    string tmp = "";
    for(size_t i = 0; i < s.size(); i++)
      if(s[i] == '\n')
        tmp += "\\n";
      else
        tmp += s[i];
    s = tmp;
    return s;
}






%}

%%
  /*
    Pattern definitions for all tokens
  */
func                       { return T_FUNC; } //T_FUNC
string                     { return T_STRINGTYPE; }
package                    { return T_PACKAGE; } //T_PACKAGE
bool                       { return T_BOOLTYPE; }
break                      { return T_BREAK; }
while                      { return T_WHILE; }
int                        { return T_INTTYPE; }
continue                   { return T_CONTINUE; }
extern                     { return T_EXTERN; }
false                      { return T_FALSE; }
for                        { return T_FOR; }
null                       { return T_NULL; }
return                     { return T_RETURN; }
true                       { return T_TRUE; }
var                        { return T_VAR; }
void                       { return T_VOID; }
else                       { return T_ELSE; }
if                         { return T_IF; }

==                         { return T_EQ; }
>=                         { return T_GEQ; }
\<\<                       { return T_LEFTSHIFT; }
\<=                        { return T_LEQ; }
\[                         { return T_LSB; }
\<                         { return T_LT; }
\-                         { return T_MINUS; }
\%                         { return T_MOD; }
\*                         { return T_MULT; }
!=                         { return T_NEQ; }
!                          { return T_NOT; }
\|\|                       { return T_OR; }
\+                         { return T_PLUS; }
\]                         { return T_RSB; }
>>                         { return T_RIGHTSHIFT; }
>                          { return T_GT; }
,                          { return T_COMMA; }
;                          { return T_SEMICOLON; }

\"([^\n"\\]|\\(a|b|t|n|v|f|r|\\|\'|\"))*\"  { return T_STRINGCONSTANT; } //T_STRINGCONSTANT

"//".*"\n"                 { return T_COMMENT; }

\'([^\n'\\]|\\(a|b|t|n|v|f|r|\\|\'|\"))\' { return T_CHARCONSTANT; } //char_lit

0[xX][a-fA-F0-9]+|[0-9]+(\.[0-9]+)? { return T_INTCONSTANT; } //int

[a-zA-Z\_][a-zA-Z\_0-9]*   { return T_ID; } //标识符，T_ID

[\t\r\a\v\b ]+             { return T_WHITESPACE; } //分隔符，T_WHITESPACE
\n+[\t\r\a\v\b ]*          { return T_WHITESPACE_N; } //T_WHITESPACE_N

\{                         { return T_LCB; } //T_LCB
\}                         { return T_RCB; } //T_RCB
\(                         { return T_LPAREN; } //T_LPAREN
\)                         { return T_RPAREN; } //T_RPAREN

&&                         { return T_AND; }
\/                         { return T_DIV; }
"."                        { return T_DOT; }
=                          { return T_ASSIGN; }
.                          { cerr << "Error: unexpected character in input" << endl; return -1; }

%%

int main () {
  int token;
  string lexeme;
  while ((token = yylex())) {
    if (token > 0) {
      lexeme.assign(yytext);
      switch(token) {
        case T_FUNC: cout << "T_FUNC " << lexeme << endl; break;
        case T_PACKAGE: cout << "T_PACKAGE " << lexeme << endl; break;
        case T_LCB: cout << "T_LCB " << lexeme << endl; break;
        case T_RCB: cout << "T_RCB " << lexeme << endl; break;
        case T_LPAREN: cout << "T_LPAREN " << lexeme << endl; break;
        case T_RPAREN: cout << "T_RPAREN " << lexeme << endl; break;
        case T_ID: cout << "T_ID " << lexeme << endl; break;
        case T_WHITESPACE: cout << "T_WHITESPACE " << lexeme << endl; break;
        case T_WHITESPACE_N: 
          cout << "T_WHITESPACE ";
            for( size_t i = 0; i < lexeme.size(); i++)
              if( lexeme[i] == '\n' ) cout << "\\n"; else cout << lexeme[i];
            cout << endl;
            break;

        //myresult
        case T_AND: cout << "T_AND " << lexeme << endl; break;
        case T_ASSIGN: cout << "T_ASSIGN " << lexeme << endl; break;
        case T_BOOLTYPE: cout << "T_BOOLTYPE " << lexeme << endl; break;
        case T_BREAK: cout << "T_BREAK " << lexeme << endl; break;
        case T_CHARCONSTANT: cout << "T_CHARCONSTANT " << lexeme << endl; break;
        case T_COMMA: cout << "T_COMMA " << lexeme << endl; break;
        case T_COMMENT: cout << "T_COMMENT " << covert_newline(lexeme) << endl; break;
        case T_CONTINUE: cout << "T_CONTINUE " << lexeme << endl; break;
        case T_DIV: cout << "T_DIV " << lexeme << endl; break;
        case T_DOT: cout << "T_DOT " << lexeme << endl; break;
        case T_INTTYPE: cout << "T_INTTYPE " << lexeme << endl; break;
        
        case T_ELSE: cout << "T_ELSE " << lexeme << endl; break;
        case T_EQ: cout << "T_EQ " << lexeme << endl; break;
        case T_EXTERN: cout << "T_EXTERN " << lexeme << endl; break;
        case T_FALSE: cout << "T_FALSE " << lexeme << endl; break;
        case T_GEQ: cout << "T_GEQ " << lexeme << endl; break;
        case T_GT: cout << "T_GT " << lexeme << endl; break;
        case T_IF: cout << "T_IF " << lexeme << endl; break;
        case T_INTCONSTANT: cout << "T_INTCONSTANT " << lexeme << endl; break;
        case T_LEFTSHIFT: cout << "T_LEFTSHIFT " << lexeme << endl; break;
        case T_LEQ: cout << "T_LEQ " << lexeme << endl; break;

        case T_LSB: cout << "T_LSB " << lexeme << endl; break;
        case T_LT: cout << "T_LT " << lexeme << endl; break;
        case T_MINUS: cout << "T_MINUS " << lexeme << endl; break;
        case T_MOD: cout << "T_MOD " << lexeme << endl; break;
        case T_MULT: cout << "T_MULT " << lexeme << endl; break;
        case T_NEQ: cout << "T_NEQ " << lexeme << endl; break;
        case T_NOT: cout << "T_NOT " << lexeme << endl; break;
        case T_NULL: cout << "T_NULL " << lexeme << endl; break;
        case T_OR: cout << "T_OR " << lexeme << endl; break;
        case T_PLUS: cout << "T_PLUS " << lexeme << endl; break;
        
        case T_RETURN: cout << "T_RETURN " << lexeme << endl; break;
        case T_RSB: cout << "T_RSB " << lexeme << endl; break;
        case T_RIGHTSHIFT: cout << "T_RIGHTSHIFT " << lexeme << endl; break;
        case T_SEMICOLON: cout << "T_SEMICOLON " << lexeme << endl; break;
        case T_STRINGCONSTANT: cout << "T_STRINGCONSTANT " << lexeme << endl; break;
        case T_STRINGTYPE: cout << "T_STRINGTYPE " << lexeme << endl; break;
        case T_TRUE: cout << "T_TRUE " << lexeme << endl; break;
        case T_VAR: cout << "T_VAR " << lexeme << endl; break;
        case T_VOID: cout << "T_VOID " << lexeme << endl; break;
        case T_WHILE: cout << "T_WHILE " << lexeme << endl; break;

        default: exit(EXIT_FAILURE);
      }
    } else {
      if (token < 0) {
        exit(EXIT_FAILURE);
      }
    }
  }
  exit(EXIT_SUCCESS);
}


