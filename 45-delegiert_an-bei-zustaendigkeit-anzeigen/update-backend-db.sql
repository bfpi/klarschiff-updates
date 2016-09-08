UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Deutsche Bahn AG' || ')' WHERE delegiert_an = 'db';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'EURAWASSER Nord GmbH' || ')' WHERE delegiert_an = 'eurawasser';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Ortsamt Mitte' || ')' WHERE delegiert_an = 'ortsamt_mitte';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Ortsamt Nordwest 1' || ')' WHERE delegiert_an = 'ortsamt_nordwest1';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Ortsamt Nordwest 2' || ')' WHERE delegiert_an = 'ortsamt_nordwest2';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Ortsamt Ost' || ')' WHERE delegiert_an = 'ortsamt_ost';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Ortsamt West' || ')' WHERE delegiert_an = 'ortsamt_west';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Deutsche Post AG' || ')' WHERE delegiert_an = 'post';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Rostocker Straßenbahn AG' || ')' WHERE delegiert_an = 'rsag';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Stadtentsorgung Rostock GmbH (Entsorgung)' || ')' WHERE delegiert_an = 'sr_entsorgung';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Stadtentsorgung Rostock GmbH (Elektroschrott)' || ')' WHERE delegiert_an = 'sr_eschrott';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Stadtentsorgung Rostock GmbH (Straßenreinigung; Winterdienst)' || ')' WHERE delegiert_an = 'sr_strassenreinigung';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Stadtwerke Rostock AG' || ')' WHERE delegiert_an = 'stadtwerke';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Deutsche Telekom AG' || ')' WHERE delegiert_an = 'telekom';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Veolia Umweltservice Nord GmbH' || ')' WHERE delegiert_an = 'veolia';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Verkehrstechnik' || ')' WHERE delegiert_an = 'verkehrstechnik';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'Arbeitsgruppe Verkehrskoordination' || ')' WHERE delegiert_an = 'vko-runde';
UPDATE klarschiff_vorgang SET zustaendigkeit_frontend = zustaendigkeit_frontend ||
  ' (' || 'WIRO &ndash; Wohnen in Rostock Wohnungsgesellschaft mbH' || ')' WHERE delegiert_an = 'wiro';