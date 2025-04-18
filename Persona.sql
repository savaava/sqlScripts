DROP TABLE IF EXISTS persona CASCADE;

CREATE TABLE persona (
	cf CHAR(16) PRIMARY KEY,
	nome VARCHAR(20),
	cognome VARCHAR(20),
	citta VARCHAR(20)
);

INSERT INTO persona VALUES 
('RSSMRA85C10H501Z', 'Mario', 'Rossi', 'Milano'),
('VRDLGI92L15F839U', 'Luigi', 'Verdi', 'Napoli'),
('BNCLRA99A01L219K', 'Laura', 'Bianchi', 'Roma'),
('NGLGPP01T22Z404H', 'Giuseppe', 'Neri', 'Torino'),
('DNLPLA87S15E888Z', 'Paola', 'Danieli', 'Venezia'),
('FNTDNL93P12C351J', 'Danilo', 'Fontana', 'Cagliari'),
-- Omonimi
('FRNLCU90D10F205Q', 'Luca', 'Ferrari', 'Firenze'),
('FRNLCU91D10F205R', 'Luca', 'Ferrari', 'Bologna'),
('BNCGPP88M01H501K', 'Giuseppe', 'Bianchi', 'Milano'),
('BNCGPP00A01H444H', 'Giuseppe', 'Bianchi', 'Torino'),
('BNCGPP95M01C351W', 'Giuseppe', 'Bianchi', 'Catania');



/* 45 Estrarre le persone che hanno degli omonimi (stesso nome e cognome, ma CF diverso) */
SELECT *
	FROM persona p1
	WHERE 1 < (
		SELECT COUNT(*) FROM persona p2
			WHERE p2.nome=p1.nome AND p2.cognome=p1.cognome
	);

SELECT *
	FROM persona p1
	WHERE EXISTS (
		SELECT * FROM persona p2
			WHERE p2.nome=p1.nome 
				AND p2.cognome=p1.cognome
				AND p2.cf <> p1.cf
	);

SELECT DISTINCT p1.*
	FROM persona p1, persona p2
	WHERE p1.nome = p2.nome
		AND p1.cognome = p2.cognome
		AND p1.cf <> p2.cf;

SELECT DISTINCT p1.*
	FROM persona p1 JOIN persona p2 
		ON p1.nome=p2.nome AND p1.cognome=p2.cognome
	WHERE p1.cf <> p2.cf;

SELECT *
	FROM persona
	WHERE (nome,cognome) = ANY ( -- oppure IN
		SELECT nome,cognome FROM persona 
		GROUP BY nome,cognome
		HAVING (COUNT(*)>1)
	);

SELECT *
	FROM persona
	WHERE (nome,cognome) <> ALL ( -- oppure NOT IN
 		SELECT nome,cognome FROM persona 
		GROUP BY nome,cognome
		HAVING (COUNT(*)=1)
	);



/* 47 Estrarre le persone che NON hanno degli omonimi */
SELECT *
	FROM persona p1
	WHERE 1 = (
		SELECT COUNT(*) FROM persona p2
			WHERE p1.nome = p2.nome
				AND p1.cognome = p2.cognome
	);

SELECT *
	FROM persona p1
	WHERE NOT EXISTS (
		SELECT * FROM persona p2
			WHERE p1.nome = p2.nome
				AND p1.cognome = p2.cognome
				AND p1.cf <> p2.cf
	);

SELECT *
	FROM persona 
	WHERE (nome,cognome) = ANY (
		SELECT nome,cognome FROM persona
			GROUP BY nome,cognome
			HAVING (COUNT(*)=1)
	);

SELECT *
	FROM persona 
	WHERE (nome,cognome) <> ALL (
		SELECT nome,cognome FROM persona
			GROUP BY nome,cognome
			HAVING (COUNT(*)>1)
	);

SELECT *
	FROM persona p1
	WHERE (nome,cognome) NOT IN (
		SELECT nome,cognome FROM persona p2
			WHERE p1.cf <> p2.cf
	);


























	