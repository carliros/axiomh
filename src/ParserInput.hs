{-# LANGUAGE CPP                       #-}
{-# LANGUAGE FlexibleContexts          #-}
{-# LANGUAGE FlexibleInstances         #-}
{-# LANGUAGE MultiParamTypeClasses     #-}
{-# LANGUAGE NoMonomorphismRestriction #-}
{-# LANGUAGE Rank2Types                #-}
{-# LANGUAGE TypeSynonymInstances      #-}

module ParserInput where

import           AST
import           Engine
import           Text.ParserCombinators.UU
import           Text.ParserCombinators.UU.BasicInstances
import           Text.ParserCombinators.UU.Utils

parseInput :: FilePath -> String -> Proposition
parseInput filepath fileContent
  = runParser filepath pProposition fileContent

operators = [[("->", implies)]]
same_prio ops = foldr (<|>) empty [ op <$ pSymbol c | (c, op) <- ops]

pProposition :: Parser Proposition
pProposition = foldr pChainr pUnitaryProposition (map same_prio operators)

pUnitaryProposition :: Parser Proposition
pUnitaryProposition =  pSymbolProposition
                   <|> pNegationProposition
                   <|> pParens pProposition

pSymbolProposition :: Parser Proposition
pSymbolProposition = (\c -> symbol [c]) <$> pLetter <* pSpaces

pNegationProposition :: Parser Proposition
pNegationProposition
  = negation <$ pSymbol "~" <*> (pSymbolProposition <|> pParens pProposition)

{-
pAxioms :: Parser Axioms
pAxioms = pListSep pDemostration pSpaces

pDemostration :: Parser Demostration
pDemostration = pSymbol "Demonstrate" <* pSymbol "|-" <*> pProposition <* pSymbol "by" <*> pSteps
-}
