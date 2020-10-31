pterm(null).
pterm(f0(X)) :- pterm(X).
pterm(f1(X)) :- pterm(X).

reverse(f0(P1), f1(P1)).
reverse(f1(P1), f0(P1)).

incr(null, f1(null)).
incr(f1(null), f0(f1(null))).
incr(f0(X), f1(X)).
incr(f1(X), f0(Y)) :- incr(X, Y), X \= null. % this is not the arithmetic predicate =/=

legal(f0(null)).
legal(X):- legal(Y), incr(Y, X).