DROP TABLE IF EXISTS clienti;
DROP TABLE IF EXISTS ordini;

CREATE TABLE clienti(
	id_cliente INTEGER,
	nome VARCHAR(10) NOT NULL,
	citta VARCHAR(30) NOT NULL,

	CONSTRAINT pk_clienti PRIMARY KEY(id_cliente)
);

CREATE TABLE ordini(
	id_ordine INTEGER,
	id_cliente INTEGER,
	data DATE,
	importo NUMERIC(6,2),

	CONSTRAINT pk_ordini PRIMARY KEY(id_ordine),
	CONSTRAINT fk_ordine_cliente FOREIGN KEY (id_cliente) REFERENCES clienti(id_cliente) 
);

SELECT nome FROM clienti 
	WHERE id_cliente IN
		(SELECT id_cliente FROM ordini 
			WHERE importo>100);
/* se c'è un legame tra la query più esterna e quella più interna
persone con un campo stipendio -> ottenere tutte le persone che hanno un importo dello stipendio
che deve essere maggiore della media di tutti i suoi stipendi */