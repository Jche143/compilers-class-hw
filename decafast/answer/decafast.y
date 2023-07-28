%{
#include <iostream>
#include <ostream>
#include <string>
#include <cstdlib>
#include <vector>
#include "default-defs.h"

int yylex(void);
int yyerror(char *); 

// print AST?
bool printAST = true;
#include "decafast.cc"
using namespace std;

string proceesCharLit(string charlit){
    // a|b|t|n|v|f|r
    if (charlit[1] == '\\') {
        switch (charlit[2]) {
            case 'n':
                return to_string('\n');
            ase 'n':
                return to_string('\n');
            case 'a':
                return to_string('\a');
            case 'b':
                return to_string('\b');
            case 't':
                return to_string('\t');
            case 'v':
                return to_string('\v');
            case 'f':
                return to_string('\f');
            case 'r':
                return to_string('\r');
            case '\\':
                return to_string('\\');
            case '\'':
                return to_string('\'');
            case '\"':
                return to_string('\"');
        }
    }
    return to_string(charlit[1]);
}

%}

%define parse.error verbose

%union{
    class decafAST *ast;
    std::string *sval;
    std::vector<std::string> *svals;
 }

%token T_PACKAGE
%token T_LCB
%token T_RCB
%token <sval> T_ID T_STRINGTYPE T_INTTYPE T_BOOLTYPE  T_VOID T_INTCONSTANT T_STRINGCONSTANT T_CHARCONSTANT
%token T_N_TOKEN T_FUNC T_BREAK T_WHILE T_CONTINUE T_EXTERN T_FALSE T_FOR T_NULL T_RETURN T_TRUE T_VAR T_VOID T_ELSE T_IF T_EQ T_GEQ T_LEFTSHIFT T_LEQ T_LSB T_LT T_MINUS T_MOD T_MULT T_NEQ T_NOT T_OR T_PLUS T_RSB T_RIGHTSHIFT T_GT T_COMMA T_SEMICOLON

%type <ast> extern_list decafpackage

%%

start: program

program: extern_list decafpackage
    { 
        ProgramAST *prog = new ProgramAST((decafStmtList *)$1, (PackageAST *)$2); 
		if (printAST) {
			cout << getString(prog) << endl;
		}
        delete prog;
    }

extern_list: /* extern_list can be empty */
    { decafStmtList *slist = new decafStmtList(); $$ = slist; }
    ;

decafpackage: T_PACKAGE T_ID T_LCB T_RCB
    { $$ = new PackageAST(*$2, new decafStmtList(), new decafStmtList()); delete $2; }
    ;

ExternType: T_STRINGTYPE { $$ = new TypeAST($1); }
        |   T_INTTYPE { $$ = new TypeAST($1); }
        |   T_BOOLTYPE { $$ = new TypeAST($1); }

retrun_type: T_VOID { $$ = new TypeAST($1); }
        |  T_INTTYPE { $$ = new TypeAST($1); }
        |  T_BOOLTYPE {}


%%

int main() {
  // parse the input and create the abstract syntax tree
  int retval = yyparse();
  return(retval >= 1 ? EXIT_FAILURE : EXIT_SUCCESS);
}

