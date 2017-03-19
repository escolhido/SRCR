% ========== INVARIANTES ============

:- ensure_loaded(srcr).

% O Id do utente é único
+utente(Id, _, _, _) :: (
    findall( Id, (utente(Id, _, _, _)), S),
    length(S, 1) ).

% Utentes com Ids diferentes têm informação diferente
+utente(_, No, I, C) :: (
    findall( (No, I, C), (utente(_, No, I, C)), S),
    length(S, 1) ).

% O Id de um médico é único
+medico(Id, _, _, _) :: (
    findall(Id, medico(Id, _, _, _), S),
    length(S, 1) ).

% O Id do serviço é único
+servico(Id, _, _, _) :: (
    findall( Id, (servico(Id, _, _, _)), S),
    length(S, 1) ).

% Serviços com Ids diferentes têm informação diferente
+servico(_, D, I, C) :: (
    findall( (D, I, C), (servico(_, D, I, C)), S),
    length(S, 1) ).

% Cada ato é relativo a um utente que existe
+ato(_, U, _, _, _) :: (
    findall( U, (utente(U, _, _, _)), L),
    length(L, 1) ).

% Cada ato é relativo a um servico que existe
+ato(_, _, S, _, _) :: (
    findall( S, (servico(S, _, _, _)), L),
    length(L, 1) ).

% Cada ato é efetuado por um medico que existe
+ato(_, _, _, M, _) :: (
    findall( M, (medico(M, _, _, _)), L),
    length(L, 1) ).

% Um ato é único
+ato(D, U, S, M, C) :: (
    findall( (D, U, S, M, C), (ato(D, U, S, M, C)), L),
    length(L, 1) ).

% ====== REMOÇÃO =======

% Não é possível remover um serviço se houver atos com esse servico.
-servico(Id, _, _, _) :: (
    findall(Id, ato(_, _, Id, _, _), []) ).

% Não é possível remover um utente se houver atos com esse utente.
-utente(Id, _, _, _) :: (
    findall(Id, ato(_, Id, _, _, _), []) ).

% Não é possível remover um medico se houver atos com esse medico.
-medico(Id, _, _, _) :: (
    findall(Id, ato(_, _, _, Id, _), []) ).
