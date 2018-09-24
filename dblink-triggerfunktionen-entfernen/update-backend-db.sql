DROP TRIGGER IF EXISTS klarschiff_trigger_adresse ON klarschiff_vorgang CASCADE;
DROP FUNCTION IF EXISTS klarschiff_triggerfunction_adresse();

DROP TRIGGER IF EXISTS klarschiff_trigger_enum_vorgang_status ON klarschiff_enum_vorgang_status CASCADE;
DROP FUNCTION IF EXISTS klarschiff_triggerfunction_enum_vorgang_status();

DROP TRIGGER IF EXISTS klarschiff_trigger_enum_vorgang_typ ON klarschiff_enum_vorgang_typ CASCADE;
DROP FUNCTION IF EXISTS klarschiff_triggerfunction_enum_vorgang_typ();

DROP TRIGGER IF EXISTS klarschiff_trigger_geo_rss ON klarschiff_geo_rss CASCADE;
DROP FUNCTION IF EXISTS klarschiff_triggerfunction_geo_rss();

DROP TRIGGER IF EXISTS klarschiff_trigger_kategorie ON klarschiff_kategorie CASCADE;
DROP FUNCTION IF EXISTS klarschiff_triggerfunction_kategorie();

DROP TRIGGER IF EXISTS klarschiff_trigger_missbrauchsmeldung ON klarschiff_missbrauchsmeldung CASCADE;
DROP FUNCTION IF EXISTS klarschiff_triggerfunction_missbrauchsmeldung();

DROP TRIGGER IF EXISTS klarschiff_trigger_stadt_grenze ON klarschiff_stadt_grenze CASCADE;
DROP FUNCTION IF EXISTS klarschiff_triggerfunction_stadt_grenze();

DROP TRIGGER IF EXISTS klarschiff_trigger_stadtteil_grenze ON klarschiff_stadtteil_grenze CASCADE;
DROP FUNCTION IF EXISTS klarschiff_triggerfunction_stadtteil_grenze();

DROP TRIGGER IF EXISTS klarschiff_trigger_trashmail ON klarschiff_trashmail CASCADE;
DROP FUNCTION IF EXISTS klarschiff_triggerfunction_trashmail();

DROP TRIGGER IF EXISTS klarschiff_trigger_unterstuetzer ON klarschiff_unterstuetzer CASCADE;
DROP FUNCTION IF EXISTS klarschiff_triggerfunction_unterstuetzer();

DROP TRIGGER IF EXISTS klarschiff_trigger_verlauf ON klarschiff_verlauf CASCADE;
DROP FUNCTION IF EXISTS klarschiff_triggerfunction_verlauf();

DROP TRIGGER IF EXISTS klarschiff_trigger_vorgang ON klarschiff_vorgang CASCADE;
DROP FUNCTION IF EXISTS klarschiff_triggerfunction_vorgang();
