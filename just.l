%{
#include <stdio.h>
#include <string.h>
%}

GSTRING \"([^\"\\]|\\.)*\"

KEYWORD "abstract"|"as"|"assert"|"boolean"|"break"|"byte"|"case"|"catch"|"char"|"class"|"const"|"continue"|"def"|"default"|"do"|"double"|"else"|"enum"|"extends"|"false"|"final"|"finally"|"float"|"for"|"goto"|"if"|"implements"|"import"|"in"|"instanceof"|"int"|"interface"|"long"|"native"|"new"|"null"|"package"|"private"|"protected"|"public"|"return"|"short"|"static"|"strictfp"|"super"|"switch"|"synchronized"|"this"|"throw"|"throws"|"transient"|"true"|"try"|"void"|"volatile"|"while"

ID ([a-zA-Z][a-zA-Z0-9]*)|(("_"|"$")[a-zA-Z0-9]+)|("foo."{KEYWORD})

OPERATOR "+"|"-"|"*"|"/"|"%"|"**"|"++"|"--"|"!"|"=="|"!="|">"|"<"|">="|"<="|"&&"|"||"|"&"|"|"|"^"|"~"|"<<"|">>"|">>>"|"?"|":"|"?:"|"?:="|"?."|"."|".&"|".@"|"=~"|"==~"|"~="|"<<="|">>="|">>>="|"+="|"-="|"*="|"/="|"%="|"&="|"|="|"^="|"as"|"in"|"is"|"to"|"in"|"==="|"as"

SEPARATOR "<"|">"|"("|")"|"["|"]"|"{"|"}"|"="
printf("\n \n \n") ;

%%

printf("\n\n");

(?:\/\/[^\n]*) {
    printf("%s\tSingle Line Comment\n", yytext);
}

\/\*[\s\S]*?\*\/ {
    printf("%s\tMulti Line Comment\n", yytext);
}

{KEYWORD} {
    printf("%s\tKeyword\n", yytext);
}

{OPERATOR} {
    {
        printf("%s\t:Operator\n", yytext);
    }
 }
{SEPARATOR} {
    {
        printf("%s\t:SEPARATOR\n", yytext);
    }
 }
 
{ID}"."{KEYWORD} {printf("%s\t:Keyword as an Identifier using dot\n", yytext);}


{ID} {
    if (!strstr(yytext, "`")) {
        printf("%s\t:Regular Identifier\n", yytext);
    }
 }
 
 
\"[^\"\n]*\"              {/* LITERALS */ printf("%s\t:Double Quoted String Literal\n", yytext); }
'[^'\n]*'                 {/* LITERALS */ printf("%s\t:Single Quoted String Literal\n", yytext); }
\'\'\'[^\'\\]*\'\'\'      {/* LITERALS */ printf("%s\t:Triple Quoted String Literal\n", yytext); }
\/[^\/]*\/                {printf("%s\t:Slashy string\n", yytext);}
\$/([^$/]|\/[^$])*\/\$    {printf("Dollar-slashy string: %s\n", yytext);}


[0-9]+                    {/* LITERALS */ printf("%s\t:Integer Literal\n", yytext); }
[0-9]+\.[0-9]+            {/* LITERALS */ printf("%s\t:Float Literal\n", yytext); }


 //Function name k liye hai isme kuch change karna padega becoz ye keyword nhi bta rha
"def"+" "+{ID}*\(  {
    char* functionName = yytext + 3; // Skip the "def" keyword
        functionName[strlen(functionName) - 1] = '\0'; // Remove the opening parenthesis
        printf("%s\t:User-defined function\n", functionName);
}

{GSTRING} {
    printf("GString: %s\n", yytext);
}
" "   { printf("");}

 
%%
int yywrap()								
{

	return 1;
}

int main() {
    printf("Enter String \n");
    yylex();
    printf("OUTPUT String \n");
    return 0;
}

