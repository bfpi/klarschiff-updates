SET statement_timeout = 0;
SET client_encoding = 'UTF8';

DROP VIEW IF EXISTS klarschiff.klarschiff_wfs_georss;
DROP VIEW IF EXISTS klarschiff.klarschiff_wfs_tmpl;
DROP VIEW IF EXISTS klarschiff.klarschiff_wfs;

ALTER TABLE klarschiff.klarschiff_vorgang RENAME COLUMN details TO beschreibung;
ALTER TABLE klarschiff.klarschiff_vorgang RENAME COLUMN details_freigegeben TO beschreibung_freigegeben;
ALTER TABLE klarschiff.klarschiff_vorgang RENAME COLUMN details_vorhanden TO beschreibung_vorhanden;
ALTER TABLE klarschiff.klarschiff_vorgang DROP COLUMN titel;
ALTER TABLE klarschiff.klarschiff_vorgang DROP COLUMN betreff_freigegeben;
ALTER TABLE klarschiff.klarschiff_vorgang DROP COLUMN betreff_vorhanden;

ALTER TABLE klarschiff.klarschiff_kategorie DROP COLUMN naehere_beschreibung_notwendig;
ALTER TABLE klarschiff.klarschiff_kategorie DROP COLUMN aufforderung;

CREATE OR REPLACE VIEW klarschiff.klarschiff_wfs AS 
  SELECT v.id,
    v.datum,
    to_char(v.datum, 'DD.MM.YYYY'::text)::character varying AS datum_erstellt,
    to_char(v.datum_statusaenderung, 'DD.MM.YYYY'::text)::character varying AS datum_statusaenderung,
    v.beschreibung,
    v.bemerkung,
    v.kategorieid,
    k.parent AS hauptkategorieid,
    v.the_geom::geometry(Point, 25833) AS the_geom,
    v.vorgangstyp,
    v.status,
    (SELECT count(*) AS count
      FROM klarschiff.klarschiff_unterstuetzer u
      WHERE v.id = u.vorgang AND u.datum IS NOT NULL
    ) AS unterstuetzer,
    v.foto_vorhanden,
    v.foto_freigegeben,
    v.foto_normal,
    v.foto_thumb,
    v.beschreibung_vorhanden,
    v.beschreibung_freigegeben,
    v.zustaendigkeit
  FROM klarschiff.klarschiff_vorgang v,
    klarschiff.klarschiff_kategorie k
  WHERE v.kategorieid = k.id AND v.status::text <> 'geloescht'::text AND v.archiviert <> true
    AND v.status::text <> 'duplikat'::text
    AND NOT v.id IN (
      SELECT m.vorgang
      FROM klarschiff.klarschiff_missbrauchsmeldung m
      WHERE m.datum_bestaetigung IS NOT NULL AND m.datum_abarbeitung IS NULL AND m.vorgang = v.id)
  ORDER BY v.datum DESC;

ALTER TABLE klarschiff.klarschiff_wfs OWNER TO klarschiff_frontend;

CREATE OR REPLACE VIEW klarschiff.klarschiff_wfs_georss AS 
  SELECT v.id AS meldung,
    initcap(v.vorgangstyp::text) AS typ,
    hk.name::text AS hauptkategorie,
    uk.parent::smallint AS hauptkategorie_id,
    uk.name::text AS unterkategorie,
    uk.id::smallint AS unterkategorie_id,
    CASE
      WHEN v.status::text = 'wirdNichtBearbeitet'::text THEN 'wird nicht bearbeitet'::text
      ELSE regexp_replace(v.status::text, '([A-Z])'::text, ' \1'::text, 'g'::text)
    END AS status,
    CASE
      WHEN (SELECT count(*) AS count
          FROM klarschiff.klarschiff_unterstuetzer u
          WHERE v.id = u.vorgang AND u.datum IS NOT NULL)::smallint > 0
        THEN (SELECT count(*) AS count
          FROM klarschiff.klarschiff_unterstuetzer u
          WHERE v.id = u.vorgang AND u.datum IS NOT NULL)::text
      ELSE 'bisher keine'::text
    END AS unterstuetzungen,
    CASE
      WHEN v.beschreibung IS NOT NULL AND v.beschreibung <> ''::text AND v.beschreibung_freigegeben IS TRUE AND v.beschreibung_vorhanden IS TRUE THEN v.beschreibung
      WHEN v.status::text = 'offen'::text AND v.beschreibung_vorhanden IS TRUE AND v.beschreibung_freigegeben IS FALSE THEN 'redaktionelle Prüfung ausstehend'::text
      WHEN v.status::text <> 'offen'::text AND v.beschreibung_vorhanden IS TRUE AND v.beschreibung_freigegeben IS FALSE THEN 'redaktionell nicht freigegeben'::text
      ELSE 'nicht vorhanden'::text
    END AS beschreibung,
    CASE
      WHEN v.foto_thumb IS NOT NULL AND v.foto_thumb::text <> ''::text AND v.foto_freigegeben IS TRUE AND v.foto_vorhanden IS TRUE
        THEN ((((('<br/><a href="http://klarschiff-hgw.de/fotos/'::text || v.foto_normal::text) ||
          '" target="_blank" title="große Ansicht öffnen…"><img src="http://klarschiff-hgw.de/fotos/'::text) || v.foto_thumb::text) ||
          '" alt="'::text) || v.foto_thumb::text) || '" /></a>'::text
      WHEN v.status::text = 'offen'::text AND v.foto_vorhanden IS TRUE AND v.foto_freigegeben IS FALSE THEN 'redaktionelle Prüfung ausstehend'::text
      WHEN v.status::text <> 'offen'::text AND v.foto_vorhanden IS TRUE AND v.foto_freigegeben IS FALSE THEN 'redaktionell nicht freigegeben'::text
      ELSE 'nicht vorhanden'::text
    END AS foto,
    CASE
      WHEN v.bemerkung IS NOT NULL AND v.bemerkung::text <> ''::text THEN v.bemerkung::text
      ELSE 'nicht vorhanden'::text
    END AS info_der_verwaltung,
    CASE
      WHEN to_char(v.datum::timestamp with time zone, 'TZ'::text) = 'CEST'::text
        THEN to_char(v.datum::timestamp with time zone, 'Dy, DD Mon YYYY HH24:MI:SS +0200'::text)
      ELSE to_char(v.datum::timestamp with time zone, 'Dy, DD Mon YYYY HH24:MI:SS +0100'::text)
    END AS datum,
    st_x(st_transform(v.the_geom, 4326))::text AS x,
    st_y(st_transform(v.the_geom, 4326))::text AS y,
    v.the_geom::geometry(Point, 25833) AS geometrie
   FROM klarschiff.klarschiff_vorgang v,
    klarschiff.klarschiff_kategorie hk,
    klarschiff.klarschiff_kategorie uk
  WHERE v.kategorieid = uk.id AND uk.parent = hk.id
    AND (v.status::text <> ALL (ARRAY['duplikat'::text, 'geloescht'::text])) AND v.archiviert IS NOT TRUE
    AND NOT v.id IN (
      SELECT m.vorgang
      FROM klarschiff.klarschiff_missbrauchsmeldung m
      WHERE m.datum_bestaetigung IS NOT NULL AND m.datum_abarbeitung IS NULL AND m.vorgang = v.id)
  ORDER BY v.datum DESC;

ALTER TABLE klarschiff.klarschiff_wfs_georss OWNER TO klarschiff_frontend;
