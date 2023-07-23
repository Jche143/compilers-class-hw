
%{

#include <iostream>
#include <cstdlib>

using namespace std;

%}

%%
  /*
    Pattern definitions for all tokens
  */
func                       { return 1; } //T_FUNC
int                        { return 2; } //T_INT
package                    { return 3; } //T_PACKAGE
\{                         { return 4; } //T_LCB
\}                         { return 5; } //T_RCB
\(                         { return 6; } //T_LPAREN
\)                         { return 7; } //T_RPAREN
[a-zA-Z\_][a-zA-Z\_0-9]*   { return 8; } //标识符，T_ID
[\t\r\a\v\b ]+             { return 9; } //分隔符，T_WHITESPACE
\n                         { return 10; } //T_WHITESPACE
&&                         { return 11; }
=                          { return 12; }
bool                       { return 13; }
break                      { return 14; }
\'[^\n'\\]|(\\(a|b|t|n|v|f|r|\\|\'|\"))\' { return 15; }
,                          { return 16; }
comment                    { return 17; }
continue                   { return 18; }
\/                         { return 19; }
\.                         { return 20; }
==                         { return 21; }
extern                     { return 22; }
false                      { return 23; }
for                        { return 24; }
>=                         { return 25; }
>                          { return 26; }
if                         { return 27; }
0[xX][a-fA-F0-9]+|[0-9]+(\.[0-9]+)? { return 28; }
\<\<                       { return 29; }
\<=                        { return 30; }
\[                         { return 31; }
\<                         { return 32; }
\-                         { return 33; }
\%                         { return 34; }
!=                         { return 35; }
!                          { return 36; }
null                       { return 37; }
\|\|                       { return 38; }
\+                         { return 39; }
return                     { return 28; }
>>                         { return 28; }
;                          { return 28; }
\"([^\n"\\]|\\(a|b|t|n|v|f|\\|\'|\"))*\" { return 28; }
else                       { return 28; }
else                       { return 28; }
else                       { return 28; }
else                       { return 28; }
.                          { cerr << "Error: unexpected character in input" << endl; return -1; }

%%

int main () {
  int token;
  string lexeme;
  while ((token = yylex())) {
    if (token > 0) {
      lexeme.assign(yytext);
      switch(token) {
        case 1: cout << "T_FUNC " << lexeme << endl; break;
        case 2: cout << "T_INT " << lexeme << endl; break;
        case 3: cout << "T_PACKAGE " << lexeme << endl; break;
        case 4: cout << "T_LCB " << lexeme << endl; break;
        case 5: cout << "T_RCB " << lexeme << endl; break;
        case 6: cout << "T_LPAREN " << lexeme << endl; break;
        case 7: cout << "T_RPAREN " << lexeme << endl; break;
        case 8: cout << "T_ID " << lexeme << endl; break;
        case 9: cout << "T_WHITESPACE " << lexeme << endl; break;
        case 10: cout << "T_WHITESPACE \\n" << endl; break;
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
