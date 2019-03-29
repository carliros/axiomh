-- | An example module.
module Engine (
    symbol
  , implies
  , negation
  , modusPonens
  , buildAxiom1
  , buildAxiom2
  , buildAxiom3
  ) where

import Text.Printf

data Proposition
  = Symbol String
  | Unary Connector Proposition
  | Binary Connector Proposition Proposition
  deriving Eq

type Connector = String

instance Show Proposition where
  show (Symbol v) = v
  show (Unary sb p) = printf "%s (%s)" sb (show p)
  show (Binary sb a b) = printf "(%s) %s (%s)" (show a) sb (show b)

symbol :: String -> Proposition
symbol = Symbol

implies :: Proposition -> Proposition -> Proposition
implies = Binary "->"

negation :: Proposition -> Proposition
negation = Unary "~"

buildAxiom1 :: Proposition -> Proposition -> Proposition
buildAxiom1 a b = implies a (implies b a)

buildAxiom2 :: Proposition -> Proposition -> Proposition -> Proposition
buildAxiom2 a b c = implies first second
  where first = implies a (implies b c)
        second = implies (implies a b) (implies a c)

buildAxiom3 :: Proposition -> Proposition -> Proposition
buildAxiom3 a b = implies first second
  where first = implies (negation a) (negation b)
        second = implies b a

modusPonens :: Proposition -> Proposition -> Maybe Proposition
modusPonens (Binary _ prop1 prop2) prop3 = if prop1 == prop3 then Just prop2
                                                             else Nothing
modusPonens _ _ = Nothing

-- Examples
ex1 :: Proposition
ex1 = implies (Symbol "A") (Binary "" (Symbol "B") (Symbol "A"))

ex2 :: Proposition
ex2 = negation (Symbol "C")

a2 :: Proposition
a2 = buildAxiom2 (symbol "a") (implies (symbol "a") (symbol "a")) (symbol "a")

a3 :: Proposition
a3 = buildAxiom1 (symbol "a") (implies (symbol "a") (symbol "a"))
