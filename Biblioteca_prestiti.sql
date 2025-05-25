DROP TABLE IF EXISTS Utente CASCADE;
DROP TABLE IF EXISTS Prestito CASCADE;
DROP TABLE IF EXISTS Libro CASCADE;
DROP TABLE IF EXISTS Biblioteca CASCADE;

CREATE TABLE Biblioteca (
	codice INTEGER PRIMARY KEY,
	denominazione TEXT
);
CREATE TABLE Utente (
	codice INTEGER PRIMARY KEY,
	nome TEXT NOT NULL,
	cognome TEXT NOT NULL,
	data_nascita DATE NOT NULL,
	tipo TEXT -- studente o docente
);
CREATE TABLE Libro (
	codice INTEGER,
	biblioteca INTEGER REFERENCES Biblioteca(codice),
	PRIMARY KEY(codice,biblioteca)
);
CREATE TABLE Prestito (
	codice INTEGER PRIMARY KEY,
	data_inizio DATE NOT NULL,
	utente INTEGER NOT NULL REFERENCES Utente(codice),
	libro INTEGER,
	biblioteca INTEGER,
	FOREIGN KEY (libro,biblioteca) REFERENCES Libro(codice,biblioteca)
);

-- Inserimento Biblioteche
INSERT INTO Biblioteca (codice, denominazione) VALUES
(1, 'Biblioteca Centrale'),
(2, 'Biblioteca di Scienze');

-- Inserimento Utenti
INSERT INTO Utente (codice, nome, cognome, data_nascita, tipo) VALUES
(100, 'Alice', 'Rossi', '2000-05-14', 'studente'),
(101, 'Luca', 'Verdi', '1995-03-22', 'docente'),
(102, 'Chiara', 'Bianchi', '1998-11-09', 'studente'),
(103, 'Marco', 'Neri', '1988-07-30', 'docente'),
(104, 'Sara', 'Conti', '2001-01-15', 'studente');

-- Inserimento Libri
INSERT INTO Libro (codice, biblioteca) VALUES
(1, 1), -- libro A nella Biblioteca Centrale
(2, 1), -- libro B nella Biblioteca Centrale
(3, 1),
(3, 2); -- libro C nella Biblioteca di Scienze

-- Inserimento Prestiti
INSERT INTO Prestito (codice, data_inizio, utente, libro, biblioteca) VALUES
(200, '2025-05-01', 100, 1, 1), -- Alice prende libro 1
(201, '2025-05-02', 101, 2, 1), -- Luca prende libro 2
(202, '2024-05-03', 102, 3, 2), -- Chiara prende libro 3
(203, '2024-05-04', 103, 1, 1), -- Marco prende di nuovo libro 1
(204, '2024-05-05', 104, 2, 1), -- Sara prende libro 2
(205, '2024-05-06', 100, 3, 2), -- Alice prende anche libro 3
(206, '2024-05-07', 102, 1, 1), -- Chiara prende anche libro 1
(207, '2024-06-06', 100, 3, 2), -- Alice prende anche libro 3
(208, '2024-06-07', 102, 1, 1), -- Chiara prende anche libro 1
(209, '2024-06-08', 100, 2, 1), -- Alice prende anche libro 2
(210, '2024-06-09', 100, 1, 1), -- Alice prende di nuovo libro 1
(214, '2024-06-13', 104, 3, 2), -- Sara prende anche libro 3
(216, '2024-06-15', 104, 3, 1); -- Sara prende ancora libro 3


--soluzione1
CREATE VIEW V AS
SELECT P.utente, P.libro, P.biblioteca
	FROM Utente U JOIN Prestito P ON U.codice=P.utente
	WHERE U.tipo='studente' AND EXTRACT(YEAR FROM P.data_inizio)=2024
	--GROUP BY P.utente
	--HAVING(COUNT(*)>2)
	ORDER BY P.utente ASC;

SELECT DISTINCT V1.utente
	FROM V AS V1
	WHERE 2 < (
		SELECT COUNT(*) FROM (
			SELECT DISTINCT (V2.libro, V2.biblioteca) FROM V AS V2 WHERE V1.utente=V2.utente
		)
	);

--soluzione2
SELECT P.utente
	FROM Utente U JOIN Prestito P ON U.codice=P.utente
	WHERE U.tipo='studente' AND EXTRACT(YEAR FROM P.data_inizio)=2024
	GROUP BY P.utente
	HAVING(COUNT(DISTINCT(P.libro,P.biblioteca))>2) -- COUNT(DISTINCT col1, col2) supportato solo da PostgreSQL

	ORDER BY P.utente ASC;

--soluzione3
SELECT P.utente
	FROM Utente U JOIN Prestito P ON U.codice=P.utente
	WHERE U.tipo='studente' AND EXTRACT(YEAR FROM P.data_inizio)=2024
	GROUP BY P.utente
	HAVING(COUNT(DISTINCT(CONCAT(P.libro,'-',P.biblioteca)))>2) -- CONCAT supportato in SQL standard
	ORDER BY P.utente ASC;





































