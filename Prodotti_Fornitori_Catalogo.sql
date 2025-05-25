-- ===================================================================
-- DROP delle tabelle
-- =================================================================== 
DROP TABLE IF EXISTS Fornitori CASCADE; 
DROP TABLE IF EXISTS Prodotti CASCADE; 
DROP TABLE IF EXISTS Catalogo CASCADE; 
-- =================================================================== 
-- Creazione delle tabelle
-- =================================================================== 
 
CREATE TABLE Fornitori(
	fid CHAR(2) PRIMARY KEY, 
  	nome CHAR(20), 
  	indirizzo CHAR(20)
); 

CREATE TABLE Prodotti(
	pid	CHAR(3) PRIMARY KEY, 
  	nome	CHAR(20), 
  	colore	CHAR(20) 
); 
 
CREATE TABLE Catalogo( 
  	fid CHAR(2), 
  	pid CHAR(3), 
	costo REAL, 
	FOREIGN KEY (fid) REFERENCES FORNITORI(fid), 
  	FOREIGN KEY (pid) REFERENCES Prodotti(pid), 
  	PRIMARY KEY(fid,pid) 
); 
 
-- ==================================================================== 
-- Inserimento di istanze nelle tabelle
-- ==================================================================== 
 
INSERT INTO Fornitori (fid,nome,indirizzo) VALUES ('F1','ACME','via Holliwood'); 
INSERT INTO Fornitori (fid,nome,indirizzo) VALUES ('F2','Ingegneria','via Eudossiana'); 
INSERT INTO Fornitori (fid,nome,indirizzo) VALUES ('F3','Sapienza','via Scarpa'); 
INSERT INTO Fornitori (fid,nome,indirizzo) VALUES ('F4','DIS','via Ariosto'); 
INSERT INTO Fornitori (fid,nome,indirizzo) VALUES ('F5','Gest','via Buonarroti'); 
 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P1','Volante','Nero'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P2','Volante','Rosso'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P3','Carrozzeria','Nero'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P4','Carrozzeria','Rosso'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P5','Carrozzeria','Verde'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P6','Cerchione','Nero'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P7','Cerchione','Rosso'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P8','Ruota','Nero'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P9','Sedile','Nero'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P10','Sedile','Rosso'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P11','Sedile','Verde'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P12','Tappetino','Nero'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P13','Tappetino','Rosso'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P14','Tappetino','Verde'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P15','Casco','Rosso'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P16','Casco','Verde'); 
 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P1',100); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P2',100); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P3',500); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P4',500); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P5',500); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P6',70); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P7',70); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P8',180); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P9',220); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P10',220); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P11',220); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P12',50); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P13',50); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P14',50); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P15',90); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P16',90); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P2',120); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P3',550); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P4',550); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P5',550); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P7',80); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P10',210); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P12',55); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P13',55); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P14',55); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P15',120); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F3','P1',60); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F3','P3',450); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F3','P4',450); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F3','P8',60); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F4','P2',60); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F4','P15',80);

-- ==================================================================== 
-- ESERCITAZIONI
-- ==================================================================== 

/*Contare il numero di tipologie di prodotti diversi (e.g., volante, sedile, etc.)
presenti nel database, senza considerare il colore*/
SELECT 
	nome AS tipologia_prodotto, 
	COUNT(*) AS "quantità"
	FROM prodotti
	GROUP BY nome;



/* Prezzo più basso per il sedile rosso */
SELECT MIN(costo)
	FROM catalogo c JOIN prodotti p USING(pid)
	WHERE nome='Sedile' AND colore='Rosso';



/* Costo medio dei Volanti per colore */
SELECT 
	colore AS colore_volante,
	CAST(AVG(costo) AS NUMERIC(10,2)) AS costo_medio
	FROM catalogo c JOIN prodotti USING(pid)
	WHERE nome='Volante' 
	GROUP BY colore;



/* Numero di prodotti di ogni fornitore, in ordine decrescente */
SELECT 
	nome AS fornitore,
	COUNT(pid) AS num_prodotti --COUNT(pid) -> per non contare i valori nulli (se un F non ha prodotti vengono contate comunque le righe con i null per il LEFT JOIN)
	FROM fornitori LEFT JOIN catalogo USING(fid)
	GROUP BY fid,nome
	ORDER BY num_prodotti DESC;



/* Nome del fornitore e numero di prodotti, solo dei fornitori che vendono più di 9 pezzi */
SELECT 
	nome AS fornitore
	FROM fornitori
	WHERE fid = ANY (
		SELECT fid
			FROM catalogo 
			GROUP BY fid
			HAVING(COUNT(*)>9)	
	);

SELECT 
	nome AS fornitore,
	COUNT(*) AS num_prodotti
	FROM fornitori JOIN catalogo USING(fid)
	GROUP BY nome
	HAVING(COUNT(*)>9);



/* Nome prodotto e costo medio di tutti i prodotti di colore Nero */
SELECT 
	nome AS nome_prodotto,
	CAST(AVG(costo) AS NUMERIC(10,2)) AS costo_medio
	FROM prodotti JOIN catalogo USING(pid)
	WHERE colore='Nero'
	GROUP BY nome;



/* Prezzo medio dei sedili (Indipendentemente dal colore) di ogni fornitore */
SELECT 
	f.nome AS nome_fornitore,
	f.fid,
	CAST(AVG(costo) AS NUMERIC(10,2)) AS costo_medio
	FROM catalogo c
		JOIN prodotti p USING(pid)
		JOIN fornitori f USING(fid)
	WHERE p.nome='Sedile'
	GROUP BY f.nome,f.fid;
	


/* Contare il numero di prodotti per colore */
SELECT 
	colore AS colore_prodotti,
	COUNT(*) AS num_prodotti
	FROM prodotti
	GROUP BY colore;



/* Eliminare il colore per il Volante Rosso; */
UPDATE prodotti
	SET colore = NULL -- oppure DEFAULT perchè in questo caso NULL è il valore di default per colore 
	WHERE nome='Volante' AND colore='Rosso';
SELECT * FROM prodotti;

UPDATE prodotti
	SET colore='Rosso'
	WHERE pid='P2';



/*
Trovare i prodotti forniti dalla ACME e da nessun altro, senza fare uso di Differenza
insiemistica: utilizzare un approccio con uso di Exists o Not Exsists
*/
SELECT p.pid, p.nome, p.colore
	FROM catalogo 
		JOIN fornitori f USING(fid)
		JOIN prodotti p USING(pid)
	WHERE f.nome='ACME'
		AND NOT EXISTS (
			SELECT * 
				FROM catalogo c JOIN fornitori f2 USING(fid)
				WHERE c.pid=p.pid AND f2.nome<>'ACME'
		);

SELECT p.pid, p.nome, p.colore
	FROM catalogo 
		JOIN fornitori f USING(fid)
		JOIN prodotti p USING(pid)
	WHERE f.nome='ACME'
EXCEPT
SELECT p.pid, p.nome, p.colore
	FROM catalogo 
		JOIN fornitori f USING(fid)
		JOIN prodotti p USING(pid)
	WHERE f.nome<>'ACME';



/* Trovare i nomi dei fornitori che forniscono ogni prodotto */
SELECT DISTINCT F.nome
	FROM Fornitori F
	WHERE NOT EXISTS (
		SELECT P.pid FROM Prodotti P
			WHERE P.pid NOT IN(
				SELECT C.pid FROM Catalogo C
					WHERE C.fid=F.fid
			)
	);

SELECT DISTINCT nome
	FROM Fornitori F
	WHERE NOT EXISTS (
		SELECT pid FROM Prodotti
			EXCEPT
		SELECT pid FROM Catalogo C
			WHERE C.fid = F.fid
	);



/* Trovare i nomi dei fornitori che forniscono tutti i prodotti rossi */
SELECT DISTINCT f.nome
	FROM Fornitori f
	WHERE NOT EXISTS( --se non esistono prodotti rossi non venduti dal fornitore corrente
		SELECT p.pid
			FROM prodotti p
			WHERE colore='Rosso'
		EXCEPT
		SELECT c.pid
			FROM catalogo c JOIN prodotti p2 USING(pid)
			WHERE p2.colore='Rosso' AND f.fid=c.fid
	);
	
SELECT DISTINCT f.nome
	FROM Fornitori f
	WHERE NOT EXISTS (
    	SELECT *
    		FROM Prodotti p
    		WHERE p.colore = 'Rosso'
    			AND p.pid NOT IN (
        			SELECT c.pid
        				FROM Catalogo c
        					WHERE c.fid = f.fid
    			)
	);




/* Trovare gli id dei fornitori che ricaricano su alcuni prodotti più del costo medio di quel prodotto */
SELECT DISTINCT fid
	FROM fornitori f JOIN catalogo c USING(fid)
	WHERE c.costo > (
		SELECT AVG(costo)
			FROM catalogo c1
			WHERE c1.pid=c.pid AND c1.fid<>c.fid
	);



/* Trovare gli id e i nomi dei fornitori che forniscono solo prodoE rossi */
SELECT DISTINCT f.fid, f.nome
	FROM fornitori f JOIN catalogo USING(fid) -- JOIN per evitare fornitori che non vendono prodotti
	WHERE 'Rosso' = ALL ( -- se tutti i prodotti venduti dal fornitore corrente sono rossi
		SELECT colore
			FROM catalogo c1 JOIN prodotti USING(pid)
			WHERE f.fid = c1.fid
	);

SELECT f.fid, f.nome
	FROM fornitori f
	WHERE NOT EXISTS ( -- se non esistono prodotti di colore != Rosso venduti dal fornitore corrente
		SELECT *
			FROM catalogo c JOIN prodotti p USING(pid)
			WHERE f.fid = c.fid AND p.colore <> 'Rosso'
	) AND EXISTS ( -- devo controllare che il fornitore corrente vende almeno un prodotto
		SELECT *
			FROM catalogo c1
			WHERE c1.fid=f.fid
	);

SELECT fid, nome
	FROM fornitori f
	WHERE NOT EXISTS ( -- se non esistono prodotti di colore != Rosso venduti dal fornitore corrente
		SELECT pid FROM catalogo c WHERE c.fid=f.fid
		EXCEPT
		SELECT pid FROM catalogo c JOIN prodotti USING(pid)
			WHERE c.fid=f.fid AND colore='Rosso'
	) AND EXISTS ( -- devo controllare che il fornitore corrente vende almeno un prodotto
		SELECT *
			FROM catalogo c1
			WHERE c1.fid=f.fid
	);


/* Trovare i fid dei fornitori che forniscono almeno un prodotto rosso e un prodotto verde */
SELECT DISTINCT c1.fid
	FROM catalogo c1
		JOIN prodotti p1 ON c1.pid=p1.pid
		JOIN catalogo c2 ON c1.fid=c2.fid
		JOIN prodotti p2 ON c2.pid=p2.pid
	WHERE p1.colore='Rosso' AND p2.colore='Verde';

SELECT fid
	FROM fornitori f
	WHERE EXISTS (
		SELECT *
			FROM catalogo c JOIN prodotti p USING(pid)
			WHERE c.fid = f.fid AND p.colore = 'Rosso'
	) AND EXISTS (
		SELECT *
			FROM catalogo c JOIN prodotti p USING(pid)
			WHERE c.fid = f.fid AND p.colore = 'Verde'
	);

/* Trovare i fid dei fornitori che forniscono esattamente un prodotto rosso e un prodotto verde */
SELECT fid 
	FROM fornitori F
	WHERE 
		2 = ( SELECT COUNT(*) FROM catalogo c WHERE c.fid=f.fid ) AND
		1 = ( SELECT COUNT(*) FROM catalogo c JOIN Prodotti USING(pid)
				WHERE c.fid=f.fid AND colore='Rosso' ) AND
		1 = ( SELECT COUNT(*) FROM catalogo c JOIN Prodotti USING(pid)
				WHERE c.fid=f.fid AND colore='Verde' );

SELECT c.fid
FROM catalogo c
JOIN prodotti p ON c.pid = p.pid
GROUP BY c.fid
HAVING COUNT(*) = 2
   AND SUM(CASE WHEN p.colore = 'Rosso' THEN 1 ELSE 0 END) = 1
   AND SUM(CASE WHEN p.colore = 'Verde' THEN 1 ELSE 0 END) = 1;

















	