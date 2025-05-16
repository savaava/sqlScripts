UPDATE materiale 
	SET qntDisponibile = qntDisponibile - 70 
	WHERE idPezzo=3;

SELECT * FROM materiale ORDER BY idPezzo;
SELECT * FROM ordine;