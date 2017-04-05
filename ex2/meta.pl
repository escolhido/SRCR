% SRCR - META PREDICADOS

:- ensure_loaded(main).

:- op(500, xfy, '&&').
:- op(500, xfy, 'ou').
:- op(700, xfy, 'eq').

:- dynamic (-)/1.

eq(verdadeiro,   &&(verdadeiro,   verdadeiro)).
eq(desconhecido, &&(desconhecido, verdadeiro)).
eq(desconhecido, &&(verdadeiro,   desconhecido)).
eq(desconhecido, &&(desconhecido, desconhecido)).
eq(falso,        &&(falso, _)).
eq(falso,        &&(_, falso)).

eq(falso,        ou(falso,        falso)).
eq(desconhecido, ou(desconhecido, falso)).
eq(desconhecido, ou(falso,        desconhecido)).
eq(desconhecido, ou(desconhecido, desconhecido)).
eq(verdadeiro,   ou(verdadeiro, _)).
eq(verdadeiro,   ou(_, verdadeiro)).

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
or([Q|Qs], R) :- or(Qs, Rs), R eq Q ou Rs.

% evolucao : Q -> {V, F}
evolucao(Q) :- findall(Inv, +Q::Inv, S),
               inserir(Q),
               testar(S).

% inserir : Q -> {V,F}
inserir(Q) :- assert(Q).
inserir(Q) :- retract(Q).

% testar : List -> {V,F}
testar([]).
testar([Q|Qs]) :- Q, testar(Qs).

