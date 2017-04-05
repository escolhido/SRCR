% SRCR - Trabalho 02

:- dynamic utente/4.
:- dynamic ato/4.
:- dynamic servico/4.

:- consult(meta).

%
% EXTENSÃO DOS PREDICADOS
%

% utente : #IdUt, Nome, Morada, Idade -> {V,F,D}
-utente(IdUt, Nome, Morada, Idade)
    :- nao( utente(IdUt, Nome, Morada, Idade) ),
       nao( excecao( utente(IdUt, Nome, Morada, Idade) ) ).

% servico : #IdServ, Descrição, Instituição, Cidade -> {V,F,D}
-servico(IdServ, Desc, Inst, Cidade)
    :- nao( servico(IdServ, Desc, Inst, Cidade) ),
       nao( excecao( servico(IdServ, Desc, Inst, Cidade) ) ).

% ato : Data, #IdUt, #IdServ, Custo -> {V,F,D}
-ato(Data, IdUt, IdServ, Custo)
    :- nao( ato(Data,IdUt, IdServ, Custo) ),
       nao( excecao( ato(Data,IdUt, IdServ, Custo) ) ).

%
% PREDICADOS AUXILIARES
%

cercade(X, Min, Max) :-
    Min is X * 0.8,
    Max is X * 1.2.
