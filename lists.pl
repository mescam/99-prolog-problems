%1.01 last_element
last_element(X,[X|[]]).
last_element(X,[_|T]) :-
	last_element(X,T).

%1.02 last_but_one
last_but_one(X,[X,_]).
last_but_one(X,[_,Y|T]) :-
	last_but_one(X,[Y|T]).

%1.03 n'th element
nth_element(H,[H|_],N) :-
	N is 1.
nth_element(X,[_|T],N) :-
	N1 is N-1,
        nth_element(X,T,N1).

%1.04 num_list
num_list([],0).
num_list([_|T],N) :-
	num_list(T,N1),
        N is N1+1.

%1.05 rev_list
rev_list([],[]).
rev_list(L,Rev) :-
	append(L1, [T], L),
        rev_list(L1, Rev1),
        append([T],Rev1,Rev).

%1.06 palindrome
palindrome(L) :-
	rev_list(L, L1),
	L1=L.

%1.07 flatten_list
flatten_list([],[]).
flatten_list([H|T],R) :-
	is_list(H),
	flatten_list(H,RH),
	flatten_list(T,RT),
	append(RH, RT, R).
flatten_list([H|T],R) :-
	flatten_list(T,R1),
	append([H],R1,R).

%1.08 compress
compress([],[]).
compress([H|T],R) :-
	compress(T,R1),
        member(H,R1),
        R=R1.
compress([H|T],R) :-
	compress(T, R1),
        append([H], R1, R).

%1.09 pack
pack([],[]).
pack([H|T],R) :-
	pack(T,[H1|T1]),
        member(H, H1),
        append([H],H1,H2),
        R=[H2|T1].
pack([H|T],R) :-
	pack(T, R1),
        append([[H]],R1,R).

%1.10 encode
encode([],[]).
encode([H|T],R) :-
	encode(T,[[N,E]|T1]),
	H=E,
	N1 is N+1,
	R=[[N1,E]|T1].
encode([H|T],R) :-
	encode(T,L),
        append([[1,H]],L,R).

%1.11 modified encode
encode_mod([],[]).
encode_mod([H|T],R) :-
	encode(T,[[N,E]|T1]),
	H=E,
	N1 is N+1,
	R=[[N1,E]|T1].
encode_mod([H|T],R) :-
	encode(T,[[N,E]|T1]),
	H\=E,
	append([H],[[N,E]|T1],R).
encode_mod([H|T],R) :-
	encode(T,[H1|T1]),
	not(is_list(H1)),
	H1=H,
        append([[2,H]],T1,R).
encode_mod([H|T],R) :-
	encode(T,[H1|T1]),
	not(is_list(H1)),
	H1\=H,
	append([H],[H1|T1],R).

%1.12 decode
decode([],[]).
decode([[N,E]|T], R) :-
	N > 1,
	N1 is N-1,
	decode([[N1,E]|T], R1), %recursion first
	append([E],R1,R).
decode([[N,E]|T], R) :-
	N =:= 1,
	decode(T, R1),
	append([E],R1,R).
decode([E|T], R) :-
	not(is_list(E)),
	decode(T, R1),
	append([E],R1,R).

