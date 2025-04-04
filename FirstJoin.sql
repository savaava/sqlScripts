SELECT *
	FROM ricoveri ri
	INNER JOIN reparti re
	ON ri.reparto = re.codice
	RIGHT JOIN medici m
	ON re.primario = m.matricola;

/*SELECT * FROM reparti*/

/* da ricoveri voglio nome del reparto e il primario ad esso associato */