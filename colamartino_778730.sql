DROP DATABASE IF EXISTS testateGiornalistiche_colamartino;
CREATE DATABASE testateGiornalistiche_colamartino;

USE testateGiornalistiche_colamartino;

CREATE TABLE redattori(
    idRedattori varchar(3) PRIMARY KEY,
    cognome varchar(10),
    nome varchar(8),
    via varchar(15),
    citta varchar(15),
    provincia char(2),
    CAP char(5),
    email text
);

CREATE TABLE redazioni(
    idRedazione varchar(4) PRIMARY KEY,
    nomeComitato varchar(10),
    citta varchar(8),
    indirizzoWeb text
);

CREATE TABLE testate(
    idTestata varchar(4) PRIMARY KEY,
    nome varchar(20),
    redazione varchar(4),
    CONSTRAINT testate_redazione FOREIGN KEY (redazione) REFERENCES redazioni(idRedazione)
);

CREATE TABLE redazRedat (
    idRedazione VARCHAR(4),
    idRedattori VARCHAR(3),
    PRIMARY KEY (idRedazione, idRedattori),
    CONSTRAINT redazRedat_idRedazione FOREIGN KEY (idRedazione) REFERENCES redazioni(idRedazione),
    CONSTRAINT redazRedat_idRedattori FOREIGN KEY (idRedattori) REFERENCES redattori(idRedattori)
);

CREATE TABLE categorie (
    nomeCategoria varchar(10) PRIMARY KEY,
    categoriaPadre varchar(10),
    CONSTRAINT categorie_categoriaPadre FOREIGN KEY (categoriaPadre) REFERENCES categorie(nomeCategoria) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE inserzioni (
    codice varchar(6) PRIMARY KEY,
    testo text,
    categoria varchar(10),
    CONSTRAINT inserzioni_categoria FOREIGN KEY (categoria) REFERENCES categorie(nomeCategoria) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE instest (
    idInserzione varchar(6),
    idTestata varchar(4),
    PRIMARY KEY(idInserzione, idTestata),
    CONSTRAINT instest_idInserzione FOREIGN KEY (idInserzione) REFERENCES inserzioni(codice),
    CONSTRAINT instest_idTestata FOREIGN KEY (idTestata) REFERENCES testate(idTestata)
);

CREATE TABLE aziende (
    idAzienda varchar(6) PRIMARY KEY,
    nomeAzienda varchar(40),
    referente varchar(40),
    telefono varchar(11),
    citta varchar(15),
    provincia char(2),
    CAP char(5),
    CapitaleSociale int
);

CREATE TABLE insaz (
    idAzienda varchar(6),
    idInserzione varchar(6),
    PRIMARY KEY (idAzienda, idInserzione),
    CONSTRAINT insaz_idAzienda FOREIGN KEY (idAzienda) REFERENCES aziende(idAzienda),
    CONSTRAINT insaz_idInserzione FOREIGN KEY (idInserzione) REFERENCES inserzioni(codice)
);

CREATE TABLE privati (
    idPrivato varchar(6) PRIMARY KEY, /* creo il campo idPrivato con lunghezza 6 invece che 3 per rispettare il vincolo di chiave esterna che dovrà sostenere con la tabella inspriv */
    cognome varchar(10),
    nome varchar(8),
    via varchar(15),
    citta varchar(15),
    provincia char(2),
    CAP char(5),
    email text
);

CREATE TABLE inspriv (
    idPrivato varchar(6),
    idInserzione varchar(6),
    PRIMARY KEY(idPrivato, idInserzione),
    CONSTRAINT inspriv_idPrivato FOREIGN KEY (idPrivato) REFERENCES privati(idPrivato),
    CONSTRAINT inspriv_idInserzione FOREIGN KEY (idInserzione) REFERENCES inserzioni(codice)
);


/* 1.  inserire nel database almeno tre testate di giornale; */
/* 5. inserire nel database tanti comitati di redazioni quante sono le testate di giornale inserite */

INSERT INTO redazioni (idRedazione, nomeComitato, citta, indirizzoWeb)
VALUES ('R001','Repubblica','Milano','www.Repubblica.it');
INSERT INTO redazioni (idRedazione, nomeComitato, citta, indirizzoWeb)
VALUES ('R002','Amzt','Roma','www.Amzt.it');
INSERT INTO redazioni (idRedazione, nomeComitato, citta, indirizzoWeb)
VALUES ('R003','Gazzetta','Milano','www.GazzettaUfficiale.it');

INSERT INTO testate (idTestata, nome, redazione)
VALUES ('T001','Testata1','R001');
INSERT INTO testate (idTestata, nome, redazione)
VALUES ('T002','Testata2','R002');
INSERT INTO testate (idTestata, nome, redazione)
VALUES ('T003','Testata3','R003');

/* 2. modificare la dimensione del nome e del cognome dei privati in testo di 30 caratteri
utilizzando l'istruzione ALTER TABLE */

ALTER TABLE privati
MODIFY column nome varchar(30);

ALTER TABLE privati
MODIFY column cognome varchar(30);

/*  3. creare la tabella città avente come attributi: città, provincia e CAP, in cui CAP è chiave
primaria */

CREATE TABLE citta (
    CAP char(5) PRIMARY KEY, 
    citta varchar(15),
    provincia char(2)
);

/* 4. modificare le tabelle in cui è presente l'attributo città in modo che abbiano una chiave esterna
alla tabella città al posto dei tre attributi separati; */

ALTER TABLE privati
ADD CONSTRAINT privati_CAP FOREIGN KEY (CAP) references citta(CAP);

ALTER TABLE aziende
ADD  CONSTRAINT aziende_CAP FOREIGN KEY (CAP) references citta(CAP);

ALTER TABLE redattori
ADD CONSTRAINT redattori_CAP FOREIGN KEY (CAP) references citta(CAP);

/* per evitare la ridondanza elimino i campi ripetuti */

ALTER TABLE privati
DROP COLUMN provincia;

ALTER TABLE privati
DROP COLUMN citta;

ALTER TABLE aziende
DROP COLUMN provincia;

ALTER TABLE aziende
DROP COLUMN citta;

ALTER TABLE redattori
DROP COLUMN provincia;

ALTER TABLE redattori
DROP COLUMN citta;

/* 6.  inserire nel database un numero di persone che compongono i comitati di redazione, tenendo
conto che qualche redattore può far parte di più comitati; */

/* Per poter inserire dei redattori, bisogna inserire almeno una città poiché usata come chiave esterna */

INSERT INTO citta(CAP, citta, provincia)
VALUES ('20100','Milano','MI');

INSERT INTO citta(CAP, citta, provincia)
VALUES ('76121','Barletta','BT');

INSERT INTO citta(CAP, citta, provincia)
VALUES ('70054','Giovinazzo','BA');

SELECT * FROM citta;
/* Ora inserisco i redattori */

INSERT INTO redattori(idRedattori, cognome, nome, via, CAP, email)
VALUES ('R01','Rossi','Mario','Via Roma 1','20100','Rossi.Mario@gmail.com');

INSERT INTO redattori(idRedattori, cognome, nome, via, CAP, email)
VALUES ('R02','Piccolo','Alessia','Via Andria 1','76121','Alessia.Piccolo@gmail.com');

INSERT INTO redattori(idRedattori, cognome, nome, via, CAP, email)
VALUES ('R03','Cola','Antonio','Via XX 1','70054','ColamartinoAntonioçoutlook.it');
/* Ora popolo la tabella redazRedat in modo da collegare i redattori alle redazioni */

INSERT INTO redazRedat(idRedazione, idRedattori)
VALUES('R001','R01');

INSERT INTO redazRedat(idRedazione, idRedattori)
VALUES('R001','R02');

INSERT INTO redazRedat(idRedazione, idRedattori)
VALUES('R002','R02');

INSERT INTO redazRedat(idRedazione, idRedattori)
VALUES('R003','R03');

/* 7.  modificare la tabella categorie in modo che la chiave primaria sia idCategoria anziché
nomeCategoria */

/* Per fare ciò bisogna prima rimuovere i vincoli, modificare, e successivamente riapplicarli */
ALTER TABLE inserzioni
DROP FOREIGN KEY  inserzioni_categoria,
DROP INDEX inserzioni_categoria;

ALTER TABLE categorie 
DROP FOREIGN KEY categorie_categoriaPadre,
DROP INDEX categorie_categoriaPadre;

ALTER TABLE categorie
DROP PRIMARY KEY;

ALTER TABLE categorie
ADD COLUMN idCategoria varchar(6) PRIMARY KEY;

ALTER TABLE categorie
MODIFY categoriaPadre varchar(6);

ALTER TABLE categorie
ADD CONSTRAINT categorie_categoriaPadre FOREIGN KEY (categoriaPadre) references categorie(idCategoria) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE inserzioni
MODIFY categoria varchar(6),
ADD CONSTRAINT inserzioni_categoria FOREIGN KEY (categoria) references categorie(idCategoria) ON DELETE CASCADE ON UPDATE CASCADE;

/* Controllo la struttura di ogni tabella */

SHOW TABLES;

DESCRIBE aziende;
DESCRIBE categorie;
DESCRIBE citta;
DESCRIBE insaz;
DESCRIBE inserzioni;
DESCRIBE inspriv;
DESCRIBE instest;
DESCRIBE privati;
DESCRIBE redattori;
DESCRIBE redazRedat;
DESCRIBE redazioni;
DESCRIBE testate;


/* 8.  inserire le categorie e ognuna con un diverso numero di sottocategorie */

    INSERT INTO categorie VALUES ('Case', NULL, 'CAT001');
    INSERT INTO categorie VALUES ('Affitti', 'CAT001', 'CAT002');
    INSERT INTO categorie VALUES ('Vendite', 'CAT001', 'CAT003');
    INSERT INTO categorie VALUES ('Sport', NULL, 'CAT004');
    INSERT INTO categorie VALUES ('Calcio', 'CAT004', 'CAT005');
    INSERT INTO categorie VALUES ('Nuoto', 'CAT004', 'CAT006');
    INSERT INTO categorie VALUES ('Sociale', NULL, 'CAT007');
    INSERT INTO categorie VALUES ('Politica', 'CAT007', 'CAT008');
    INSERT INTO categorie VALUES ('VIP', 'CAT007', 'CAT009');
    INSERT INTO categorie VALUES ('Eventi', 'CAT007', 'CAT010');
    INSERT INTO categorie VALUES ('Tecnologia', NULL, 'CAT011');
    INSERT INTO categorie VALUES ('Smartphone', 'CAT011', 'CAT012');
    INSERT INTO categorie VALUES ('Computer', 'CAT011', 'CAT013');
    INSERT INTO categorie VALUES ('Componenti', 'CAT011', 'CAT014');
    INSERT INTO categorie VALUES ('Software', 'CAT011', 'CAT015');

/* Controllo l'inserimento */

SELECT * FROM categorie;

/* 9. inserire nelle tabelle almeno 10 inserzioni di privati e 10 inserzioni di aziende */

INSERT INTO privati VALUES ('PRI001','Azzurri','Francesco','Via Primo','20100','AzzurriFrancesco@gmail.com');
INSERT INTO privati VALUES ('PRI002','Rossi','Mario','Via Secondo','70054','RossiMario@gmail.com');
INSERT INTO privati VALUES ('PRI003','Gialli','Gaetano','Via Terzo','70054','GialliGaetano@gmail.com');
INSERT INTO privati VALUES ('PRI004','Nero','Giuseppe','Via Quarto','76121','NeroGiuseppe@gmail.com');
INSERT INTO privati VALUES ('PRI005','Grigio','Antonio','Via Quinto','76121','GrigioAntonio@gmail.com');
INSERT INTO privati VALUES ('PRI006','Viola','Claudio','Via Sesto','20100','ViolaClaudio@gmail.com');
INSERT INTO privati VALUES ('PRI007','Pianchi','Pasquale','Via Settimo','20100','BianchiPasquale@gmail.com');
INSERT INTO privati VALUES ('PRI008','Celeste','Aurora','Via Ottavo','70054','CelesteGiovanni@gmail.com');

SELECT * FROM privati;

INSERT INTO aziende VALUES ('AZI001',' Azienduno','Luca Uno','3680252872','20100',20000);
INSERT INTO aziende VALUES ('AZI002',' Aziendue','Ruggero Due','3685452872','20100',650000);
INSERT INTO aziende VALUES ('AZI003',' Aziendtre','Piergiacomo Tre','3688765872','70054',670000);
INSERT INTO aziende VALUES ('AZI004',' Aziendquat','Giacomo Quattro','3655652306','70054',20000000);
INSERT INTO aziende VALUES ('AZI005',' Aziendcinq','Luigi Quinto','0800252832','76121',19000000);
INSERT INTO aziende VALUES ('AZI006',' Aziendsix','Arcangelo Sesto','0800250694','76121',4920000);

SELECT * FROM aziende;

INSERT INTO inserzioni VALUES ('INS001','Vendesi Monolocale in via Milano','CAT003');
INSERT INTO inserzioni VALUES ('INS002','Affittasi camera matrimoniale vicino al Politecnico','CAT002');
INSERT INTO inserzioni VALUES ('INS003','Allegri lascia la Juventus','CAT005');
INSERT INTO inserzioni VALUES ('INS004','Federica Pellegrini vince le olimpiadi','CAT006');
INSERT INTO inserzioni VALUES ('INS005','Vendesi iPhone X usato a €200','CAT012');
INSERT INTO inserzioni VALUES ('INS006','Elezioni 2024 USA','CAT008');
INSERT INTO inserzioni VALUES ('INS007','Lancio del nuovo iPhone 16','CAT012');
INSERT INTO inserzioni VALUES ('INS008','Sanremo 2024: i concorrenti','CAT010');
INSERT INTO inserzioni VALUES ('INS009','Nasce il figlio di Elon Musk','CAT009');
INSERT INTO inserzioni VALUES ('INS010','Lancio di Windows 11','CAT015');
INSERT INTO inserzioni VALUES ('INS011','Affittasi Villa Fasano','CAT002');
INSERT INTO inserzioni VALUES ('INS012','Intel presenta il nuovo processore i11','CAT014');
INSERT INTO inserzioni VALUES ('INS013','Recensione del nuovo processore di intel i11','CAT014');
INSERT INTO inserzioni VALUES ('INS014','Legge svuota carceri bocciata in senato','CAT008');
INSERT INTO inserzioni VALUES ('INS015','Apertura centro studi e formazione a Poggiofranco','CAT007');
INSERT INTO inserzioni VALUES ('INS016','Piersilvio Berlusconi lascia la rai','CAT009');
INSERT INTO inserzioni VALUES ('INS017','Adobe lancia il nuovo pacchetto','CAT015');
INSERT INTO inserzioni VALUES ('INS018','Vendesi casa in via Brombeis','CAT003');
INSERT INTO inserzioni VALUES ('INS019','Dibattito politico in centro a Bari','CAT010');
INSERT INTO inserzioni VALUES ('INS020','La Francia non parteciperà alla gara europea di Nuoto','CAT006');

SELECT * FROM inserzioni;

/* Ho popolato la tabella con 20 inserzioni, ora popolo le tabelle di collegamento con 10 inserzioni per i privati e 10 per le aziende */

INSERT INTO inspriv VALUES ('PRI001','INS001');
INSERT INTO inspriv VALUES ('PRI001','INS002');
INSERT INTO inspriv VALUES ('PRI002','INS005');
INSERT INTO inspriv VALUES ('PRI003','INS013');
INSERT INTO inspriv VALUES ('PRI004','INS018');
INSERT INTO inspriv VALUES ('PRI005','INS016');
INSERT INTO inspriv VALUES ('PRI006','INS011');
INSERT INTO inspriv VALUES ('PRI007','INS007');
INSERT INTO inspriv VALUES ('PRI008','INS017');
INSERT INTO inspriv VALUES ('PRI008','INS010');

SELECT * FROM inspriv;

INSERT INTO insaz VALUES ('AZI001','INS003');
INSERT INTO insaz VALUES ('AZI002','INS004');
INSERT INTO insaz VALUES ('AZI003','INS006');
INSERT INTO insaz VALUES ('AZI004','INS008');
INSERT INTO insaz VALUES ('AZI005','INS009');
INSERT INTO insaz VALUES ('AZI006','INS012');
INSERT INTO insaz VALUES ('AZI001','INS014');
INSERT INTO insaz VALUES ('AZI002','INS015');
INSERT INTO insaz VALUES ('AZI003','INS019');
INSERT INTO insaz VALUES ('AZI004','INS020');

SELECT * FROM insaz;

/* Popolo anche la tabella di collegamento instest tenendo conto che alcune inserzioni possono essere pubblicate su testate diverse */

INSERT INTO instest VALUES ('INS001','T001');
INSERT INTO instest VALUES ('INS002','T002');
INSERT INTO instest VALUES ('INS003','T003');
INSERT INTO instest VALUES ('INS004','T001');
INSERT INTO instest VALUES ('INS005','T002');
INSERT INTO instest VALUES ('INS006','T003');
INSERT INTO instest VALUES ('INS007','T001');
INSERT INTO instest VALUES ('INS008','T002');
INSERT INTO instest VALUES ('INS009','T003');
INSERT INTO instest VALUES ('INS010','T001');
INSERT INTO instest VALUES ('INS011','T002');
INSERT INTO instest VALUES ('INS012','T003');
INSERT INTO instest VALUES ('INS013','T001');
INSERT INTO instest VALUES ('INS014','T002');
INSERT INTO instest VALUES ('INS015','T003');
INSERT INTO instest VALUES ('INS016','T001');
INSERT INTO instest VALUES ('INS017','T002');
INSERT INTO instest VALUES ('INS018','T003');
INSERT INTO instest VALUES ('INS019','T001');
INSERT INTO instest VALUES ('INS020','T002');
INSERT INTO instest VALUES ('INS001','T003');
INSERT INTO instest VALUES ('INS002','T001');

SELECT * FROM instest;

/* INIZIO QUERY DI INTERROGAZIONE */

/* 6. visualizzare il nome di tutte le testate presenti nel database */

SELECT DISTINCT nome
FROM testate;

/* 7. visualizzare l'elenco dei redattori presenti nel database, mostrando tutte le informazioni
disponibili; */

SELECT *
FROM redattori;

/* 8. visualizzare l'elenco dei redattori presenti nel database, mostrando cognome e nome */

SELECT cognome, nome
FROM redattori;

/* 9. visualizzare l'elenco dei redattori presenti nel database, mostrando cognome, nome ed
e-mail; */

SELECT cognome, nome, email
FROM redattori;

/* 10. visualizzare l'elenco dei redattori presenti nel database la cui e-mail inizia con la lettera a; */

SELECT *
FROM redattori
WHERE email LIKE 'a%';

/* 11. visualizzare i redattori che hanno inserito un'email corretta (quelli in cui il campo e-mail
contiene una chiocciola; */

SELECT *
FROM redattori
WHERE email LIKE '%@%';

/* 12. visualizzare i redattori che hanno inserito un'email sbagliata (quelli in cui il campo e-mail
NON contiene una chiocciola; */

SELECT *
FROM redattori
WHERE email NOT LIKE '%@%';

/* 13. visualizzare il nome di comitato di tutte le redazioni presenti nel database, se presente
anche l'indirizzo web; */

SELECT nomeComitato, indirizzoWeb
FROM redazioni;

/* 14. visualizzare il testo e il codice delle inserzioni della categoria 'casa', se questa categoria
non è presente prenderne un'altra */

SELECT testo, codice
FROM inserzioni INNER JOIN categorie ON inserzioni.categoria = categorie.idCategoria
WHERE categorie.nomeCategoria = 'Case';

/* Poiché la categoria Case è stata usata come una categoria padre non ho popolato inserzioni con quella categoria, quindi la tabella restituita è vuota, provo la stessa query con la categoria 'Vendite' */

SELECT testo, codice
FROM inserzioni INNER JOIN categorie ON inserzioni.categoria = categorie.idCategoria
WHERE categorie.nomeCategoria = 'Vendite';

/* 15. visualizzare il codice e il testo di tutte le inserzioni che hanno al loro interno la parola
'casa'; */

SELECT codice, testo
FROM inserzioni
WHERE testo LIKE '%casa%';

/* 16. visualizzare il codice e il testo di tutte le inserzioni che hanno al loro interno la parola 'casa'
e la sottostringa 'vend' */

SELECT codice, testo
FROM inserzioni
WHERE testo LIKE '%casa%' AND testo like '%vend%';

/* 17. visualizzare il codice e il testo di tutte le inserzioni che hanno al loro interno la sottostringa
'modic'; */

SELECT codice, testo
FROM inserzioni
WHERE testo LIKE '%modic%';

/* 18. visualizzare l'elenco dei privati presenti nel database; */

SELECT *
FROM privati;

/* 19. visualizzare l'elenco dei privati provenienti dalla città con CAP: 70125 o 70126; */

SELECT *
FROM privati
WHERE CAP = '70125' OR CAP = '70126';

/* 20. visualizzare l'elenco delle aziende il cui telefono contiene le cifre: 556 */

SELECT *
FROM aziende
WHERE telefono LIKE '%556%';

/* Inserisco i valori nei campi: età e numero civico, nella tabella privati */

ALTER TABLE privati
ADD COLUMN numeroCivico int;

ALTER TABLE privati
ADD COLUMN eta int;

/* Popolo i nuovi campi della tabella */

UPDATE privati SET numeroCivico = 1 WHERE idPrivato = 'PRI001';
UPDATE privati SET numeroCivico = 2 WHERE idPrivato = 'PRI002';
UPDATE privati SET numeroCivico = 3 WHERE idPrivato = 'PRI003';
UPDATE privati SET numeroCivico = 4 WHERE idPrivato = 'PRI004';
UPDATE privati SET numeroCivico = 15 WHERE idPrivato = 'PRI005';
UPDATE privati SET numeroCivico = 10 WHERE idPrivato = 'PRI006';
UPDATE privati SET numeroCivico = 7 WHERE idPrivato = 'PRI007';
UPDATE privati SET numeroCivico = 21 WHERE idPrivato = 'PRI008';

UPDATE privati SET eta = 43 WHERE idPrivato = 'PRI001';
UPDATE privati SET eta = 34 WHERE idPrivato = 'PRI002';
UPDATE privati SET eta = 33 WHERE idPrivato = 'PRI003';
UPDATE privati SET eta = 65 WHERE idPrivato = 'PRI004';
UPDATE privati SET eta = 18 WHERE idPrivato = 'PRI005';
UPDATE privati SET eta = 32 WHERE idPrivato = 'PRI006';
UPDATE privati SET eta = 21 WHERE idPrivato = 'PRI007';
UPDATE privati SET eta = 22 WHERE idPrivato = 'PRI008';

SELECT * FROM privati;

/* faccio lo stesso per la tabella aziende dove aggiungo i campi numeroCivico e annoFondazione */

ALTER TABLE aziende
ADD COLUMN numeroCivico int;

ALTER TABLE aziende
ADD COLUMN annoFondazione int;

UPDATE aziende SET numeroCivico = 1 WHERE idAzienda = 'AZI001';
UPDATE aziende SET numeroCivico = 2 WHERE idAzienda = 'AZI002';
UPDATE aziende SET numeroCivico = 3 WHERE idAzienda = 'AZI003';
UPDATE aziende SET numeroCivico = 4 WHERE idAzienda = 'AZI004';
UPDATE aziende SET numeroCivico = 17 WHERE idAzienda = 'AZI005';
UPDATE aziende SET numeroCivico = 16 WHERE idAzienda = 'AZI006';

UPDATE aziende SET annoFondazione = 1993 WHERE idAzienda = 'AZI001';
UPDATE aziende SET annoFondazione = 1908 WHERE idAzienda = 'AZI002';
UPDATE aziende SET annoFondazione = 1938 WHERE idAzienda = 'AZI003';
UPDATE aziende SET annoFondazione = 2016 WHERE idAzienda = 'AZI004';
UPDATE aziende SET annoFondazione = 2012 WHERE idAzienda = 'AZI005';
UPDATE aziende SET annoFondazione = 1969 WHERE idAzienda = 'AZI006';

SELECT * FROM aziende;

/* 21. visualizzare il nome di tutte le aziende presenti nel database */

SELECT nomeAzienda
FROM aziende;

/* 22. visualizzare il nome di tutte le aziende presenti nel database aventi anno di fondazione precedente al
1980; */

SELECT nomeAzienda
FROM aziende
WHERE annoFondazione<1980;

/* 23. visualizzare il nome di tutte le aziende presenti nel database aventi anno di fondazione successivo al
1998; */

SELECT nomeAzienda
FROM aziende
WHERE annoFondazione>1998;

/* 24. visualizzare il nome di tutte le aziende presenti nel database aventi anno di fondazione compreso tra il
1980 e il 1998; */

SELECT nomeAzienda
FROM aziende
WHERE annoFondazione BETWEEN 1980 AND 1998;

/* 25. visualizzare l'elenco dei privati presenti nel database, mostrando tutte le informazioni disponibili,
evitando l'uso dell'asterisco;  */

SELECT idPrivato, cognome, nome, via, CAP, email, numeroCivico, eta
FROM privati;

/* 26. visualizzare l'elenco dei privati presenti nel database che abitano in un numero civico superiore a 20,
mostrando cognome e nome e numero civico */

SELECT cognome, nome, numeroCivico
FROM privati
WHERE numeroCivico > 20;

/* 27. visualizzare l'elenco dei privati presenti nel database che abitano in un numero civico pari a 10 o a 15,
mostrando cognome e nome e numero civico; */

SELECT cognome, nome, numeroCivico
FROM privati
WHERE numeroCivico = 10 OR numeroCivico = 15;

/* 28. visualizzare nome, cognome, via, numero civico e CAP dei privati il cui numero civico è compreso tra
15 e 30, visualizzare CAP come Codice_Avviamento_Postale; */

SELECT nome, cognome, via, numeroCivico, CAP AS Codice_Avviamento_Postale
FROM privati
WHERE numeroCivico > 15 AND numeroCivico < 30;

/* 29. visualizzare il nome e il capitale sociale delle aziende, visualizzare anche la metà del capitale sociale
con il nome: Plafond_max_disponibile; */

SELECT nomeAzienda, capitaleSociale, ( capitaleSociale / 2) AS Plafond_max_disponibile
FROM aziende;

/* 30. visualizzare le età e il nome dei privati che hanno un'età inferiore a 30; */

SELECT eta, nome
FROM privati
WHERE eta < 30;

/* 31. visualizzare il nome di comitato di tutte le redazioni presenti nel database che hanno all'interno del
nome una sottostringa costituita da tre lettere di cui ma lettera centrale non è importante: "m t"; */

SELECT nomeComitato
FROM redazioni
WHERE nomeComitato LIKE '%m_t%';

/* 32. creare una tabella PrivatiGiovani con le stesse caratteristiche della tabella Privati e senza vincoli di
integrità interrelazionali; */

CREATE TABLE PrivatiGiovani (
    idPrivato varchar(6) PRIMARY KEY,
    cognome varchar(30),
    nome varchar(30),
    via varchar(15),
    CAP char(5),
    email text,
    numeroCivico int,
    eta int
);

/* controllo che la struttura sia identica a Privati */

DESCRIBE privati;
DESCRIBE PrivatiGiovani;

/* 33. inserire nella tabella PrivatiGiovani tutti i privati contenuti nella tabella Privati che hanno età inferiore a
30; */

INSERT INTO PrivatiGiovani ( SELECT * FROM privati WHERE eta < 30);

SELECT * FROM PrivatiGiovani;

/* 34. Rinominare il cognome dei PrivatiGiovani il cui cognome inizia con la lettera "P" con la parola "Rossi"; */

UPDATE PrivatiGiovani SET cognome = 'Rossi' WHERE cognome LIKE 'P%';

/* 35. Rinominare il nome dei PrivatiGiovani il cui nome contiene la sottostringa "aur" con la parola "Arnold"; */

UPDATE PrivatiGiovani SET nome = 'Arnold' WHERE nome LIKE '%aur%';

/* 36. visualizzare cognome, nome ed età dei privati il cui nome è Arnold, in particolare visualizzare il campo
nome come "Nick"; */

/* Eseguo questa query sulla tabella PrivatiGiovani perché è effettivamente quella dove ho precedentemente modificato alcuni nomi in Arnold e posso trovarne sicuramente */

SELECT cognome, nome AS Nick, eta
FROM PrivatiGiovani
WHERE nome = 'Arnold';

/* 37. visualizzare cognome, nome ed età dei privati il cui cognome è "Rossi", in particolare visualizzare un
unico campo cognomenome come "Pilota"; */

/* Per lo stesso motivo di prima anche questa query la eseguo su PrivatiGiovani */

SELECT CONCAT(cognome, ' ', nome) as Pilota, eta
FROM PrivatiGiovani
WHERE cognome = 'Rossi';

/* 38. visualizzare l'elenco delle aziende il cui telefono inizia per 080. */

SELECT *
FROM aziende
WHERE telefono LIKE '080%';

/* 39. visualizzare il nome e il numero civico di tutte le aziende presenti nel database che hanno o potrebbero
avere un numero civico superiore a 15; */

SELECT nomeAzienda, numeroCivico
FROM aziende
WHERE numeroCivico > 15 OR numeroCivico IS NULL;

/* 40. visualizzare il nome e l'anno di fondazione di tutte le aziende presenti nel database che hanno o
potrebbero avere anno di fondazione precedente al 1980; */

SELECT nomeAzienda, annoFondazione
FROM aziende
WHERE annoFondazione < 1980 OR annoFondazione IS NULL;

/* 41. visualizzare il nome di tutte le aziende presenti nel database che hanno o potrebbero avere anno di
fondazione compreso tra il 1980 e il 1998; */

SELECT nomeAzienda
FROM aziende
WHERE annoFondazione BETWEEN 1980 AND 1998 OR annoFondazione IS NULL;

/* 42. visualizzare codice, testo e categoria delle inserzioni presenti nel database; */

SELECT codice, testo, categoria
FROM inserzioni;

/* 43. visualizzare l'elenco dei codici di inserzioni e dei codici delle aziende (tabella insaz); */

SELECT *
FROM insaz;

/* 44. visualizzare per ogni codice articolo presente in insaz nome azienda, referente e telefono utilizzando il
prodotto cartesiano; */

SELECT idInserzione AS Codice_Articolo, nomeAzienda, referente, telefono
FROM aziende, insaz
WHERE insaz.idAzienda = aziende.idAzienda; 

/* 45. visualizzare, utilizzando il prodotto cartesiano, codice, testo e categoria delle inserzioni con relativi
nome azienda, referente, telefono, utilizzando le tabelle aziende, insaz e inserzioni; */

SELECT codice, testo, categoria, nomeAzienda, referente, telefono
FROM aziende, insaz, inserzioni
WHERE aziende.idAzienda = insaz.idAzienda AND inserzioni.codice = insaz.idInserzione;

/* 46. visualizzare l'interrogazione precedente effettuando le seguenti ridenominazioni sulle relative tabelle:
aziende in elenco_aziende, insaz in IA, inserzioni in pubblicazioni; */

SELECT codice, testo, categoria, nomeAzienda, referente, telefono
FROM aziende AS elenco_aziende, insaz AS IA, inserzioni AS pubblicazioni
WHERE elenco_aziende.idAzienda = IA.idAzienda AND pubblicazioni.codice = IA.idInserzione;

/* 47. visualizzare l'interrogazione precedente ridenominando i seguenti attributi: codice in codice_articolo,
testo in descrizione; */

SELECT codice AS codice_articolo, testo AS descrizione, categoria, nomeAzienda, referente, telefono
FROM aziende AS elenco_aziende, insaz AS IA, inserzioni AS pubblicazioni
WHERE elenco_aziende.idAzienda = IA.idAzienda AND pubblicazioni.codice = IA.idInserzione;

/* 48. della query precedente visualizzare solo le aziende che hanno un capitale sociale superiore 18000000; */

SELECT codice AS codice_articolo, testo AS descrizione, categoria, nomeAzienda, referente, telefono
FROM aziende AS elenco_aziende, insaz AS IA, inserzioni AS pubblicazioni
WHERE elenco_aziende.idAzienda = IA.idAzienda AND pubblicazioni.codice = IA.idInserzione AND capitaleSociale > 18000000;

/* 49. visualizzare l'elenco dei nomi dei privati presenti nel database; */

SELECT nome
FROM privati;

/* 50. visualizzare l'elenco dei nomi diversi presenti nel database; */

SELECT DISTINCT nome
FROM privati;

/* 51. ripetere le interrogazioni dalla numero 45 alla numero 48 utilizzando il NATURAL JOIN (Join naturale); */

/* 45 */

SELECT codice, testo, categoria, nomeAzienda, referente, telefono
FROM ( SELECT idInserzione AS codice, idAzienda FROM insaz)
    insaz NATURAL JOIN inserzioni NATURAL JOIN aziende;

/* 46 */

SELECT codice, testo, categoria, nomeAzienda, referente, telefono
FROM (SELECT idInserzione AS codice, idAzienda FROM insaz AS IA)
    IA NATURAL JOIN inserzioni pubblicazioni NATURAL JOIN aziende elenco_aziende;

/* 47 */

SELECT codice_articolo, descrizione, categoria, nomeAzienda, referente, telefono
FROM ( SELECT idInserzione AS codice_articolo, idAzienda FROM insaz AS IA ) IA NATURAL JOIN ( SELECT codice AS codice_articolo, testo AS descrizione, categoria FROM inserzioni AS pubblicazioni)
    pubblicazioni NATURAL JOIN aziende elenco_aziende;

/* 48 */

SELECT codice_articolo, descrizione, categoria, nomeAzienda, referente, telefono
FROM ( SELECT idInserzione AS codice_articolo, idAzienda FROM insaz AS IA) IA NATURAL JOIN ( SELECT codice AS codice_articolo, testo AS descrizione, categoria FROM inserzioni AS pubblicazioni)
    pubblicazioni NATURAL JOIN aziende elenco_aziende WHERE capitaleSociale > 18000000;

/* 52. ripetere le interrogazioni dalla numero 45 alla numero 48 utilizzando il Theta JOIN (Join esplicito); */

/* 45 */

SELECT codice, testo, categoria, nomeAzienda, referente, telefono
FROM insaz JOIN inserzioni on insaz.idInserzione = inserzioni. codice JOIN aziende ON insaz.idAzienda = aziende.idAzienda;

/* 46 */

SELECT codice, testo, categoria, nomeAzienda, referente, telefono
FROM insaz AS IA JOIN inserzioni on IA.idInserzione = inserzioni. codice JOIN aziende ON IA.idAzienda = aziende.idAzienda;

/* 47 */

SELECT codice AS codice_articolo, testo AS descrizione, categoria, nomeAzienda, referente, telefono
FROM insaz AS IA JOIN inserzioni AS pubblicazioni ON IA.idInserzione = pubblicazioni.codice JOIN aziende AS elenco_aziende on IA.idAzienda = elenco_aziende.idAzienda;

/* 48 */

SELECT codice AS codice_articolo, testo AS descrizione, categoria, nomeAzienda, referente, telefono
FROM insaz AS IA JOIN inserzioni AS pubblicazioni ON IA.idInserzione = pubblicazioni.codice JOIN aziende AS elenco_aziende on IA.idAzienda = elenco_aziende.idAzienda;
WHERE CapitaleSociale > 18000000;

/* 53. visualizzare l'interrogazione al punto 45 ordinata per numeri di telefono; */

SELECT codice, testo, categoria, nomeAzienda, referente, telefono
FROM aziende, insaz, inserzioni
WHERE aziende.idAzienda = insaz.idAzienda AND inserzioni.codice = insaz.idInserzione
ORDER BY telefono;

/* 54. visualizzare l'interrogazione al punto 45 ordinata per numeri di telefono decrescenti; */

SELECT codice, testo, categoria, nomeAzienda, referente, telefono
FROM aziende, insaz, inserzioni
WHERE aziende.idAzienda = insaz.idAzienda AND inserzioni.codice = insaz.idInserzione
ORDER BY telefono DESC;

/* 55. visualizzare l'elenco delle aziende, indicando il CAP della città in cui hanno sede; */

SELECT nomeAzienda, CAP
FROM aziende;

/* 56. visualizzare l'elenco delle aziende, e per ognuna indicare il nome della città in cui hanno sede, il CAP e
la provincia; */

SELECT aziende.*, citta.citta, citta.provincia
FROM aziende INNER JOIN citta ON aziende.CAP = citta.CAP;

/* 57. visualizzare l'elenco dei privati e per ognuno il CAP della città di residenza */

SELECT nome, cognome, CAP
FROM privati;

/* 58. visualizzare l'elenco dei privati e per ognuno il CAP, il nome e la provincia della città in cui risiedono; */

SELECT privati.*, citta.citta, citta.provincia
FROM privati INNER JOIN citta ON privati.CAP = citta.CAP;

/* 59. visualizzare l'elenco delle città e per ogni città, nome dell'azienda che ha sede nella città, nome e
cognome dei privati che risiedono nella città (fare attenzione a non visualizzare due volte le stesse
informazioni); */

SELECT DISTINCT citta.*, nomeAzienda, nome, cognome
FROM citta LEFT JOIN aziende ON citta.CAP = aziende.CAP LEFT JOIN privati ON citta.CAP = privati.CAP;

/* 60. visualizzare i privati che hanno un cognome iniziante con la lettera P oppure con la lettera A, indicando i
codici delle inserzioni che questi hanno fatto; */

SELECT privati.*, idInserzione AS codice
FROM privati NATURAL JOIN inspriv
WHERE cognome LIKE 'P%' OR cognome LIKE 'A%';

/* 61. ripetere il punto precedente visualizzando anche la categoria dell'inserzione */

SELECT privati.*, codice, categoria,
FROM privati NATURAL JOIN inspriv JOIN inserzioni on idInserzione = codice
WHERE cognome LIKE 'P%' OR cognome LIKE 'A%';

/* 62. ripetere il punto precedente visualizzando anche il testo delle inserzioni; */

SELECT privati.*, codice, categoria, testo
FROM privati NATURAL JOIN inspriv JOIN inserzioni on idInserzione = codice
WHERE cognome LIKE 'P%' OR cognome LIKE 'A%';

/* 63. visualizzare il nome dei privati e il nome delle testate in cui i privati hanno pubblicato delle inserzioni; */

SELECT DISTINCT privati.nome AS 'Nome_Privato', testate.nome as 'Nome_Testata'
FROM privati NATURAL JOIN inspriv NATURAL JOIN instest JOIN testate on instest.idTestata = testate.idTestata;

/* 64 visualizzare il nome dei privati, il nome delle testate in cui i privati hanno pubblicato delle inserzioni, i nomi dei comitati di redazione che dirigono le testate visualizzate; */

SELECT DISTINCT privati.nome AS 'Nome_Privato', testate.nome as 'Nome_Testata', nomeComitato as 'Nome_Comitato'
FROM privati NATURAL JOIN inspriv NATURAL JOIN instest JOIN testate on instest.idTestata = testate.idTestata JOIN redazioni ON testate.redazione = redazioni.idRedazione;

/* 65. visualizzare l'interrogazione al punto precedente indicando anche i nomi di tutti i redattori presenti nelle testate giornalistiche */

SELECT DISTINCT privati.nome AS 'Nome_Privato', testate.nome as 'Nome_Testata', nomeComitato as 'Nome_Comitato', redattori.nome as 'Nome_Redattore'
FROM privati NATURAL JOIN inspriv NATURAL JOIN instest JOIN testate on instest.idTestata = testate.idTestata JOIN redazioni ON testate.redazione = redazioni.idRedazione NATURAL JOIN redazRedat JOIN redattori ON redazRedat.idRedattori = redattori.idRedattori;

/* 66 effettuare l'interrogazione al punto precedente visualizzando solo i privati il cui cognome inizia con la lettera p oppure con la lettera a */

SELECT DISTINCT privati.nome AS 'Nome_Privato', testate.nome as 'Nome_Testata', nomeComitato as 'Nome_Comitato', redattori.nome as 'Nome_Redattore'
FROM privati NATURAL JOIN inspriv NATURAL JOIN instest JOIN testate on instest.idTestata = testate.idTestata JOIN redazioni ON testate.redazione = redazioni.idRedazione NATURAL JOIN redazRedat JOIN redattori ON redazRedat.idRedattori = redattori.idRedattori
WHERE privati.cognome LIKE 'P%' OR privati.cognome LIKE 'A%';
 
/* 67 Visualizzare il testo delle inserzioni presenti nelle categorie principali (quelle che non hanno categoria padre); */

SELECT testo
FROM inserzioni JOIN categorie ON inserzioni.categoria = categorie.idCategoria
WHERE categoriaPadre is NULL;

/* 68. Visualizzare il numero delle inserzioni presenti nelle categorie principali; */

SELECT COUNT(codice) as 'Inserzioni in Categorie Principali'
FROM inserzioni JOIN categorie ON inserzioni.categoria = categorie.idCategoria
WHERE categoriaPadre is NULL;

/* 69. Modificare lo script relativo ad insAz in modo da aggiungere l'attributo costo nella tabella insAz */

ALTER TABLE insaz
ADD COLUMN costo float;

ALTER TABLE insaz ADD CONSTRAINT intervallo_costo check (costo >= 30 AND costo <= 50);

DESCRIBE insaz;

/* 70 Inserire il costo delle inserzioni nella tabella insAz, variabile tra 30 e 50 euro; */

UPDATE insaz SET costo = 31 WHERE idInserzione = 'INS003';
UPDATE insaz SET costo = 31.5 WHERE idInserzione = 'INS014';
UPDATE insaz SET costo = 33 WHERE idInserzione = 'INS004';
UPDATE insaz SET costo = 35.3 WHERE idInserzione = 'INS015';
UPDATE insaz SET costo = 43 WHERE idInserzione = 'INS006';
UPDATE insaz SET costo = 44 WHERE idInserzione = 'INS019';
UPDATE insaz SET costo = 47.7 WHERE idInserzione = 'INS008';
UPDATE insaz SET costo = 36 WHERE idInserzione = 'INS020';
UPDATE insaz SET costo = 49 WHERE idInserzione = 'INS009';
UPDATE insaz SET costo = 49 WHERE idInserzione = 'INS012';

SELECT * FROM insaz;

/* 71. Visualizzare la spesa totale sostenuta dall'azienda con codice 'COM000' per pubblicare le inserzioni; */

SELECT SUM(costo) AS 'Spesa Totale Azienda'
FROM insaz
WHERE idAzienda = 'COM000'
GROUP BY idAzienda;

/* poiché ho usato uno standard diverso da quello richiesto nella traccia, provo la stessa query con un codice dello standard utilizzato */

SELECT SUM(costo) AS 'Spesa Totale Azienda'
FROM insaz
WHERE idAzienda = 'AZI002'
GROUP BY idAzienda;

/* 72. Visualizzare tutte le informazioni sulle inserzioni pubblicate; */

SELECT *
FROM inserzioni;

/* 73. Visualizzare il numero totale delle inserzioni pubblicate; */

SELECT COUNT(Codice) AS 'Numero di Inserzioni: '
FROM inserzioni;

/* 74. Visualizzare le inserzioni che hanno all'interno del testo la stringa 'affa'; */

SELECT * 
FROM inserzioni
WHERE testo LIKE '%affa%';

/* 75 Visualizzare il numero di inserzioni che hanno all'interno del testo la stringa 'affa'; */

SELECT count(codice) AS 'Inserizioni con sottostringa affa:'
FROM inserzioni
WHERE testo LIKE '%affa%';

/* 76. Visualizzare codice e costo delle inserzioni totali (utilizzare l'operatore UNION tra tabella insAz e insPriv) */

/* La query fa supporre che anche la tabella inspriv abbia il costo, quindi modifico la tabella e aggiungo il campo come ho fatto precedentemente con insaz */


ALTER TABLE inspriv
ADD COLUMN costo float;

ALTER TABLE inspriv ADD CONSTRAINT intervallo_costo check (costo >= 30 AND costo <= 50);

DESCRIBE inspriv;

UPDATE inspriv SET costo = 30 WHERE idInserzione = 'INS001';
UPDATE inspriv SET costo = 31.3 WHERE idInserzione = 'INS002';
UPDATE inspriv SET costo = 34 WHERE idInserzione = 'INS005';
UPDATE inspriv SET costo = 35 WHERE idInserzione = 'INS013';
UPDATE inspriv SET costo = 36.5 WHERE idInserzione = 'INS018';
UPDATE inspriv SET costo = 39 WHERE idInserzione = 'INS016';
UPDATE inspriv SET costo = 40 WHERE idInserzione = 'INS011';
UPDATE inspriv SET costo = 41.5 WHERE idInserzione = 'INS007';
UPDATE inspriv SET costo = 42 WHERE idInserzione = 'INS010';
UPDATE inspriv SET costo = 46 WHERE idInserzione = 'INS017';

SELECT * FROM inspriv;

SELECT idInserzione as codice, costo
FROM insaz
UNION
SELECT idInserzione as codice, costo
FROM inspriv
ORDER BY codice;

/* 77. Visualizzare il numero delle inserzioni totali (utilizzare l'operatore UNION tra tabella insAz e insPriv) */

SELECT COUNT(idInserzione) AS 'Inserzioni INserite:'
FROM ( SELECT idInserzione
FROM insaz
UNION
SELECT idInserzione
FROM inspriv)insazpriv;

/* 78. Visualizzare il numero di inserzioni di privati e il numero di inserzioni di aziende; */

SET @ins_priv = ( SELECT COUNT(idInserzione) FROM inspriv);
SET @ins_az   = ( SELECT COUNT(IdInserzione) FROM insaz);
SELECT @ins_priv AS 'Inserzioni Privati:', @ins_az AS 'Inserzioni Aziende';

/* 79. Mostrare quante inserzioni ci sono per ogni categoria */

SELECT nomeCategoria, COUNT(codice) as 'Inserzioni Per Categoria:'
FROM categorie LEFT JOIN inserzioni ON categorie.idCategoria = inserzioni.categoria
GROUP BY idCategoria;

/* 80. Visualizzare le inserzioni che appartengono a più di una categoria */

SELECT nomeCategoria
FROM categorie JOIN inserzioni ON categorie.idCategoria = inserzioni.categoria
GROUP BY idCategoria
HAVING COUNT(codice) > 1;

/* 81. Visualizzare il numero di inserzioni presenti in ciascuna categoria; */

SELECT nomeCategoria, COUNT(codice) AS 'Inserzioni Per Categoria:'
FROM categorie LEFT JOIN inserzioni on categorie.idCategoria = inserzioni.Categoria
GROUP BY nomeCategoria;

/* 82. Visualizzare il numero di inserzioni pubblicate per ogni testata (insTest collega le inserzioni alle testate) */

SELECT nome, COUNT(idInserzione) AS 'Inserzioni per Testata'
FROM testate NATURAL JOIN instest
GROUP BY nome;

/* 83. Visualizzare in quante testate è presente ogni inserzione */

SELECT codice, COUNT(idTestata) as 'Numero testate per inserzione'
FROM inserzioni JOIN instest ON inserzioni.codice = instest.idInserzione
GROUP BY codice;

/* 84. Visualizzare le inserzioni di aziende che costano meno di 35 */

SELECT inserzioni.*
FROM inserzioni JOIN insaz ON inserzioni.codice = insaz.idInserzione
WHERE costo < 35;

/* 85. Visualizzare il numero di inserzioni di aziende che costano meno di 35; */

SELECT COUNT(idInserzione) as 'Inserzioni con un costo inferiore a 35:'
FROM insaz
WHERE costo < 35;

/* 86. Quanti sono i privati presenti in ogni citta', escludendo Putignano? */

SELECT citta.citta, count(idPrivato)AS 'Numero privati in citta'
FROM citta LEFT JOIN privati on citta.CAP = privati.CAP
WHERE citta.citta != 'Putignano'
GROUP BY citta.citta;

/* 87. Visualizzare i privati di Bari ordinati per nome; */

SELECT privati.*
FROM privati JOIN citta on privati.CAP = citta.CAP
WHERE citta.citta = 'Bari'
ORDER BY privati.nome;

/* 88. Visualizzare l'età media dei privati raggruppati per nome */

SELECT nome, avg(eta)
FROM privati
GROUP BY nome;

/* 89. Visualizzare nome ed età del privato con età maggiore */

SELECT nome, eta
FROM privati
WHERE eta = (SELECT MAX(eta) FROM privati);

/* 90. Ordinare le inserzioni delle aziende (insAz) per costi crescenti e, a parità di costo, per codici decrescenti; */

SELECT *
FROM insaz
ORDER BY costo, idInserzione DESC;

/* 91. Ordinare le inserzioni delle aziende (insAz) per costi decrescenti e, a parità di costo, per codici decrescenti */

SELECT *
FROM insaz
ORDER BY costo DESC, idInserzione DESC;

/* 92. Visualizzare per ciascuna inserzione la sua descrizione; */

SELECT testo
FROM inserzioni;

/* 93. Visualizzare per ciascuna inserzione il codice dell'azienda che l'ha pubblicata; */

SELECT inserzioni.*, idAzienda
FROM inserzioni JOIN insaz ON inserzioni.codice = insaz.idInserzione;

/* 94. Visualizzare per ciascuna inserzione il codice dell'azienda che l'ha pubblicata e il nome del referente; */

SELECT inserzioni.*, aziende.idAzienda, referente
FROM inserzioni JOIN insaz ON inserzioni.codice = insaz.idInserzione NATURAL JOIN aziende;

/* 95. Visualizzare per ciascuna inserzione il codice dell'azienda che l'ha pubblicata, il nome e il telefono del referente e la città dell'azienda */

SELECT inserzioni.*, aziende.idAzienda, referente, citta.citta
FROM inserzioni JOIN insaz ON inserzioni.codice = insaz.idInserzione NATURAL JOIN aziende JOIN citta ON aziende.CAP = citta.CAP;

/* 96. Visualizzare per ciascuna inserzione il codice del privato che l'ha pubblicata */

SELECT inserzioni.*, idPrivato AS 'Codice Privato'
FROM inserzioni JOIN inspriv ON inserzioni.codice = inspriv.idInserzione;

/* 97. Visualizzare per ciascuna inserzione il codice e il nome del privato che l'ha pubblicata; */

SELECT inserzioni.*, idPrivato AS 'Codice Privato', privati.nome
FROM inserzioni JOIN inspriv ON inserzioni.codice = inspriv.idInserzione NATURAL JOIN privati;

/* 98. Visualizzare il numero di inserzioni delle aziende che hanno pubblicato nella testata con numero di inserzioni maggiore, mostrando anche il nome della testata. */

SELECT nome as 'Testate col maggior Numero di Inserzioni', nomeAzienda, count(idInserzione) AS 'Inserzioni pubblicate da aziende su testate'
FROM testate NATURAL JOIN instest NATURAL JOIN insaz NATURAL JOIN aziende
WHERE idTestata in (
    SELECT idTestata
    FROM testate NATURAL JOIN instest
    GROUP BY idTestata
    HAVING COUNT(idInserzione) = (
        SELECT MAX(numero)
        FROM (
            SELECT COUNT(idInserzione) AS numero
            FROM testate NATURAL JOIN instest
            GROUP BY idTestata
        ) inserzioni_per_testata
    )
);
