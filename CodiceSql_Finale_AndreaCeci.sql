DROP DATABASE IF EXISTS DbProgetto;
CREATE DATABASE DbProgetto;


USE DbProgetto;

DROP TABLE IF EXISTS Paziente;
CREATE TABLE Paziente(
codiceFiscale VARCHAR(20),
nome VARCHAR(20),
cognome VARCHAR(20),
consenso BOOLEAN,
dataNascita DATE,
telefono VARCHAR(15),
email VARCHAR(40),
PRIMARY KEY(codiceFiscale)
);
INSERT INTO Paziente
VALUES('CCENDR91S29H501A','Andrea','Ceci',TRUE,'1991-11-29','3401720958','andrea.ceci@units.it');
INSERT INTO Paziente
VALUES('SCNGRG93M60H501T','Giorgia','Sceni',TRUE,'1993-08-20','3393865784','giorgia.sceni@units.it');


DROP TABLE IF EXISTS Agevolazione;
CREATE TABLE Agevolazione(
codiceAgevolazione INTEGER AUTO_INCREMENT,
nomeAgevolazione VARCHAR(40),
riduzione double,
tipoAgevolazione VARCHAR(15),
PRIMARY KEY(codiceAgevolazione)
);

INSERT INTO Agevolazione(nomeAgevolazione, riduzione)
VALUES('Postevita', 33);
INSERT INTO Agevolazione(nomeAgevolazione, riduzione)
VALUES('MetaSalute', 20);


DROP TABLE IF EXISTS AgevolazionePosseduta;
CREATE TABLE AgevolazionePosseduta(
codiceFiscale VARCHAR(20),
codiceAgevolazione INTEGER,
PRIMARY KEY(codiceFiscale, codiceAgevolazione),
FOREIGN KEY(codiceFiscale) REFERENCES Paziente(codiceFiscale),
FOREIGN KEY(codiceAgevolazione) REFERENCES Agevolazione(codiceAgevolazione)
);
INSERT INTO AgevolazionePosseduta
VALUES('CCENDR91S29H501A','1');
INSERT INTO AgevolazionePosseduta
VALUES('SCNGRG93M60H501T','2');

DROP TABLE IF EXISTS TipologiaMansione;
CREATE TABLE TipologiaMansione(
mansione VARCHAR(20),
tipo VARCHAR(15),
PRIMARY KEY(mansione)
);
INSERT INTO  TipologiaMansione
VALUES('Medico','Sanitario');
INSERT INTO  TipologiaMansione
VALUES('Infermiere','Sanitario');
INSERT INTO  TipologiaMansione
VALUES('Desk Informativo','Amministrativo');
INSERT INTO  TipologiaMansione
VALUES('Segretaria','Amministrativo');

DROP TABLE IF EXISTS AnagraficaSede;
CREATE TABLE AnagraficaSede(
cap VARCHAR(5),
citta VARCHAR(20),
indirizzo VARCHAR(40),
numeroCivico INTEGER,
provincia VARCHAR(2),
regione VARCHAR(25),
PRIMARY KEY(cap)
);
INSERT INTO AnagraficaSede
VALUES('00043','Ciampino','Viale del lavoro',1,'RM','Lazio');
INSERT INTO AnagraficaSede
VALUES('00042','Roma','Viale del Circuito',25,'RM','Lazio');
INSERT INTO AnagraficaSede
VALUES('00100','Roma','Viale Marino',12,'RM','Lazio');

DROP TABLE IF EXISTS Sede;
CREATE TABLE Sede(
nomeSede VARCHAR(20),
cap VARCHAR(5),
PRIMARY KEY(nomeSede),
FOREIGN KEY(cap) REFERENCES AnagraficaSede(cap)
);
INSERT INTO Sede
VALUES('Andromeda','00100');
INSERT INTO Sede
VALUES('Aries','00043');


DROP TABLE IF EXISTS Dipendente;
CREATE TABLE Dipendente(
matricola INTEGER AUTO_INCREMENT,
nome VARCHAR(20),
cognome VARCHAR(20),
mansione VARCHAR(20),
telefono VARCHAR(15),
email VARCHAR(40),
reparto VARCHAR(20),
nomeSede VARCHAR(20),
PRIMARY KEY(matricola),
FOREIGN KEY(nomeSede) REFERENCES Sede(nomeSede),
FOREIGN KEY(mansione) REFERENCES TipologiaMansione(mansione)
);
INSERT INTO Dipendente(nome, cognome, mansione, telefono, email, reparto, nomeSede)
VALUES('Michele','Scio','Medico','3401829888','michele.scio@sagittarius.it','Ortopedia','Andromeda');
INSERT INTO Dipendente(nome, cognome, mansione, telefono, email, reparto, nomeSede)
VALUES('Anna','DiGiulio','Medico','3339888765','anna.digiulio@sagittarius.it','Generale','Andromeda');
INSERT INTO Dipendente(nome, cognome, mansione, telefono, email, reparto, nomeSede)
VALUES('Ilaria','Cnesi','Infermiere','3378474657','ilaria.censi@sagittarius.it','Ginecologia','Aries');

INSERT INTO Dipendente(nome, cognome, mansione, telefono, email, reparto, nomeSede)
VALUES('Claudio','Buffi','Desk Informativo','3347464764','claudio.buffi@sagittarius.it','Ginecologia','Andromeda');
INSERT INTO Dipendente(nome, cognome, mansione, telefono, email, reparto, nomeSede)
VALUES('Loredana','Berte','Segretaria','3398477856','loredana.berte@sagittarius.it','Ginecologia','Andromeda');


DROP TABLE IF EXISTS Prestazione;
CREATE TABLE Prestazione(
codicePrestazione VARCHAR(4),
matricolaMedico INTEGER,
nomePrestazione VARCHAR(50),
tipoPrestazione VARCHAR(20),
tariffaPrestazione DOUBLE,
PRIMARY KEY(codicePrestazione, matricolaMedico),
FOREIGN KEY(matricolaMedico) REFERENCES Dipendente(matricola)
);
INSERT INTO Prestazione
VALUES('0001','1','Ecografia','Diagnostica', 50);
INSERT INTO Prestazione
VALUES('0001','2','Ecografia','Diagnostica', 100);
INSERT INTO Prestazione
VALUES('0002','1','Menisco','Operazione', 2000);
INSERT INTO Prestazione
VALUES('0002','2','Menisco','Operazione',4000);

INSERT INTO Prestazione
VALUES('0001','3','Ginecologica','Visita',100);
INSERT INTO Prestazione
VALUES('0002','3','Menisco','Operazione',3000);


DROP TABLE IF EXISTS Visita;
CREATE TABLE Visita(
codiceFiscale VARCHAR(20),
codicePrestazione VARCHAR(4),
matricolaMedico INTEGER,
dataVisita date,
PRIMARY KEY(codiceFiscale, codicePrestazione, matricolaMedico, dataVisita),
FOREIGN KEY(codiceFiscale) REFERENCES Paziente(codiceFiscale),
FOREIGN KEY(codicePrestazione) REFERENCES Prestazione(codicePrestazione)
);

INSERT INTO Visita
VALUES('CCENDR91S29H501A','0001',1,'2022-06-30');
INSERT INTO Visita
VALUES('CCENDR91S29H501A','0002',1,'2022-06-30');
INSERT INTO Visita
VALUES('SCNGRG93M60H501T','0001',2,'2022-06-15');

INSERT INTO Visita
VALUES('SCNGRG93M60H501T','0001',3,'2022-06-20');
INSERT INTO Visita
VALUES('SCNGRG93M60H501T','0002',3,'2022-06-20');

DROP TABLE IF EXISTS EsameLaboratorio;
CREATE TABLE EsameLaboratorio(
codiceEsame VARCHAR(4),
nomeEsame VARCHAR(50),
tipoEsame VARCHAR(20),
nomeSede VARCHAR(20),
tariffaEsame DOUBLE,
PRIMARY KEY(codiceEsame, nomeSede),
FOREIGN KEY(nomeSede) REFERENCES Sede(nomeSede)
);

INSERT INTO EsameLaboratorio
VALUES('0001','Urinocoltura','Urine','Andromeda',10);
INSERT INTO EsameLaboratorio
VALUES('0002','Urinoglobulina','Urine','Andromeda',20);
INSERT INTO EsameLaboratorio
VALUES('0001','Urinocoltura','Urine','Aries',20);
INSERT INTO EsameLaboratorio
VALUES('0002','Urinoglobulina','Urine','Aries',40);


DROP TABLE IF EXISTS Analisi;
CREATE TABLE Analisi(
codiceFiscale VARCHAR(20),
codiceEsame VARCHAR(4),
nomeSede VARCHAR(20),
dataEsame date,
PRIMARY KEY(codiceFiscale, codiceEsame, nomeSede, dataEsame),
FOREIGN KEY(codiceFiscale) REFERENCES Paziente(codiceFiscale),
FOREIGN KEY(codiceEsame) REFERENCES EsameLaboratorio(codiceEsame),
FOREIGN KEY(nomeSede) REFERENCES EsameLaboratorio(nomeSede)
);

INSERT INTO Analisi
VALUES('CCENDR91S29H501A','0001','Andromeda','2022-05-20');
INSERT INTO Analisi
VALUES('CCENDR91S29H501A','0002','Andromeda','2022-05-20');
INSERT INTO Analisi
VALUES('SCNGRG93M60H501T','0001','Aries','2022-05-15');


# TRIGGER ControlloSanitario
DELIMITER $$
CREATE TRIGGER BloccoAmministrativo
BEFORE INSERT ON Prestazione
FOR EACH ROW
BEGIN
DECLARE temp VARCHAR(20);
SELECT TipologiaMansione.tipo INTO temp FROM Dipendente INNER JOIN TipologiaMansione ON Dipendente.mansione = TipologiaMansione.mansione WHERE Dipendente.matricola = NEW.matricolaMedico;

IF temp = 'Amministrativo' THEN SIGNAL SQLSTATE "45011" SET MESSAGE_TEXT = "Non ha una mansione sanitaria!";
END IF;
END$$
DELIMITER ;

SHOW TRIGGERS;

INSERT INTO Prestazione
VALUES('0001','4','Menisco','Operazione',4000);

INSERT INTO Prestazione
VALUES('0001','5','Menisco','Operazione',4000);


# TRIGGER IncassoGiornalieroSede
DROP PROCEDURE IncassoGiornalieroSede;

DELIMITER $$
CREATE PROCEDURE IncassoGiornalieroSede(nomeSede VARCHAR(20), dataEsaminare DATE)
BEGIN
	SELECT SUM(Prestazione.tariffaPrestazione) As 'Totale Incasso'
	FROM Visita	
	INNER JOIN Prestazione
	ON Visita.codicePrestazione = Prestazione.codicePrestazione AND Visita.matricolaMedico = Prestazione.matricolaMedico
	INNER JOIN Dipendente
	ON Prestazione.matricolaMedico = Dipendente.Matricola
	WHERE Dipendente.nomeSede = nomeSede AND Visita.dataVisita = dataEsaminare;
END$$
DELIMITER ;

CALL IncassoGiornalieroSede('Aries','2022-06-20');