DROP TABLE IF EXISTS clienti CASCADE;
DROP TABLE IF EXISTS ordini CASCADE;

CREATE TABLE clienti(
	id INTEGER,
	nome VARCHAR(100) DEFAULT 'Pippo',
	cognome VARCHAR(100) NOT NULL,
	data_nascita DATE NOT NULL,
	citta VARCHAR(100) NOT NULL,

	CONSTRAINT pk_clienti PRIMARY KEY(id),
	CONSTRAINT key_clienti UNIQUE (nome,cognome,data_nascita,citta)
);

-- TABELLA REFERENZIANTE
CREATE TABLE ordini(
	id_ordine INTEGER PRIMARY KEY,
	id_cliente INTEGER REFERENCES clienti(id) 
		ON DELETE SET DEFAULT ON UPDATE CASCADE,
	id_fornitore INTEGER REFERENCES clienti(id)
		ON DELETE SET DEFAULT ON UPDATE CASCADE,
	data DATE,
	importo NUMERIC(6,2),

	CONSTRAINT fornitore_cliente_check CHECK(id_cliente!=id_fornitore)
);

/*ALTER TABLE ordini ADD COLUMN 
	id_fornitore INTEGER REFERENCES clienti(id)
		ON DELETE SET DEFAULT ON UPDATE CASCADE;
ALTER TABLE ordini ADD CONSTRAINT fornitore_cliente_check CHECK(id_ordine!=id_fornitore);*/


INSERT INTO clienti VALUES(1,'Gis','Monte','2025-03-08','Cava');
INSERT INTO clienti (id,nome,cognome,data_nascita,citta) VALUES(2,'Giuseppe','Alto','2025-03-08','Mat');
INSERT INTO clienti (id,cognome,data_nascita,citta) VALUES(3,'Verdi','2020-03-08','Sa');
INSERT INTO clienti VALUES(9,'Antonio','Rossi','2025-03-08','Cava');

INSERT INTO ordini VALUES(1,9,2,'2023-03-08',110.55);
INSERT INTO ordini VALUES(2,9,2,'2018-03-08',200.99);
INSERT INTO ordini VALUES(55,3,2,'2017-03-08',60.99);
INSERT INTO ordini VALUES(56,3,2,'2016-03-08',300.99);
INSERT INTO ordini VALUES(31,2,1,'2001-03-08',0.99);
INSERT INTO ordini VALUES(32,2,1,'2004-03-08',51);
INSERT INTO ordini VALUES(33,2,1,'2003-03-08',109.99);
INSERT INTO ordini VALUES(4,1,2,'2022-03-10',106.99);
INSERT INTO ordini VALUES(5,1,2,'2022-03-07',4000);
INSERT INTO ordini (id_ordine,data,importo) VALUES(6,'2000-03-07',50.5);
INSERT INTO ordini (id_ordine,data,importo) VALUES(7,'2024-03-07',0.5);

DELETE FROM clienti WHERE id=10;
DELETE FROM clienti 
	WHERE id IN
		(SELECT id_cliente FROM ordini WHERE importo<-50.99);

SELECT * FROM ordini;

/*
SELECT nome FROM clienti 
	WHERE id IN
		(SELECT id_cliente FROM ordini 
			WHERE importo>100);
 se c'è un legame tra la query più esterna e quella più interna
persone con un campo stipendio -> ottenere tutte le persone che hanno un importo dello stipendio
che deve essere maggiore della media di tutti i suoi stipendi */