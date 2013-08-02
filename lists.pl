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
rev_list(L,Rev) :- append(L1, [T], L),
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

%1.13 direct encode
count([],_,0).
count([E|T],E,N) :-
	count(T,E,N1),
	N is N1+1.
count([H|_],E,N) :-
	H\=E,
	N=0.


%1.14 duplicate
dupli([],[]).
dupli([H|T],X) :-
	dupli(T,X1),
	X = [H,H|X1].

%1.15 duplicate N times
multiply(_,0,[]).
multiply(E,C,R) :-
	C1 is C-1,
	multiply(E,C1,R1),
	append([E],R1,R).

dupli([],_,[]).
dupli([H|T],C,X) :-
	dupli(T,C,X1),
	multiply(H,C,R1),
	append(R1,X1,X).

%1.16 drop nth
drop_n([],_,_,[]).
drop_n([_|T],I,C,R) :-
	I1 is I+1,
	drop_n(T,I1,C,R1),
	0 =:= I mod C,
	R = R1.
drop_n([H|T],I,C,R) :-
	I1 is I+1,
	drop_n(T,I1,C,R1),
	0 =\= (I mod C),
	R = [H|R1].

drop(L,C,R) :-
	drop_n(L,1,C,R).

%1.17 split
split(L,0,[],L).
split([H|T],N,L1,L2) :-
	N > 0,
	N1 is N-1,
	split(T,N1,L1n,L2),
	L1=[H|L1n].

%1.18 slice
slice(_,N1,N2,_,_) :- N1 > N2, !, fail.
slice(L,_,0,[],L).
slice([H|T],N1,N2,L1,L2) :-
	N1 > 1,
	N1x is N1-1,
	N2x is N2-1,
	slice(T,N1x,N2x,L1x,L2x),
	L1=L1x,
	L2=[H|L2x].
slice([H|T],N1,N2,L1,L2) :-
	N1 =< 1,
	N1x is N1-1,
	N2x is N2-1,
	slice(T,N1x,N2x,L1x,L2x),
        L1=[H|L1x],
	L2=L2x.

%1.19 (**) Rotate a list N places to the left.
rotate(L,N,R) :-
	N > 0,
	split(L, N, L1, L2),
	append(L2,L1,R).
rotate(L,N,R) :-
	N =< 0,
	length(L, Len),
	N1 is Len+N,
	split(L, N1, L1, L2),
	append(L2, L1, R).

%1.20 (*) Remove the K'th element from a list.
remove_at(H,[H|T],1,T).
remove_at(X,[H|T],K,R) :-
	K>1,
	K1 is K-1,
	remove_at(X,T,K1,R1),
	R=[H|R1].

%1.21 (*) Insert an element at a given position into a list.
insert_at(E,L,1,[E|L]).
insert_at(E,[H|T],K,R) :-
	K>1,
	K1 is K-1,
	insert_at(E,T,K1,R1),
	R=[H|R1].

%1.22 (*) Create a list containing all integers within a given range.
range(X,X,[X]). % lol.
range(X,Y,_) :- X>Y, !, fail.
range(X,Y,L) :-
	X\=Y,
	X1 is X+1,
	range(X1,Y,L1),
	L=[X|L1].

% 1.23 (**) Extract a given number of randomly selected elements from a
% list.
rnd_select(_,0,[]).
rnd_select(L,N,R) :-
	length(L,Len),
	Len>=N,
	N>0,
	N1 is N-1,
	Y is random(Len)+1,
	remove_at(X,L,Y,L1),
	rnd_select(L1,N1,R1),
	R=[X|R1].

%1.24 (*) Lotto: Draw N different random numbers from the set 1..M.
lotto(N,M,L) :-
	range(1,M,L1),
	rnd_select(L1,N,L).

%1.25 (*) Generate a random permutation of the elements of a list.
rnd_permu(L,R) :-
	length(L,Len),
	rnd_select(L,Len,R).

%1.26 (**) Generate the combinations of K distinct objects chosen from
%the N elements of a list

element(X,[X|T],T).
element(X, [_|T],R) :- element(X,T,R).

combination(0,_,[]).
combination(K,We,Wy) :-
	K>0,
	K1 is K-1,
	element(X, We, R),
	combination(K1, R, Wy1),
	Wy=[X|Wy1].

%1.27 (**) Group the elements of a set into disjoint subsets.
%a) In how many ways can a group of 9 people work in 3 disjoint subgroups of 2, 3 and 4 persons? Write a predicate that generates all the possibilities via backtracking.
group3(L,G1,G2,G3) :-
	%group 1
	select_gmembers(L, 2, G1),
	subtract(L, G1, L1),
	select_gmembers(L1, 3, G2),
	subtract(L1, G2, L2),
	select_gmembers(L2, 4, G3).

select_gmembers(_, 0, []).
select_gmembers(L, N, [X|Wy1]) :-
	N > 0,
	element(X, L, L1),
	N1 is N-1,
	select_gmembers(L1, N1, Wy1).

%b) Generalize the above predicate in a way that we can specify a list of group sizes and the predicate will return a list of groups.

group(_,[],[]).
group(L, [N|Ns], Wy) :-
	select_gmembers(L, N, Wy1),
	subtract(L, Wy1, L1),
	group(L1, Ns, Wy2),
	Wy = [Wy1|Wy2].

%1.28 (**) Sorting a list of lists according to length of sublists
% a) We suppose that a list (InList) contains elements that are lists
% themselves. The objective is to sort the elements of InList according
% to their length. E.g. short lists first, longer lists later, or vice
% versa.

into_sorted_list(X,[],[X]).
into_sorted_list(X,[H|T],[H|R2]) :-
	length(X,Len1),
	length(H,Len2),
	Len1 > Len2, !,
	into_sorted_list(X,T,R2).
into_sorted_list(X, [H|T], [X,H|T]).


lsort([X],[X]) :- !.
lsort([H|T], R) :-
	lsort(T, R1),
	into_sorted_list(H, R1, R).

%b) Again, we suppose that a list (InList) contains elements that are lists themselves. But this time the objective is to sort the elements of InList according to their length frequency; i.e. in the default, where sorting is done ascendingly, lists with rare lengths are placed first, others with a more frequent length come later.

add_len([],[],0).
add_len([H|T],[H1|T1]) :-
	add_len(T,T1),
	length(H,Len),
	H1 = H/Len.





