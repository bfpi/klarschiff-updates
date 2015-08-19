SET statement_timeout = 0;
SET client_encoding = 'UTF8';

DROP VIEW klarschiff.klarschiff_wfs_tmpl;
DROP VIEW klarschiff.klarschiff_wfs;

ALTER TABLE klarschiff.klarschiff_vorgang RENAME COLUMN details TO beschreibung;
ALTER TABLE klarschiff.klarschiff_vorgang RENAME COLUMN details_freigegeben TO beschreibung_freigegeben;
ALTER TABLE klarschiff.klarschiff_vorgang RENAME COLUMN details_vorhanden TO beschreibung_vorhanden;
ALTER TABLE klarschiff.klarschiff_vorgang DROP COLUMN betreff;
ALTER TABLE klarschiff.klarschiff_vorgang DROP COLUMN betreff_freigegeben;
ALTER TABLE klarschiff.klarschiff_vorgang DROP COLUMN betreff_vorhanden;

ALTER TABLE klarschiff.klarschiff_kategorie DROP COLUMN naehere_beschreibung_notwendig;
ALTER TABLE klarschiff.klarschiff_kategorie DROP COLUMN aufforderung;

CREATE VIEW klarschiff.klarschiff_wfs AS 
  SELECT v.id,
    v.datum,
    to_char(v.datum, 'DD.MM.YYYY'::text)::character varying AS datum_erstellt,
    to_char(v.datum_statusaenderung, 'DD.MM.YYYY'::text)::character varying AS datum_statusaenderung,
    v.beschreibung,
    v.bemerkung,
    v.kategorieid,
    k.parent AS hauptkategorieid,
    v.the_geom::geometry(Point,25833) AS the_geom,
    v.titel,
    v.vorgangstyp,
    v.status,
    ( SELECT count(*) AS count
           FROM klarschiff.klarschiff_unterstuetzer u
          WHERE v.id = u.vorgang AND u.datum IS NOT NULL) AS unterstuetzer,
    v.foto_vorhanden,
    v.foto_freigegeben,
    v.foto_normal,
    v.foto_thumb,
    v.beschreibung_vorhanden,
    v.beschreibung_freigegeben,
    v.zustaendigkeit
   FROM klarschiff.klarschiff_vorgang v,
    klarschiff.klarschiff_kategorie k
  WHERE v.kategorieid = k.id AND v.status::text <> 'geloescht'::text AND v.archiviert <> true AND v.status::text <> 'duplikat'::text AND NOT (v.id IN ( SELECT m.vorgang
           FROM klarschiff.klarschiff_missbrauchsmeldung m
          WHERE m.datum_bestaetigung IS NOT NULL AND m.datum_abarbeitung IS NULL AND m.vorgang = v.id))
  ORDER BY v.datum DESC;

alter view klarschiff.klarschiff_wfs owner to klarschiff_frontend;

CREATE VIEW klarschiff.klarschiff_wfs_tmpl AS
  SELECT v.id,
    v.datum,
    v.beschreibung,
    v.bemerkung,
    v.kategorieid,
    k.name AS kategorie_name,
    v.hauptkategorieid,
    kh.name AS hauptkategorie_name,
    v.the_geom,
    v.titel,
    v.vorgangstyp,
    t.name AS vorgangstyp_name,
    v.status,
    s.name AS status_name,
    v.unterstuetzer,
    v.foto_vorhanden,
    v.foto_freigegeben,
    v.foto_normal,
    v.foto_thumb,
    v.beschreibung_vorhanden,
    v.beschreibung_freigegeben,
    v.zustaendigkeit
   FROM klarschiff.klarschiff_wfs v,
    klarschiff.klarschiff_status s,
    klarschiff.klarschiff_kategorie k,
    klarschiff.klarschiff_kategorie kh,
    klarschiff.klarschiff_vorgangstyp t
  WHERE v.status::text = s.id::text AND v.kategorieid = k.id AND v.hauptkategorieid = kh.id AND v.vorgangstyp::text = t.id::text;

alter view klarschiff.klarschiff_wfs_tmpl owner to klarschiff_frontend;

