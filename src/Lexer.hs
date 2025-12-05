module Lexer where

import Data.Char

data Token = TokenNum Int
           | TokenTrue 
           | TokenFalse
           | TokenPlus 
           | TokenTimes 
           | TokenAnd 
           | TokenOr 
           | TokenLParen 
           | TokenRParen 
           | TokenIf
           | TokenThen
           | TokenElse
           | TokenLam
           | TokenDot
           | TokenColon
           | TokenVar String
           | TokenNumType
           | TokenBoolType
           | TokenArrow
           | TokenLBracket
           | TokenRBracket
           | TokenComma
           | TokenHead
           | TokenTail
           | TokenListType
           deriving Show

data Expr = Num Int 
          | BTrue 
          | BFalse 
          | Add Expr Expr
          | Times Expr Expr
          | And Expr Expr
          | Or Expr Expr
          | Paren Expr
          | If Expr Expr Expr
          | Var String
          | Lam String Ty Expr
          | App Expr Expr
          | List [Expr]
          | Head Expr
          | Tail Expr
          deriving Show

data Ty = TNum
        | TBool
        | TFun Ty Ty
        | TList Ty 
        deriving (Show, Eq)

lexer :: String -> [Token]
lexer [] = []
lexer ('+':cs) = TokenPlus : lexer cs
lexer ('*':cs) = TokenTimes : lexer cs
lexer ('(':cs) = TokenLParen : lexer cs
lexer (')':cs) = TokenRParen : lexer cs
lexer ('&':'&':cs) = TokenAnd : lexer cs
lexer ('|':'|':cs) = TokenOr : lexer cs
lexer ('\\':cs) = TokenLam : lexer cs
lexer ('.':cs) = TokenDot : lexer cs
lexer (':':cs) = TokenColon : lexer cs
lexer ('-':'>':cs) = TokenArrow : lexer cs
lexer ('[':cs) = TokenLBracket : lexer cs
lexer (']':cs) = TokenRBracket : lexer cs
lexer (',':cs) = TokenComma : lexer cs
lexer cs@(c:rest) | isSpace c = lexer rest
               | isDigit c = lexNum cs
               | isAlpha c = lexKw cs
lexer _ = error "Lexical error"

lexNum cs = case span isDigit cs of
              (num, rest) -> TokenNum (read num) : lexer rest

lexKw cs = case span isAlpha cs of
             ("true", rest) -> TokenTrue : lexer rest
             ("false", rest) -> TokenFalse : lexer rest
             ("if", rest) -> TokenIf : lexer rest
             ("then", rest) -> TokenThen : lexer rest
             ("else", rest) -> TokenElse : lexer rest
             ("Num", rest)   -> TokenNumType : lexer rest
             ("Bool", rest)  -> TokenBoolType : lexer rest
             ("head", rest)  -> TokenHead : lexer rest
             ("tail", rest)  -> TokenTail : lexer rest
             ("List", rest)  -> TokenListType : lexer rest 
             (v, rest) -> TokenVar v : lexer rest