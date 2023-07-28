%{
#include "default-defs.h"
#include "decafast.tab.h"
#include <cstring>
#include <string>
#include <sstream>
#include <iostream>

using namespace std;

int lineno = 1;
int tokenpos = 1;

%}

%%
  /*
    Pattern definitions for all tokens 
  */
func                       { return T_FUNC; } //T_FUNC
string                     { yylval.sval = new string("StringType"); return T_STRINGTYPE; }
package                    { return T_PACKAGE; } //T_PACKAGE
bool                       { yylval.sval = new string("BoolType"); return T_BOOLTYPE; }
break                      { return T_BREAK; }
while                      { return T_WHILE; }
int                        { yylval.sval = new string("IntType"); return T_INTTYPE; }
continue                   { return T_CONTINUE; }
extern                     { return T_EXTERN; }
false                      { return T_FALSE; }
for                        { return T_FOR; }
null                       { return T_NULL; }
return                     { return T_RETURN; }
true                       { return T_TRUE; }
var                        { return T_VAR; }
void                       { yylval.sval = new string("VoidType"); return T_VOID; }
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

\"([^\n"\\]|\\(a|b|t|n|v|f|r|\\|\'|\"))*\"  { yylval.sval = new string(yytext); return T_STRINGCONSTANT; } //T_STRINGCONSTANT

"//".*"\n"                 { }

\'([^\n'\\]|\\(a|b|t|n|v|f|r|\\|\'|\"))\' { yylval.sval = new string(yytext); return T_CHARCONSTANT; } //char_lit

0[xX][a-fA-F0-9]+|[0-9]+(\.[0-9]+)? { yylval.sval = new string(yytext); return T_INTCONSTANT; } //int

[a-zA-Z\_][a-zA-Z\_0-9]*   { yylval.sval = new string(yytext); return T_ID; } //标识符，T_ID

[\t\r\a\v\b ]+             {  } //ignore whitespace
\n+[\t\r\a\v\b ]*          {  } 

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

int yyerror(const char *s) {
  cerr << lineno << ": " << s << " at char " << tokenpos << endl;
  return 1;
}

