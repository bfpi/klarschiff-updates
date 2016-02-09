alter table klarschiff_vorgang add column status_datum timestamp;
update klarschiff_vorgang
set status_datum = (SELECT MAX(datum)
  FROM klarschiff_verlauf 
  WHERE typ IN ('status', 'erzeugt')
    AND vorgang = klarschiff_vorgang.id);
alter table klarschiff_vorgang alter column status_datum set not null;
