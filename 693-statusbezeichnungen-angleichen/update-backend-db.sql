UPDATE klarschiff_verlauf set wert_alt = 'nicht lösbar' where wert_alt = 'wird nicht bearbeitet';
UPDATE klarschiff_verlauf set wert_neu = 'nicht lösbar' where wert_neu = 'wird nicht bearbeitet';

UPDATE klarschiff_verlauf set wert_alt = 'gelöst' where wert_alt = 'abgeschlossen';
UPDATE klarschiff_verlauf set wert_neu = 'gelöst' where wert_neu = 'abgeschlossen';

UPDATE klarschiff_enum_vorgang_status set id = 'nichtLoesbar', text = 'nicht lösbar' where id = 'wirdNichtBearbeitet';
UPDATE klarschiff_enum_vorgang_status set id = 'geloest', text = 'gelöst' where id = 'abgeschlossen';

UPDATE klarschiff_vorgang set status = 'nichtLoesbar' where status = 'wirdNichtBearbeitet';
UPDATE klarschiff_vorgang set status = 'geloest' where status = 'abgeschlossen';

alter table klarschiff_redaktion_kriterien rename COLUMN wirdnichtbearbeitet_ohne_statuskommentar TO nicht_loesbar_ohne_statuskommentar;
