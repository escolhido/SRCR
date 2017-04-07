% SRCR - Invariantes

:- ensure_loaded(main).

% O Id do utente é único
+utente(Id, _, _, _) :: (
     findall(Id, (utente(Id, _, _, _)), L),
     length(L, 1)).

% Utentes com Ids diferentes têm informação diferente
+utente(_, No, I, C) :: (
    findall((No, I, C), (utente(_, No, I, C)), L),
    length(L, 1)).

% O Id do serviço é único
+servico(Id, _, _, _) :: (
    findall(Id, (servico(Id, _, _, _)), L),
    length(L, 1)).

% Serviços com Ids diferentes têm informação diferente
+servico(_, D, I, C) :: (
    findall((D, I, C), (servico(_, D, I, C)), L),
    length(L, 1)).

% Cada ato é relativo a uma data que existe
+ato(D, _, _, _) :: (
    findall(D, (data(D, _, _, _)), L),
    length(L, 1)).

% Cada ato é relativo a um utente que existe
+ato(_, U, _, _) :: (
    findall(U, (utente(U, _, _, _)), L),
    length(L, 1)).

% Cada ato é relativo a um servico que existe
+ato(_, _, S, _) :: (
    findall(S, (servico(S, _, _, _)), L),
    length(L, 1)).

% O ID de uma data é único
+data(Id, _, _, _) :: (
    findall(Id, date(Id, _, _, _), L),
    length(L, 1)).

% Datas com IDs diferentes têm dados diferentes
+data(_, D, M, A) :: (
    findall((D, M, A), data(_, D, M, A), L),
    length(L, 1)).

% ====== REMOÇÃO =======

% Não é possível remover um serviço se houver atos com esse servico.
-servico(Id, _, _, _) :: (findall(Id, ato(_, _, Id, _, _), [])).

% Não é possível remover um utente se houver atos com esse utente.
-utente(Id, _, _, _) :: (findall(Id, ato(_, Id, _, _), [])).

% Não é possível remover uma data se houver atos que ocorreram nessa data.
-data(Id, _, _, _) :: (findall(Id, data(Id, _, _, _), [])).
