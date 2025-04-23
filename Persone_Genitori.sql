Drop Table if exists Genitori cascade;
Drop Table if exists Persone cascade;

Create Table PERSONE (
	Nome varchar(50) Primary Key,
	Reddito integer default 0,
	Eta integer default 0,
	Sesso char(1) NOT NULL,
	
	constraint RedditoCK check (Reddito >=0 and Reddito <=1000000),
	constraint EtaCK check (Eta >=0 and Eta <=150 ),
	constraint SessoCK check (Sesso='M' or Sesso='F') 
);

Insert into Persone(Nome, Reddito, Eta, Sesso) Values ('Mario', 15, 80, 'M');
Insert into Persone(Nome, Reddito, Eta, Sesso) Values ('Carlo', 25, 24, 'M');
Insert into Persone(Nome, Reddito, Eta, Sesso) Values ('Giuseppe', 30, 45, 'M');
Insert into Persone(Nome, Reddito, Eta, Sesso) Values ('Maria', 76, 43, 'F');
Insert into Persone(Nome, Reddito, Eta, Sesso) Values ('Gianni', 60, 50, 'M');
Insert into Persone(Nome, Reddito, Eta, Sesso) Values ('Francesca', 26, 24, 'F');
Insert into Persone(Nome, Reddito, Eta, Sesso) Values ('Paola', 45, 60, 'F');
Insert into Persone(Nome, Reddito, Eta, Sesso) Values ('Marco', 80, 35, 'M');

Create Table Genitori (
	Figlio varchar(50),
	Genitore varchar(50),
	
	constraint KEYGenitori Primary Key (Figlio, Genitore),
	constraint figlioFK foreign key (Figlio) references Persone(Nome)
		ON UPDATE RESTRICT ON DELETE RESTRICT,
	constraint GenitoreFK foreign key (Genitore) references Persone(Nome)
		ON UPDATE RESTRICT ON DELETE RESTRICT 
);

Insert into Genitori(Figlio, Genitore) Values ('Paola', 'Mario');
Insert into Genitori(Figlio, Genitore) Values ('Marco', 'Paola');
Insert into Genitori(Figlio, Genitore) Values ('Carlo', 'Gianni');
Insert into Genitori(Figlio, Genitore) Values ('Carlo', 'Maria');
Insert into Genitori(Figlio, Genitore) Values ('Francesca', 'Giuseppe');
Insert into Genitori(Figlio, Genitore) Values ('Marco', 'Giuseppe');



/* Selezionare tutte le informazioni delle persone e mostrare il genitore */
SELECT g.genitore, p.*
	FROM persone p JOIN genitori g ON p.nome=g.figlio;



/* Selezionare tutte le informazioni e, se disponibile, mostrare il genitore */
SELECT p.*, g.genitore
	FROM persone p LEFT JOIN genitori g ON p.nome=g.figlio;



/* Selezionare i figli e i loro padri */
SELECT figlio, genitore AS padre
	FROM genitori g
		JOIN persone p2 ON p2.nome=g.genitore
	WHERE p2.sesso='M';



/* Trovare i nonni di ogni persona */
SELECT g1.figlio, g2.genitore AS nonno
	FROM genitori g1 JOIN genitori g2 ON g1.genitore=g2.figlio;
	


/* Mostrare le coppie di fratelli */
SELECT g1.figlio, g2.figlio
	FROM genitori g1 JOIN genitori g2 USING(genitore)
	WHERE g1.figlio<>g2.figlio;



/* Mostrare per ciascun figlio entrambi i genitori, solo se li ha entrambi */
SELECT 
	g1.figlio, 
	p1.nome AS madre,
	p2.nome AS padre
	FROM genitori g1
		JOIN genitori g2 USING(figlio)
		JOIN persone p1 ON p1.nome=g1.genitore
		JOIN persone p2 ON p2.nome=g2.genitore
	WHERE g1.genitore<>g2.genitore 
		AND p1.sesso='F'
		AND p2.sesso='M';



/* Trovare le persone che sono genitori di almeno due figli */
SELECT genitore
	FROM genitori
	GROUP BY genitore
	HAVING(COUNT(*)>=2);

SELECT DISTINCT genitore
	FROM genitori g1 JOIN genitori g2 USING(genitore)
	WHERE g1.figlio<>g2.figlio;











































































