Updates zur Strukturänderung im Rahmen von Ticket #27 - persönliche Startseite überarbeiten

1. Alte Backend-Anwendung stoppen und undeployen
2. Neue Backend-Anwendung deployen und starten
3. update-db.sql gegen die DB ausführen (nach dem deployen, da die DB-Spalten vom Backend erst angelegt werden müssen)
     Skript dauert einmalig sehr lange (pro 1000 Vorgänge ca. 75 Sekunden)

