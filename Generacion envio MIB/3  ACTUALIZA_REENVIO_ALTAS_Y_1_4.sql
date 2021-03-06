SELECT MES_ENVIO,COUNT(*)
FROM MP_REENVIO
GROUP BY MES_ENVIO;

--SE SUSTITUYE EN MES_ENVIO (mes anterior, mes actual)
SELECT  MES_ENVIO, NO_REENVIOS_HECHOS ,COUNT(*)
FROM   MP_REENVIO
WHERE  MES_ENVIO IN('1811','1812')
GROUP BY  MES_ENVIO, NO_REENVIOS_HECHOS;

SELECT  MES_ENVIO, NO_REENVIOS_HECHOS , TO_CHAR(FECHA_ALTA_REENVIO,'RRRR-MM'), COUNT(*)
FROM   MP_REENVIO
WHERE  MES_ENVIO IN('1811','1812')
GROUP BY  MES_ENVIO, NO_REENVIOS_HECHOS, TO_CHAR(FECHA_ALTA_REENVIO,'RRRR-MM')
/

--SE SUSTITUYE EN MES_ENVIO Y LA FECHA DE REENVIO
SELECT COUNT(*) FROM MP_REENVIO
WHERE FECHA_ALTA_REENVIO BETWEEN '01/11/18' AND '30/11/18'
AND   MES_ENVIO='1811'
AND   NO_REENVIOS_HECHOS IS NULL;

--SE SUSTITUYE EL MES_ENVIO
SELECT COUNT(*) FROM MP_REENVIO
WHERE FECHA_ALTA_REENVIO BETWEEN '01/11/18' AND '30/11/18'
AND   MES_ENVIO IS NULL;

-- MES DE ENVIO ACTUAL Y FECHA DE ALTA MES ANTERIOR
UPDATE MP_REENVIO
SET MES_ENVIO='1812',NO_REENVIOS_HECHOS=NULL
WHERE FECHA_ALTA_REENVIO BETWEEN '01/11/18' AND '30/11/18'
AND   MES_ENVIO IS NULL
AND   NO_REENVIOS_HECHOS IS NULL;
COMMIT;

-- MES DE ENVIO ACTUAL Y FECHA 2 MESES ANTERIOR
UPDATE MP_REENVIO
SET MES_ENVIO='1812',NO_REENVIOS_HECHOS=NULL
WHERE FECHA_ALTA_REENVIO BETWEEN '01/10/18' AND '30/11/18'
AND   MES_ENVIO is NULL
AND   NO_REENVIOS_HECHOS IS NULL;

-- MES ANTERIOR
SELECT MES_ENVIO,NO_REENVIOS_HECHOS,COUNT(*)
FROM MP_REENVIO
WHERE  MES_ENVIO IS NOT NULL
AND    MES_ENVIO='1811'
GROUP BY MES_ENVIO,NO_REENVIOS_HECHOS;

SELECT MES_ENVIO,NO_REENVIOS_HECHOS,COUNT(*)
FROM MP_REENVIO
WHERE  MES_ENVIO IS NULL
GROUP BY MES_ENVIO,NO_REENVIOS_HECHOS;

--EJECUTAR LA INSERCION DE ARCHIVO 3.2
--EJECUTAR LA INSERCION DE ARCHIVO 3.2.1

---------------COMPROBACION DE INSERCION

SELECT NUM_COD,COUNT(*) FROM ALTAS
WHERE  CONTPER='2H'
GROUP BY NUM_COD;

--COMPROBACION
SELECT COUNT(*) FROM MP_REENVIO
WHERE FECHA_ALTA_REENVIO BETWEEN '01/11/18' AND '30/11/18'
AND MES_ENVIO ='1811';

--CAMBIAR MES DE ENVIO AL ANERIOR
SELECT NO_REENVIOS_HECHOS,COUNT(DISTINCT NO_CONSUMIDORA) FROM MP_REENVIO
WHERE NO_CONSUMIDORA IN (SELECT CON_ID FROM ALTAS
                         WHERE CONTPER='2H')
AND MES_ENVIO='1811'
GROUP BY NO_REENVIOS_HECHOS;

SELECT NO_REENVIOS_HECHOS,COUNT(DISTINCT NO_CONSUMIDORA) FROM MP_REENVIO
WHERE NO_CONSUMIDORA IN (SELECT CON_ID FROM ALTAS
                         WHERE CONTPER='2H')
AND MES_ENVIO='1811'
GROUP BY NO_REENVIOS_HECHOS;
