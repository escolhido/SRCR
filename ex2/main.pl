% SRCR - Trabalho 02

:- style_check(-discontiguous).

:- op(900, xfy, '::').

:- dynamic utente/4.
:- dynamic ato/4.
:- dynamic servico/4.

:- include(meta).
:- include(conhecimento).
:- include(invariantes).

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

% data : Id, Dia, Mes, Ano -> {V, F, D}
-data(Id, Dia, Mes, Ano)
    :- nao( data(Id, Dia, Mes, Ano) ),
       nao( excecao( data(Id, Dia, Mes, Ano) ) ).


valid_data(_, Dia, Mes, _)
    :- Dia > 0, Dia =< 31,
       Mes > 0, Mes =< 12.

%
% PREDICADOS AUXILIARES
%

proximo_de(X, Min, Max)
    :- Min is X * 0.9,
       Max is X * 1.1.

cerca_de(X, Min, Max)
    :- Min is X * 0.8,
       Max is X * 1.2.

quinzena(X, Min, Max)
    :- Min is (X-1) * 15 + 1,
       Max is X * 15.
