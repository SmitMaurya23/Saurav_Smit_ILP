%{
#include <stdio.h>
#include <string.h>
%}

GSTRING \"([^\"\\]|\\.)*\"

KEYWORD "abstract"|"as"|"assert"|"boolean"|"break"|"byte"|"case"|"catch"|"char"|"class"|"const"|"continue"|"def"|"default"|"do"|"double"|"else"|"enum"|"extends"|"false"|"final"|"finally"|"float"|"for"|"goto"|"if"|"implements"|"import"|"in"|"instanceof"|"int"|"interface"|"long"|"native"|"new"|"null"|"package"|"private"|"protected"|"public"|"return"|"short"|"static"|"strictfp"|"super"|"switch"|"synchronized"|"this"|"throw"|"throws"|"transient"|"true"|"try"|"void"|"volatile"|"while"

ID ([a-zA-Z][a-zA-Z0-9]*)|(("_"|"$")[a-zA-Z0-9]+)|("foo."{KEYWORD})

OPERATOR "+"|"-"|"*"|"/"|"%"|"**"|"++"|"--"|"!"|"=="|"!="|">"|"<"|">="|"<="|"&&"|"||"|"&"|"|"|"^"|"~"|"<<"|">>"|">>>"|"?"|":"|"?:"|"?:="|"?."|"."|".&"|".@"|"=~"|"==~"|"~="|"<<="|">>="|">>>="|"+="|"-="|"*="|"/="|"%="|"&="|"|="|"^="|"as"|"in"|"is"|"to"|"in"|"==="|"as"

SEPARATOR "<"|">"|"("|")"|"["|"]"|"{"|"}"
printf("\n \n \n") ;

%%

printf("\n\n");

(?:\/\/[^\n]*) {
    printf("Single Line Comment: %s\n", yytext);
}

\/\*[\s\S]*?\*\/ {
    printf("Multi Line Comment: %s\n", yytext);
}

{GSTRING} {
    printf("GString: %s\n", yytext);
}

{KEYWORD} {
    printf("Keyword: %s\n", yytext);
}

{ID} {
    if (!strstr(yytext, "`")) {
        printf("Regular Identifier: %s\n", yytext);
    }
 }
 
{OPERATOR} {
    {
        printf("Operator: %s\n", yytext);
    }
 }
{SEPARATOR} {
    {
        printf("SEPARATOR: %s\n", yytext);
    }
 }
 
\"[^\"\n]*\"   {/* LITERALS */ printf("Double Quoted String Literal: %s\n", yytext); }
'[^'\n]*'      {/* LITERALS */ printf("Single Quoted String Literal: %s\n", yytext); }
[0-9]+\.[0-9]+            {/* LITERALS */ printf("Float Literal: %s\n", yytext); }
" "            { printf("");}

 
%%
int yywrap()								
{

	return 1;
}

int main() {
printf("\n \n \n") ;
    yylex();
    return 0;
}

