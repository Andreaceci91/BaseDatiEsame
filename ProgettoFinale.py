from ctypes.wintypes import CHAR
from pydoc import doc
import mysql.connector
db = mysql.connector.connect(host = 'localhost', user = 'root', password = 'Alfredo0', database = 'DbProgetto')

cursore = db.cursor( )

print("Scelta 1: Inserimento Nuovo Paziente")
print("Scelta 2: Aggiornamento consenso Paziente")
print("Scelta 3: Vedere Anagrafica Paziente")
print("Scelta 4: Ricerca tutti medici che effettuano una determinata Prestazione e relativo prezzo")

scelta = int(input("Inserisci la tua scelta: "))

if scelta == 1:

    CF = input("Digitare Codice Fiscale del Paziente:")
    nome = input("Digitare il nome del paziente:")
    cognome = input("Digitare il cognome del paziente:")
    consenso = input("Il paziente ha prestato il consenso?")
    dataNascita = input("Inserire data di nascita del paziente:")
    telefonoPaziente = input("Inserire il telefono del paziente:")
    email = input("Inserire email del paziente:")

    adr = (CF, nome, cognome, consenso, dataNascita, telefonoPaziente, email)

    sql = "INSERT INTO Paziente (codiceFiscale, nome, cognome, consenso, dataNascita, telefono, email) VALUES (%s, %s, %s, %s, %s, %s, %s) ;"

    cursore.execute(sql, adr)

    results = cursore.fetchall( )

    for line in results:
    
        print(line)

    db.commit( )

if scelta == 2:

    consenso = input("Inserire 1 o 0")

    codiceFiscale = input("Inserire Codice Fiscale Paziente")

    sql = "UPDATE Paziente SET consenso = %s WHERE codiceFiscale= %s"

    adr = (consenso, codiceFiscale)

    cursore.execute(sql, adr)

    results = cursore.fetchall( )

    for line in results:
    
        print(line)

    db.commit( )


if scelta == 3:
    sql = "SELECT * FROM Paziente WHERE codiceFiscale = %s"
    nome = input("Inserire codice fiscale paziente:")
    nome = (nome, )
    cursore.execute(sql, nome)
    results = cursore.fetchall( )

    for line in results:
    
        print(line)

if scelta == 4:
    sql = "SELECT Dipendente.nome, Dipendente.cognome, Prestazione.nomePrestazione, Prestazione.tariffaPrestazione FROM Dipendente INNER JOIN Prestazione ON Dipendente.matricola = Prestazione.matricolaMedico WHERE Prestazione.nomePrestazione = %s"
    adr = input("Inserire la visita ricercata:")
    adr = (adr,)

    cursore.execute(sql,adr)
    results = cursore.fetchall( )

    for line in results:
    
        print(line)

db.close( )
