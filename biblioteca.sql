DROP TABLE IF EXISTS libri CASCADE;
DROP TABLE IF EXISTS amici CASCADE;
DROP TABLE IF EXISTS prestiti CASCADE;

-- CREAZIONE TABELLE

CREATE TABLE libri (
	nome CHAR(20) PRIMARY KEY
);

CREATE TABLE amici (
	nome CHAR(20),
	soprannome CHAR(20),

	PRIMARY KEY(nome,soprannome)
);

CREATE TABLE prestiti (
	libroPrestato CHAR(20),
	nomeAmicoCreditore CHAR(20),
	soprannomeAmicoCreditore CHAR(20),
	dataRestituzione DATE,
	
	FOREIGN KEY (libroPrestato) REFERENCES libri(nome),
	FOREIGN KEY (nomeAmicoCreditore,soprannomeAmicoCreditore) REFERENCES amici(nome,soprannome),
	PRIMARY KEY(libroPrestato,nomeAmicoCreditore,soprannomeAmicoCreditore)
);

-- INSERIMENTO

INSERT INTO libri (nome) VALUES ('Basi di dati VI');
INSERT INTO libri (nome) VALUES ('Basi di dati V');
INSERT INTO libri (nome) VALUES ('Basi di dati IV');

INSERT INTO amici (nome,soprannome) VALUES ('Alessandro','Gisandro');
INSERT INTO amici (nome,soprannome) VALUES ('Annamaria','Ske');
INSERT INTO amici (nome,soprannome) VALUES ('Ubaldo','Baldone');

INSERT INTO prestiti (
	libroPrestato,
	nomeAmicoCreditore,
	soprannomeAmicoCreditore,
	dataRestituzione) 
VALUES (
	'Basi di dati V',
	'Alessandro',
	'Gisandro',
	'2025-03-20'
);
INSERT INTO prestiti (
	libroPrestato,
	nomeAmicoCreditore,
	soprannomeAmicoCreditore,
	dataRestituzione) 
VALUES (
	'Basi di dati VI',
	'Annamaria',
	'Ske',
	'2025-03-19'
);
INSERT INTO prestiti (
	libroPrestato,
	nomeAmicoCreditore,
	soprannomeAmicoCreditore,
	dataRestituzione) 
VALUES (
	'Basi di dati VI',
	'Ubaldo',
	'Baldone',
	'2025-03-18'
);
INSERT INTO prestiti (
	libroPrestato,
	nomeAmicoCreditore,
	soprannomeAmicoCreditore,
	dataRestituzione) 
VALUES (
	'Basi di dati VI',
	'Alessandro',
	'Gisandro',
	'2025-03-18'
);

