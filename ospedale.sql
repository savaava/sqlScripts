DROP TABLE IF EXISTS pazienti CASCADE;
DROP TABLE IF EXISTS ricoveri CASCADE;
DROP TABLE IF EXISTS medici CASCADE;
DROP TABLE IF EXISTS reparti CASCADE;


CREATE TABLE pazienti(
	codice CHAR(4) PRIMARY KEY,
	cognome CHAR(20),
	nome CHAR(20)
);
CREATE TABLE ricoveri(
	paziente CHAR(4),
	inizio date,
	fine date,
	reparto CHAR(1),
	PRIMARY KEY (paziente,inizio)
);
CREATE TABLE medici(
	matricola CHAR(3) PRIMARY KEY,
	cognome CHAR(20),
	nome CHAR(20),
	reparto CHAR(1)
);
CREATE TABLE reparti(
	codice CHAR(1) PRIMARY KEY,
	nome CHAR(20),
	primario CHAR(3)
);


ALTER TABLE ricoveri ADD CONSTRAINT check_date_range CHECK (fine >= inizio);

ALTER TABLE ricoveri 
	ADD CONSTRAINT fk_ricoveri_pazienti 
	FOREIGN KEY (paziente) REFERENCES pazienti(codice);

ALTER TABLE ricoveri 
	ADD CONSTRAINT fk_ricoveri_reparti 
	FOREIGN KEY (reparto) REFERENCES reparti(codice);

ALTER TABLE medici 
	ADD CONSTRAINT fk_medici_reparti
	FOREIGN KEY (reparto) REFERENCES reparti(codice);

ALTER TABLE reparti
	ADD CONSTRAINT fk_reparti_medici
	FOREIGN KEY (primario) REFERENCES medici(matricola);


INSERT INTO pazienti (codice,cognome,nome) VALUES ('A102','Necchi','Luca');
INSERT INTO pazienti (codice,cognome,nome) VALUES ('B372','Rossini','Piero');
INSERT INTO pazienti (codice,cognome,nome) VALUES ('B543','Missoni','Nadia');
INSERT INTO pazienti (codice,cognome,nome) VALUES ('B444','Missoni','Luigi');
INSERT INTO pazienti (codice,cognome,nome) VALUES ('S555','Rossetti','Gino');

INSERT INTO reparti (codice,nome,primario) VALUES ('A','Chirurgia',null);
INSERT INTO reparti (codice,nome,primario) VALUES ('B','Pediatria',null);
INSERT INTO reparti (codice,nome,primario) VALUES ('C','Medicina',null);

INSERT INTO ricoveri (paziente,inizio,fine,reparto) VALUES('A102','2021-05-02','2021-05-09','A');
INSERT INTO ricoveri (paziente,inizio,fine,reparto) VALUES('A102','2021-12-02','2022-01-02','A');
INSERT INTO ricoveri (paziente,inizio,fine,reparto) VALUES('S555','2021-04-25','2021-05-03','B');
INSERT INTO ricoveri (paziente,inizio,fine,reparto) VALUES('B444','2021-12-01','2022-01-02','B');
INSERT INTO ricoveri (paziente,inizio,fine,reparto) VALUES('S555','2021-10-05','2021-11-01','A');

INSERT INTO medici (matricola,cognome,nome,reparto) VALUES ('203','Neri','Piero','A');
INSERT INTO medici (matricola,cognome,nome,reparto) VALUES ('574','Bisi','Mario','B');
INSERT INTO medici (matricola,cognome,nome,reparto) VALUES ('461','Bargio','Sergio','B');
INSERT INTO medici (matricola,cognome,nome,reparto) VALUES ('530','Belli','Nicola','C');
INSERT INTO medici (matricola,cognome,nome,reparto) VALUES ('405','Mizzi','Nicola','A');
INSERT INTO medici (matricola,cognome,nome,reparto) VALUES ('501','Monti','Mario','A');

UPDATE reparti SET primario='203' WHERE codice='A';
UPDATE reparti SET primario='574' WHERE codice='B';
UPDATE reparti SET primario='530' WHERE codice='C';









	