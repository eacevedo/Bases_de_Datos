-- PARA EJECUTAR ES:
EXEC SP_CONTROL_INS_SUSCRICION (1,12)
-----------------------------------------
CREATE OR REPLACE PROCEDURE SP_CONTROL_INS_SUSCRICION (REVISTA NUMBER,TOTAL_ENVIOS NUMBER)
AS
CURSOR CTO_CUR IS

 SELECT CONCALT,NOMBRE_CAMPA�A,C.FECHA_REGISTRO,M.FECHA_ENVIO,AUTORIZACION_PAGO,NO_ADQUISIONES,REVISTA,0,TOTAL_ENVIOS,
 CONNOM, CONAP1,CONAP2,
 RTRIM (LTRIM(RTRIM(LTRIM(CONVIA || ' ' || CONNVIA || ' ' || DECODE (CONNUEX,'SN',NULL,CONNUEX,CONNUEX) )|| ' ' ||
  RTRIM(LTRIM(DECODE(CONEDIF,NULL,NULL,CONEDIF,'ED ' || CONEDIF) )|| ' ' ||
  DECODE (DECODE(CONEDIF,NULL,NULL,CONEDIF,'EDI') ||DECODE(CONNUIN,NULL,NULL,CONNUIN,'DEP'),NULL,NULL,'EDIDEP','DEPTO','DEP','-') ||
  ' ' || CONNUIN || ' ' || CONENTR ) ) )|| ' '|| DECODE(CONMANZ,NULL,NULL,CONMANZ, 'MZ '|| CONMANZ) || ' ' ||DECODE(CONLOTE,NULL,NULL,CONLOTE,'LT ' || CONLOTE)) DIRECCION,
 CONCOLO COLONIA,
 CONCPO || ' ' || CONPOB || ' ' ||  CONEDO || ' ' || CONOFCR POBLACION,CONPREF LADA ,TELEFONO
 FROM
 MP_PRMALTASM p, COMPRA_CONSUMIDOR_VDIRECTA c, CAMPANA_VENTA_DIRECTA v,MAIL_VENTA_DIRECTA M,MEDIO_RESPUESTA_SFERAMEX R
  WHERE P.CONCALT=M.COD_CONSUMIDOR
  AND   P.CONCALT=C.COD_CONSUMIDOR
  AND   M.COD_CAMPANA=C.COD_CAMPANA
  AND   M.COD_CONSUMIDOR=C.COD_CONSUMIDOR
  AND   M.COD_EJECUCION=C.COD_EJECUCION
  AND   M.COD_CAMPANA=V.COD_CAMPA�A
  AND   M.COD_EJECUCION=V.NO_EJECUCION
  AND   M.COD_RESPUESTA=R.COD_RESPUESTA(+)
  AND   M.COD_CAMPANA IN (SELECT COD_CAMPANA from  PROMOCIONES_VENTA_DIRECTA
                                           WHERE REVISTA_ID =REVISTA
                                            AND TIPO_SUSCRIPCION IN ('P','W'))
  AND  AUTORIZACION_PAGO='S'
  AND  FECHA_REGISTRO>='01/09/15';

 CTO_REC CTO_CUR%ROWTYPE;

 TOTAL_ENVIO NUMBER;

BEGIN

OPEN CTO_CUR;

  LOOP
   FETCH CTO_CUR INTO CTO_REC;
    EXIT WHEN CTO_CUR%NOTFOUND;

    BEGIN
    INSERT INTO CONTROL_SUSCRIPTORAS (ID,NOMBRE_CAMPA�A,FECHA_REGISTRO,FECHA_AUTORIZACION,AUTORIZACION,
                                      NO_SUSCRIPCIONES,REVISTA_ID,NO_ENVIOS_HECHOS,NO_ENVIOS_POR_HACER,
                                      AP_PATERNO,AP_MATERNO,NOMBRE,DIRECCION,COLONIA,POBLACION,LADA,TELEFONO,COMPLETADO)
    VALUES
     (CTO_REC.CONCALT,CTO_REC.NOMBRE_CAMPA�A,CTO_REC.FECHA_REGISTRO,CTO_REC.FECHA_ENVIO,
      CTO_REC.AUTORIZACION_PAGO,CTO_REC.NO_ADQUISIONES,REVISTA,0,TOTAL_ENVIOS,CTO_REC.CONAP1,CTO_REC.CONAP2,
      CTO_REC.CONNOM,CTO_REC.DIRECCION,CTO_REC.COLONIA,CTO_REC.POBLACION,CTO_REC.LADA,CTO_REC.TELEFONO,'N');

     EXCEPTION WHEN OTHERS THEN

           NULL;

  END;

END LOOP;

  CLOSE CTO_CUR;

      COMMIT;

END;


----