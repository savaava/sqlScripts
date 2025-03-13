-- ===================================================================
-- DROP delle tabelle
-- ===================================================================

DROP TABLE IF EXISTS fornitori CASCADE;
DROP TABLE IF EXISTS prodotti CASCADE;
DROP TABLE IF EXISTS catalogo CASCADE;

-- ===================================================================
-- Creazione delle tabelle
-- ===================================================================

CREATE TABLE fornitori (
	fid CHAR(2) PRIMARY KEY,
	nome CHAR(20),
	indirizzo CHAR(20)
);

CREATE TABLE prodotti (
	pid CHAR(3) PRIMARY KEY,
	nome CHAR(20),
	colore CHAR(20)
);

CREATE TABLE catalogo (
	fid CHAR(2),
	pid CHAR(3),
	costo REAL,
	FOREIGN KEY (fid) REFERENCES fornitori(fid),
	FOREIGN KEY (pid) REFERENCES prodotti(pid),
	PRIMARY KEY(fid,pid)
);

-- ====================================================================
-- Inserimento di istanze nelle tabelle
-- ====================================================================

INSERT INTO fornitori (fid, nome, indirizzo) VALUES ('F1', 'ACME', 'via Holliwood');
INSERT INTO fornitori (fid,nome,indirizzo) VALUES ('F2','Ingegneria','via Eudossiana');
INSERT INTO fornitori (fid,nome,indirizzo) VALUES ('F3','Sapienza','via Scarpa');
INSERT INTO fornitori (fid,nome,indirizzo) VALUES ('F4','DIS','via Ariosto');
INSERT INTO fornitori (fid,nome,indirizzo) VALUES ('F5','Gest','via Buonarroti');

INSERT INTO prodotti (pid,nome,colore) VALUES ('P1','Volante','Nero');
INSERT INTO prodotti (pid,nome,colore) VALUES ('P2','Volante','Rosso');
INSERT INTO prodotti (pid,nome,colore) VALUES ('P3','Carrozzeria','Nero');
INSERT INTO prodotti (pid,nome,colore) VALUES ('P4','Carrozzeria','Rosso');
INSERT INTO prodotti (pid,nome,colore) VALUES ('P5','Carrozzeria','Verde');

INSERT INTO catalogo (fid,pid,costo) VALUES ('F1','P1',100);
INSERT INTO catalogo (fid,pid,costo) VALUES ('F1','P2',50.7);
INSERT INTO catalogo (fid,pid,costo) VALUES ('F1','P3',99.9);
INSERT INTO catalogo (fid,pid,costo) VALUES ('F2','P1',200);
INSERT INTO catalogo (fid,pid,costo) VALUES ('F2','P2',880);
INSERT INTO catalogo (fid,pid,costo) VALUES ('F2','P3',80.7);







