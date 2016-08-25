\echo 'Obsolete Triggerfunktion entfernen'
DROP FUNCTION klarschiff_triggerfunction_verlauf() CASCADE;

\echo 'Kategorien entfernen'
DELETE FROM klarschiff_kategorie_initial_zustaendigkeiten
  WHERE kategorie IN (128, 137, 138, 139, 140, 153, 154, 155, 156, 157, 158, 159, 160);

DELETE FROM klarschiff_kategorie
  WHERE id IN (128, 137, 138, 139, 140, 153, 154, 155, 156, 157, 158, 159, 160);

\echo 'Hauptkategorien anlegen'
INSERT INTO klarschiff_kategorie (id, naehere_beschreibung_notwendig, name, typ) VALUES (162, 'keine', 'Verkehr', 'idee');
  (167, 'keine', 'Aufenthalt', 'idee');
  (170, 'keine', 'Sport & Spiel', 'idee');
  (173, 'keine', 'Sonstiges', 'idee');

\echo 'Unterkategorien anlegen'
INSERT INTO klarschiff_kategorie (id, parent, naehere_beschreibung_notwendig, name) VALUES
  (163, 162, 'keine', 'Auto / Motorrad'),
  (164, 162, 'keine', 'Radfahren'),
  (165, 162, 'keine', 'Zu Fuß'),
  (166, 162, 'keine', 'ÖPNV'),
  (168, 167, 'keine', 'Öffentliche Plätze und Orte zum Verweilen'),
  (169, 167, 'keine', 'Brachen'),
  (171, 170, 'keine', 'Sportplätze'),
  (172, 170, 'keine', 'Spielplätze'),
  (174, 173, 'keine', 'Sonstiges');

\echo 'Sequenz aktualisieren'
UPDATE klarschiff_kategoriesequence SET sequence_next_hi_value = 175;

\echo 'Initiale Zuständigkeiten für neue Kategorien'
INSERT INTO klarschiff_kategorie_initial_zustaendigkeiten (kategorie, initial_zustaendigkeiten) VALUES
  (163, 'a60_stadtentwicklung'),
  (164, 'a60_stadtentwicklung'),
  (165, 'a60_stadtentwicklung'),
  (166, 'a60_stadtentwicklung'),
  (168, 'a60_stadtentwicklung'),
  (169, 'a60_stadtentwicklung'),
  (171, 'a60_stadtentwicklung'),
  (172, 'a60_stadtentwicklung'),
  (174, 'a60_stadtentwicklung');
