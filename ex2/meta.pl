% SRCR - META PREDICADOS

:- ensure_loaded(main).

:- op(400, yfx, '&&').
:- op(400, yfx, '$$').
:- op(600, xfx, 'eq').

:- dynamic (-)/1.

eq(verdadeiro,   &&(verdadeiro,   verdadeiro)).
eq(desconhecido, &&(desconhecido, verdadeiro)).
eq(desconhecido, &&(verdadeiro,   desconhecido)).
eq(desconhecido, &&(desconhecido, desconhecido)).
eq(falso,        &&(falso, _)).
eq(falso,        &&(_, falso)).

eq(falso,        $$(falso,        falso)).
eq(desconhecido, $$(desconhecido, falso)).
eq(desconhecido, $$(falso,        desconhecido)).
eq(desconhecido, $$(desconhecido, desconhecido)).
eq(verdadeiro,   $$(verdadeiro, _)).
eq(verdadeiro,   $$(_, verdadeiro)).

% demo : Q -> {V, F, D}
demo(Q, verdadeiro)
    :- Q.
demo(Q, falso)
    :- -Q.
demo(Q, desconhecido)
    :- nao(Q),
       nao(-Q).

% demoC : [Q] -> {V, F, D}
demoC(L, R) :- maplist(demo, L, Rss),
               and(Rss, R).

% demoD : [Q] -> {V, F, D}
demoD(L, R) :- maplist(demo, L, Rss),
               or(Rss, R).

% nao : Q -> {V,F}
nao(Q) :- Q, !, fail.
nao(_).

% and : Qs -> {V,F,R}
and([], verdadeiro).
and([Q|Qs], R) :- and(Qs, Rs), R eq Q && Rs.

% or : Qs -> {V,F,R}
or([], falso).
or([Q|Qs], R) :- or(Qs, Rs), R eq Q $$ Rs.

% evolucao : Q -> {V, F}
evolucao(Q) :-
    findall(Inv, +Q::Inv, S),
    inserir(Q),
    testar(S).

% involucao : Q -> {V,F}
involucao(Q) :-
     findall(I, -Q::I, L),
     testar(L),
     remove(Q).

% inserir : Q -> {V,F}
inserir(Q) :- assert(Q).
inserir(Q) :- retract(Q), !, fail.

% remove : Q -> {V,F}
remove(Q) :- retract(Q).

% testar : List -> {V,F}
testar([]).
testar([Q|Qs]) :- Q, testar(Qs).

% utente_interdito((Id, Nome, Idade, Morada), Simbolo) :-
%     assert( nulo(Simbolo) ),
%     assert( +utente(Id, Nome, Idade, Morada) :: (
%         findall((Id, Nome, Idade, Morada),
%                 (utente(Id, Nome, Idade, Morada), nao( nulo(Simbolo) )),
%                 []))).
