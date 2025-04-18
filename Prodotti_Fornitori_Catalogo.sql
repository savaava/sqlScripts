-- ===================================================================
-- DROP delle tabelle
-- =================================================================== 
DROP TABLE IF EXISTS Fornitori CASCADE; 
DROP TABLE IF EXISTS Prodotti CASCADE; 
DROP TABLE IF EXISTS Catalogo CASCADE; 
-- =================================================================== 
-- Creazione delle tabelle
-- =================================================================== 
 
CREATE TABLE Fornitori(
	fid CHAR(2) PRIMARY KEY, 
  	nome CHAR(20), 
  	indirizzo CHAR(20)
); 

CREATE TABLE Prodotti(
	pid	CHAR(3) PRIMARY KEY, 
  	nome	CHAR(20), 
  	colore	CHAR(20) 
); 
 
CREATE TABLE Catalogo( 
  	fid CHAR(2), 
  	pid CHAR(3), 
	costo REAL, 
	FOREIGN KEY (fid) REFERENCES FORNITORI(fid), 
  	FOREIGN KEY (pid) REFERENCES Prodotti(pid), 
  	PRIMARY KEY(fid,pid) 
); 
 
-- ==================================================================== 
-- Inserimento di istanze nelle tabelle
-- ==================================================================== 
 
INSERT INTO Fornitori (fid,nome,indirizzo) VALUES ('F1','ACME','via Holliwood'); 
INSERT INTO Fornitori (fid,nome,indirizzo) VALUES ('F2','Ingegneria','via Eudossiana'); 
INSERT INTO Fornitori (fid,nome,indirizzo) VALUES ('F3','Sapienza','via Scarpa'); 
INSERT INTO Fornitori (fid,nome,indirizzo) VALUES ('F4','DIS','via Ariosto'); 
INSERT INTO Fornitori (fid,nome,indirizzo) VALUES ('F5','Gest','via Buonarroti'); 
 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P1','Volante','Nero'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P2','Volante','Rosso'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P3','Carrozzeria','Nero'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P4','Carrozzeria','Rosso'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P5','Carrozzeria','Verde'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P6','Cerchione','Nero'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P7','Cerchione','Rosso'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P8','Ruota','Nero'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P9','Sedile','Nero'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P10','Sedile','Rosso'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P11','Sedile','Verde'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P12','Tappetino','Nero'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P13','Tappetino','Rosso'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P14','Tappetino','Verde'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P15','Casco','Rosso'); 
INSERT INTO Prodotti (pid,nome,colore) VALUES ('P16','Casco','Verde'); 
 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P1',100); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P2',100); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P3',500); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P4',500); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P5',500); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P6',70); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P7',70); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P8',180); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P9',220); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P10',220); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P11',220); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P12',50); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P13',50); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P14',50); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P15',90); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F1','P16',90); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P2',120); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P3',550); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P4',550); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P5',550); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P7',80); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P10',210); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P12',55); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P13',55); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P14',55); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F2','P15',120); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F3','P1',60); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F3','P3',450); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F3','P4',450); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F3','P8',60); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F4','P2',60); 
INSERT INTO Catalogo (fid,pid,costo) VALUES ('F4','P15',80);