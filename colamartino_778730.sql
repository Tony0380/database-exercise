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
    FOREIGN KEY (redazione) REFERENCES redazioni(idRedazione)
);

CREATE TABLE redazRedat (
    idRedazione VARCHAR(4),
    idRedattori VARCHAR(3),
    PRIMARY KEY (idRedazione, idRedattori),
    FOREIGN KEY (idRedazione) REFERENCES redazioni(idRedazione),
    FOREIGN KEY (idRedattori) REFERENCES redattori(idRedattori)
);

CREATE TABLE categorie (
    nomeCategoria varchar(10) PRIMARY KEY,
    categoriaPadre varchar(10),
    FOREIGN KEY (categoriaPadre) REFERENCES categorie(nomeCategoria)
);

CREATE TABLE inserzioni (
    codice varchar(6) PRIMARY KEY,
    testo text,
    categoria varchar(10),
    FOREIGN KEY (categoria) REFERENCES categorie(nomeCategoria)
);

CREATE TABLE instest (
    idInserzione varchar(6),
    idTestata varchar(4),
    PRIMARY KEY(idInserzione, idTestata),
    FOREIGN KEY (idInserzione) REFERENCES inserzioni(codice),
    FOREIGN KEY (idTestata) REFERENCES testate(idTestata)
);

CREATE TABLE aziende (
    idAzienda varchar(6) PRIMARY KEY,
    nomeAzienda varchar(40),
    referente varchar(40),
    telefono varchar(11),
    citta varchar(15),
    provincia char(2),
    CAP char(5),
    email text
);

CREATE TABLE insaz (
    idAzienda varchar(6),
    idInserzione varchar(6),
    PRIMARY KEY (idAzienda, idInserzione),
    FOREIGN KEY (idAzienda) REFERENCES aziende(idAzienda),
    FOREIGN KEY (idInserzione) REFERENCES inserzioni(codice)
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
    FOREIGN KEY (idPrivato) REFERENCES privati(idPrivato),
    FOREIGN KEY (idInserzione) REFERENCES inserzioni(codice)
);

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
DESCRI