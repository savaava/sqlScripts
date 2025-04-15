/* *************************** impiegato - dipartimento *************************** */
DROP TABLE IF EXISTS impiegato CASCADE;
DROP TABLE IF EXISTS dipartimento CASCADE;

CREATE TABLE dipartimento(
	nome VARCHAR(20) PRIMARY KEY,
	indirizzo TEXT,
	citta TEXT
);

CREATE TABLE impiegato(
	nome VARCHAR(20),
	cognome VARCHAR(20),
	dipart VARCHAR(20) REFERENCES dipartimento(nome),
	ufficio INTEGER,
	stipendio REAL,
	citta TEXT,

	PRIMARY KEY (nome, cognome)
);

INSERT INTO dipartimento VALUES('Amministrazione','Via Tito Livio, 27','Milano');
INSERT INTO dipartimento VALUES('Produzione','P.le Lavater, 3','Torino');
INSERT INTO dipartimento VALUES('Distribuzione','Via Segre, 9','Roma');
INSERT INTO dipartimento VALUES('Direzione','Via Tito Livio, 27','Milano');
INSERT INTO dipartimento VALUES('Ricerca','Via Venosa, 6','Milano');

INSERT INTO impiegato VALUES('Mario','Rossi','Amministrazione',10,4500,'Milano');
INSERT INTO impiegato VALUES('Carlo','Bianchi','Produzione',20,3600,'Torino');
INSERT INTO impiegato VALUES('Giovanni','Verdi','Amministrazione',20,4000,'Roma');
INSERT INTO impiegato VALUES('Franco','Neri','Distribuzione',16,4500,'Napoli');
INSERT INTO impiegato VALUES('Carlo','Rossi','Direzione',14,8000,'Milano');
INSERT INTO impiegato VALUES('Gino','Rossi','Direzione',5,8000,'Genova');
INSERT INTO impiegato VALUES('Lorenzo','Gialli','Direzione',7,7300,'Genova');
INSERT INTO impiegato VALUES('Paola','Rosati','Amministrazione',75,4000,'Venezia');
INSERT INTO impiegato VALUES('Marco','Franco','Produzione',20,4600,'Roma');
INSERT INTO impiegato VALUES('Mario','Franco','Produzione',3,2300,'Venezia');


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



/* *************************** impiegato - dipartimento *************************** */
--SELECT * FROM dipartimento;

--SELECT * FROM impiegato;

-- Estrarre i nomi degli impiegati e le città del dipartimento in cui lavorano
/*SELECT impiegato.nome "Nome", cognome, dipartimento.citta "Città" 
	FROM impiegato, dipartimento
	WHERE impiegato.dipart=dipartimento.nome;*/
-- EQUIVALENTE:
/*SELECT i.nome "Nome", cognome, d.citta "Città" 
	FROM impiegato i JOIN dipartimento d
		ON dipart=d.nome;*/

-- Estrarre il nome degli impiegati che lavorano nell'ufficio 20 del dipartimento Amministrazione
/*SELECT nome,cognome FROM impiegato
	WHERE ufficio=20 AND dipart='Amministrazione';*/

-- Estrarre i nomi e cognomi degli impiegati che lavorano nel dipartimento Amministrazione o nel dip Produzione
/*SELECT nome,cognome FROM impiegato
	WHERE dipart IN ('Amministrazione','Produzione');*/

-- Estrarre i nomi degli impiegati "Rossi" che lavorano nei dipartimenti Amministrazione o Produzione
/*SELECT nome FROM impiegato
	WHERE dipart IN ('Amministrazione','Produzione') AND cognome='Rossi';*/

-- Estrarre gli impiegati che hanno un cognome che ha una o in seconda posizione e finisce per i
/*SELECT * FROM impiegato
	WHERE cognome LIKE '_o%i';*/

-- estrarre le città delle persone con cognome "Rossi", facendo comparire ogni città al più una volta
/*SELECT DISTINCT citta FROM impiegato
	WHERE cognome='Rossi';*/

-- Prelevo nome, cognome, ufficio di tutti gli impiegati che lavorano in Ricerca o Amministrazione o Direzione
/*SELECT i.nome, i.cognome, i.ufficio, d.nome "dipartimento" FROM impiegato i 
	JOIN dipartimento d ON i.dipart=d.nome
	WHERE d.nome IN ('Ricerca', 'Amministrazione', 'Direzione');*/

-- 17 Estrarre tutti gli impiegati che hanno lo stesso cognome e nome diverso del dipartimento Produzione
/*SELECT i1.nome,i1.cognome FROM impiegato i1, impiegato i2
	WHERE i1.dipart = 'Produzione' 
		AND i1.nome <> i2.nome
		AND i1.cognome = i2.cognome;*/

-- 18 Estrarre il nome e lo stipendio dei capi degli impiegati che guadagnano più di 40k


-- Prove mie
/*SELECT nome,stipendio FROM impiegato
	WHERE stipendio=(SELECT MAX(stipendio) FROM impiegato)
	ORDER BY nome DESC;*/

/*SELECT MAX(stipendio), AVG(stipendio) FROM impiegato;*/

/*SELECT dipart,AVG(stipendio) FROM impiegato
	GROUP BY dipart;*/


/* *************************** guidatore - automobile *************************** */
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












	