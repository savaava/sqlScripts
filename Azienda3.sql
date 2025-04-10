DROP TABLE IF EXISTS progetti CASCADE;
DROP TABLE IF EXISTS impiegati CASCADE;
DROP TABLE IF EXISTS partecipazione_progetti CASCADE;
DROP TABLE IF EXISTS dipartimenti CASCADE;
DROP TABLE IF EXISTS sedi CASCADE;
DROP TABLE IF EXISTS telefoni CASCADE;

CREATE TABLE progetti(
	nome TEXT PRIMARY KEY,
	budget REAL,
	data_consegna DATE NOT NULL
);

CREATE TABLE impiegati(
	codice CHAR(5) PRIMARY KEY CHECK(char_length(codice)=5),
	cognome VARCHAR(20) NOT NULL,
	stipendio REAL,
	eta INTEGER NOT NULL CHECK(eta>=25 AND eta<=80),
	dipart_afferenza TEXT,
	sede_dipart_afferenza TEXT,
	data_afferenza DATE
);

CREATE TABLE partecipazione_progetti(
	progetto TEXT REFERENCES progetti(nome),
	impiegato CHAR(5) REFERENCES impiegati(codice),
	data_inizio DATE NOT NULL,

	PRIMARY KEY (progetto,impiegato)
);

CREATE TABLE sedi(
	citta TEXT PRIMARY KEY,
	num_civico CHAR(5) NOT NULL,
	via TEXT NOT NULL, 
	CAP INTEGER NOT NULL
);

CREATE TABLE dipartimenti(
	nome TEXT,
	sede TEXT REFERENCES sedi(citta),
	impiegato_direttore CHAR(5) REFERENCES impiegati(codice),

	PRIMARY KEY (nome, sede)
);

CREATE TABLE telefoni(
	numero TEXT PRIMARY KEY,
	dipart TEXT,
	sede_dipart TEXT,

	CONSTRAINT fk_telefoni FOREIGN KEY (dipart, sede_dipart) REFERENCES dipartimenti(nome, sede)
);

ALTER TABLE impiegati 
	ADD CONSTRAINT fk_afferenza 
		FOREIGN KEY (dipart_afferenza,sede_dipart_afferenza) REFERENCES dipartimenti(nome, sede);


INSERT INTO progetti VALUES('Scilla',5000000.99,'2025-04-10');
INSERT INTO progetti (nome,data_consegna) VALUES('X509','1999-04-10');

INSERT INTO impiegati VALUES ('AAAAA','Scofield',10000.00,40,null,null,'2020-03-09');
INSERT INTO impiegati VALUES ('AAAAB','Barrows',8000,45,null,null,'2020-03-09');

INSERT INTO partecipazione_progetti VALUES ('Scilla', 'AAAAa', '2025-02-15');
INSERT INTO partecipazione_progetti VALUES ('Scilla', 'AAAAB', '2025-02-15');

SELECT * FROM impiegati





