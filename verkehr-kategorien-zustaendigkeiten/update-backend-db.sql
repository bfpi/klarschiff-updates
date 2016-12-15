
\echo 'Initiale Zuständigkeiten für vorhandene Kategorien korrigieren'
update klarschiff_kategorie_initial_zustaendigkeiten set initial_zustaendigkeiten = 'a66_bauhof' 
  where kategorie in (select id from klarschiff_kategorie where parent in (121, 129, 149) 
	and initial_zustaendigkeiten != 'a66_bauhof');

\echo 'Neue Kategorien anlegen'
INSERT INTO klarschiff_kategorie (id, naehere_beschreibung_notwendig, name, typ, parent, geloescht)
  VALUES(175, 'keine', 'Scherben auf Radweg', NULL, 121, false),
  (176, 'keine', 'Verkehrsführung ändern', NULL, 121, false),
  (177, 'keine', 'Wegweisung', NULL, 121, false),
  (178, 'keine', 'Einbahnstraßen', NULL, 149, false),
  (179, 'keine', 'Geschwindigkeitsreduktion', NULL, 149, false),
  (180, 'keine', 'Parkbeschilderung/-Markierung einführen/ändern', NULL, 149, false),
  (181, 'keine', 'Parkgebühren', NULL, 149, false),
  (182, 'keine', 'Parkplatz einrichten', NULL, 149, false),
  (183, 'keine', 'Parkverbot erlassen/aufheben', NULL, 149, false),
  (184, 'keine', 'Verkehrsführung ändern', NULL, 149, false),
  (185, 'keine', 'Begrünung', 'idee', NULL, false),
  (186, 'keine', 'Begrünung - neu anlegen', NULL, 185, false),
  (187, 'keine', 'Begrünung - verändern', NULL, 185, false);


\echo 'Sequenz aktualisieren'
UPDATE klarschiff_kategoriesequence SET sequence_next_hi_value = 188;

\echo 'Initiale Zuständigkeiten für neue Kategorien'
INSERT INTO klarschiff_kategorie_initial_zustaendigkeiten (kategorie, initial_zustaendigkeiten) VALUES
  (175, 'a66_bauhof'),
  (176, 'a66_bauhof'),
  (177, 'a66_bauhof'),
  (178, 'a66_bauhof'),
  (179, 'a66_bauhof'),
  (180, 'a66_bauhof'),
  (181, 'a66_bauhof'),
  (182, 'a66_bauhof'),
  (183, 'a66_bauhof'),
  (184, 'a66_bauhof'),
  (185, 'a66_bauhof'),
  (186, 'a66_bauhof'),
  (187, 'a66_bauhof');

\echo 'Vorgänge von zu löschenden Kategorien auf andere Kategorien ändern'
UPDATE klarschiff_vorgang set kategorie = 174 where id = 1178 and kategorie = 164;
UPDATE klarschiff_vorgang set kategorie = 134 where id = 1388 and kategorie = 165;
UPDATE klarschiff_vorgang set kategorie = 178 where id = 1306 and kategorie = 163;
UPDATE klarschiff_vorgang set kategorie = 184 where id = 1335 and kategorie = 163;
UPDATE klarschiff_vorgang set kategorie = 152 where id = 1251 and kategorie = 165;
UPDATE klarschiff_vorgang set kategorie = 179 where id = 1242 and kategorie = 163;
UPDATE klarschiff_vorgang set kategorie = 182 where id = 1336 and kategorie = 163;
UPDATE klarschiff_vorgang set kategorie = 174 where id = 1305 and kategorie = 164;
UPDATE klarschiff_vorgang set kategorie = 179 where id = 1267 and kategorie = 163;
UPDATE klarschiff_vorgang set kategorie = 177 where id = 1321 and kategorie = 164;
UPDATE klarschiff_vorgang set kategorie = 182 where id = 1358 and kategorie = 163;
UPDATE klarschiff_vorgang set kategorie = 174 where id = 1371 and kategorie = 164;
UPDATE klarschiff_vorgang set kategorie = 174 where id = 1192 and kategorie = 165;
UPDATE klarschiff_vorgang set kategorie = 180 where id = 1376 and kategorie = 163;
UPDATE klarschiff_vorgang set kategorie = 176 where id = 1389 and kategorie = 165;
UPDATE klarschiff_vorgang set kategorie = 176 where id = 1434 and kategorie = 164;

\echo 'Lösche Unbrauchbare Kategorien'
DELETE FROM klarschiff_kategorie_initial_zustaendigkeiten where kategorie in 
  (select id from klarschiff_kategorie where id = 162 or parent = 162);
DELETE FROM klarschiff_kategorie where id = 162 or parent = 162;

\echo 'Aktualisieren des Zuständigkeitenkataloges entsprechend der neuen Verwaltungsstruktur'
UPDATE klarschiff_kategorie_initial_zustaendigkeiten set initial_zustaendigkeiten = 'a30_rechtsamt' where initial_zustaendigkeiten = 'a32_ordnungsamt';
UPDATE klarschiff_kategorie_initial_zustaendigkeiten set initial_zustaendigkeiten = 'a30_bussgeldstelle' where initial_zustaendigkeiten = 'a32_bussgeldstelle';

\echo 'Umbennenen entsprechend der neuen Verwaltungsstruktur'
UPDATE klarschiff_redaktion_empfaenger set zustaendigkeit = 'a30_rechtsamt' where zustaendigkeit = 'a32_ordnungsamt';
UPDATE klarschiff_redaktion_empfaenger set zustaendigkeit = 'a30_bussgeldstelle' where zustaendigkeit = 'a32_bussgeldstelle';
UPDATE klarschiff_vorgang set zustaendigkeit = 'a30_rechtsamt' where zustaendigkeit = 'a32_ordnungsamt';
UPDATE klarschiff_vorgang set zustaendigkeit = 'a30_bussgeldstelle' where zustaendigkeit = 'a32_bussgeldstelle';
UPDATE klarschiff_vorgang_history_classes_history_classes set history_classes = 'a30_rechtsamt' where history_classes = 'a32_ordnungsamt';
UPDATE klarschiff_vorgang_history_classes_history_classes set history_classes = 'a30_bussgeldstelle' where history_classes = 'a32_bussgeldstelle';
UPDATE klarschiff_verlauf set wert_alt = 'a30_rechtsamt' where typ = 'zustaendigkeit' and wert_alt = 'a32_ordnungsamt';
UPDATE klarschiff_verlauf set wert_alt = 'a30_bussgeldstelle' where typ = 'zustaendigkeit' and wert_alt = 'a32_bussgeldstelle';
UPDATE klarschiff_verlauf set wert_neu = 'a30_rechtsamt' where typ = 'zustaendigkeit' and wert_neu = 'a32_ordnungsamt';
UPDATE klarschiff_verlauf set wert_neu = 'a30_bussgeldstelle' where typ = 'zustaendigkeit' and wert_neu = 'a32_bussgeldstelle';

