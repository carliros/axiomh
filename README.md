# Axiom Helper Tool

Axioms are a nice way to learning logic. But it is tedious to demonstrate
its theorems. They are prone to error doing in paper. That is why we need a
tool to help us doing that job.

## How to demonstrate theorems in AxiomH
Here is a example:

~~~
Demonstrate T1 |- A -> A by
1. |- (A -> ((A -> A) -> A)) -> ((A -> (A -> A)) -> (A -> A)) by Axiom 2 with A, (A -> A), A
2. |- A -> ((A -> A) -> A) by Axiom 1 with A, (A -> A), A
3. Modus Ponens with 1, 2
4. |- A -> (A -> A) by Axiom 1 with A, A, A
5. Modus Ponens with 3, 4
~~~

## Comments
We can have shorter and larger declarations
For example Shorter declarations can be
  Modus Ponens with 1, 2  -- ID Reference, ID Reference
  Axiom 2 with A, (A -> A), A -- Proposition, Proposition, Proposition
And Larger declarations can be
  A -> ((A -> A) -> A) by Axiom 1 with A, (A -> A), A
  (A -> ((A -> A) -> A)) -> ((A -> (A -> A)) -> (A -> A)) by Axiom 2 with A, (A -> A), A
