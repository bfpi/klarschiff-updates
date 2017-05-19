ALTER TABLE klarschiff_geo_rss
 ADD COLUMN probleme_unterkategorien character varying(255);
ALTER TABLE klarschiff_geo_rss
 ADD COLUMN ideen_unterkategorien character varying(255);

ALTER TABLE klarschiff_geo_rss
 RENAME COLUMN probleme_kategorien TO probleme_hauptkategorien;
ALTER TABLE klarschiff_geo_rss
 RENAME COLUMN ideen_kategorien TO ideen_hauptkategorien;
