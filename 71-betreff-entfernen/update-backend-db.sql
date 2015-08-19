SET statement_timeout = 0;
SET client_encoding = 'UTF8';

UPDATE klarschiff_vorgang
SET details = betreff || ': ' || details
WHERE betreff IS NOT NULL AND LENGTH(TRIM(betreff)) > 0;

ALTER TABLE klarschiff_vorgang RENAME COLUMN details TO beschreibung;
ALTER TABLE klarschiff_vorgang RENAME COLUMN details_freigabe_status TO beschreibung_freigabe_status;
ALTER TABLE klarschiff_vorgang DROP COLUMN betreff;
ALTER TABLE klarschiff_vorgang DROP COLUMN betreff_freigabe_status;

DROP TABLE klarschiff_enum_naehere_beschreibung_notwendig;
