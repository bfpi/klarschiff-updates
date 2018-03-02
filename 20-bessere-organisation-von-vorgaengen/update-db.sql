SET statement_timeout = 0;
SET client_encoding = 'UTF8';

ALTER TABLE klarschiff_vorgang
  ADD COLUMN letzter_bearbeiter character varying(255);

UPDATE klarschiff_vorgang
  SET letzter_bearbeiter=verlauf.nutzer
FROM (SELECT distinct on (vorgang) vorgang, nutzer from klarschiff_verlauf v where nutzer is not null order by vorgang, datum desc) AS verlauf
  WHERE klarschiff_vorgang.id=verlauf.vorgang;
