{
module Parser where

import Lexer
}

%name parser
%tokentype { Token }
%error { parseError }

%right "->" -- para tipos, associativa à direita
%left "||" -- OR, menor precedência
%left "&&" -- AND, precedência maior que OR
%left '+' -- soma
%left '*' -- multiplicação, precedência maior que +
%left ','   

%token
    num             { TokenNum $$ }
    true            { TokenTrue }
    false           { TokenFalse }
    '+'             { TokenPlus }
    '*'             { TokenTimes }
    "&&"            { TokenAnd }
    "||"            { TokenOr }
    '('             { TokenLParen }
    ')'             { TokenRParen }
    "if"            { TokenIf }
    "then"          { TokenThen }
    "else"          { TokenElse }
    lam             { TokenLam }
    '.'             { TokenDot }
    ':'             { TokenColon }
    var             { TokenVar $$ }
    numtype         { TokenNumType }    -- <- adicionado
    booltype        { TokenBoolType }   -- <- adicionado
    arrow           { TokenArrow }      -- <- adicionado
    '['             { TokenLBracket }
    ']'             { TokenRBracket }
    ','             { TokenComma }
    head            { TokenHead }
    tail            { TokenTail }
    listtype { TokenListType }

%%

Exp     : num                             { Num $1 }
        | true                            { BTrue }
        | false                           { BFalse }
        | Exp '+' Exp                     { Add $1 $3 }
        | Exp '*' Exp                     { Times $1 $3 }
        | Exp "&&" Exp                    { And $1 $3 }
        | Exp "||" Exp                    { Or $1 $3 }
        | '(' Exp ')'                     { Paren $2 }
        | "if" Exp "then" Exp "else" Exp  { If $2 $4 $6 }
        | lam var ':' Ty '.' Exp          { Lam $2 $4 $6 }
        | Exp Exp                         { App $1 $2 }
        | var                             { Var $1 }
        | '[' ListElems ']'               { List $2 }
        | head Exp                        { Head $2 }
        |    tail Exp                     { Tail $2 }

Ty      : numtype              { TNum }
        | booltype             { TBool }
        | listtype Ty          { TList $2 }
        | '(' Ty arrow  Ty ')' { TFun $2 $4 }

ListElems
    : Exp                    { [$1] }
    | ListElems ',' Exp      { $1 ++ [$3] }

{
parseError :: [Token] -> a
parseError _ = error "Syntax error!"
}