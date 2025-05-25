DROP TABLE IF EXISTS Dipartimento CASCADE;
DROP TABLE IF EXISTS Docente CASCADE;
DROP TABLE IF EXISTS Corso CASCADE;
DROP TABLE IF EXISTS Docenza CASCADE;

CREATE TABLE Dipartimento (
	nome TEXT PRIMARY KEY,
	telefono TEXT
);
CREATE TABLE Docente (
	matricola INTEGER PRIMARY KEY,
	cognome TEXT,
	nome TEXT,
	dipartimento TEXT REFERENCES Dipartimento(nome)
);
CREATE TABLE Corso (
	nome TEXT PRIMARY KEY,
	num_crediti INTEGER NOT NULL
);
CREATE TABLE Docenza (
	docente INTEGER REFERENCES Docente(matricola),
	corso TEXT REFERENCES Corso(nome),
	PRIMARY KEY(docente, corso)
);


-- Inserimenti nella tabella Dipartimento
INSERT INTO Dipartimento (nome, telefono) VALUES
('Informatica', '0811234567'),
('Matematica', '0812345678'),
('Fisica', '0813456789'),
('Filosofia', '0814567890'); -- Dipartimento senza docenti né corsi

-- Inserimenti nella tabella Docente
INSERT INTO Docente (matricola, cognome, nome, dipartimento) VALUES
(1001, 'Rossi',    'Marco',   'Informatica'),
(1002, 'Verdi',    'Anna',    'Matematica'),
(1003, 'Bianchi',  'Luca',    'Fisica'),
(1004, 'Conti',    'Giulia',  'Informatica'), -- docente senza corsi
(1005, 'Esposito', 'Davide',  'Matematica'),
(1006, 'Rossi',    'Marco',   'Fisica'),      -- omonimo
(1007, 'Verdi',    'Anna',    'Fisica');      -- omonima

-- Inserimenti nella tabella Corso
INSERT INTO Corso (nome, num_crediti) VALUES
('Programmazione', 9),
('Analisi Matematica I', 12),
('Fisica I', 6),
('Algoritmi e Strutture Dati', 6),
('Geometria', 9);

-- Inserimenti nella tabella Docenza
INSERT INTO Docenza (docente, corso) VALUES
(1001, 'Programmazione'),
(1001, 'Algoritmi e Strutture Dati'),
(1002, 'Analisi Matematica I'),
(1005, 'Geometria'),
(1003, 'Fisica I'),
(1006, 'Fisica I'); -- omonimo che insegna lo stesso corso in altro dipartimento


/* 1 Si trovino i docenti con un omonimo in un altro dipartimento. */
SELECT matricola,nome,cognome
	FROM Docente D1
	WHERE EXISTS (
		SELECT * FROM Docente D2
			WHERE D1.matricola <> D2.matricola
				AND D1.nome = D2.nome
				AND D1.cognome = D2.cognome
				AND D1.dipartimento <> D2.dipartimento
	);


/* 2 Si trovi il nome dei dipartimenti che erogano il minor numero di crediti (si noti che ci potrebbero
essere dipartimenti che non erogano corsi) */
CREATE VIEW V1 AS
	SELECT 
		Dip.nome,
		SUM(C.num_crediti) AS crediti_totali
		FROM Dipartimento Dip
		LEFT JOIN Docente D1 ON Dip.nome = D1.dipartimento
		LEFT JOIN Docenza D2 ON D1.matricola = D2.docente
		LEFT JOIN Corso C ON D2.corso = C.nome
		GROUP BY Dip.nome;

CREATE VIEW V2 AS
	SELECT * FROM V1 WHERE crediti_totali IS NOT NULL
	UNION
	SELECT nome,0 FROM V1 WHERE crediti_totali IS NULL;

SELECT 
	nome AS dipartimento,
	crediti_totali
	FROM V2
	WHERE crediti_totali = (
		SELECT MIN(crediti_totali) FROM V2
	);


/* 3 Si trovi il nome dei dipartimenti che erogano il maggior numero di crediti */
CREATE VIEW V11 AS
	SELECT 
		Dip.nome,
		SUM(C.num_crediti) AS crediti_totali
		FROM Dipartimento Dip
		JOIN Docente D1 ON Dip.nome = D1.dipartimento
		JOIN Docenza D2 ON D1.matricola = D2.docente
		JOIN Corso C ON D2.corso = C.nome
		GROUP BY Dip.nome;

SELECT 
	nome AS dipartimento,
	crediti_totali
	FROM V11
	WHERE crediti_totali = (
		SELECT MAX(crediti_totali) FROM V11
	);



















































