
SELECT COMPLETADO,COUNT(*) FROM CONTROL_SUSCRIPTORAS
WHERE REVISTA_ID=1
GROUP BY COMPLETADO;

SELECT COUNT(*) FROM ALTAS
WHERE CONTPER='SUS'
/


----
