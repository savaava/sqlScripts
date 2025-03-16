DROP TABLE IF EXISTS "Impiegato" CASCADE;
DROP TABLE IF EXISTS "Dipartimento" CASCADE;
DROP TABLE IF EXISTS "Dip_Citta" CASCADE;
DROP TABLE IF EXISTS "Sede" CASCADE;
DROP TABLE IF EXISTS "Progetto" CASCADE;
DROP TABLE IF EXISTS "Lavora_Su" CASCADE;


CREATE TABLE "Dipartimento" (
	"Codice" CHAR(4),
	"Nome" VARCHAR(20),

	CONSTRAINT "PK_dipartimento" PRIMARY KEY ("Codice")
);

CREATE TABLE "Sede" (
	"Citta" VARCHAR(20),
	"Indirizzo" VARCHAR(40),

	CONSTRAINT "PK_sede" PRIMARY KEY ("Citta")
);

CREATE TABLE "Dip_Citta" (
	"Dipartimento" CHAR(4),
	"Sede" VARCHAR(20),
	
	CONSTRAINT "PK_dipcitta" PRIMARY KEY ("Dipartimento","Sede"),
	CONSTRAINT "FK_dipcitta_dipartimento" FOREIGN KEY ("Dipartimento") REFERENCES "Dipartimento"("Codice")
		on delete restrict on update restrict,
	CONSTRAINT "FK_dipcitta_sede" FOREIGN KEY ("Sede") REFERENCES "Sede"("Citta")
		on delete restrict on update restrict
);

CREATE TABLE "Impiegato" (
	"CF" CHAR(16),
	"Capo_CF" CHAR(16),
	"Dipartimento" CHAR(4),
	"Cognome" VARCHAR(20),
	"Nome" VARCHAR(20),
	"Data_N" date,
	"Stipendio" INTEGER,

	CONSTRAINT "PK_impiegato" PRIMARY KEY ("CF"),
	CONSTRAINT "CHECK_stipendio" CHECK ("Stipendio" >= 800 AND "Stipendio"<=3000),
	CONSTRAINT "FK_capo_is_impiegato" FOREIGN KEY ("Capo_CF") REFERENCES "Impiegato"("CF") 
		on delete restrict on update restrict,
	CONSTRAINT "FK_impiegato_dipartimento" FOREIGN KEY ("Dipartimento") REFERENCES "Dipartimento"("Codice") 
		on delete restrict on update restrict
);


CREATE TABLE "Progetto" (
	"Nome" VARCHAR(20),
	"Responsibile" CHAR(16),
	"Budget" INTEGER,

	CONSTRAINT "PK_progetto" PRIMARY KEY ("Nome"),
	CONSTRAINT "FK_progetto_impiegato" FOREIGN KEY ("Responsibile") REFERENCES "Impiegato"("CF") 
		on delete restrict on update cascade
);

CREATE TABLE "Lavora_Su" (
	"Impiegato" CHAR(16) REFERENCES "Impiegato"("CF"),
	"Progetto" VARCHAR(20) REFERENCES "Progetto"("Nome"),
	
	CONSTRAINT "PK_lavorasu" PRIMARY KEY ("Impiegato","Progetto"),
	CONSTRAINT "FK_lavorasu_impiegato" FOREIGN KEY ("Impiegato") REFERENCES "Impiegato"("CF")
		on delete restrict on update restrict,
	CONSTRAINT "FK_lavorasu_progetto" FOREIGN KEY ("Progetto") REFERENCES "Progetto"("Nome")
		on delete restrict on update restrict
);









