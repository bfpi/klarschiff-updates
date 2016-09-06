UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend || ' (' || delegiert_an || ')' 
  WHERE delegiert_an IS NOT NULL AND length(trim(delegiert_an)) > 0;
