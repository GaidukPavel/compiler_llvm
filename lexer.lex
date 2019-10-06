%{
    #include <stdio.h>
  int col_number = 1;
%}

%option main
%option yylineno

%%

[/][/].*\n      {
  col_number = 1;
 }// comment

\n {
  col_number = 1;
}

\t {
  col_number += 4;
}

\s {
  col_number++;
}

\'[a-zA-Z0-9]\'         {
  printf("Symbol - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
  col_number += yyleng;
}

\"[a-zA-Z0-9_ ]*\"         {
  printf("String_literal - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
  col_number += yyleng;
}

int {
    printf("int_type - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
  col_number += yyleng;
}

char {
    printf("char type - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
col_number += yyleng;
  }

\[           {
  printf("Left_index - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
                col_number += yyleng;
  }

\]           {
  printf("Right_index - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
                col_number += yyleng;
  }


[=][=]|[>][=]|[<][=]|[>]|[<]|[!][=]        {
  printf("Logical_operator <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
                col_number += yyleng;
  }

[=] {
  printf("Operator = - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
col_number += yyleng;
  }

public {
  printf("Public - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
col_number += yyleng;
  }

class {
  printf("class - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
col_number += yyleng;
  }

static {
  printf("static - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
col_number += yyleng;
  }

Type {
  printf("Type - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
col_number += yyleng;
  }

\; {
    printf("Semi - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
col_number += yyleng;
  }

[0-9]* {
  printf("Constant - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
col_number += yyleng;
  }

if           {
  printf("Condition - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
                col_number += yyleng;
  }

Main          {
  printf("f_main - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
                col_number += yyleng;
  }

while          {
  printf("loop - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
                col_number += yyleng;
  }

break;          {
  printf("break - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
                col_number += yyleng;
  }

else          {
  printf("else - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
                col_number += yyleng;
  }

return          {
  printf("return - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
                col_number += yyleng;
  }

, {
  printf("comma - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
col_number += yyleng;
  }

\{ {
  printf("R_brace - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
col_number += yyleng;
  }

\} {
  printf("L_brace - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
  col_number += yyleng;
  }

\( {
  printf("L_parenthesis - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
  col_number += yyleng;
  }

\) {
  printf("R_parenthesis - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
  col_number += yyleng;
  }


[a-zA-Z0-9_]* {
  printf("Identifier - <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
  col_number += yyleng;
  }


[-]|[+]|[*]|[/]          {
  printf("Operator <%s>, Loc=<%d,%d>\n", yytext, yylineno, col_number);
              
  col_number += yyleng;
  }


[ \t\r\n]       ; // whitespace
.               { printf("Syntax error in line %d\n", yylineno); exit(1); }
%%
