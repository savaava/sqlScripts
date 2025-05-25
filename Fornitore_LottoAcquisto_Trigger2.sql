DROP TABLE IF EXISTS Fornitore CASCADE;
DROP TABLE IF EXISTS LottoAcquisto CASCADE;

CREATE TABLE Fornitore (
	codice INTEGER PRIMARY KEY,
	indirizzo TEXT,
	ragione_sociale TEXT,
	lotti_totali INTEGER NOT NULL DEFAULT 0
);
CREATE TABLE LottoAcquisto (
	codice INTEGER PRIMARY KEY,
	data_ DATE,
	fornitore INTEGER REFERENCES Fornitore(codice)
);

CREATE OR REPLACE FUNCTION increment_cont()
	RETURNS TRIGGER 
	AS $$
	BEGIN
		UPDATE Fornitore F
			SET  lotti_totali = lotti_totali + (
				SELECT COUNT(*)
					FROM nuovi_lotti nt
					WHERE nt.fornitore = F.codice
			);
		RETURN NULL;
	END;
	$$
	LANGUAGE plpgsql;

CREATE TRIGGER insert_lotto
	AFTER INSERT ON LottoAcquisto
	REFERENCING
		NEW TABLE AS nuovi_lotti
	--FOR EACH STATEMENT
	EXECUTE PROCEDURE increment_cont();
	
/*
CREATE OR REPLACE FUNCTION increment_cont()
	RETURNS TRIGGER
	AS $$
	BEGIN
		UPDATE Fornitore F
			SET lotti_totali = lotti_totali + 1
			WHERE F.codice = NEW.fornitore;
		RETURN NULL;
	END;
	$$
	LANGUAGE plpgsql;

CREATE TRIGGER insert_lotto
	AFTER INSERT ON LottoAcquisto
	FOR EACH ROW
	EXECUTE PROCEDURE increment_cont();
*/


-- Inserimento fornitori
INSERT INTO Fornitore (codice, indirizzo, ragione_sociale) VALUES
(1, 'Via Roma 10, Milano', 'Alfa S.r.l.'),
(2, 'Corso Torino 5, Torino', 'Beta Spa'),
(3, 'Piazza Dante 3, Napoli', 'Gamma S.p.A.'),
(4, 'Via Verdi 22, Bologna', 'Delta Srl'),
(5, 'Via Milano 15, Firenze', 'Epsilon S.r.l.');

-- Inserimento lotti acquisto (trigger incrementa lotti_totali in Fornitore)
INSERT INTO LottoAcquisto (codice, data_, fornitore) VALUES
(1001, '2024-01-15', 1),
(1002, '2024-02-20', 1),
(1003, '2024-03-05', 2),
(1004, '2024-04-10', 3),
(1005, '2024-04-15', 3),
(1006, '2024-05-01', 3),
(1007, '2024-06-12', 5);
-- Nota: Fornitore con codice 4 non ha lotti, quindi lotti_totali resterà 0.


SELECT * FROM Fornitore
	ORDER BY lotti_totali ASC;










































