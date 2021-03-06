alter table klarschiff_vorgang add column trust smallint;

/* E-Mail-Adressen der Mitarbeiter in den Außendienstgruppen eintragen */
update klarschiff_vorgang set trust = 2 where autor_email in ('max.mustermann@rostock.de');
update klarschiff_vorgang set trust = 1 where trust IS NULL AND autor_email like ('%@rostock.de');
update klarschiff_vorgang set trust = 0 where trust IS NULL;

alter table klarschiff_vorgang alter column trust set not null;
