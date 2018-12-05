CREATE OR REPLACE PROCEDURE   SP_INS_REENVIO_ALTAS_1_4
AS
CURSOR CTO_CUR IS
 SELECT CONCALT,CONNOM,CONAP1,CONAP2,CONVIA,CONNVIA,CONNUEX,CONNUIN,CONEDIF,
       CONMANZ,CONLOTE,CONCOLO,CONCPO,CONPOB,CONUHA,CONENTR,DUP,NO_REENVIOS_HECHOS,
       CONSUSCRIP,CONOFCR,CONEDO
FROM MP_PRMALTASM,MP_REENVIO
WHERE CONMAR=50
AND CONPRM=1
AND CONCALT=NO_CONSUMIDORA
AND MES_ENVIO='1811'  ----- VERIFICAR EL MES DE ENVIO----------
AND NO_REENVIOS_HECHOS BETWEEN 1 AND 3
AND CONNOM IS NOT NULL
AND CONAP1 IS NOT NULL
AND CONCPO IS NOT NULL
AND CONCOLO IS NOT NULL
AND CONPOB IS NOT NULL
AND CONSUSCRIP IS NULL
AND SUSPENCION_ENVIOS IS NULL;

 CTO_REC CTO_CUR%ROWTYPE;

BEGIN

OPEN CTO_CUR;

  LOOP
   FETCH CTO_CUR INTO CTO_REC;
    EXIT WHEN CTO_CUR%NOTFOUND;

 BEGIN

     INSERT INTO ALTAS(CON_ID,CONNOM,CONAP1,CONAP2,CONTIPO,CONNVIA,CONNUEX,CONNUIN,
                  CONEDIF,CONMANZ,CONLOTE,CONPOBA,CONCPO,CONMUNI,CONUHA,CONENTR,DUP,
                  NUM_COD,CONSUS,CONADM,CONEDO,CONTPER)
     VALUES (CTO_REC.CONCALT,CTO_REC.CONNOM,CTO_REC.CONAP1,CTO_REC.CONAP2,CTO_REC.CONVIA,
            CTO_REC.CONNVIA,CTO_REC.CONNUEX,CTO_REC.CONNUIN,CTO_REC.CONEDIF,
            CTO_REC.CONMANZ,CTO_REC.CONLOTE,CTO_REC.CONCOLO,CTO_REC.CONCPO,CTO_REC.CONPOB,CTO_REC.CONUHA,
            CTO_REC.CONENTR,CTO_REC.DUP,CTO_REC.NO_REENVIOS_HECHOS,CTO_REC.CONSUSCRIP,CTO_REC.CONOFCR,CTO_REC.CONEDO,'2H');

     EXCEPTION WHEN OTHERS THEN

           NULL;

  END;

END LOOP;

  CLOSE CTO_CUR;

      COMMIT;

END;
