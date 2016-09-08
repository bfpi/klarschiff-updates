INSERT INTO klarschiff_enum_vorgang_typ (id, ordinal, text) VALUES ('tipp', 2, 'Tipp');

\echo 'Hauptkategorien'
INSERT INTO klarschiff_kategorie (id, naehere_beschreibung_notwendig, name, typ, parent, geloescht)
  VALUES (161, 'details', 'Gewerberecht', 'tipp', null, false);

\echo 'Unterkategorien'
INSERT INTO klarschiff_kategorie (id, naehere_beschreibung_notwendig, name, typ, parent, geloescht)
  VALUES (162, 'details', 'Rauchen in Gaststätten', null, 161, false);

INSERT INTO klarschiff_kategorie (id, naehere_beschreibung_notwendig, name, typ, parent, geloescht)
  VALUES (163, 'details', 'Fehlende Preisangaben', null, 161, false);

INSERT INTO klarschiff_kategorie (id, naehere_beschreibung_notwendig, name, typ, parent, geloescht)
  VALUES (164, 'details', 'Alkoholverkauf an Jugendliche', null, 161, false);

INSERT INTO klarschiff_kategorie (id, naehere_beschreibung_notwendig, name, typ, parent, geloescht)
  VALUES (165, 'details', 'Baustellen ohne Firmenschilder', null, 161, false);

INSERT INTO klarschiff_kategorie (id, naehere_beschreibung_notwendig, name, typ, parent, geloescht)
  VALUES (166, 'details', 'Spielhallen mit Jugendlichen', null, 161, false);

INSERT INTO klarschiff_kategorie (id, naehere_beschreibung_notwendig, name, typ, parent, geloescht)
  VALUES (167, 'details', 'Verdacht auf Schwarzarbeit', null, 161, false);

\echo 'Initiale Zuständigkeiten'
INSERT INTO klarschiff_kategorie_initial_zustaendigkeiten (kategorie, initial_zustaendigkeiten) VALUES (162, 'a32_gewerbe');
INSERT INTO klarschiff_kategorie_initial_zustaendigkeiten (kategorie, initial_zustaendigkeiten) VALUES (163, 'a32_gewerbe');
INSERT INTO klarschiff_kategorie_initial_zustaendigkeiten (kategorie, initial_zustaendigkeiten) VALUES (164, 'a32_gewerbe');
INSERT INTO klarschiff_kategorie_initial_zustaendigkeiten (kategorie, initial_zustaendigkeiten) VALUES (165, 'a32_gewerbe');
INSERT INTO klarschiff_kategorie_initial_zustaendigkeiten (kategorie, initial_zustaendigkeiten) VALUES (166, 'a32_gewerbe');
INSERT INTO klarschiff_kategorie_initial_zustaendigkeiten (kategorie, initial_zustaendigkeiten) VALUES (167, 'a32_gewerbe');

update klarschiff_kategoriesequence set sequence_next_hi_value = 167;
