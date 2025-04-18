/* *************************** guidatore - automobile *************************** */
DROP TABLE IF EXISTS guidatore CASCADE;
DROP TABLE IF EXISTS automobile CASCADE;

CREATE TABLE guidatore(
	nome VARCHAR(20),
	cognome VARCHAR(20),
	nro_patente CHAR(10) PRIMARY KEY
);
CREATE TABLE automobile(
	targa CHAR(7) PRIMARY KEY,
	marca TEXT,
	modello TEXT,
	guidatore CHAR(10) REFERENCES guidatore(nro_patente)
);

INSERT INTO guidatore VALUES ('Mario','Rossi','VR2030020Y');
INSERT INTO guidatore VALUES ('Carlo','Bianchi','PZ1012436B');
INSERT INTO guidatore VALUES ('Marco','Neri','AP4544442R');

INSERT INTO automobile VALUES ('KB574WW','Fiat','Punto','VR2030020Y');
INSERT INTO automobile VALUES ('GA652FF','Fiat','Panda','VR2030020Y');
INSERT INTO automobile VALUES ('BJ747XX','Lancia','Ypsilon','PZ1012436B');
INSERT INTO automobile VALUES ('ZB421JJ','Fiat','Uno',null);

-- Estrarre i guidatori con le automobili loro associate, mantenendo anel risultato anche i guidatori
-- senza automobile
/*SELECT g.*,targa,marca,modello FROM guidatore g 
	LEFT JOIN automobile a ON g.nro_patente=a.guidatore;*/

-- Estrarre i guidatori con le loro automobili associate, escludendo i guidatori senza automobili 
/*SELECT g.*,targa,marca,modello FROM guidatore g, automobile a
	WHERE g.nro_patente=a.guidatore; --(è una INNER JOIN)*/

-- Estrarre tutti i guidatori e tutte le auto, mostrando tutte le relazioni esistenti tra essi
SELECT g.*,targa,marca,modello FROM guidatore g
	FULL JOIN automobile a ON g.nro_patente=a.guidatore;