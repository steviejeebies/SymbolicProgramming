pterm(null).
pterm(f0(X)) :- pterm(X).
pterm(f1(X)) :- pterm(X).

reverse(f0(P1), f1(P1)).
reverse(f1(P1), f0(P1)).

% Question 1

incr(null, f1(null)).
incr(f1(null), f0(f1(null))).
incr(f0(X), f1(X)).g
incr(f1(X), f0(Y)) :- incr(X, Y), X \= null. % this is not the arithmetic predicate =/=

% Question 2

legal(f0(null)).
legal(X):- legal(Y), incr(Y, X).

incrR(X, Y):- legal(X), incr(X, Y).

% Question 3

add(null, X, X).
add(f0(null), X, X).
add(X, Y, Z) :- incr(A, X), add(A, Y, B), incr(B, Z).

% Question 4

mult(null, _, f0(null)). % for X * 0 = 0 (if 0 is defined as null)
mult(f0(null), _, f0(null)). % (if 0 is defined as f0(null))
mult(f1(null), X, X).
mult(X, Y, Z) :- incr(A, X), mult(A, Y, B), add(Y, B, Z). 

% Question 5

revers(X,Y) :- rev(X, Y, null).
rev(f0(X), Y, Z) :- rev(X, Y, f0(Z)).
rev(f1(X), Y, Z) :- rev(X, Y, f1(Z)).
rev(null, Z, Z).

% Question 6

normalize(f0(null), f0(null)).
normalize(null, f0(null)).
normalize(X, Y) :- X \= f0(null), X \= null, nmls(X, Y).

nmlz(null, null).
nmlz(f1(X), f1(Y)) :- nmlz(X, Y).
nmlz(f0(X), null) :- nmlz(X, Y), Y = null.
nmlz(f0(X), f0(Y)) :- nmlz(X, Y), Y \= null.

% Clauses to be added for assignment:
% 
% test add inputting numbers N1 and N2
testAdd(N1,N2,T1,T2,Sum,SumT) :- numb2pterm(N1,T1), numb2pterm(N2,T2), add(T1,T2,SumT), pterm2numb(SumT,Sum).

% test mult inputting numbers N1 and N2
testMult(N1,N2,T1,T2,N1N2,T1T2) :- numb2pterm(N1,T1), numb2pterm(N2,T2),mult(T1,T2,T1T2), pterm2numb(T1T2,N1N2).

% test revers inputting list 
testRev(L,Lr,T,Tr) :- ptermlist(T,L), revers(T,Tr), ptermlist(Tr,Lr).

% test normalize inputting list L
testNorm(L,T,Tn,Ln) :- ptermlist(T,L), normalize(T,Tn), ptermlist(Tn,Ln).

% make a pterm T from a number N numb2term(+N,?T)
numb2pterm(0,f0(null)).
numb2pterm(N,T) :- N>0, M is N-1, numb2pterm(M,Temp), incr(Temp,T).

% make a number N from a pterm T  pterm2numb(+T,?N)
pterm2numb(null,0).
pterm2numb(f0(X),N) :- pterm2numb(X,M), N is 2*M.
pterm2numb(f1(X),N) :- pterm2numb(X,M), N is 2*M +1.

% reversible  ptermlist(T,L)
ptermlist(null,[]).
ptermlist(f0(X),[0|L]) :- ptermlist(X,L).
ptermlist(f1(X),[1|L]) :- ptermlist(X,L).