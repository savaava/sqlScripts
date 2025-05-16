DROP TABLE IF EXISTS materiale CASCADE;
DROP TABLE IF EXISTS ordine CASCADE;

CREATE TABLE materiale(
	idPezzo INTEGER PRIMARY KEY,
	qntDisponibile INTEGER NOT NULL,
	qntLimite INTEGER NOT NULL,
	qntRiordino INTEGER NOT NULL
);

CREATE TABLE ordine (
	idPezzo INTEGER PRIMARY KEY REFERENCES materiale(idPezzo),
	qntRiordino INTEGER NOT NULL,
	dataOrdine DATE NOT NULL
);



INSERT INTO materiale VALUES
	(1,200,150,100),
	(2,450,400,120),
	(3,500,150,130),
	(4,100,150,100);



CREATE OR REPLACE FUNCTION Riordino()
	RETURNS TRIGGER AS
	$BODY$		
	BEGIN
		IF (NOT EXISTS (SELECT * FROM ordine o WHERE o.idPezzo = NEW.idPezzo)) THEN
			INSERT INTO ordine
				VALUES(NEW.idPezzo, NEW.qntRiordino, CURRENT_DATE); -- Potrebbe violare il vincolo PK qundi lancierebbe l'eccezione per vedere se già c'è in ordine
		END IF;
		-- E' inutile restituire qualcosa perchè il trigger è AFTER però devo comunque metterlo
		RETURN NULL;
	END;
	$BODY$
	LANGUAGE plpgsql;
	

CREATE TRIGGER riordino
	AFTER
	UPDATE OF qntDisponibile ON materiale
	FOR EACH ROW 
	WHEN (NEW.qntDisponibile < NEW.qntLimite)
	EXECUTE FUNCTION Riordino();



























