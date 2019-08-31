module AST where

import           Text.Printf

type Axioms = [Demostration]

type Name = String
data Demostration
  = Demostration Name Proposition [Step]
  deriving Show

data Step
  = LargeStep Proposition ActionStep
  | ShortStep ActionStep
  deriving Show

data ActionStep
  = ActionStep Name [Argument]
  deriving Show

data Argument
  = ArgumentProp Proposition
  | ArgumentRef Int
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
