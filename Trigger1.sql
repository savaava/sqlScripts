DROP TABLE IF EXISTS prodotto CASCADE;
DROP TABLE IF EXISTS produttore CASCADE;

CREATE TABLE produttore(
	nome text PRIMARY KEY,
	contatore_prodotti integer
);

CREATE TABLE prodotto (
	codice text PRIMARY KEY,
	produttore text REFERENCES produttore(nome)
);

INSERT INTO produttore VALUES ('PFIZER',0),('Astrazeneca',0);

CREATE OR REPLACE FUNCTION gestione_contatori() 
	RETURNS trigger AS
	$$
	BEGIN
	UPDATE produttore p SET contatore_prodotti = p.contatore_prodotti + (
		SELECT COUNT(*) FROM nt WHERE nt.produttore = p.nome
	);
	RETURN NULL;
	END;
	$$ 
	LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER contatori_prodotti
	AFTER INSERT ON prodotto
	REFERENCING NEW TABLE AS nt
	FOR EACH STATEMENT
	EXECUTE PROCEDURE gestione_contatori();

INSERT INTO prodotto VALUES ('Tachipirina','PFIZER');
INSERT INTO prodotto VALUES 
	('Morfina','Astrazeneca'),
	('Gaviscon','PFIZER'),
	('Velamox','Astrazeneca');

SELECT * FROM produttore;








