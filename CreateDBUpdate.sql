create database WebPrintTrackDB;
use WebPrintTrackDB;

Create table Korisnik
(
IDKorisnik int identity(1,1) 
	Constraint PK_Korisnik Primary key (IDKorisnik),
Naziv NVARCHAR(100) not null,
Lokacija NVARCHAR(100) not null, -- ?? možda æe trebati neki drugi tip podataka (GPS,...)
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
------- nadogradnja na v2-3
alter table Narudzba
add StatusNarID int Constraint FK_StatusNarID foreign key (StatusNarID) references StatusiNar(IDStatusNar)
;

create table Narudzba
(
IDNarudzba int identity(1,1), 
KorisnikID int
   Constraint FK_KorisnikNar foreign key (KorisnikID) References Korisnik(IDKorisnik)
, 
KontaktID int null,
Constraint PK_narudzba primary key (IDNarudzba) 
);
<<<<<<< Updated upstream
-- a zatim dodajem Constraint
Alter Table Narudzba_test2
ADD Constraint FK_KorisnikNarTest2 foreign key (KorisnikID) References Korisnik(IDKorisnik)
;
=======
----------------------------------------------------------------------------------
-------- Igor v2_2 -------------------
Create table Marka
(
IDMarka int identity(1,1) Constraint PK_Marka Primary key (IDMarka),
Naziv nvarchar(100) not null
);
GO

Create table Model
(
IDModel int identity(1,1) Constraint PK_Model Primary key (IDModel),
MarkaID int Constraint FK_Marka Foreign key (MarkaID) references Marka(IDMarka),
BrojModela nvarchar(25),
Naziv nvarchar(100)
);
GO

Create table Tinta
(
IDTinta int identity(1,1) Constraint PK_Tinta Primary key (IDTinta),
Naziv nvarchar(25),
RokTrajanjaMjeseci int
);
GO

Create table Printer
(
IDPrinter int identity(1,1) Constraint PK_Printer Primary key (IDPrinter),
SerijskiBroj nvarchar (25),
ModelID int 
	Constraint FK_Model Foreign key (ModelID) references Model(IDModel),
KorisnikID int 
	constraint FK_KorisnikPrinter Foreign key (KorisnikID) references Korisnik(IDKorisnik),
TintaID int 
	constraint FK_Tinta Foreign key (TintaID) references Tinta(IDTinta),
DatumPrveInstalacija date,
ServisniPeriod int,
ServisniPeriodDatumKraja date
);
GO

Create table StatusRadnogNaloga
(
IDStatusRadnogNaloga int identity(1,1) Constraint PK_StatusRadnogNaloga Primary key (IDStatusRadnogNaloga),
Naziv nvarchar(25)
);
GO
 
Create table RadniNalog
(
IDRadniNalog int identity(1,1) Constraint PK_RadniNalog Primary key (IDRadniNalog),
PrinterID int 
	Constraint FK_PrinterRadniNalog Foreign key (PrinterID) references Printer(IDPrinter),
NarudzbaID int 
	Constraint FK_NarudzbaRadniNalog Foreign key (NarudzbaID) references Narudzba(IDNarudzba),
StatusRadnogNalogaID int 
	Constraint FK_StatusRadnogNaloga Foreign key (StatusRadnogNalogaID) references StatusRadnogNaloga(IDStatusRadnogNaloga),
ZakazaniDatum date,
DatumKreiranja date
);
GO

Create table StatusServisa
(
IDStatusServisa int identity(1,1) Constraint PK_StatusServisa Primary key (IDStatusServisa),
Naziv nvarchar(25)
);
GO

Create table Serviser
(
IDServiser int identity(1,1) Constraint PK_Serviser Primary key (IDServiser),
Ime nvarchar (25),
Prezime nvarchar (25)
);
GO

Create table RadniSat
(
IDRadniSat int identity(1,1) Constraint PK_RadniSat Primary key (IDRadniSat),
Iznos decimal(10,4),
Naziv nvarchar(25)
);
GO

Create table ServisniIzvjestaj
(
IDServisniIzvjestaj int identity(1,1) Constraint PK_ServisniIzvjestaj Primary key (IDServisniIzvjestaj),
RadniNalogID int 
	Constraint FK_RadniNalogServIzvjestaj Foreign key (RadniNalogID) references RadniNalog(IDRadniNalog),
DatumISatOd date,
DatumISatDo date,
RadniSatID int 
	Constraint FK_RadniSatServIzvjestaj Foreign key (RadniSatID) references RadniSat(IDRadniSat),
KolicinaRadnihSati int,
OpisIzvrsenihRadnji nvarchar (200),
ServiserID int 
	Constraint FK_ServiserServIzvjestaj Foreign key (ServiserID) references Serviser(IDServiser),
ServisniSljedeciID int 
	Constraint FK_ServiniSljedeci Foreign key (ServisniSljedeciID) references ServisniIzvjestaj(IDServisniIzvjestaj) null,
DatumKreiranja date,
Prihvacen bit,
);
GO
alter table ServisniIzvjestaj
add StatusServisaID int 
Constraint FK_StatusServisaServisniIzvj Foreign key (StatusServisaID) references StatusServisa(IDStatusServisa)
;
alter table ServisniIzvjestaj drop COLUMN Prihvacen
;



Create table Reklamacija
(
IDReklamacija int identity(1,1) Constraint PK_Reklamacija Primary key (IDReklamacija),
ServisniIzvjestajID int 
	Constraint FK_ServisniIzvjestajReklamacija Foreign key (ServisniIzvjestajID) references ServisniIzvjestaj(IDServisniIzvjestaj),
PrimjedbaKlijenta nvarchar(500),
Obrazlozenje nvarchar(500),------------------????
RijesenaDatum date
);
GO

Create table Ocjena
(
IDOcjena int identity(1,1) Constraint PK_Ocjena Primary key (IDOcjena),
ServisniIzvjestajID int 
	Constraint FK_ServisniIzvjestajOcjena Foreign key (ServisniIzvjestajID) references ServisniIzvjestaj(IDServisniIzvjestaj),
Opis nvarchar(500)
);
GO

Create table RezervniDio
(
IDRezervniDio int identity(1,1) Constraint PKRezervniDio Primary key (IDRezervniDio),
BrojModela nvarchar(25) unique,
Naziv nvarchar(50)
);
GO

Create table ServisniI_RezervniD
(
IDServisniI_RezervniD int identity(1,1) Constraint PK_ServiniI_RezervniD Primary key (IDServisniI_RezervniD),
ServisniIzvjestajID int 
	Constraint FK_ServisniIzvjestajRezervniID Foreign key (ServisniIzvjestajID) references ServisniIzvjestaj(IDServisniIzvjestaj),
RezervniDioID int 
	Constraint FK_RezervniDio Foreign key (RezervniDioID) references RezervniDio(IDRezervniDio),
Kolicina int
);
GO

Create table Cijena
(
IDCijena int identity(1,1) Constraint PK_Cijena Primary key (IDCijena),
BrojModela nvarchar(25) 
	Constraint FK_BrojModelaCijena Foreign key (BrojModela) references RezervniDio(BrojModela),
CijenaIznos decimal(10,4),
CijenaDatumKraja date
);
GO

Create table ServisnaRadnja
(
IDServisnaRadnja int identity(1,1) Constraint PK_ServisnaRadnja Primary key (IDServisnaRadnja),
Naziv nvarchar(50),
Opis nvarchar(200)
);
GO

Create table ServisnaR_ServisniI
(
IDServisnaR_ServisniI int identity(1,1) Constraint PKServisnaR_ServisniI Primary key (IDServisnaR_ServisniI),
ServisniIzvjestajID int 
	Constraint FK_ServisniIzvjestajServisnaR Foreign key (ServisniIzvjestajID) references ServisniIzvjestaj(IDServisniIzvjestaj),
ServisnaRadnjaID int 
	Constraint FK_ServisnaRadnja Foreign key (ServisnaRadnjaID) references ServisnaRadnja(IDServisnaRadnja)
);
GO

>>>>>>> Stashed changes
