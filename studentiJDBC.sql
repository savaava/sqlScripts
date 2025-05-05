DROP TABLE IF EXISTS studente;

CREATE TABLE studente (
	matricola CHAR(10) PRIMARY KEY,
	nome VARCHAR(20),
	cognome VARCHAR(20)
);

INSERT INTO studente VALUES ('1270013', 'Mario', 'Rossi');
INSERT INTO studente VALUES ('6127003', 'Gigi', 'Bianchi');
INSERT INTO studente VALUES ('6127004', 'Ernesto', 'Bianchi');

SELECT * FROM studente;