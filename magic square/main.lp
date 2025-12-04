#const n = 3.


lato(1..n). valore(1..n*n).
diag(1..2). magicval(((n*n)*(n*n+1))/(2*n)).

1 { magic(X,Y,V) : valore(V) } 1 :- lato(X),lato(Y).
1 { magic(X,Y,V) : lato(X),lato(Y) } 1 :- valore(V).

sum_cols(X, S ) :- S = #sum{ V : magic(X,L,V), lato(L)}, lato(X).
sum_rows(Y, S ) :- S = #sum{ V : magic(L,Y,V), lato(L)}, lato(Y).
sum_diag(1, S ) :- S = #sum{ V : magic(L,L,V), lato(L)}.
sum_diag(2, S ) :- S = #sum{ V : magic(L,n-L+1,V), lato(L)}.

% Equal cols
:- lato(X), sum_cols(X,V), magicval(T), V != T.
% Equal rows
:- lato(X), sum_rows(X,V), magicval(T), V != T.
% Equal diags
:- diag(D), sum_diag(D,V), magicval(T), V != T.
