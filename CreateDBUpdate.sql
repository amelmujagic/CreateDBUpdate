create database WebPrintTrackDB;
use WebPrintTrackDB;

Create table Korisnik
(
IDKorisnik int identity(1,1) -- ovo kaže da se kreæe od 1 i indeksi novog zapisa kreiraju svaki put u koracima od 1 (5,6,7,...)
	Constraint PK_Korisnik Primary key (IDKorisnik), -- pazi da nema zareza izmeðu Constraint i deklaracije IDKorisnik int...
Naziv NVARCHAR(100) not null,
Lokacija NVARCHAR(100) not null, -- ?? možda æe trebati neki drugi tip podataka (GPS,...)
AdresaUlica NVARCHAR(100) not null,
AdresaKBroj NVARCHAR(100) not null,
AdresaPostBroj NVARCHAR(100) not null
);
/*
Inaèe, moglo bi skraæeno ovako 
    IDKorisnik int PRIMARY KEY
ali onda bi primary key imao neko generièko ime

*/
create table KontaktOsoba
(
IDKontakt int identity(1,1) Constraint PK_Kontakt Primary key (IDKontakt), 
KorisnikID int
-- dodajem foreign key...
--             njegovo_ime              polje u tbl.           strana_tablica(polje_u_stranoj_tablici)
    Constraint FK_Korisnik Foreign key (KorisnikID) references Korisnik(IDKorisnik)
, -- pazi na položaj zereza jer izmeðu dijela deklaracije KorisnikID i kljuène rijeèi Constraint NE SMIJE(!) biti zarez
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
KontaktID int null, -- ovako æe moæi biti ako Kontakt osoba nije obavezna, ne znam kako smo dogovarali!
Constraint PK_narudzba primary key (IDNarudzba) -- Može i ovako; nakon svega samo mora biti odvojeno zarezom 
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
/* Pazi, kreirao sam novu tablicu ali sam u njoj imenovao PK i FK drugaèije jer mislim da 
   ime kljuèa MORA BITI jedinstveno za cijelu bazu. A i da nije, nazvao bih ga drugaèije da ne doðe do zabune!
*/

/*
3.) **** Treæi naèin: *****
Možeš mijenjati deklaraciju tablice tako da joj dodaš SAMO Foreign key!

Znaèi, prvo deklariraš (CREATE) tablicu:
*/
create table Narudzba_test2
(
IDNarudzba int identity(1,1), 
KorisnikID int, -- ovdje nisi odredio nikakav Constraint ali zato dole... odvojeno zarezima
KontaktID int null, 
Constraint PK_narudzbaTest2 primary key (IDNarudzba)
);
-- a zatim dodaš Constraint, OVAKO!:
Alter Table Narudzba_test2
ADD Constraint FK_KorisnikNarTest2 foreign key (KorisnikID) References Korisnik(IDKorisnik)
;
