num2list(We,Wy) :-
	We1 is We div 10,
	We1 > 0, !,
	num2list(We1, Wy1),
	Wy2 is We mod 10,
	append(Wy1,[Wy2],Wy).
num2list(We,Wy) :-
	Wx is We mod 10,
	Wy = [Wx].


qpart([],_,[],[]).
qpart([H|T],X,M,W) :-
	H>X, !,
	qpart(T,X,M,W1),
	W=[H|W1].
qpart([H|T],X,M,W) :-
	qpart(T,X,M1,W),
	M=[H|M1].

quicksort([],[]).
quicksort([H|T],Wy) :-
	qpart(T,H,M,W),
	quicksort(M,M1),
	quicksort(W,W1),
	append(M1,[H|W1],Wy).

num2sorted(We,Wy) :-
	num2list(We,X),
	quicksort(X,Wy).

compress([X],[[1,X]]).
compress([H|T],Wy) :-
	compress(T,Wy1),
	[[_,Y]|_] = Wy1,
	H =\= Y, !,
	Wy = [[1,H]|Wy1].
compress([H|T], Wy) :-
	compress(T, Wy1),
	[[X,Y]|T1] = Wy1,
	H =:= Y, !,
	X1 is X+1,
	Wy = [[X1,Y]|T1].

is_crazy_helper([]).
is_crazy_helper([[X,Y]|T]) :-
	X =< Y,
	is_crazy_helper(T).

is_crazy(X) :-
	num2list(X,X1),
	quicksort(X1,X2),
	compress(X2,X3),!,
	is_crazy_helper(X3).





