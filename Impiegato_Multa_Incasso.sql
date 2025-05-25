DROP TABLE IF EXISTS Impiegato CASCADE;
DROP TABLE IF EXISTS Incasso CASCADE;
DROP TABLE IF EXISTS Multa CASCADE;

CREATE TABLE Impiegato (
	matricola INTEGER PRIMARY KEY,
	nome TEXT NOT NULL,
	cognome TEXT NOT NULL
);
CREATE TABLE Multa (
	codice INTEGER PRIMARY KEY,
	importo NUMERIC(10,2),
	data_ DATE
);
CREATE TABLE Incasso (
	impiegato INTEGER REFERENCES Impiegato(matricola),
	multa INTEGER REFERENCES Multa(codice),
	data_ DATE,
	PRIMARY KEY(impiegato,multa)
);

-- Inserimento dati in Impiegato (inclusi impiegati senza incassi)
INSERT INTO Impiegato (matricola, nome, cognome) VALUES
(1001, 'Marco', 'Rossi'),
(1002, 'Luca', 'Bianchi'),
(1003, 'Anna', 'Verdi'),
(1004, 'Giulia', 'Conti'),   -- Nessun incasso
(1005, 'Davide', 'Moretti'); -- Nessun incasso

-- Inserimento dati in Multa
INSERT INTO Multa (codice, importo, data_) VALUES
(2001, 50.00, '2025-04-01'),
(2002, 75.50, '2025-04-02'),
(2003, 120.00, '2025-04-03'),
(2004, 35.25, '2025-04-04');

-- Inserimento dati in Incasso (solo alcuni impiegati)
INSERT INTO Incasso (impiegato, multa, data_) VALUES
(1001, 2001, '2025-04-05'),
(1002, 2002, '2025-04-06'),
(1001, 2003, '2025-04-07'),
(1003, 2004, '2025-04-08');


/*Si trovi la Matricola, il Cognome ed il Nome dell?impiegato con il minor numero di multe
incassate (si noti che ci potrebbero essere impiegati che non hanno incassato multe); si visualizzi
il risultato ordinando le tuple sul Cognome (in ordine crescente) e sul Nome (in ordine
decrescente).*/

/* prima soluzione */
CREATE VIEW imp_num_multe AS
	SELECT 
		matricola,
		COUNT(multa) AS num_multe
	FROM Impiegato LEFT JOIN Incasso ON matricola=impiegato
	GROUP BY matricola;

SELECT I.*
	FROM Impiegato I JOIN imp_num_multe V USING(matricola)
	WHERE num_multe = (
		SELECT MIN(num_multe) FROM imp_num_multe )
	ORDER BY I.cognome ASC, I.nome DESC;

/* seconda soluzione */
CREATE VIEW V1 AS
	SELECT 
		impiegato,
		COUNT(*) AS num_multe
	FROM Incasso
	GROUP BY impiegato;

CREATE VIEW V2 AS
	SELECT impiegato AS matricola, num_multe FROM V1
	UNION
	SELECT matricola,0 FROM Impiegato 
		WHERE matricola NOT IN (SELECT impiegato FROM V1);

SELECT I.*
	FROM Impiegato I JOIN V2 USING(matricola)
	WHERE num_multe = (
		SELECT MIN(num_multe) FROM V2 )
	ORDER BY I.cognome ASC, I.nome DESC;








	

