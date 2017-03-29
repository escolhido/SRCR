% BASE DE CONHECIMENTO

% utente : Id,Nome,Idade,Morada -> {V,F}
utente(01, "Maria Gonçalves"   , 12, "Guimaraes").
utente(02, "Joao Cancelinha"   , 14, "Guimaraes").
utente(03, "Marco Aurelio"     , 31, "Guimaraes").
utente(04, "Alexandra Matos"   , 15, "Chaves"   ).
utente(05, "Marcelo Miranda"   , 20, "Guimaraes").
utente(06, "Tiago Vasconcelos" ,  8, "Guimaraes").
utente(07, "Guilherme Fernades", 10, "Barcelos" ).
utente(08, "Joana Teixeira"    , 89, "Guimaraes").
utente(09, "Ana Silva"         , 45, "Alentejo" ).
utente(10, "Alexandre Lopes"   , 50, "Lisboa"   ).
utente(11, "Vitoria Alves"     , 12, "Guimaraes").
utente(12, "Sofia Sampaio"     , 90, "Leiria"   ).
utente(13, "Maria Mendes"      , 25, "Porto"    ).
utente(14, "Vitoria Fonseca"   , 30, "Guimaraes").
utente(15, "Alexandra Batista" , 67, "Viana"    ).
utente(16, "Vitoria Mendes"    , 18, "Guimaraes").
utente(17, "Helena Dias"       , 23, "Mirandela").
utente(18, "Rui Teixeira"      , 34, "Guimaraes").
utente(19, "Ines Faria"        ,  2, "Chaves"   ).
utente(20, "Gonçalo Feio"      , 21, "Braga"    ).


% servico : Id, Descrição, Instituição, Cidade -> {V,F}
servico(01, "Oftaumologia"     , "Santa Maria"               , "Braga"      ).
servico(02, "Patologia Clinica", "Santa Maria"               , "Braga"      ).
servico(03, "Urologia"         , "HES"                       , "Braga"      ).
servico(04, "Cardiologia"      , "Sao Cruz"                  , "Guimaraes"  ).
servico(05, "Cirurgia"         , "Senhora da Oliveira"       , "Guimaraes"  ).
servico(06, "Imagiologia"      , "Senhora da Oliveira"       , "Guimaraes"  ).
servico(07, "Imuno-hemoterapia", "Santa Casa da Misericordia", "Riba de ave").
servico(08, "Consulta Geral"   , "Senhora da Oliveira"       , "Guimaraes"  ).
servico(09, "Reabilitacao"     , "IPO"                       , "Porto"      ).
servico(10, "Ortopedia"        , "Sao Cruz"                  , "Guimaraes"  ).
servico(11, "Cirurgia"         , "Santa Maria"               , "Braga"      ).
servico(12, "Oftaumologia"     , "Senhora da Oliveira"       , "Guimaraes"  ).


% ato : Data, IdUt, IdServ, IdMed, Custo -> {V,F}
ato("2015-01-01", 01, 01, 01, 00).
ato("2015-01-01", 01, 01, 01, 10).
ato("2015-01-02", 02, 02, 02, 15).
ato("2015-01-02", 08, 12, 06, 23).
ato("2015-01-02", 02, 05, 03, 16).
ato("2015-01-02", 03, 04, 03, 20).
ato("2015-01-03", 04, 03, 13, 10).
ato("2015-01-03", 05, 09, 07, 35).
ato("2015-01-03", 07, 12, 06, 26).
ato("2015-01-04", 06, 10, 08, 16).
ato("2015-01-04", 07, 09, 09, 10).
ato("2015-01-05", 08, 07, 12, 12).
ato("2015-01-05", 09, 06, 15, 25).
ato("2015-01-05", 10, 05, 14, 26).
ato("2015-01-06", 11, 08, 10, 30).
ato("2015-01-06", 11, 04, 03, 10).
ato("2015-01-07", 12, 08, 09, 45).
ato("2015-01-07", 12, 06, 08, 60).
ato("2015-01-08", 13, 04, 11, 40).
ato("2015-01-08", 14, 02, 04, 30).
ato("2015-01-08", 15, 07, 05, 12).
ato("2015-01-09", 16, 09, 03, 15).
ato("2015-01-09", 17, 10, 02, 16).
ato("2015-01-10", 18, 01, 01, 17).
ato("2015-01-10", 19, 02, 04, 09).
ato("2015-01-11", 20, 03, 05, 06).
ato("2015-01-11", 02, 09, 06, 00).
ato("2015-01-11", 01, 10, 07, 10).
ato("2015-01-12", 03, 05, 08, 05).
ato("2015-01-12", 04, 01, 01, 06).
ato("2015-01-13", 05, 07, 09, 30).
ato("2015-01-14", 06, 02, 10, 18).
ato("2015-01-14", 07, 08, 11, 35).
ato("2015-01-17", 08, 03, 05, 16).
ato("2015-01-19", 09, 04, 03, 03).
ato("2015-01-20", 11, 01, 01, 18).
ato("2015-01-20", 02, 11, 11, 30).
ato("2015-01-21", 18, 06, 12, 20).
ato("2015-01-21", 19, 05, 10, 23).
ato("2015-01-21", 05, 01, 14, 24).
ato("2015-01-23", 06, 08, 15, 38).
ato("2015-01-24", 14, 09, 09, 15).
ato("2015-01-26", 13, 10, 13, 46).
ato("2015-01-28", 12, 03, 13, 20).
ato("2015-01-29", 17, 06, 09, 30).
ato("2015-02-01", 18, 01, 01, 40).
ato("2015-02-02", 20, 02, 02, 20).
ato("2015-02-02", 20, 07, 02, 15).
ato("2015-02-02", 11, 08, 01, 20).
ato("2015-02-03", 02, 10, 03, 21).
ato("2015-02-03", 03, 09, 04, 23).
ato("2015-02-05", 06, 04, 04, 26).
ato("2015-02-06", 07, 05, 08, 09).
ato("2015-02-06", 20, 05, 08, 06).
ato("2015-02-16", 20, 11, 11, 34).
ato("2015-03-01", 05, 11, 11, 36).


% medico : Id, Nome, Especialização, [Instituições] -> {V, F}
medico(01, "Jose Sousa Martins", 01, ["HES", "Santa Maria"]                             ).
medico(02, "Antonio Egas Moniz", 02, ["Sao  Cruz", "Santa Maria"]                       ).
medico(03, "Garcia de Orta"    , 04, ["HES", "Sao Cruz"]                                ).
medico(04, "Maria Fernandes"   , 02, ["Santa Maria"]                                    ).
medico(05, "Inês Sampaio"      , 03, ["HES", "IPO"]                                     ).
medico(06, "Adriana Guedes"    , 12, ["Senhora da Oliveira", "Sao cruz"]                ).
medico(07, "Ricardo Esteves"   , 05, ["Senhora da Oliveira", "Sao Cruz"]                ).
medico(08, "Miguel Pinto"      , 08, ["Senhora da Oliveira"]                            ).
medico(09, "Martinho Aragão"   , 09, ["IPO","Santa Maria", "Santa Casa da Misericordia"]).
medico(10, "Sara Sousa"        , 10, ["Sao Cruz", "HES"]                                ).
medico(11, "Nuno Dias"         , 11, ["Santa Maria","Sao Cruz"]                         ).
medico(12, "Manuel Videira"    , 06, ["Senhora da Oliveira", "Santa Maria"]             ).
medico(13, "Jose Silva"        , 03, ["HES", "Senhora da Oliveira"]                     ).
medico(14, "Marcelo Lima"      , 07, ["Santa Casa da Misericordia", "Sao Cruz"]         ).
medico(15, "David Silva"       , 09, ["IPO"]                                            ).
