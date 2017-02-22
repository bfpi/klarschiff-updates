ALTER TABLE klarschiff_stadt_grenze
  ALTER COLUMN grenze TYPE geometry(MultiPolygon, 25833) USING ST_Multi(grenze);
ALTER TABLE klarschiff_stadtteil_grenze
  ALTER COLUMN grenze TYPE geometry(MultiPolygon, 25833) USING ST_Multi(grenze);
