% SRCR - BASE DE CONHECIMENTO

:- ensure_loaded(main).

% utente : #IdUt, Nome, Idade, Morada -> {V,F,D}
utente(1 , "João Maria"         , 20,         "S. Vitor"    ).
utente(2 , "Manuel Sampaio"     , 49,         "S. Nicolau"  ).
utente(3 , "Alenquer Menezes"   , ut03_idade, "S. Mamede"   ).
utente(4 , "Mariana da Abadia"  , 73,         "St. Arcozelo").
utente(5 , ut05_nome            , ut05_idade, ut05_morada   ).
utente(6 , "Tiago Vasconcelos"  ,  8,         "Guimaraes"   ).
utente(7 , "Guilherme Fernades" , 10,         "Barcelos"    ).
utente(8 , "Joana Teixeira"     , 89,         "Guimaraes"   ).
utente(9 , ut09_nome            , 45,         "Alentejo"    ).
utente(10, "Alexandre Lopes"    , 50,         "Lisboa"      ).
utente(11, "Vitoria Alves"      , ut11_idade, "Guimaraes"   ).

excecao( utente(3, "Alenquer Menezes", Idade, "S. Mamede") )
    :- Idade >= 70,
       Idade =< 80.

excecao( utente(5, _, Idade, _) )
    :- cerca_de(70, Min, Max),
       Idade >= Min,
       Idade =< Max.

excecao( utente(9, Nome, _, _) )
    :- member(Nome, ["Maria", "Mariana"]).

excecao( utente(11, _, Idade, _) )
    :- proximo_de(14, Min, Max),
       Idade >= Min,
       Idade =< Max.

nulo(ut05_nome).
nulo(ut05_morada).

+utente(_, Nome, _, _) :: (
        findall(Nome, (utente(5, Nome, _, _), nao(nulo(Nome))), [])).

+utente(_, _, _, Morada) :: (
        findall(Morada, (utente(5, _, _, Morada), nao(nulo(Morada))), [])).

% servico : #IdServ, Descrição, Instituição, Cidade -> {V,F,D}
servico(1,  "Oftaumologia"      , "Santa Maria"                , "Braga"      ).
servico(2,  "Patologia Clinica" , "Santa Maria"                , "Braga"      ).
servico(3,  "Urologia"          , "HES"                        , "Braga"      ).
servico(4,  "Cardiologia"       , "Sao Cruz"                   , "Guimaraes"  ).
servico(5,  "Cirurgia"          , "Senhora da Oliveira"        , "Guimaraes"  ).
servico(6,  "Imagiologia"       , "Senhora da Oliveira"        , "Guimaraes"  ).
servico(7,  "Imuno-hemoterapia" , "Santa Casa da Misericordia" , "Riba de ave").
servico(8,  "Consulta Geral"    , "Senhora da Oliveira"        , "Guimaraes"  ).
servico(9,  "Reabilitacao"      , "IPO"                        , "Porto"      ).
servico(10, "Ortopedia"         , "Sao Cruz"                   , "Guimaraes"  ).
servico(11, "Cirurgia"          , "Santa Maria"                , "Braga"      ).
servico(12, "Oftaumologia"      , "Senhora da Oliveira"        , "Guimaraes"  ).

% data : Id, Dia, Mes, Ano -> {V, F, D}
data(1,  2,        4,  1993).
data(2,  6,        9,  2002).
data(3,  9,        7,  2007).
data(4,  dt04_dia, 1,  2010).
data(5,  28,       12, 2014).
data(7,  22,       9,  2016).
data(8,  12,       8,  2016).
data(9,  4,        9,  2016).
data(10, 25,       1,  2017).
data(11, 28,       2,  2017).

excecao( data(4, Dia, _, _) )
    :- quinzena(1, Min, Max),
       Dia >= Min,
       Dia =< Max.

% ato : Data, IdUt, IdServ, Custo -> {V,F, D}
ato(1,  1,  1, ato01_custo).
ato(2,  1,  1, 10         ).
ato(3,  2,  2, 15         ).
ato(4,  8,  2, 23         ).
ato(5,  2,  5, 16         ).
ato(6,  3,  4, 20         ).
ato(7,  4,  3, 10         ).
ato(8,  5,  9, 35         ).
ato(9,  7, 12, 26         ).
ato(10, 6, 10, 16         ).
ato(11, 7,  9, 10         ).
ato(11, 8,  7, 12         ).
ato(11, 8,  7, 12         ).
