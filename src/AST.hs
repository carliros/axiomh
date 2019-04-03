module AST where

import           Text.Printf

type Axioms = [Demostration]

type Name = String
data Demostration
  = Demostration Name Proposition [Step]
  deriving Show

data Step
  = LargeStep Name Proposition ActionStep
  | ShortStep Name ActionStep
  deriving Show

data ActionStep
  = ActionStep Name [Proposition]
  deriving Show

data Proposition
  = Symbol String
  | Unary Connector Proposition
  | Binary Connector Proposition Proposition
  deriving Eq

type Connector = String

instance Show Proposition where
  show (Symbol v)      = v
  show (Unary sb p)    = printf "%s (%s)" sb (show p)
  show (Binary sb a b) = printf "(%s) %s (%s)" (show a) sb (show b)
