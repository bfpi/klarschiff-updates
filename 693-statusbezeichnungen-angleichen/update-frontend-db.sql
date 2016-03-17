INSERT INTO klarschiff.klarschiff_status(id, name, nid) VALUES ('nichtLoesbar', 'nicht lösbar', 3);
INSERT INTO klarschiff.klarschiff_status(id, name, nid) VALUES ('geloest', 'gelöst', 5);

UPDATE klarschiff.klarschiff_vorgang set status = 'nichtLoesbar' where status = 'wirdNichtBearbeitet';
UPDATE klarschiff.klarschiff_vorgang set status = 'geloest' where status = 'abgeschlossen';

CREATE OR REPLACE VIEW klarschiff.klarschiff_wfs_georss AS 
  SELECT v.id AS meldung,
    initcap(v.vorgangstyp::text) AS typ,
    hk.name::text AS hauptkategorie,
    uk.parent::smallint AS hauptkategorie_id,
    uk.name::text AS unterkategorie,
    uk.id::smallint AS unterkategorie_id,
        CASE
            WHEN v.status::text = 'nichtLoesbar'::text THEN 'nicht lösbar'::text
            ELSE regexp_replace(v.status::text, '([A-Z])'::text, ' \1'::text, 'g'::text)
        END AS status,
        CASE
            WHEN v.bemerkung IS NOT NULL AND v.bemerkung::text <> ''::text THEN v.bemerkung::text
            ELSE 'nicht vorhanden'::text
        END AS statusinformation,
        CASE
            WHEN (( SELECT count(*) AS count
               FROM klarschiff.klarschiff_unterstuetzer u
              WHERE v.id = u.vorgang AND u.datum IS NOT NULL))::smallint > 0 THEN (( SELECT count(*) AS count
               FROM klarschiff.klarschiff_unterstuetzer u
              WHERE v.id = u.vorgang AND u.datum IS NOT NULL))::text
            ELSE 'bisher keine'::text
        END AS unterstuetzungen,
        CASE
            WHEN v.beschreibung IS NOT NULL AND v.beschreibung <> ''::text AND v.beschreibung_freigegeben IS TRUE AND v.beschreibung_vorhanden IS TRUE THEN v.beschreibung
            WHEN v.status::text = 'offen'::text AND v.beschreibung_vorhanden IS TRUE AND v.beschreibung_freigegeben IS FALSE THEN 'redaktionelle Prüfung ausstehend'::text
            WHEN v.status::text <> 'offen'::text AND v.beschreibung_vorhanden IS TRUE AND v.beschreibung_freigegeben IS FALSE THEN 'redaktionell nicht freigegeben'::text
            ELSE 'nicht vorhanden'::text
        END AS beschreibung,
        CASE
            WHEN v.foto_thumb IS NOT NULL AND v.foto_thumb::text <> ''::text AND v.foto_freigegeben IS TRUE AND v.foto_vorhanden IS TRUE THEN ((((('<br/><a href="http://www.klarschiff-hro.de/fotos/'::text || v.foto_normal::text) || '" target="_blank" title="große Ansicht öffnen…"><img src="http://www.klarschiff-hro.de/fotos/'::text) || v.foto_thumb::text) || '" alt="'::text) || v.foto_thumb::text) || '" /></a>'::text
            WHEN v.status::text = 'offen'::text AND v.foto_vorhanden IS TRUE AND v.foto_freigegeben IS FALSE THEN 'redaktionelle Prüfung ausstehend'::text
            WHEN v.status::text <> 'offen'::text AND v.foto_vorhanden IS TRUE AND v.foto_freigegeben IS FALSE THEN 'redaktionell nicht freigegeben'::text
            ELSE 'nicht vorhanden'::text
        END AS foto,
        CASE
            WHEN to_char(v.datum::timestamp with time zone, 'TZ'::text) = 'CEST'::text THEN to_char(v.datum::timestamp with time zone, 'Dy, DD Mon YYYY HH24:MI:SS +0200'::text)
            ELSE to_char(v.datum::timestamp with time zone, 'Dy, DD Mon YYYY HH24:MI:SS +0100'::text)
        END AS datum,
    st_x(st_transform(v.the_geom, 4326))::text AS x,
    st_y(st_transform(v.the_geom, 4326))::text AS y,
    v.the_geom::geometry(Point,25833) AS geometrie
   FROM klarschiff.klarschiff_vorgang v,
    klarschiff.klarschiff_kategorie hk,
    klarschiff.klarschiff_kategorie uk
  WHERE v.kategorieid = uk.id AND uk.parent = hk.id AND (v.status::text <> ALL (ARRAY['duplikat'::text, 'geloescht'::text])) AND v.archiviert IS NOT TRUE AND NOT (v.id IN ( SELECT m.vorgang
           FROM klarschiff.klarschiff_missbrauchsmeldung m
          WHERE m.datum_bestaetigung IS NOT NULL AND m.datum_abarbeitung IS NULL AND m.vorgang = v.id))
  ORDER BY v.datum DESC;
