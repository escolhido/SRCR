% SRCR - META PREDICADOS

:- ensure_loaded(main).

:- op(400, yfx, '&&').
:- op(400, yfx, '$$').
:- op(600, xfx, 'eq').

:- dynamic (-)/1.
:- dynamic excecao/1.

%
% SISTEMA DE INFERÊNCIA
%

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

%
% EVOLUÇÃO DE CONHECIMENTO
%

%
%%% Evolução de conhecimento perfeito
% evolucao(utente(3, "Maria", 25, "St. Barbara")).
%
%%% Evolução de conhecimento imperfeito do tipo desconhecido
% evolucao(utente(3, "Maria", ut03_idade, "St. Barbara)).
% utente_desconhecido(3, idade).
%
%%% Evolução de conhecimento imperfeito do tipo impreciso
% evolucao(utente(3, "Maria", ut03_idade, "St. Barbara)).
% utente_desconhecido(3, idade, Idade, (Idade >= 50, Idade =< 70)).
%
%%% Evolução de conhecimento imperfeito do tipo interdito
% evolucao(utente(3, nome, 30, "St. Barbara").
% utente_interdito(3, nome, Nome,
%                 (findall(Nome, (utente(3, Nome, _, _), nao(nulo(Nome))), []))).
%
%%% Evolução de conhecimento imperfeito desconhecido/impreciso para perfeito
% evolucao(utente(3, "Maria", ut03_idade, "St. Barbara")).
% utente_desconhecido(3, idade).
%
% utente_conhecido(idade, 3, 23).

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

%
% EVOLUÇÃO DE CONHECIMENTO IMPERFEITO
%

% Transformar conhecimento imperfeito desconhecido/impreciso em conhechimento perfeito
conhecer_utente(nome, Id, Nome)
    :- utente_id(Id, utente(Id, S, I, M)),
       atom(S), nao( atom(Nome) ),
       substituir(utente(Id, S, I, M), utente(Id, Nome, I, M)).
conhecer_utente(idade, Id, Idade)
    :- utente_id(Id, utente(Id, N, S, M)),
       atom(S), nao( atom(Idade) ),
       substituir(utente(Id, N, S, M), utente(Id, N, Idade, M)).
conhecer_utente(morada, Id, Morada)
    :- utente_id(Id, utente(Id, N, I, S)),
       atom(S), nao( atom(Morada) ),
       substituir(utente(Id, N, I, S), utente(Id, N, I, Morada)).

conhecer_servico(descricao, Id, Descricao)
    :- servico_id(Id, servico(Id, S, I, C)),
       atom(S), nao( atom(Descricao) ),
       substituir(servico(Id, S, I, C), servico(Id, Descricao, I, C)).
conhecer_servico(instituicao, Id, Instituicao)
    :- servico_id(Id, servico(Id, D, S, C)),
       atom(S), nao( atom(Instituicao) ),
       substituir(servico(Id, D, S, C), servico(Id, D, Instituicao, C)).
conhecer_servico(cidade, Id, Cidade)
    :- servico_id(Id, servico(Id, D, I, S)),
       atom(S), nao( atom(Cidade) ),
       substituir(servico(Id, D, I, S), servico(Id, D, I, Cidade)).

conhecer_ato(data, Simbolo, Data)
    :- findall(ato(Simbolo, U, S, C), ato(Simbolo, U, S, C), [A|_]),
       atom(Simbolo), not( atom(Data) ),
       substituir(A, ato(Data, U, S, C)).
conhecer_ato(utente, Simbolo, Utente)
    :- findall(ato(D, Simbolo, S, C), ato(D, Simbolo, S, C), [A|_]),
       atom(Simbolo), not( atom(Utente) ),
       substituir(A, ato(D, Utente, S, C)).
conhecer_ato(servico, Simbolo, Servico)
    :- findall(ato(D, U, Simbolo, C), ato(D, U, Simbolo, C), [A|_]),
       atom(Simbolo), not( atom(Servico) ),
       substituir(A, ato(D, U, Servico, C)).
conhecer_ato(custo, Simbolo, Custo)
    :- findall(ato(D, U, S, C), ato(D, U, S, C), [A|_]),
       atom(Simbolo), not( atom(Custo) ),
       substituir(A, ato(D, U, S, C)).

conhecer_data(dia, Id, Dia)
    :- data_id(Id, data(Id, S, M, A)),
       atom(S), not( atom(Dia) ),
       substituir(data(Id, S, M, A), data(Id, Dia, M, A)).
conhecer_data(mes, Id, Mes)
    :- data_id(Id, data(Id, D, S, A)),
       atom(S), not( atom(Mes) ),
       substituir(data(Id, D, S, A), data(Id, D, Mes, A)).
conhecer_data(ano, Id, Ano)
    :- data_id(Id, data(Id, D, M, Ano)),
       atom(S), not( atom(Ano) ),
       substituir(data(Id, D, M, S), data(Id, D, M, Ano)).

% declarar conhecimento imperfeito desconhecido
utente_desconhecido(Id, nome)
    :- utente_id(Id, utente(_, N, _, _) ), atom(N),
       assert( excecao( utente(IdUt, _, I, M)) :- utente(IdUt, N, I, M) ).
utente_desconhecido(Id, idade)
    :- utente_id(Id, utente(_, _, I, _) ), atom(I),
       assert( excecao( utente(IdUt, N, _, M)) :- utente(IdUt, N, I, M) ).
utente_desconhecido(Id, morada)
    :- utente_id(Id, utente(_, _, _, M) ), atom(M),
       assert( excecao( utente(IdUt, N, I, _)) :- utente(IdUt, N, I, M) ).

servico_desconhecido(Id, descricao)
    :- servico_id(Id, servico(_, D, _, _)), atom(D),
       assert( excecao( servico(IdServ, _, I, C) ) :- servico(IdServ, D, I, C) ).
servico_desconhecido(Id, instituicao)
    :- servico_id(Id, servico(_, _, I, _)), atom(I),
       assert( excecao( servico(IdServ, D, _, C) ) :- servico(IdServ, D, I, C) ).
servico_desconhecido(Id, cidade)
    :- servico_id(Id, servico(_, _, _, C)), atom(C),
       assert( excecao( servico(IdServ, D, I, _) ) :- servico(IdServ, D, I, C) ).

ato_desconhecido(Simbolo, data)
    :- atom(Simbolo),
       assert( excecao( ato(_, U, S, C) ) :- ato(Simbolo, U, S, C) ).
ato_desconhecido(Simbolo, utente)
    :- atom(Simbolo),
       assert( excecao( ato(D, _, S, C) ) :- ato(D, Simbolo, S, C) ).
ato_desconhecido(Simbolo, servico)
    :- atom(Simbolo),
       assert( excecao( ato(D, U, _, C) ) :- ato(D, U, Simbolo, C) ).
ato_desconhecido(Simbolo, custo)
    :- atom(Simbolo),
       assert( excecao( ato(D, U, S, _) ) :- ato(D, U, S, Simbolo) ).

data_desconhecida(Id, dia)
    :- data_id(Id, data(_, D, _, _)), atom(D),
       assert( excecao( data(Id, _, M, A) ) :- data(Id, D, M, A)).
data_desconhecida(Id, mes)
    :- data_id(Id, data(_, _, M, _)), atom(M),
       assert( excecao( data(Id, D, _, A) ) :- data(Id, D, M, A)).
data_desconhecida(Id, ano)
    :- data_id(Id, data(_, _, _, A)), atom(A),
       assert( excecao( data(Id, D, M, _) ) :- data(Id, D, M, A)).

% declarar conhecimento imperfeito impreciso
utente_desconhecido(Id, nome, Nome, Q)
    :- utente_id(Id, utente(_, N, _, _)), atom(N),
       assert( excecao( utente(IdUt, Nome, I, M)) :- (utente(IdUt, N, I, M), Q)).
utente_desconhecido(Id, idade, Idade, Q)
    :- utente_id(Id, utente(_, _, I, _)), atom(I),
       assert( excecao( utente(IdUt, N, Idade, M)) :- (utente(IdUt, N, I, M), Q)).
utente_desconhecido(Id, morada, Morada, Q)
    :- utente_id(Id, utente(_, _, _, M)), atom(M),
       assert( excecao( utente(IdUt, N, I, Morada)) :- (utente(IdUt, N, I, M), Q)).

servico_desconhecido(Id, descricao, Desc, Q)
    :- servico_id(Id, servico(_, D, _, _)), atom(D),
       assert( excecao( servico(IdServ, Desc, I, C) ) :- (servico(IdServ, D, I, C), Q)).
servico_desconhecido(Id, instituicao, Inst, Q)
    :- servico_id(Id, servico(_, _, I, _)), atom(I),
       assert( excecao( servico(IdServ, D, Inst, C) ) :- (servico(IdServ, D, I, C), Q)).
servico_desconhecido(Id, cidade, Cidade, Q)
    :- servico_id(Id, servico(_, _, _, C)), atom(C),
       assert( excecao( servico(IdServ, D, I, Cidade) ) :- (servico(IdServ, D, I, C),Q)).

ato_desconhecido(Simbolo, data, Data, Q)
    :- atom(Simbolo),
       assert( excecao( ato(Data, U, S, C) ) :- (ato(Simbolo, U, S, C), Q)).
ato_desconhecido(Simbolo, utente, Utente, Q)
    :- atom(Simbolo),
       assert( excecao( ato(D, Utente, S, C) ) :- (ato(D, Simbolo, S, C), Q)).
ato_desconhecido(Simbolo, servico, Servico, Q)
    :- atom(Simbolo),
       assert( excecao( ato(D, U, Servico, C) ) :- (ato(D, U, Simbolo, C), Q)).
ato_desconhecido(Simbolo, custo, Custo, Q)
    :- atom(Simbolo),
       assert( excecao( ato(D, U, S, Custo) ) :- (ato(D, U, S, Simbolo),Q)).

data_desconhecida(Id, dia, Dia, Q)
    :- data_id(Id, data(_, D, _, _)), atom(D),
       assert( excecao( data(Id, Dia, M, A) ) :- (data(Id, D, M, A), Q)).
data_desconhecida(Id, mes, Mes, Q)
    :- data_id(Id, data(_, _, M, _)), atom(M),
       assert( excecao( data(Id, D, Mes, A) ) :- (data(Id, D, M, A), Q)).
data_desconhecida(Id, ano, Ano, Q)
    :- data_id(Id, data(_, _, _, A)), atom(A),
       assert( excecao( data(Id, D, M, Ano) ) :- (data(Id, D, M, A), Q)).

% declarar conhecimento imperfeito interdito
utente_interdito(Id, nome, Nome, Q)
    :- utente_id(Id, utente(_, N, _, _)), atom(N),
       assert( nulo(N) ),
       assert( +utente(_, Nome, _, _) :: (Q)).
utente_interdito(Id, idade, Idade, Q)
    :- utente_id(Id, utente(_, _, I, _)), atom(I),
       assert( nulo(I) ),
       assert( +utente(_, _, Idade, _) :: (Q)).
utente_interdito(Id, morada, Morada, Q)
    :- utente_id(Id, utente(_, _, _, M)), atom(M),
       assert( nulo(M) ),
       assert( +utente(_, _, _, Morada) :: (Q)).

servico_interdito(Id, descricao, Desc, Q)
    :- servico_id(Id, servico(_, D, _, _)), atom(D),
       assert( nulo(D) ),
       assert( +servico(_, Desc, _, _) :: (Q)).
servico_interdito(Id, instituicao, Inst, Q)
    :- servico_id(Id, servico(_, _, I, _)), atom(I),
       assert( nulo(I) ),
       assert( +servico(_, _, Inst, _) :: (Q)).
servico_interdito(Id, cidade, Cidade, Q)
    :- servico_id(Id, servico(_, _, _, C)), atom(C),
       assert( nulo(C) ),
       assert( +servico(_, _, _, Cidade) :: (Q)).

ato_interdito(Simbolo, data, Data, Q)
    :- atom(Simbolo),
       assert( nulo(Simbolo) ),
       assert( +ato(Data, _, _, _) :: (Q)).
ato_interdito(Simbolo, utente, Utente, Q)
    :- atom(Simbolo),
       assert( nulo(Simbolo) ),
       assert( +ato(_, Utente, _, _) :: (Q)).
ato_interdito(Simbolo, servico, Servico, Q)
    :- atom(Simbolo),
       assert( nulo(Simbolo) ),
       assert( +ato(_, _, Servico, _) :: (Q)).
ato_interdito(Simbolo, custo, Custo, Q)
    :- atom(Simbolo),
       assert( nulo(Simbolo) ),
       assert( +ato(_, _, _, Custo) :: (Q)).

data_interdita(Id, dia, Dia, Q)
    :- data_id(Id, data(_, D, _, _)), atom(D),
       assert( nulo(D) ),
       assert( +data(_, Dia, _, _) :: (Q)).
data_interdita(Id, mes, Mes, Q)
    :- data_id(Id, data(_, _, M, _)), atom(M),
       assert( nulo(M) ),
       assert( +data(_, _, Mes, _) :: (Q)).
data_interdita(Id, ano, Ano, Q)
    :- data_id(Id, data(_, _, _, A)), atom(A),
       assert( nulo(A) ),
       assert( +data(_, _, _, Ano) :: (Q)).

% substituir : Old,New -> {V,F}
substituir(Old, New) :- retract(Old), evolucao(New).
substituir(Old, _)   :- assert(Old), !, fail.
