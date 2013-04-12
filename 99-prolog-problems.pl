%last_elementt remo
last_element(X,[X|[]]).
last_element(X,[_|T]) :- last_element(X,T).

%last_but_one
last_but_one(X,[X,_]).
last_but_one(X,[_,Y|T]) :- last_but_one(X,[Y|T]).

%n'th element
nth_element(H,[H|_],N) :- N is 1.
nth_element(X,[_|T],N) :- N1 is N-1, 
                          nth_element(X,T,N1).

%num_list
num_list([],0).
num_list([_|T],N) :- num_list(T,N1), 
                     N is N1+1.

%rev_list
rev_list([],[]).
rev_list(L,Rev) :- append(L1, [T], L), 
                   rev_list(L1, Rev1),
                   append([T],Rev1,Rev).

%palindrome
palindrome(L) :- rev_list(L, L1), 
                 L1=L.

%flatten_list
flatten_list([],[]).
flatten_list([H|T],R) :- is_list(H), 
                         flatten_list(H,RH), 
                         flatten_list(T,RT), 
                         append(RH, RT, R).
flatten_list([H|T],R) :- flatten_list(T,R1), 
                         append([H],R1,R).

%compress
compress([],[]).
compress([H|T],R) :- compress(T,R1),
                     member(H,R1),
                     R=R1.
compress([H|T],R) :- compress(T, R1),
                     append([H], R1, R).
