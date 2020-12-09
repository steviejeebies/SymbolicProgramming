s --> [2].
s --> one, s, one.
s --> zero, s, zero.
one --> [1].
zero --> [0].

notEqual(X, Y, Z) :-X \== Y, X \== Z, Y \== Z.

nbd --> house(A1,A2,A3), house(B1,B2,B3), house(C1,C2,C3), 
    {notEqual(A1,B1,C1), notEqual(A2, B2, C2), notEqual(A3, B3, C3)}.
house(X,Y,Z) --> [h(X,Y,Z)],{col([X],[]),nat([Y],[]),pet([Z],[])}.
col --> [red].
col --> [blue].
col --> [green].
nat --> [english].
nat --> [spanish].
nat --> [japanese].
pet --> [jaguar].
pet --> [snail].
pet --> [zebra].

accept(L) :- steps(q0,L,F), final(F).
steps(Q,[],Q).
steps(Q,[H|T],Q2) :- tran(Q,H,Qn), steps(Qn,T,Q2).

tran(q0,A,q0) :- is(A, 1); is(A, 0).
tran(q0,1,q1).
tran(q1,A,q2) :- is(A, 1); is(A, 0).
tran(q2,A,q3) :- is(A, 1); is(A, 0).
final(q3).

q0 --> [A], q0, {is(A, 1); is(A, 0)}.
q0 --> [1], q1.
q1 --> [A], q2, {is(A, 1); is(A, 0)}.
q2 --> [A], q3, {is(A, 1); is(A, 0)}.
q3 --> [].

createString([], 0).
createString([0|Y], succ(X)) :- createString(Y, X).
createString([1|Y], succ(X)) :- createString(Y, X).

l3(String,Numeral) :- createString(String, Numeral), accept(String).

numeral(0).
numeral(succ(X)) :- numeral(X).