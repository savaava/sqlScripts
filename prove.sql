DROP TABLE IF EXISTS persone;

CREATE TABLE persone(
    id INTEGER,
    nome VARCHAR(100),
    email VARCHAR(100),
	eta SMALLINT NOT NULL,
	altezza NUMERIC(5,2) DEFAULT 180,

	CONSTRAINT pk_persone PRIMARY KEY(id),
	CONSTRAINT eta_check CHECK(eta>=0 AND eta<=150),
	CONSTRAINT altezza_check CHECK(altezza>=0 AND altezza<=300)
);

INSERT INTO persone(id, nome, email, eta, altezza) VALUES (1, 'Andrea', 'andre@gm.com', 20, 180.99);
INSERT INTO persone VALUES (2, 'gg', 'andre@gm.com', 25);
INSERT INTO persone VALUES (3, 'wewe', 'andre@gm.com', 21);
INSERT INTO persone (id, eta) VALUES (44, 1);
-- INSERT INTO persone (id) VALUES (44); Non è possibile questo

SELECT * FROM persone;