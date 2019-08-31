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

parseInput :: FilePath -> String -> Axioms
parseInput filepath fileContent
  = runParser filepath pAxioms fileContent

pAxioms :: Parser Axioms
pAxioms = pListSep pSpaces pDemostration

pDemostration :: Parser Demostration
pDemostration
  = Demostration <$  pKey "Demonstrate"
                 <*> pIdentifier
                 <*  pKey "|-"
                 <*> pProposition
                 <*  pKey "by"
                 <*> pList1_ng pStep

pStep :: Parser Step
pStep =  LargeStep <$  pKey "|-" <*> pProposition <* pKey "by" <*> pActionStep
     <|> ShortStep <$> pActionStep

pActionStep :: Parser ActionStep
pActionStep = ActionStep <$> pIdentifier
                         <*  pKey "with"
                         <*> pList1Sep pComma pArgument

pArgument :: Parser Argument
pArgument =  ArgumentProp <$> pProposition
         <|> ArgumentRef  <$> pNatural

operators = [[("->", implies)]]
same_prio ops = foldr (<|>) empty [ op <$ pKey c | (c, op) <- ops]

pProposition :: Parser Proposition
pProposition = foldr pChainr pUnitaryProposition (map same_prio operators)

pUnitaryProposition :: Parser Proposition
pUnitaryProposition =  pSymbolProposition
                   <|> pNegationProposition
                   <|> pParens pProposition

pSymbolProposition :: Parser Proposition
pSymbolProposition = symbol <$> pIdentifier

pNegationProposition :: Parser Proposition
pNegationProposition
  = negation <$ pKey "~" <*> (pSymbolProposition <|> pParens pProposition)

-- Utils
pKey :: String -> Parser String
pKey str = pToken str <* pSpaces

pIdentifier :: Parser String
pIdentifier = pLetterDigit <* pSpaces

pLetterDigit :: Parser String
pLetterDigit = (\l ls -> l:ls) <$> pLetter <*> pList (pLetter <|> pDigit)
