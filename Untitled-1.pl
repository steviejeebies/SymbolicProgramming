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

incrR(X, Y):- legal(X), incr(X, Y).

add(null, X, X).
add(f0(null), X, X).
add(X, Y, Z) :- incr(A, X), add(A, Y, B), incr(B, Z).

mult(null, _, f0(null)). % for X * 0 = 0 (if 0 is defined as null)
mult(f0(null), _, f0(null)). % (if 0 is defined as f0(null))
mult(f1(null), X, X).
mult(X, Y, Z) :- incr(A, X), mult(A, Y, B), add(Y, B, Z). 