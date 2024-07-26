/*
Query per visualizzare gli utenti che hanno partecipato ad un sondaggio
*/
SELECT u.CodiceFiscale, u.Nome, u.Cognome, u.Età, u.Sesso, p.Id_sondaggio
FROM Utente u
JOIN Partecipazione p ON u.CodiceFiscale = p.CodiceFiscale
ORDER BY p.Id_sondaggio, u.Cognome, u.Nome;
/*
Visualizzare qaunti sondaggi ci sono di una determinata categoria
*/
SELECT COUNT(*) AS NumeroSondaggi
FROM Sondaggio
WHERE IdCategoria = categoria_id;
/*
visualizzare i sondaggi ai quali hanno partecipato almeno 20 utenti
*/
SELECT s.Id_sondaggio, s.Nome, s.Descrizione, COUNT(p.CodiceFiscale) AS NumeroPartecipanti
FROM Sondaggio s
JOIN Partecipazione p ON s.Id_sondaggio = p.Id_sondaggio
GROUP BY s.Id_sondaggio, s.Nome, s.Descrizione
HAVING COUNT(p.CodiceFiscale) >= 20;
