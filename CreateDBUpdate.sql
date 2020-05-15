create database WebPrintTrackDB;
use WebPrintTrackDB;

Create table Korisnik
(
IDKorisnik int identity(1,1) -- ovo ka�e da se kre�e od 1 i indeksi novog zapisa kreiraju svaki put u koracima od 1 (5,6,7,...)
	Constraint PK_Korisnik Primary key (IDKorisnik), -- pazi da nema zareza izme�u Constraint i deklaracije IDKorisnik int...
Naziv NVARCHAR(100) not null,
Lokacija NVARCHAR(100) not null, -- ?? mo�da �e trebati neki drugi tip podataka (GPS,...)
AdresaUlica NVARCHAR(100) not null,
AdresaKBroj NVARCHAR(100) not null,
AdresaPostBroj NVARCHAR(100) not null
);
/*
Ina�e, moglo bi skra�eno ovako 
    IDKorisnik int PRIMARY KEY
ali onda bi primary key imao neko generi�ko ime

*/
create table KontaktOsoba
(
IDKontakt int identity(1,1) Constraint PK_Kontakt Primary key (IDKontakt), 
KorisnikID int
-- dodajem foreign key...
--             njegovo_ime              polje u tbl.           strana_tablica(polje_u_stranoj_tablici)
    Constraint FK_Korisnik Foreign key (KorisnikID) references Korisnik(IDKorisnik)
, -- pazi na polo�aj zereza jer izme�u dijela deklaracije KorisnikID i klju�ne rije�i Constraint NE SMIJE(!) biti zarez
Ime nvarchar(100) not null,
Prezime nvarchar(100) not null,
Email nvarchar(100) not null,
Telefon nvarchar(100) not null
);

create table StatusiNar
(
IDStatusNar int identity(1,1) constraint PK_Statusnar primary key (IDStatusNar),
Naziv NVARCHAR(20)
);

create table Narudzba
(
IDNarudzba int identity(1,1), 
KorisnikID int
   Constraint FK_KorisnikNar foreign key (KorisnikID) References Korisnik(IDKorisnik)
, 
KontaktID int null, -- ovako �e mo�i biti ako Kontakt osoba nije obavezna, ne znam kako smo dogovarali!
Constraint PK_narudzba primary key (IDNarudzba) -- Mo�e i ovako; nakon svega samo mora biti odvojeno zarezom 
-- jer se ne odnosi na polje iznad nego na neko gore (bilo koje)
);

-- FK i PK mogu biti definirani i na kraju, OVAKO!:
create table Narudzba_test1
(
IDNarudzba int identity(1,1), 
KorisnikID int, -- ovdje nisi odredio nikakav Constraint ali zato dole... odvojeno zarezima
KontaktID int null, 
Constraint PK_narudzbaTest1 primary key (IDNarudzba)
, Constraint FK_KorisnikNarTest1 foreign key (KorisnikID) References Korisnik(IDKorisnik)
);
/* Pazi, kreirao sam novu tablicu ali sam u njoj imenovao PK i FK druga�ije jer mislim da 
   ime klju�a MORA BITI jedinstveno za cijelu bazu. A i da nije, nazvao bih ga druga�ije da ne do�e do zabune!
*/

/*
3.) **** Tre�i na�in: *****
Mo�e� mijenjati deklaraciju tablice tako da joj doda� SAMO Foreign key!

Zna�i, prvo deklarira� (CREATE) tablicu:
*/
create table Narudzba_test2
(
IDNarudzba int identity(1,1), 
KorisnikID int, -- ovdje nisi odredio nikakav Constraint ali zato dole... odvojeno zarezima
KontaktID int null, 
Constraint PK_narudzbaTest2 primary key (IDNarudzba)
);
-- a zatim doda� Constraint, OVAKO!:
Alter Table Narudzba_test2
ADD Constraint FK_KorisnikNarTest2 foreign key (KorisnikID) References Korisnik(IDKorisnik)
;
