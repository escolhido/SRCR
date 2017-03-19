% SRCR - TRABALHO 01

:- op(900, xfy, '::').

:- style_check(-discontiguous).

:- dynamic servico/4.
:- dynamic utente/4.
:- dynamic medico/4.
:- dynamic ato/5.

:- consult(invariantes).
:- consult(bc).

% Extensao do meta-predicado demo: Questao,Resposta -> {V,F}
demo(Questao, verdadeiro) :-
    Questao.
demo(Questao, falso) :-
    -Questao.
demo(Questao, desconhecido) :-
    nao(Questao),
    nao(-Questao).

% Extensao do meta-predicado nao: Questao -> {V,F}
nao(Questao) :-
    Questao, !, fail.
nao(_).


% insere : Q -> {V,F}
insere(Q) :- assert(Q).
insere(Q) :- retract(Q), !, fail.

% remove : Q -> {V,F}
remove(Q) :- retract(Q).

% testar : List -> {V,F}
testar([]).
testar([X | XS]) :- X, testar(XS).

concat([], []).
concat([X], X).
concat([L | LS], R) :-
      concat(LS, N),
      junta(L, N, R).

% unicos : List, List ->{V,F}
unicos([], []).
unicos([H | T],  R) :- member(H,T), unicos(T,R).
unicos([H | T], [H | R]):- not(member(H,T)), unicos(T, R).

% ----------------------------------------------------------------------------------

% sum : List,R -> {V,F}
sum([], 0).
sum([H | T], R) :-
    sum(T, N),
    R is H + N.

evolucao(Q) :-
    findall(I, +Q::I, L),
    insere(Q),
    testar(L).

involucao(Q) :-
     findall(I, -Q::I, L),
     testar(L),
     remove(Q).

% remove(Q) :- retract(Q).
% remove(Q) :- assert(Q), !, fail.



% ========== FUNCIONALIDADES ============

% Registar
registar(Q) :-
    evolucao(Q).

% Remover
remover(Q) :-
    involucao(Q).

% Devolve o Id de um utente/serviço/medico
getId(utente(I, _, _, _), I).
getId(servico(I, _, _, _), I).
getId(medico(I, _, _, _), I).

% Utente com o id Id
utente_id(Id, U) :-
    findall(utente(Id, Nome, I, M), utente(Id, Nome, I, M), [U | _]).

% Utentes com o nome Nome
utentes_nome(Nome, Utentes) :-
    findall(utente(Id, Nome, I, M), (utente(Id, Nome, I, M)), Utentes).

% Utentes com a idade Idade
utentes_idade(Idade, Utentes) :-
    findall(utente(Id, N, Idade, M), (utente(Id, N, Idade, M)), Utentes).

% Utentes com a morada Morada
utentes_morada(Morada, Utentes) :-
    findall(utente(Id, N, I, Morada), (utente(Id, N, I, Morada)), Utentes).

% Médico com id Id
medico_id(Id, Medico) :-
    findall(medico(Id, N, E, Ins), medico(Id, N, E, Ins), [Medico | _]).

% Médicos com nome Nome
medicos_nome(Nome, Medicos) :-
    findall(medico(Id, Nome, E, Ins), medico(Id, Nome, E, Ins), Medicos).

% Médicos com especialidade Esp
medicos_especialidade(Esp, Medicos) :-
    findall(medico(Id, N, Esp, Ins), medico(Id, N, Esp, Ins), Medicos).

% Instituicoes que prestam servicoes
instituicoes(Ins) :-
    findall(I, servico(_, _, I, _), L),
    unicos(L, Ins).

% Instituicao referida por um servico
instituicao_servico(servico(_, _, I, _), I).

% Serviço com id Id
servico_id(Id, Servico) :-
     findall(servico(Id, D, I, C), servico(Id, D, I, C), [ Servico | _ ]).

% Serviços de uma instituicao
servicos_instituicao(I, Servicos) :-
    findall(servico(Id, D, I, C), servico(Id, D, I, C), Servicos).

% Serviços de uma cidade
servicos_cidade(C, Servicos) :-
    findall(servico(Id, D, I, C), servico(Id, D, I, C), Servicos).

% Utentes de uma instituição
utentes_instituicao(In, Utentes) :-
    servicos_instituicao(In, Servicos),
    maplist(utentes_servico, Servicos, U),
    concat(U, Utentes).

% Utentes de um serviço
utentes_servico(servico(S, _, _, _), Utentes) :-
    findall(U, ato(_, U, S, _, _), Us),
    maplist(get_utente, Us, Utentes).

% Custo de um ato
custo_ato(ato(_, _, _, _, C), C).

% Atos de um dado Utente
atos_utente(U, Atos) :-
    findall(ato(Data, U, S, M, Custo), ato(Data, U, S, M, Custo), Atos).

% Atos de um dado Servico
atos_servico(S, Atos) :-
    findall(ato(Data, U, S, M, Custo), ato(Data, U, S, M, Custo), Atos).

% Atos de um dado Médico
atos_medico(M, Atos) :-
    findall(ato(Data, U, S, M, Custo), ato(Data, U, S, M, Custo), Atos).

% Atos de um dado Instituição
atos_instituicao(In, Atos) :-
    servicos_instituicao(In, Servicos),
    maplist(getId, Servicos, Ss),
    maplist(atos_servico, Ss, As),
    concat(As, Atos).
%    unicos(As, Atos).

% Servicos de um utente
servicos_utente(U, Servicos) :-
    findall(S, ato(_, U, S, _,  _), Ss),
    maplist(servico_id, Ss, Servicos).

% Instituições de um utente
instituicoes_utente(U, Instituicoes) :-
    servicos_utente(U, Servicos),
    maplist(instituicao_servico, Servicos, Instituicoes).

% Total de custos de um Utente
total_utente(Utente, Total) :-
    findall(C, ato(_, Utente, _, _, C), Cs),
    sum(Cs, Total).

% Total de custos de uma Instituição
total_instituicao(Instituicao, Total) :-
    atos_instituicao(Instituicao, Ss),
    maplist(custo_ato, Ss, Cs),
    sum(Cs, Total).

% Total de custos numa Data
total_data(Data, Total) :-
    findall(C, ato(Data, _, _, _, C), Cs),
    sum(Cs, Total).
