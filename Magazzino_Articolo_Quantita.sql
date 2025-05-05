DROP TABLE IF EXISTS Magazzino CASCADE;
DROP TABLE IF EXISTS Articolo CASCADE;
DROP TABLE IF EXISTS Quantita CASCADE;

CREATE TABLE Magazzino (
	codice CHAR(4) PRIMARY KEY,
	nome VARCHAR(20) NOT NULL,
	citta VARCHAR(20) NOT NULL
);

CREATE TABLE Articolo (
	codice CHAR(3) PRIMARY KEY,
	nome VARCHAR(20) NOT NULL,
	descrizione VARCHAR(50) NOT NULL
);

CREATE TABLE Quantita (
	magazzino CHAR(4),
	articolo CHAR(3),
	quantita INTEGER NOT NULL,
	PRIMARY KEY(magazzino,articolo),
	CONSTRAINT fk1 FOREIGN KEY (magazzino) REFERENCES Magazzino(codice),
	CONSTRAINT fk2 FOREIGN KEY (articolo) REFERENCES Articolo(codice)
);


INSERT INTO Magazzino VALUES ('M001', 'SuperMag1', 'Roma');
INSERT INTO Magazzino VALUES ('M002', 'Depot Nord', 'Milano');
INSERT INTO Magazzino VALUES ('M003', 'EmptyBox', 'Napoli'); -- Vuoto
INSERT INTO Magazzino VALUES ('M004', 'MegaStore', 'Torino');
INSERT INTO Magazzino VALUES ('M005', 'MiniHub', 'Bologna'); -- Vuoto

INSERT INTO Articolo VALUES ('AAA','Tastiera','Tastiera meccanica RGB');
INSERT INTO Articolo VALUES ('A02','Mouse','Mouse laser ergonomico');
INSERT INTO Articolo VALUES ('A03','Monitor','Monitor 27’’ IPS');
INSERT INTO Articolo VALUES ('A04','SSD','Solid State Drive 1TB'); -- Non assegnato
INSERT INTO Articolo VALUES ('A05','Router','Router Wi-Fi 6 dual band');
INSERT INTO Articolo VALUES ('A06','Hub USB','Hub USB 3.0 4 porte');
INSERT INTO Articolo VALUES ('A07','Webcam','Webcam HD 1080p'); -- Non assegnato

INSERT INTO Quantita VALUES ('M001','AAA', 50);
INSERT INTO Quantita VALUES ('M001','A02', 30);
INSERT INTO Quantita VALUES ('M002','AAA', 20);
INSERT INTO Quantita VALUES ('M002','A03', 10);
INSERT INTO Quantita VALUES ('M004','A05', 15);
INSERT INTO Quantita VALUES ('M004','A06', 25);



/* Trovare la città con il magazzino con meno merce
(si consideri esplicitamente che possono esistere magazzini vuoti). */
CREATE VIEW quantita_merce_magazzini_tmp AS
	SELECT codice, SUM(quantita) AS quantita_merce
		FROM Magazzino LEFT JOIN Quantita ON codice=magazzino
		GROUP BY codice;

CREATE VIEW quantita_merce_magazzini AS 
	SELECT 
		codice,
		CASE
			WHEN quantita_merce IS NULL THEN 0
			ELSE quantita_merce
		END
		FROM quantita_merce_magazzini_tmp;


SELECT DISTINCT citta
	FROM Magazzino JOIN quantita_merce_magazzini USING(codice)
	WHERE quantita_merce = (
		SELECT MIN(quantita_merce)
			FROM quantita_merce_magazzini
		);



/* Cambiare il codice dell'articolo AAA in BBB ipotizzando (i) che i vincoli di IR siano stati
 definiti con politica di reazione no action */
BEGIN; 
ALTER TABLE Quantita
	DROP CONSTRAINT fk2;
ALTER TABLE Quantita
	ADD CONSTRAINT fk2
		FOREIGN KEY (articolo) REFERENCES Articolo(codice)
			ON UPDATE CASCADE;
/* In questo modo se modifico (con UPDATE SET) il codice dell'articolo AAA in BBB 
con la politica CASCADE si modificherà il valore dell'articolo AAA per ogni tupla nell'associazione 
Quantita */
UPDATE Articolo
	SET codice = 'BBB'
	WHERE codice = 'AAA';

/* ripristino la politica NO ACTION */
ALTER TABLE Quantita
	DROP CONSTRAINT fk2;
ALTER TABLE Quantita
	ADD CONSTRAINT fk2
		FOREIGN KEY (articolo) REFERENCES Articolo(codice);
COMMIT;

/* Cambiare il codice dell'articolo AAA in BBB ipotizzando (i) che i vincoli di IR siano stati
 definiti con politic adi reazione no action e (ii) di non disporre dei privilegi per modificare lo
 schema. */
BEGIN; 
INSERT INTO Articolo (codice, nome, descrizione)
	SELECT 'BBB',nome,descrizione
		FROM Articolo
		WHERE codice='AAA';
/* In questo modo duplico l'articolo AAA come articolo BBB con le stesse proprietà e poi associo 
 questo a tutti i magazzini, lasciando AAA senza nessun magazzino */
UPDATE Quantita 
	SET articolo='BBB'
	WHERE articolo='AAA'; 
/* In questo modo non vi sono magazzini associati a articoli AAA e quindi DELETE (anche UPDATE) può essere
 eseguito senza restrizioni per la politica NO ACTION */
DELETE FROM Articolo
	WHERE codice='AAA';
COMMIT;

SELECT * 
	FROM Articolo JOIN Quantita ON codice=articolo;














