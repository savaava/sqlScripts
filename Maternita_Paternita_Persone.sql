DROP TABLE IF EXISTS maternita CASCADE;
DROP TABLE IF EXISTS paternita CASCADE;
DROP TABLE IF EXISTS persone CASCADE;

CREATE TABLE persone (
	nome VARCHAR(20) PRIMARY KEY,
	eta SMALLINT,
	reddito NUMERIC(7,2)
);

CREATE TABLE maternita (
	madre VARCHAR(20),
	figlio VARCHAR(20),
	
	PRIMARY KEY(madre,figlio),
	FOREIGN KEY (madre) REFERENCES persone(nome),
	FOREIGN KEY (figlio) REFERENCES persone(nome)
);

CREATE TABLE paternita (
	padre VARCHAR(20),
	figlio VARCHAR(20),
	
	PRIMARY KEY(padre,figlio),
	FOREIGN KEY (padre) REFERENCES persone(nome),
	FOREIGN KEY (figlio) REFERENCES persone(nome)
);

INSERT INTO persone VALUES 
	('Andrea', 27, 2100),
	('Aldo', 25, 1500),
	('Maria', 55, 4200),
	('Anna', 50, 3500),
	('Filippo', 26, 3000),
	('Luigi', 50, 4000),
	('Franco', 60, 2000),
	('Olga', 30, 4100),
	('Sergio', 85, 3500),
	('Luisa', 75, 8700);
INSERT INTO maternita VALUES 
	('Luisa','Maria'),
	('Luisa','Luigi'),
	('Anna','Olga'),
	('Anna','Filippo'),
	('Maria','Andrea'),
	('Maria','Aldo');
INSERT INTO paternita VALUES 
	('Sergio','Franco'),
	('Luigi','Olga'),
	('Luigi','Filippo'),
	('Franco','Andrea'),
	('Franco','Aldo');


/* Nome e reddito dei padri di persone che guadagnano più di 20 */
SELECT nome, reddito
	FROM persone 
	WHERE nome = ANY (
		SELECT padre 
			FROM persone pe JOIN paternita pa ON pe.nome=pa.figlio
			WHERE reddito > 2000
	);

SELECT nome, reddito
	FROM persone 
	WHERE nome = ANY (
		SELECT padre 
			FROM paternita
			WHERE figlio = ANY (
				SELECT nome FROM persone 
					WHERE reddito > 2000
			)
	);

select distinct P.Nome, P.Reddito
	from Persone P, Paternita, Persone F
	where P.Nome = Padre 
		and Figlio = F.Nome
		and F.Reddito > 2000;



/* Nome e reddito dei padri di persone che guadagnano più di 20,
con indicazione del reddito del figlio */
SELECT DISTINCT 
	p1.nome AS nome_padre,
	p1.reddito AS reddito_padre,
	p3.reddito AS reddito_figlio
	FROM persone p1, paternita p2, persone p3
	WHERE p1.nome=p2.padre
		AND p2.figlio=p3.nome
		AND p3.reddito > 2000;

SELECT DISTINCT 
	p1.nome AS nome_padre,
	p1.reddito AS reddito_padre,
	p3.reddito AS reddito_figlio
	FROM persone p1
		JOIN paternita p2 ON p1.nome=p2.padre
		JOIN persone p3 ON p2.figlio=p3.nome
	WHERE p3.reddito > 2000;



/* I padri i cui figli guadagnano tutti più di 20 */
SELECT DISTINCT padre
	FROM paternita p1
	WHERE NOT EXISTS (
		SELECT *
			FROM persone p2 JOIN paternita p3 ON p2.nome=p3.figlio
			WHERE p3.padre=p1.padre
				AND p2.reddito <= 2000
	);

SELECT padre FROM paternita
EXCEPT
SELECT padre
	FROM paternita p1 JOIN persone p2 ON p1.figlio=p2.nome
	WHERE reddito <= 2000;

SELECT padre
	FROM paternita JOIN persone ON figlio=nome 
	GROUP BY padre
	HAVING (MIN(reddito)>2000);



/* Estrarre, per ciascuna persona che ha sia una madre che un padre, le informazioni:
Nome del figlio, Nome della madre, Nome del padre, Reddito medio dei genitori
Ordnando il risultato per nome del figlio. */
SELECT 
	p.nome AS figlio,
	padre,
	madre,
	p2.reddito AS reddito_padre,
	p3.reddito AS reddito_madre,
	CAST((p2.reddito + p3.reddito)/2 AS NUMERIC(7,2)) AS reddito_medio_genitori
	FROM persone p
		JOIN paternita p1 ON p.nome=p1.figlio
		JOIN maternita m ON p.nome=m.figlio
		JOIN persone p2 ON p1.padre=p2.nome
		JOIN persone p3 ON m.madre=p3.nome
	ORDER BY figlio;




/* Per ogni madre che guadagna meno del marito, mostrare:
il nome della madre, il nome del figlio, il nome del padre, il reddito della madre, il reddito del padre
ordinando per reddito della madre */
SELECT 
	madre,
	padre,
	m.figlio,
	p1.reddito AS reddito_madre,
	p3.reddito AS reddito_padre
	FROM maternita m 
		JOIN persone p1 ON madre=p1.nome
		JOIN paternita p2 ON m.figlio=p2.figlio
		JOIN persone p3 ON p3.nome=p2.padre
	WHERE p3.reddito > p1.reddito
	ORDER BY p1.reddito; 















