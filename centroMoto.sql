DROP TABLE IF EXISTS moto CASCADE;
DROP TABLE IF EXISTS proprietario CASCADE;

CREATE TABLE moto (
	targa CHAR(6) PRIMARY KEY,
	cilindrata INTEGER,
	marca CHAR(20),
	nazione CHAR(20),
	tasse CHAR(20)
);

CREATE TABLE proprietario (
	nome CHAR(20),
	targa CHAR(6),
	PRIMARY KEY(nome,targa),
	FOREIGN KEY (targa) REFERENCES moto(targa)
);

INSERT INTO moto (targa,cilindrata,marca,nazione,tasse) VALUES ('AA1234',150,'Aprilia','Italia','100€');
INSERT INTO moto (targa,cilindrata,marca,nazione,tasse) VALUES ('ZZ2222',500,'Ducati','Giappone','100€');
INSERT INTO moto (targa,cilindrata,marca,nazione,tasse) VALUES ('TT4568',1050,'Ducati','Giappone','100€');
INSERT INTO moto (targa,cilindrata,marca,nazione,tasse) VALUES ('TT7777',1000,'Honda','Giappone','100€');
INSERT INTO moto (targa,cilindrata,marca,nazione,tasse) VALUES ('BB1233',125,'Honda','Italia','100€');
INSERT INTO moto (targa,cilindrata,marca,nazione,tasse) VALUES ('AB1211',750,'Kawasaki','Italia','100€');

INSERT INTO proprietario (nome,targa) VALUES ('Gino','AA1234');
INSERT INTO proprietario (nome,targa) VALUES ('Gino','BB1233');
INSERT INTO proprietario (nome,targa) VALUES ('Gino','AB1211');
INSERT INTO proprietario (nome,targa) VALUES ('Giacomo','ZZ2222');
INSERT INTO proprietario (nome,targa) VALUES ('Chri','TT7777');
INSERT INTO proprietario (nome,targa) VALUES ('Chri','TT4568');