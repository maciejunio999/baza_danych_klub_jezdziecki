-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema wiekszabaza
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema wiekszabaza
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wiekszabaza` DEFAULT CHARACTER SET utf8mb3 ;
USE `wiekszabaza` ;

-- -----------------------------------------------------
-- Table `wiekszabaza`.`adresy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`adresy` (
  `ID_adresu` INT NOT NULL AUTO_INCREMENT,
  `Kraj` VARCHAR(30) NOT NULL,
  `Miasto` VARCHAR(20) NOT NULL,
  `Ulica` VARCHAR(30) NOT NULL,
  `Numer_budynku` VARCHAR(4) NOT NULL,
  `Numer_lokalu` VARCHAR(5) NULL DEFAULT NULL,
  `Kod_pocztowy` CHAR(6) NOT NULL,
  PRIMARY KEY (`ID_adresu`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`dane_instytucji`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`dane_instytucji` (
  `ID_danych` INT NOT NULL,
  `NIP` VARCHAR(10) NOT NULL,
  `Numer_KRS` VARCHAR(10) NULL DEFAULT NULL,
  `Numer_REGON` CHAR(9) NOT NULL,
  PRIMARY KEY (`ID_danych`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`kluby_jezdzieckie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`kluby_jezdzieckie` (
  `ID_klubu` INT NOT NULL AUTO_INCREMENT,
  `Nazwa` VARCHAR(20) NOT NULL,
  `Data_zalozenia` DATE NOT NULL,
  `Numer_telefonu` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  `Powierzchnia` INT NOT NULL,
  `ID_adresu` INT NOT NULL,
  PRIMARY KEY (`ID_klubu`),
  INDEX `IX_Relationship1` (`ID_adresu` ASC) VISIBLE,
  CONSTRAINT `Klub_ma_adres`
    FOREIGN KEY (`ID_adresu`)
    REFERENCES `wiekszabaza`.`adresy` (`ID_adresu`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`klienci`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`klienci` (
  `ID_klienta` INT NOT NULL AUTO_INCREMENT,
  `Numer_telefonu` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  `ID_klubu` INT NOT NULL,
  `ID_adresu` INT NOT NULL,
  PRIMARY KEY (`ID_klienta`),
  INDEX `IX_Relationship18` (`ID_klubu` ASC) VISIBLE,
  INDEX `IX_Relationship27` (`ID_adresu` ASC) VISIBLE,
  CONSTRAINT `Klient_ma_adres`
    FOREIGN KEY (`ID_adresu`)
    REFERENCES `wiekszabaza`.`adresy` (`ID_adresu`),
  CONSTRAINT `Klub_ma_klientow`
    FOREIGN KEY (`ID_klubu`)
    REFERENCES `wiekszabaza`.`kluby_jezdzieckie` (`ID_klubu`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`firmy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`firmy` (
  `ID_klienta` INT NOT NULL,
  `Nazwa` VARCHAR(30) NOT NULL,
  `ID_danych` INT NOT NULL,
  PRIMARY KEY (`ID_klienta`),
  INDEX `IX_Relationship16` (`ID_danych` ASC) VISIBLE,
  CONSTRAINT `Firma_posiada_dane`
    FOREIGN KEY (`ID_danych`)
    REFERENCES `wiekszabaza`.`dane_instytucji` (`ID_danych`),
  CONSTRAINT `Klient_jako_firma`
    FOREIGN KEY (`ID_klienta`)
    REFERENCES `wiekszabaza`.`klienci` (`ID_klienta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`jezyki_obce`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`jezyki_obce` (
  `ID_jezyka` INT NOT NULL AUTO_INCREMENT,
  `Nazwa` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`ID_jezyka`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`stajnie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`stajnie` (
  `ID_stajni` INT NOT NULL AUTO_INCREMENT,
  `Nazwa` VARCHAR(20) NOT NULL,
  `Pojemnosc` INT NOT NULL,
  `ID_klubu` INT NOT NULL,
  PRIMARY KEY (`ID_stajni`),
  INDEX `IX_Posiada` (`ID_klubu` ASC) VISIBLE,
  CONSTRAINT `Klub_posiada_stajnie`
    FOREIGN KEY (`ID_klubu`)
    REFERENCES `wiekszabaza`.`kluby_jezdzieckie` (`ID_klubu`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`konie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`konie` (
  `ID_konia` INT NOT NULL AUTO_INCREMENT,
  `Nazwa` VARCHAR(20) NOT NULL,
  `Rasa` VARCHAR(40) NOT NULL,
  `Data_urodzenia` DATE NOT NULL,
  `Wysokosc` INT NULL DEFAULT NULL,
  `ID_klubu` INT NOT NULL,
  `ID_stajni` INT NOT NULL,
  PRIMARY KEY (`ID_konia`),
  INDEX `IX_Udostepnia` (`ID_klubu` ASC) VISIBLE,
  INDEX `IX_Relationship3` (`ID_stajni` ASC) VISIBLE,
  CONSTRAINT `Klub_jezdzecki_udostepnia_konia`
    FOREIGN KEY (`ID_klubu`)
    REFERENCES `wiekszabaza`.`kluby_jezdzieckie` (`ID_klubu`),
  CONSTRAINT `Kon_jest_w_stajni`
    FOREIGN KEY (`ID_stajni`)
    REFERENCES `wiekszabaza`.`stajnie` (`ID_stajni`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`karty_czlonkowskie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`karty_czlonkowskie` (
  `Data` DATE NOT NULL,
  `ID_konia` INT NOT NULL,
  `ID_klienta` INT NOT NULL,
  PRIMARY KEY (`Data`, `ID_konia`, `ID_klienta`),
  INDEX `Kon_jest_ujezdzany` (`ID_konia` ASC) VISIBLE,
  INDEX `Klient_ujezdza_konia` (`ID_klienta` ASC) VISIBLE,
  CONSTRAINT `Klient_ujezdza_konia`
    FOREIGN KEY (`ID_klienta`)
    REFERENCES `wiekszabaza`.`klienci` (`ID_klienta`),
  CONSTRAINT `Kon_jest_ujezdzany`
    FOREIGN KEY (`ID_konia`)
    REFERENCES `wiekszabaza`.`konie` (`ID_konia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`pracownicy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`pracownicy` (
  `ID_pracownika` INT NOT NULL AUTO_INCREMENT,
  `Imie` VARCHAR(20) NOT NULL,
  `Drugie_imie` VARCHAR(20) NULL DEFAULT NULL,
  `Nazwisko` VARCHAR(30) NOT NULL,
  `Data_urodzenia` DATE NOT NULL,
  `Numer_telefonu` CHAR(15) NOT NULL,
  `Email` VARCHAR(30) NOT NULL,
  `Pesel` CHAR(11) NULL DEFAULT NULL,
  `Data_zatrudnienia` DATE NOT NULL,
  `Data_zwolnienia` DATE NULL DEFAULT NULL,
  `ID_klubu` INT NOT NULL,
  `ID_stajni` INT NULL DEFAULT NULL,
  `ID_adresu` INT NOT NULL,
  PRIMARY KEY (`ID_pracownika`),
  INDEX `IX_Zatrudnia` (`ID_klubu` ASC) VISIBLE,
  INDEX `IX_Pracuje_w` (`ID_stajni` ASC) VISIBLE,
  INDEX `IX_Relationship2` (`ID_adresu` ASC) VISIBLE,
  CONSTRAINT `Klub_zatrudnia_pracownika`
    FOREIGN KEY (`ID_klubu`)
    REFERENCES `wiekszabaza`.`kluby_jezdzieckie` (`ID_klubu`),
  CONSTRAINT `Pracownik_ma_adres`
    FOREIGN KEY (`ID_adresu`)
    REFERENCES `wiekszabaza`.`adresy` (`ID_adresu`),
  CONSTRAINT `W_stajni_sa_pracownicy`
    FOREIGN KEY (`ID_stajni`)
    REFERENCES `wiekszabaza`.`stajnie` (`ID_stajni`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`obslugi`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`obslugi` (
  `ID_konia` INT NOT NULL,
  `ID_pracownika` INT NOT NULL,
  INDEX `Kon_jest_obslugiwany` (`ID_konia` ASC) VISIBLE,
  INDEX `Pracownik_obsluguje_konia` (`ID_pracownika` ASC) VISIBLE,
  CONSTRAINT `Kon_jest_obslugiwany`
    FOREIGN KEY (`ID_konia`)
    REFERENCES `wiekszabaza`.`konie` (`ID_konia`),
  CONSTRAINT `Pracownik_obsluguje_konia`
    FOREIGN KEY (`ID_pracownika`)
    REFERENCES `wiekszabaza`.`pracownicy` (`ID_pracownika`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`osoby_prywatne`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`osoby_prywatne` (
  `ID_klienta` INT NOT NULL,
  `Imie` VARCHAR(20) NOT NULL,
  `Drugie_imie` VARCHAR(20) NULL DEFAULT NULL,
  `Nazwisko` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`ID_klienta`),
  CONSTRAINT `Klient_jako_osoba_prywatna`
    FOREIGN KEY (`ID_klienta`)
    REFERENCES `wiekszabaza`.`klienci` (`ID_klienta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`pracownicy_biura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`pracownicy_biura` (
  `ID_pracownika` INT NOT NULL,
  `Numer_biurka` INT NOT NULL,
  PRIMARY KEY (`ID_pracownika`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`pracownicy_stajni`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`pracownicy_stajni` (
  `ID_pracownika` INT NOT NULL,
  `Stanowisko` CHAR(25) NOT NULL,
  `Data_badania` DATE NOT NULL,
  PRIMARY KEY (`ID_pracownika`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`sprzedawcy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`sprzedawcy` (
  `ID_pracownika` INT NOT NULL,
  `Numer_kasy` INT NOT NULL,
  PRIMARY KEY (`ID_pracownika`),
  CONSTRAINT `Pracownik_jako_sprzedawca`
    FOREIGN KEY (`ID_pracownika`)
    REFERENCES `wiekszabaza`.`pracownicy` (`ID_pracownika`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`szkoly`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`szkoly` (
  `Nazwa` VARCHAR(20) NOT NULL,
  `ID_klienta` INT NOT NULL,
  `ID_danych` INT NOT NULL,
  PRIMARY KEY (`ID_klienta`),
  INDEX `IX_Relationship15` (`ID_danych` ASC) VISIBLE,
  CONSTRAINT `Klient_jako_szkola`
    FOREIGN KEY (`ID_klienta`)
    REFERENCES `wiekszabaza`.`klienci` (`ID_klienta`),
  CONSTRAINT `Szkola_posiada_dane`
    FOREIGN KEY (`ID_danych`)
    REFERENCES `wiekszabaza`.`dane_instytucji` (`ID_danych`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`weterynarze`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`weterynarze` (
  `ID_pracownika` INT NOT NULL,
  `Numer_legitymacji` INT NOT NULL,
  `Liczba_wizytacji` INT NOT NULL,
  `Liczba_raportow` INT NOT NULL,
  PRIMARY KEY (`ID_pracownika`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`wynagrodzenia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`wynagrodzenia` (
  `ID_wynagrodzenia` INT NOT NULL AUTO_INCREMENT,
  `Data_przyznania` DATE NOT NULL,
  `Pensja_podstawowa` DECIMAL(8,2) NOT NULL,
  `Premia_dodatkowa` DECIMAL(7,2) NOT NULL,
  `ID_pracownika` INT NOT NULL,
  PRIMARY KEY (`ID_wynagrodzenia`),
  INDEX `IX_Relationship23` (`ID_pracownika` ASC) VISIBLE,
  CONSTRAINT `Pracownik_ma_wynagrodzenie`
    FOREIGN KEY (`ID_pracownika`)
    REFERENCES `wiekszabaza`.`pracownicy` (`ID_pracownika`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `wiekszabaza`.`znajomosc_jezykow_obcych`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wiekszabaza`.`znajomosc_jezykow_obcych` (
  `ID_jezyka` INT NOT NULL,
  `ID_pracownika` INT NOT NULL,
  `Stopien_znajomosci` CHAR(30) NOT NULL,
  PRIMARY KEY (`ID_jezyka`, `ID_pracownika`),
  INDEX `Sprzedawca_zna_jezyk` (`ID_pracownika` ASC) VISIBLE,
  CONSTRAINT `Jezyk_jest_znany`
    FOREIGN KEY (`ID_jezyka`)
    REFERENCES `wiekszabaza`.`jezyki_obce` (`ID_jezyka`),
  CONSTRAINT `Sprzedawca_zna_jezyk`
    FOREIGN KEY (`ID_pracownika`)
    REFERENCES `wiekszabaza`.`sprzedawcy` (`ID_pracownika`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
