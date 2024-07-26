-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Lug 22, 2024
-- Versione del server: 10.4.28-MariaDB
-- Versione PHP: 8.2.4

DROP DATABASE IF EXISTS `SondaggiDB`;
CREATE DATABASE IF NOT EXISTS `SondaggiDB`;
USE `SondaggiDB`;

START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `SondaggiDB`
--

-- --------------------------------------------------------

--
-- Creazione della tabella Utente
--

CREATE TABLE `Utente` (
    `CodiceFiscale` VARCHAR(16) NOT NULL,
    `Nome` VARCHAR(50),
    `Cognome` VARCHAR(50),
    `Età` INT,
    `Sesso` CHAR(1),
    PRIMARY KEY (`CodiceFiscale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Popolazione della tabella Utente
--

INSERT INTO `Utente` (`CodiceFiscale`, `Nome`, `Cognome`, `Età`, `Sesso`) VALUES
('RSSMRA85M01H501Z', 'Mario', 'Rossi', 38, 'M'),
('VLDLGI80A01H501U', 'Luigi', 'Verdi', 43, 'M'),
('BNCLRA70B01H501K', 'Laura', 'Bianchi', 54, 'F'),
('FRNMRC90C01H501F', 'Marco', 'Ferrari', 33, 'M'),
('GLLLRA75D01H501P', 'Lara', 'Galli', 49, 'F');

--
-- Creazione della tabella Categoria
--

CREATE TABLE `Categoria` (
    `IdCategoria` INT NOT NULL AUTO_INCREMENT,
    `Descrizione` VARCHAR(100),
    PRIMARY KEY (`IdCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Popolazione della tabella Categoria
--

INSERT INTO `Categoria` (`Descrizione`) VALUES
('Tecnologia'),
('Salute'),
('Sport'),
('Cucina'),
('Viaggi');

--
-- Creazione della tabella Sondaggio
--

CREATE TABLE `Sondaggio` (
    `Id_sondaggio` INT NOT NULL AUTO_INCREMENT,
    `Nome` VARCHAR(100),
    `Descrizione` TEXT,
    `DataCreazione` DATE,
    `IdCategoria` INT,
    PRIMARY KEY (`Id_sondaggio`),
    KEY `IdCategoria` (`IdCategoria`),
    CONSTRAINT `Sondaggio_ibfk_1` FOREIGN KEY (`IdCategoria`) REFERENCES `Categoria`(`IdCategoria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Popolazione della tabella Sondaggio
--

INSERT INTO `Sondaggio` (`Nome`, `Descrizione`, `DataCreazione`, `IdCategoria`) VALUES
('Sondaggio Tecnologia 2024', 'Opinioni sulle nuove tecnologie emergenti.', '2024-01-15', 1),
('Sondaggio Salute 2024', 'Abitudini e preferenze in ambito salute.', '2024-02-10', 2),
('Sondaggio Sport 2024', 'Interessi e partecipazione agli eventi sportivi.', '2024-03-05', 3),
('Sondaggio Cucina 2024', 'Preferenze culinarie e abitudini alimentari.', '2024-04-12', 4),
('Sondaggio Viaggi 2024', 'Destinazioni di viaggio preferite e esperienze.', '2024-05-18', 5);

--
-- Creazione della tabella Partecipazione
--

CREATE TABLE `Partecipazione` (
    `CodiceFiscale` VARCHAR(16) NOT NULL,
    `Id_sondaggio` INT NOT NULL,
    `Data_iscrizione` DATE,
    PRIMARY KEY (`CodiceFiscale`, `Id_sondaggio`),
    KEY `CodiceFiscale` (`CodiceFiscale`),
    KEY `Id_sondaggio` (`Id_sondaggio`),
    CONSTRAINT `Partecipazione_ibfk_1` FOREIGN KEY (`CodiceFiscale`) REFERENCES `Utente`(`CodiceFiscale`),
    CONSTRAINT `Partecipazione_ibfk_2` FOREIGN KEY (`Id_sondaggio`) REFERENCES `Sondaggio`(`Id_sondaggio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Popolazione della tabella Partecipazione
--

INSERT INTO `Partecipazione` (`CodiceFiscale`, `Id_sondaggio`, `Data_iscrizione`) VALUES
('RSSMRA85M01H501Z', 1, '2024-01-20'),
('VLDLGI80A01H501U', 2, '2024-02-12'),
('BNCLRA70B01H501K', 3, '2024-03-07'),
('FRNMRC90C01H501F', 4, '2024-04-15'),
('GLLLRA75D01H501P', 5, '2024-05-20'),
('RSSMRA85M01H501Z', 3, '2024-03-08'),
('VLDLGI80A01H501U', 4, '2024-04-16');

--
-- Creazione della tabella Domanda
--

CREATE TABLE `Domanda` (
    `IdDomanda` INT NOT NULL AUTO_INCREMENT,
    `Domanda` TEXT NOT NULL,
    `TipoDiDomanda` VARCHAR(50),
    `Id_sondaggio` INT,
    PRIMARY KEY (`IdDomanda`),
    KEY `Id_sondaggio` (`Id_sondaggio`),
    CONSTRAINT `Domanda_ibfk_1` FOREIGN KEY (`Id_sondaggio`) REFERENCES `Sondaggio`(`Id_sondaggio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Popolazione della tabella Domanda
--

INSERT INTO `Domanda` (`Domanda`, `TipoDiDomanda`, `Id_sondaggio`) VALUES
('Qual è la tua opinione sulle nuove tecnologie?', 'Aperta', 1),
('Quante volte vai dal medico all anno?', 'Numerica', 2),
('Quale sport pratichi regolarmente?', 'Aperta', 3),
('Qual è il tuo piatto preferito?', 'Aperta', 4),
('Qual è la tua destinazione di viaggio preferita?', 'Aperta', 5);

--
-- Creazione della tabella Risposta
--

CREATE TABLE `Risposta` (
    `IdRisposta` INT NOT NULL AUTO_INCREMENT,
    `Risposta` TEXT NOT NULL,
    `TipoDiRisposta` VARCHAR(50),
    `IdDomanda` INT,
    PRIMARY KEY (`IdRisposta`),
    KEY `IdDomanda` (`IdDomanda`),
    CONSTRAINT `Risposta_ibfk_1` FOREIGN KEY (`IdDomanda`) REFERENCES `Domanda`(`IdDomanda`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Popolazione della tabella Risposta
--

INSERT INTO `Risposta` (`Risposta`, `TipoDiRisposta`, `IdDomanda`) VALUES
('Sono molto interessato alle nuove tecnologie.', 'Testo', 1),
('Vado dal medico circa 3 volte all anno.', 'Numerica', 2),
('Pratico regolarmente calcio.', 'Testo', 3),
('Il mio piatto preferito è la pasta.', 'Testo', 4),
('La mia destinazione di viaggio preferita è il Giappone.', 'Testo', 5);

--
-- Creazione della tabella Report
--

CREATE TABLE `Report` (
    `Id_report` INT NOT NULL AUTO_INCREMENT,
    `DataReport` DATE,
    `ContenutoReport` TEXT,
    `Id_sondaggio` INT,
    PRIMARY KEY (`Id_report`),
    KEY `Id_sondaggio` (`Id_sondaggio`),
    CONSTRAINT `Report_ibfk_1` FOREIGN KEY (`Id_sondaggio`) REFERENCES `Sondaggio`(`Id_sondaggio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- trigger Report
--
DELIMITER $$

-- Creazione della procedura per generare il contenuto del report
CREATE PROCEDURE GeneraReport(IN sondaggioID INT)
BEGIN
    DECLARE reportContent TEXT;
    DECLARE sondaggioNome VARCHAR(100);
    DECLARE totalPartecipazioni INT;

    -- Recupero del nome del sondaggio
    SELECT Nome INTO sondaggioNome
    FROM Sondaggio
    WHERE Id_sondaggio = sondaggioID;

    -- Conta il numero di partecipazioni al sondaggio
    SELECT COUNT(*) INTO totalPartecipazioni
    FROM Partecipazione
    WHERE Id_sondaggio = sondaggioID;

    -- Composizione del contenuto del report
    SET reportContent = CONCAT('Report per il sondaggio: ', sondaggioNome, '. Numero totale di partecipazioni: ', totalPartecipazioni, '.');

    -- Inserimento del report nella tabella Report
    INSERT INTO Report (DataReport, ContenutoReport, Id_sondaggio)
    VALUES (CURDATE(), reportContent, sondaggioID);
END$$

DELIMITER ;

-- Creazione del trigger per la generazione automatica del report
DELIMITER $$

CREATE TRIGGER GeneraReportTrigger
AFTER INSERT ON Partecipazione
FOR EACH ROW
BEGIN
    -- Chiama la procedura per generare il report
    CALL GeneraReport(NEW.Id_sondaggio);
END$$

DELIMITER ;

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
