create database University;

use University;

create table Modulo (
    Codice numeric(8) primary key check (Codice>0),
    Nome varchar(50) not null unique,
    Descrizione varchar(50),
    CFU numeric(2) not null check (CFU=6 or CFU=9 or CFU=12)
);

create table Corso_Laurea (
    Codice numeric(3) primary key check (Codice>0),
    Nome varchar(50) not null unique,
    Descrizione varchar(50)
);

create table Dipartimento (
    Codice numeric(4) primary key check (Codice>0),
    Nome varchar(50) not null unique
);

create table Sede (
    Codice numeric(5) primary key check (Codice>0),
    Indirizzo varchar(50) not null unique,
    Città varchar(15) not null
);

create table Studente (
    Matricola numeric(6) primary key check (Matricola>0),
    Corso_laurea numeric(3) not null check (Corso_laurea>0),
    Nome varchar(30) not null,
    Cognome varchar(30) not null,
    Data_nascita date,
    Codice_fiscale char(16) unique,
    Foto blob,
    foreign key (Corso_laurea) references Corso_Laurea (Codice) on update cascade on delete no action
);

create table Docente (
    Matricola numeric(6) primary key check (Matricola>0),
    Dipartimento numeric(4) check (Dipartimento>0),
    Nome varchar(30) not null,
    Cognome varchar(30) not null,
    Data_nascita date,
    Codice_fiscale char(16) unique,
    Foto blob,
    foreign key (Dipartimento) references Dipartimento (Codice) on update cascade on delete no action
);

create table Esame (
    Matricola_studente numeric(6) not null check (Matricola_studente>0),
    Codice_modulo numeric(8) check (Codice_modulo>0),
    Matricola_docente numeric(6) not null check (Matricola>0),
    Data date not null,
    Voto numeric(2) not null,
    Note varchar(50),
    primary key (Matricola_studente, Codice_modulo, Data),
    foreign key (Matricola_studente) references Studente (Matricola),
    foreign key (Codice_modulo) references Modulo (Codice) on update cascade on delete no action,
    foreign key (Matricola_docente) references Docente (Matricola)
);

create table Sede_Dipartimento (
    Codice_Sede numeric(5) not null check (Codice_Sede>0),
    Codice_Dipartimento numeric(4) not null check (Codice_Dipartimento>0),
    Note varchar(50),
    primary key (Codice_Sede, Codice_Dipartimento),
    foreign key (Codice_Sede) references Sede (Codice) on update cascade on delete no action,
    foreign key (Codice_Dipartimento) references Dipartimento (Codice) on update cascade on delete no action 
);

insert into Modulo (Codice, Nome, Descrizione, CFU)
  values ('47029484', 'Basi di Dati', 'creazione e gestione database', 9 ),
         ('47029483', 'Ingegneria del Software', 'sviluppo e progettazione software', 12),
         ('47029485', 'Calcolo Numerico', 'studio algoritmi numerici', 6),
         ('47029486', 'Statistica', 'studi andamento dati numerici', 6),
         ('47029487', 'Sistemi Informativi', 'creazione e gestione database con trigger', 9 );
insert into Corso_Laurea (Codice, Nome, Descrizione)
  values ('110', 'Informatica e Comunicazione Digitale', 'descrizione');
insert into Dipartimento (Codice, Nome)
  values ('1001', 'Dipartimento di Informatica di Bari'),
         ('1002', 'Dipartimento di Chimica di Bari');
insert into Sede (Codice, Indirizzo, Città)
  values ('10001', 'Viale del Turismo', 'Taranto'),
         ('10002', 'Via E. Orabona', 'Bari');
insert into Studente (Matricola, Corso_laurea, Nome, Cognome, Data_nascita, Codice_fiscale, Foto)
  values ('123456', '110', 'Andrea', 'Rossi', '2000-01-01', 'GSPVRC00A01L049C', NULL),
         ('123457', '110', 'Stefano', 'Neri', '1999-02-03', 'NRESFN99C02A662A', NULL);
insert into Docente (Matricola, Dipartimento, Nome, Cognome, Data_nascita, Codice_fiscale, Foto)
  values ('123333', '1001', 'Stefano', 'Neri', '1974-01-01', 'STFNRE74A01L049Y', NULL),
         ('123334', '1001', 'Alessio', 'Bianchi', '1978-08-20', 'LSSBCH78M20E506V', NULL),
         ('123335', '1001', 'Marco', 'Bianchi', '1986-05-07', 'BNCMRC86E07E986J', NULL),
         ('123336', '1001', 'Luca', 'Marrone', '1980-01-01', 'LCUMRN80A01E506D', NULL),
         ('123337', '1001', 'Gianvito', 'Pio', '1990-09-05', 'PIOGVT90P05A662Q', NULL);
insert into Esame (Matricola_studente, Codice_modulo, Matricola_docente, Data, Voto, Note)
  values ('123456', '47029484', '123333', '2020-04-07', 30, 'note'),
         ('123457', '47029483', '123334', '2020-04-07', 28, 'note'),
         ('123456', '47029485', '123335', '2020-06-15', 23, 'note'),
         ('123456', '47029483', '123334', '2020-06-23', 30, 'note'),
         ('123456', '47029486', '123336', '2020-01-15', 30, 'note');
insert into Sede_Dipartimento (Codice_Sede, Codice_Dipartimento, Note)
  values ('10001', '1001', 'note'),
         ('10002', '1002', 'note');
