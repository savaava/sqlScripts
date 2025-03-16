DROP TABLE IF EXISTS impiegato CASCADE;
DROP TABLE IF EXISTS filiale CASCADE;


CREATE TABLE impiegato (
	"CF" CHAR(16) PRIMARY KEY,
	cognome CHAR(20),
	nome CHAR(20),
	dataNascita date,
	filiale CHAR(4)

	-- FOREIGN KEY (filiale) REFERENCES filiale(codice)
);

CREATE TABLE filiale (
	codice CHAR(4) PRIMARY KEY,
	sede CHAR(20),
	direttore CHAR(16)

	-- FOREIGN KEY (direttore) REFERENCES impiegato("CF")
);


-- Ora che entrambe le tabelle esistono, posso aggiungere i vincoli referenziali
ALTER TABLE impiegato
ADD CONSTRAINT fk_impiegato_filiale FOREIGN KEY (filiale) REFERENCES filiale(codice);

ALTER TABLE filiale
ADD CONSTRAINT fk_filiale_direttore FOREIGN KEY (direttore) REFERENCES impiegato("CF");



INSERT INTO impiegato ("CF",cognome,nome,dataNascita,filiale) VALUES ('RSSMRA76E27H501Z','Rossi','Mario','1976-05-27',null);
INSERT INTO impiegato ("CF",cognome,nome,dataNascita,filiale) VALUES ('BRNGNN90D03F205E','Bruni','Giovanni','1990-04-03',null);
INSERT INTO impiegato ("CF",cognome,nome,dataNascita,filiale) VALUES ('GLLBRN64E04F839H','Gialli','Bruno','1964-05-04',null);
INSERT INTO impiegato ("CF",cognome,nome,dataNascita,filiale) VALUES ('NREGNI64L01G273Y','Neri','Gino','1964-07-01',null);
INSERT INTO impiegato ("CF",cognome,nome,dataNascita,filiale) VALUES ('RSSNNA45R42D969X','Rossi','Anna','1945-10-02',null);
INSERT INTO impiegato ("CF",cognome,nome,dataNascita,filiale) VALUES ('RGIPNI77M05M082B','Riga','Pino','1977-08-05',null);

INSERT INTO filiale (codice,sede,direttore) VALUES ('AB04','Roma Tiburtina','NREGNI64L01G273Y');
UPDATE impiegato SET filiale='AB04' WHERE "CF"='NREGNI64L01G273Y' OR "CF"='BRNGNN90D03F205E' OR "CF"='RGIPNI77M05M082B';
INSERT INTO filiale (codice,sede,direttore) VALUES ('GT09','Roma Monteverde','RSSNNA45R42D969X');
UPDATE impiegato SET filiale='GT09' WHERE "CF"='RSSNNA45R42D969X' OR "CF"='GLLBRN64E04F839H';
INSERT INTO filiale (codice,sede,direttore) VALUES ('PT67','Roma Eur','RSSMRA76E27H501Z');
UPDATE impiegato SET filiale='PT67' WHERE "CF"='RSSMRA76E27H501Z';





