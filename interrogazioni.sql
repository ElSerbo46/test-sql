\* 1) Mostrare nome e descrizione di tutti i moduli da 9 CFU *\
 
select Nome, Descrizione 
from modulo 
where CFU=9;

\* 2) Mostrare matricola, nome e cognome dei docenti che hanno più di 60 anni *\

select matricola, nome, cognome 
from docente 
where data_nascita > data_nascita+60;

\* 3) Mostrare nome, cognome e nome del dipartimento di ogni docente, ordinati dal più giovane al più anziano. *\

select doc.nome, cognome, dip.nome 
from docente doc, dipartimento dip 
where dipartimento=codice
order by data_nascita desc;

select doc.nome, cognome, dip.nome 
from docente doc join dipartimento dip on dipartimento=codice
order by data_nascita desc;

\* 4) Mostrare città e indirizzo di ogni sede del dipartimento di codice "1001" *\

select città, indirizzo 
from sede join sede_dipartimento on codice=codice_sede 
where codice_dipartimento=1001;

select città, indirizzo 
from sede, sede_dipartimento 
where codice=codice_sede 
and codice_dipartimento=1001;

\* 5) Mostrare nome del dipartimento, città e indirizzo di ogni sede di ogni dipartimento, 
      ordinate alfabeticamente prima per nome dipartimento, poi per nome città e infine per indirizzo. *\

select nome, città, indirizzo
from dipartimento join sede_dipartimento on dipartimento.codice=codice_dipartimento join sede on codice_sede=sede.codice 
order by nome, città, indirizzo;

\* 6) Mostrare il nome di ogni dipartimento che ha una sede a Bari. *\

select nome 
from dipartimento join sede_dipartimento on dipartimento.codice=codice_dipartimento join sede on codice_sede=sede.codice 
where città='Bari';

\* 7) Mostrare il nome di ogni dipartimento che non ha sede a Brindisi. *\

select nome 
from dipartimento join sede_dipartimento on dipartimento.codice=codice_dipartimento join sede on codice_sede=sede.codice 
where città<>'Brindisi';

\* 8) Mostrare media, numero esami sostenuti e totale CFU acquisiti dello studente con matricola 123456. *\

select avg(voto), count(*) as numero_esami, sum(CFU) 
from studente join esame on matricola=matricola_studente join modulo on Codice_modulo=codice 
where matricola=123456;

\* 9) Mostrare nome, cognome, nome del corso di laurea, media e numero esami sostenuti dello studente 
      con matricola 123456. *\

select studente.nome, cognome, corso_laurea.nome, avg(voto), count(*) as numero_esami 
from studente join corso_laurea on corso_laurea=corso_laurea.codice join esame on matricola=matricola_studente join modulo on Codice_modulo=modulo.codice 
where matricola=123456
group by matricola;

\* 10) Mostrare codice, nome e voto medio di ogni modulo, ordinati dalla media più alta alla più bassa. *\

select codice, nome, avg(voto) 
from modulo join esame on codice=codice_modulo 
group by codice 
order by avg(voto) desc;

\* 11) Mostrare nome e cognome del docente, nome e descrizione del modulo per ogni docente 
       ed ogni modulo di cui quel docente abbia tenuto almeno un esame; il risultato deve includere 
       anche i docenti che non abbiano tenuto alcun esame, in quel caso rappresentati con un'unica tupla 
       in cui nome e descrizione del modulo avranno valore NULL. *\ 

select distinct docente.nome, docente.cognome, modulo.nome, modulo.descrizione 
from modulo left join esame on codice=codice_modulo right join docente on matricola_docente=matricola 
where exists (select * 
              from esame 
              where matricola_docente=matricola) 
or matricola_docente is null;

\* 12) Mostrare matricola, nome, cognome, data di nascita, media e numero esami sostenuti di ogni studente. *\

select matricola, nome, cognome, data_nascita, avg(voto), count(*) 
from studente join esame on matricola=matricola_studente 
group by matricola_studente;

\* 13) Mostrare matricola, nome, cognome, data di nascita, media e numero esami sostenuti di ogni studente 
       del corso di laurea di codice "ICD" che abbia media maggiore di 27. *\

select matricola, studente.nome, cognome, data_nascita, avg(voto), count(*) 
from corso_laurea join studente on corso_laurea=codice join esame on matricola=matricola_studente 
where corso_laurea.nome='Informatica e Comunicazione Digitale' 
group by matricola_studente 
having avg(voto)>27;

\* 14) Mostrare nome, cognome e data di nascita di tutti gli studenti che ancora non hanno superato nessun esame. *\

select matricola, nome, cognome 
from studente 
where not exists (select * 
                  from esame 
                  where matricola=matricola_studente);

\* 15) Mostrare la matricola di tutti gli studenti che hanno superato almeno un esame e che hanno preso 
       sempre voti maggiori di 26. *\ 

select matricola_studente 
from esame 
where matricola_studente <> all (select matricola_studente 
                                 from esame
                                 where voto < 26);

\* 16) Mostrare, per ogni modulo, il numero degli studenti che hanno preso tra 18 e 21, quelli che
       hanno preso tra 22 e 26 e quelli che hanno preso tra 27 e 30 (con un'unica interrogazione). *\ 



\* 17) Mostrare matricola, nome, cognome e voto di ogni studente che ha preso un voto maggiore della media
       nel modulo "BDD" *\

select matricola, studente.nome, cognome, voto 
from studente join esame on matricola=matricola_studente join modulo on codice_modulo=codice 
where modulo.nome='Basi di Dati' and matricola in (select p1.matricola_studente 
                                                   from esame p1 
                                                   where voto > (select avg(voto) 
                                                                 from esame p2 
                                                                 where p2.matricola_studente=p1.matricola_studente 
                                                                 group by p2.matricola_studente));

\* 18) Mostrare matricola, nome, cognome di ogni studente che ha preso ad almeno 3 esami un voto maggiore 
       della media per quel modulo. *\ 



