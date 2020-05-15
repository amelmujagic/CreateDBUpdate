-- HOCU DA OVO BUDE patch
create database WebPrintTrackDB;
use WebPrintTrackDB;

Create table Korisnik
(
IDKorisnik int identity(1,1) 
	Constraint PK_Korisnik Primary key (IDKorisnik),
Naziv NVARCHAR(100) not null,
Lokacija NVARCHAR(100) not null, -- ?? mozda ce trebati neki drugi tip podataka (GPS,...)
AdresaUlica NVARCHAR(100) not null,
AdresaKBroj NVARCHAR(100) not null,
AdresaPostBroj NVARCHAR(100) not null
);
create table KontaktOsoba
(
IDKontakt int identity(1,1) Constraint PK_Kontakt Primary key (IDKontakt), 
KorisnikID int
    Constraint FK_Korisnik Foreign key (KorisnikID) references Korisnik(IDKorisnik)
, 
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
KontaktID int null,
Constraint PK_narudzba primary key (IDNarudzba)

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
create table Narudzba_test2
(
IDNarudzba int identity(1,1), 
KorisnikID int,
KontaktID int null, 
Constraint PK_narudzbaTest2 primary key (IDNarudzba)
);
-- a zatim dodajem Constraint
Alter Table Narudzba_test2
ADD Constraint FK_KorisnikNarTest2 foreign key (KorisnikID) References Korisnik(IDKorisnik)
;
