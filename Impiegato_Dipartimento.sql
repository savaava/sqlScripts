-- ===================================================================
-- DROP delle tabelle
-- ===================================================================

DROP TABLE IF EXISTS impiegato CASCADE;
DROP TABLE IF EXISTS dipartimento CASCADE;

-- ===================================================================
-- CREATE delle tabelle
-- ===================================================================

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

-- ===================================================================
-- INSERT nelle tabelle
-- ===================================================================

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


-- ===================================================================
-- ESERCITAZIONI
-- ===================================================================

-- Estrarre i nomi degli impiegati e le città del dipartimento in cui lavorano
/*SELECT impiegato.nome "Nome", cognome, dipartimento.citta "Città" 
	FROM impiegato, dipartimento
	WHERE impiegato.dipart=dipartimento.nome;*/
	
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



/* estrarre le città delle persone con cognome "Rossi", facendo comparire ogni città al più una volta */
/*SELECT DISTINCT citta FROM impiegato
	WHERE cognome='Rossi';*/



/* Prelevo nome, cognome, ufficio di tutti gli impiegati che lavorano in Ricerca o Amministrazione o Direzione */
/*SELECT i.nome, i.cognome, i.ufficio, d.nome "dipartimento" FROM impiegato i 
	JOIN dipartimento d ON i.dipart=d.nome
	WHERE d.nome IN ('Ricerca', 'Amministrazione', 'Direzione');*/



/*17 Estrarre tutti gli impiegati che hanno lo stesso cognome e nome diverso, del dipartimento Produzione*/

/*SELECT i1.nome,i1.cognome
	FROM impiegato i1,impiegato i2
	WHERE i1.cognome=i2.cognome 
		AND i1.nome<>i2.nome
		AND i1.dipart='Produzione';*/
		
/*SELECT i1.nome,i1.cognome
	FROM impiegato i1 JOIN impiegato i2 ON i1.cognome=i2.cognome
	WHERE i1.nome<>i2.nome
		AND i1.dipart='Produzione';*/

/*SELECT i1.nome,i1.cognome
	FROM impiegato i1
	WHERE i1.cognome IN (
		SELECT i1.cognome FROM impiegato i2 
			WHERE i1.cognome=i2.cognome 
				AND i1.nome<>i2.nome
				AND i1.dipart='Produzione'
	);*/

	

/* 21 Estrarre il numero di diversi valori dell'attributo Stipendio fra tutte le righe di impiegato */
SELECT COUNT(DISTINCT stipendio)
	FROM impiegato;



/* 22 estrarre il numero di righe che possiefono un valore non nullo per l'attributo Nome */
SELECT COUNT(nome)
	FROM impiegato;
SELECT COUNT(ALL nome)
	FROM impiegato;



/* 23 Estrarre la somma degli stipendi del dipartimento Amministrazione */
SELECT SUM(stipendio) stipendio_totale
	FROM impiegato
	WHERE dipart='Amministrazione';



/* 24+ stipendio minimo, massimo e medio tra tutti gli impiegati per ogni specifico dipartimento */
SELECT 
	MIN(stipendio) AS stipendio_minimo,
	MAX(stipendio) AS stipendio_massimo,
	AVG(stipendio) AS stipendio_medio,
	dipart
	FROM impiegato
	GROUP BY dipart;



/* 25 Estrarre il massimo stipendio tra quelli degli impiegati che lavorano in un dipartimento con sede a Milano */
SELECT 
	MAX(stipendio) AS stipendio_massimo	
	FROM impiegato i JOIN dipartimento d 
		ON i.dipart=d.nome
	WHERE d.citta='Milano';
/* 25+ Estrarre il massimo stipendio, e il full name dell'impiegato a cui appartiene,
tra quelli degli impiegati che lavorano in un dipartimento con sede a Milano */
SELECT 
	i1.stipendio AS stipendio_massimo_milano,
	CONCAT(i1.nome, ' ', i1.cognome) AS full_name_impiegato
	FROM impiegato i1 JOIN dipartimento d1 ON i1.dipart=d1.nome
	WHERE d1.citta='Milano' AND i1.stipendio=(
		SELECT MAX(stipendio)	
			FROM impiegato i2 JOIN dipartimento d2 ON i2.dipart=d2.nome
			WHERE d2.citta='Milano'
	);



/* 30 Restituire dipartimenti, numero di impiegati di ciascun dipartimento e la città in cui il dip ha sede */

SELECT 
	d.nome AS nome_dipartimento,
	d.citta,
	COUNT(i.nome) AS numero_impiegati_afferenti
	FROM dipartimento d LEFT JOIN impiegato i 
		ON d.nome=i.dipart
	GROUP BY d.nome,d.citta;
	
SELECT 
	d.nome AS nome_dipartimento,
  	d.citta,
  	(SELECT COUNT(*)
    	FROM impiegato i
    	WHERE i.dipart = d.nome
  	) AS numero_impiegati
	FROM dipartimento d;



/* 31 Estrarre i dipartimenti che spendono più di 100mila euro in stipendi */

SELECT 
	dipart,
	SUM(stipendio) AS somma_stipendi
	FROM impiegato
	GROUP BY dipart
	HAVING (SUM(stipendio)>100000);



/* 32 Estrarre i dipartimenti per cui la media degli stipendi degli impiegati che lavorano nell'ufficio 20 è >25mila */
SELECT 
	dipart,
	AVG(stipendio) AS media_stipendi
	FROM impiegato
	WHERE ufficio=20
	GROUP BY dipart
	HAVING AVG(stipendio)>25000;



/* 34 Estrarre i nomi e cognomi di tutti gli impiegati, eccetto quelli appartenenti al dipartimento Amministrazione,
mantenendo i duplicati */
SELECT nome 
	FROM impiegato
	WHERE dipart <> 'Amministrazione'
UNION ALL
SELECT cognome AS nome 
	FROM impiegato
	WHERE dipart <> 'Amministrazione';



/* 37 Estrarre gli impiegati che lavorano in dipartimenti situati a Firenze */
SELECT i.nome,cognome
	FROM impiegato i JOIN dipartimento d 
		ON i.dipart=d.nome
	WHERE d.citta='Torino';

SELECT i.nome, i.cognome
	FROM impiegato i
	WHERE dipart IN ( -- IN  oppure  = ANY
		SELECT d.nome FROM dipartimento d
			WHERE d.citta='Torino'
	);



/* 38 Trovare gli impiegati che hanno lo stesso nome di un impiegato del dipartimento Produzione */
SELECT i1.nome,i1.cognome
	FROM impiegato i1
	WHERE i1.nome = ANY (
		SELECT i2.nome 
			FROM impiegato i2
			WHERE i2.dipart='Produzione'
	);

SELECT i1.nome, i1.cognome
	FROM impiegato i1, impiegato i2
	WHERE i1.nome=i2.nome AND i2.dipart='Produzione';

SELECT i1.nome, i2.cognome
	FROM impiegato i1 JOIN impiegato i2 USING(nome,cognome)
	WHERE i2.dipart='Produzione';



/* 40 Estrarre i dipartimenti in cui non lavorano persone di cognome Rossi */
SELECT dipart
	FROM impiegato
EXCEPT
SELECT dipart
	FROM impiegato
	WHERE cognome='Rossi';

SELECT DISTINCT dipart
	FROM impiegato
	WHERE dipart NOT IN( -- oppure <> ALL
		SELECT dipart FROM impiegato WHERE cognome='Rossi'
	);



/* 42-43 Estrarre il dipartimento dell'impiegato che guadadna lo stipendio massimo */
SELECT DISTINCT dipart
	FROM impiegato
	WHERE stipendio = ( -- oppure = ANY
		SELECT MAX(stipendio)
			FROM impiegato
	);

SELECT DISTINCT dipart
	FROM impiegato
	WHERE stipendio >= ALL (
		SELECT stipendio FROM impiegato 
	);



/* 44 Estrarre gli impiegati che afferiscono al dipartimento Produzione o a un dipartimento che risiede nella stessa
citta del dipartimento produzione */
SELECT 
	CONCAT(nome, ' ', cognome) AS full_name_impiegato,
	dipart
	FROM impiegato
	WHERE dipart='Amministrazione' OR dipart = ANY (
		SELECT nome FROM dipartimento 
			WHERE citta=(SELECT citta FROM dipartimento WHERE nome='Amministrazione')
	);













	