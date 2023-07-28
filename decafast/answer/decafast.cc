
#include "decafast.tab.h"
#include <list>
#include <ostream>
#include <iostream>
#include <sstream>

#ifndef YYTOKENTYPE
#include "decafast.tab.h"
#endif

using namespace std;

/// decafAST - Base class for all abstract syntax tree nodes.
class decafAST {
public:
  virtual ~decafAST() {}
  virtual string str() { return string(""); }
};

string getString(decafAST *d) {
	if (d != NULL) {
		return d->str();
	} else {
		return string("None");
	}
}

template <class T>
string commaList(list<T> vec) {
    string s("");
    for (typename list<T>::iterator i = vec.begin(); i != vec.end(); i++) { 
        s = s + (s.empty() ? string("") : string(",")) + (*i)->str(); 
    }   
    if (s.empty()) {
        s = string("None");
    }   
    return s;
}

/// decafStmtList - List of Decaf statements
class decafStmtList : public decafAST {
	list<decafAST *> stmts;
public:
	decafStmtList() {}
	~decafStmtList() {
		for (list<decafAST *>::iterator i = stmts.begin(); i != stmts.end(); i++) { 
			delete *i;
		}
	}
	int size() { return stmts.size(); }
	void push_front(decafAST *e) { stmts.push_front(e); }
	void push_back(decafAST *e) { stmts.push_back(e); }
	string str() { return commaList<class decafAST *>(stmts); }
};

//package
class PackageAST : public decafAST {
	string Name;
	decafStmtList *FieldDeclList;
	decafStmtList *MethodDeclList;
public:
	PackageAST(string name, decafStmtList *fieldlist, decafStmtList *methodlist) 
		: Name(name), FieldDeclList(fieldlist), MethodDeclList(methodlist) {}
	~PackageAST() { 
		if (FieldDeclList != NULL) { delete FieldDeclList; }
		if (MethodDeclList != NULL) { delete MethodDeclList; }
	}
	string str() { 
		return string("Package") + "(" + Name + "," + getString(FieldDeclList) + "," + getString(MethodDeclList) + ")";
	}
};

/// ProgramAST - the decaf program
class ProgramAST : public decafAST {
	decafStmtList *ExternList;
	PackageAST *PackageDef;
public:
	ProgramAST(decafStmtList *externs, PackageAST *c) : ExternList(externs), PackageDef(c) {}
	~ProgramAST() { 
		if (ExternList != NULL) { delete ExternList; } 
		if (PackageDef != NULL) { delete PackageDef; }
	}
	string str() { return string("Program") + "(" + getString(ExternList) + "," + getString(PackageDef) + ")"; }
};

//TypeAST
class TypeAST : public decafAST {
	string * Name;

public:
	TypeAST(string * name): Name(name) {};
	~TypeAST() {if(Name) delete Name; }
	string str() {
		return string(*Name);
	}
};

//VarDefAST
class VarDefAST : public decafAST {
	string name;
	decafStmtList * TypeList;

	public:
		VarDefAST(decafStmtList * typelist) {}
		VarDefAST(std::string name, typename * type) {
			decafStmtList * typelist = new decafStmtList();
			typelist->push_back(type);
			TypeList = typelist;
			Name = name;
		};

		~VarDefAST() {
			if( TypeList ) delete TypeList;
		}

		string str() {
			if (TypeList->size() == 0)
				return string("None");
			else if(TypeList->size() == 1 && Name != "")
				return string("VarDef(") + getString(TypeList) + ")";
			else
				return string("VarDef(") + getString(TypeList) + ")";
		}
};

// extern func identifier "(" [ { ExternType }+, ] ")" MethodType ";" 
// ExternFunction(identifier name, method_type return_type, extern_type* typelist)
class ExternFunctionAST : public decafAST {
	string name;
	TypeAST * ReturnType;
	VarDefAST * VarList;

	public:
		ExternFunctionAST(string name, TypeAST * returntype, VarDefAST * varlist): Name(name), ReturnType(returntype), VarList(varlist) {};
		~ExternFunctionAST() {
			if( VarList ) delete VarList;
			if( ReturnType ) delete ReturnType;
		}

		string str() {
			return string("ExternFunction") + "(" + Name + "," + ReturnType->str() + "," + getString(VarList) + ")";
		}
};

// field_size = Scalar | Array(int array_size) 
enum VAR_TYPE {VAR_TYPE_SCALAR, VAR_TYPE_ARRAY };

//VarSizeAST
class VarSizeAST : public decafAST {
private:
	VAR_TYPE VarType;
	string Size;
public:
	VarSizeAST(VAR_TYPE type, string size): VarType(type), Size(size) {};

	string str() {
		if (VarType == VAR_TYPE_SCALAR)
			return string("Scalar");
		else
			return string("Array(") + Size + ")";
	}
}

// FieldDecl(identifier name, decaf_type type, field_size size)
// FieldDecl(x,IntType,Scalar)
class FieldDeclAST : public decafAST {
	string Name;
	TypeAST * Type;
	VarSizeAST * field_size;

	FieldDeclAST(identifier name, TypeAST type, VarSizeAST size) : Name(name), TypeAST(type), field_size(size) { };
	~FieldDeclAST() {
		if(Type) delete Type; 
		if(field_size) delete field_size;
	};

	string str() {
		return string("FieldDecl(") + Name + "," + getString(Type) + "," + getString("field_size") + ")";
	}
};

//StringConstant(string value)
class StringConstantAST : public decafAST {
	string Value;
	public:
	StringConstantAST(string v): Value(v) {};
	~StringConstantAST() {};

	var str() {
		return string("StringConstant(") + Value + ")";
	}
}