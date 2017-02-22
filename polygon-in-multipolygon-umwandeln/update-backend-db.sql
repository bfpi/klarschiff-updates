ALTER TABLE klarschiff_stadt_grenze SET DATA TYPE geometry(MultiPolygon, 25833) USING grenze = ST_Multi(grenze);
ALTER TABLE klarschiff_stadtteil_grenze SET DATA TYPE geometry(MultiPolygon, 25833) USING grenze = ST_Multi(grenze);
