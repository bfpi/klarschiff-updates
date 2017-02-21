UPDATE klarschiff_stadt_grenze SET grenze = ST_Multi(grenze);
UPDATE klarschiff_stadtteil_grenze SET grenze = ST_Multi(grenze);
