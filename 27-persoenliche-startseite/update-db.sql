SET statement_timeout = 0;

UPDATE klarschiff_vorgang set initiale_akzeptierte_zustaendigkeit = COALESCE(sub.prio1, sub.prio2, sub.prio3)
FROM
  (select 
    vo.id, 
    vo.zustaendigkeit as prio3,
    (select wert_neu from klarschiff_verlauf where vorgang = vo.id and typ = 'zustaendigkeit' and datum < 
      (select datum from klarschiff_verlauf where vorgang = vo.id and typ = 'zustaendigkeitAkzeptiert' 
        and wert_neu = 'akzeptiert' order by datum limit 1
      ) order by datum limit 1
    ) prio2,
    (select wert_alt from klarschiff_verlauf where vorgang = vo.id and typ = 'zustaendigkeit' and datum > 
      (select datum from klarschiff_verlauf where vorgang = vo.id and typ = 'zustaendigkeitAkzeptiert' 
        and wert_neu = 'akzeptiert' order by datum limit 1
      ) order by datum limit 1
    ) as prio1
  from klarschiff_vorgang vo 
  where vo.initiale_akzeptierte_zustaendigkeit is null 
  and vo.id in (
    select distinct (vorgang) 
      from klarschiff_verlauf 
      where typ = 'zustaendigkeitAkzeptiert'
    )
  ) as sub
WHERE klarschiff_vorgang.id = sub.id;
