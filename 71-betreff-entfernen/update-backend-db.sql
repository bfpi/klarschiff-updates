SET statement_timeout = 0;
SET client_encoding = 'UTF8';

UPDATE klarschiff_vorgang SET details = betreff || ': ' || details WHERE betreff IS NOT NULL AND length(trim(betreff)) > 0;

DELETE FROM klarschiff_enum_verlauf_typ WHERE id LIKE 'betreff%';
UPDATE klarschiff_enum_verlauf_typ SET id = 'beschreibung', text = 'beschreibung' WHERE id IN ('detail', 'details');
UPDATE klarschiff_enum_verlauf_typ SET id = 'beschreibungFreigabeStatus', text = 'beschreibungFreigabeStatus' WHERE id = 'detailsFreigabeStatus';
INSERT INTO klarschiff_enum_verlauf_typ(id, ordinal, text) VALUES ('fotowunsch', 1, 'fotowunsch');
INSERT INTO klarschiff_enum_verlauf_typ(id, ordinal, text) VALUES ('aufgabeStatus', 2, 'aufgabeStatus');

DELETE FROM klarschiff_verlauf WHERE typ LIKE 'betreff%';
UPDATE klarschiff_verlauf SET typ = 'beschreibung' WHERE typ IN ('detail', 'details');
UPDATE klarschiff_verlauf SET typ = 'beschreibungFreigabeStatus' WHERE typ = 'detailsFreigabeStatus';

ALTER TABLE klarschiff_vorgang RENAME COLUMN details TO beschreibung;
ALTER TABLE klarschiff_vorgang RENAME COLUMN details_freigabe_status TO beschreibung_freigabe_status;
ALTER TABLE klarschiff_vorgang DROP COLUMN betreff;
ALTER TABLE klarschiff_vorgang DROP COLUMN betreff_freigabe_status;

DROP TABLE klarschiff_enum_naehere_beschreibung_notwendig;
