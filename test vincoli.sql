insert into Modulo (Codice, Nome, Descrizione, CFU)
  values ('47029485', 'reti', 'modello ISO-OSI', 9 );           

insert into Modulo (Codice, Nome, Descrizione, CFU)
  values (NULL, 'reti', 'modello ISO-OSI', 9 );                

insert into Modulo (Codice, Nome, Descrizione, CFU)
  values ('670294876', 'reti', 'modello ISO-OSI', 6 );           

insert into Modulo (Codice, Nome, Descrizione, CFU)
  values ('-7029486', 'reti', 'modello ISO-OSI', 9 );            

insert into Modulo (Codice, Nome, Descrizione, CFU)
  values ('67029486', NULL, 'modello ISO-OSI', 9 );              

insert into Modulo (Codice, Nome, Descrizione, CFU)
  values ('67029486', 'Basi di Dati', 'modello ISO-OSI', 9 );    

insert into Modulo (Codice, Nome, Descrizione, CFU)
  values ('67029486', 'reti', 'modello ISO-OSI', NULL );         

insert into Modulo (Codice, Nome, Descrizione, CFU)
  values ('67029486', 'reti', 'modello ISO-OSI', 5 );            

insert into esame (Matricola_studente, Codice_modulo, Matricola_docente, Data, Voto, Note)
  values ('123458', '47029484', '123333', '2020-04-07', 30, 'note');    

 delete from Modulo where Codice='47029485';                            