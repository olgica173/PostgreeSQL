
create table ProizvodObleka(
shifra_dodatok integer constraint pk_obleka primary key,
Materijal varchar,
brzaliha integer,
popust integer,
cena integer,
id_prodavnica integer constraint fk_prodavnica references Prodavnica(id_prodavnica) not null
);
create table ProizvodDodatok(
shifra_dodatok integer constraint pk_dodatok primary key,
zaliha integer,
Materijal varchar,
popust integer,
cena integer,
id_prodavnica integer constraint fk_prodavnica references Prodavnica(id_prodavnica) not null
);
create table Kupuvach(
EMBG integer constraint pk_kupuvach primary key,
ime varchar(100),
Prezime varchar(100),
telbroj varchar(10),
shifra_dodatok integer constraint fk_dodatok references ProizvodDodatok(shifra_dodatok) not null
);
create table Vraboten(
EMBG_vraboten integer constraint pk_vraboten primary key,
ime varchar(100),
Prezime varchar(100),
telbroj varchar(10),
id_prodavnica integer constraint fk_prodavnica references Prodavnica(id_prodavnica) not null
);
create table Prodavnica(
id_prodavnica integer constraint pk_prodavnica primary key,
website varchar(100),
adresa varchar(200),
Ime varchar(100),
telbroj varchar(100)

);
insert into Prodavnica values(1,'modam.com.mk','Kej 8 Septemvri br.190','ModaM',078712345);
insert into Prodavnica values(2,'modam1.com.mk','Kej 8 Septemvri br.192','ModaM1',078712345);

insert into Kupuvach(2407998496008,'Maja','Kostadinova',07873728292);
insert into Kupuvach(7807996495006,'Monika','Koceva',078737456);

insert into Vraboten('Tom','John',078654345,1);
insert into Vraboten('Tomce','Jovanov',078654345,2);
insert into Vraboten('Jovana','Miteva',078789345,2);

insert into proizvoddodatok values(123,12,'biser',20,560,1);
insert into proizvoddodatok values(1234,10,'kamen',15,1200,2);
insert into proizvoddodatok values(1235,1,'svila',4,500,2);

insert into proizvoddodatok values(11,15,'len',20,900,1);
insert into proizvoddodatok values(22,10,'teksas',15,120,2);
insert into proizvoddodatok values(33,1,'svila',50,520,2);

insert into proizvodobleka values(01,12,'kozha',15,850,1);
insert into proizvodobleka values(02,11,'teksas',25,1200,2);
insert into proizvodobleka values(03,10,'svila',50,500,2);

select *from prodavnica

UPDATE Vraboten
SET ime = 'Petre'
WHERE ime='Tom';

ALTER TABLE proizvoddodatok
DROP COLUMN brzaliha;

UPDATE Kupuvach
SET prezime='Petkova'
WHERE ime='Maja';

SELECT count(ime)
FROM vraboten 
GROUP BY vraboten.prezime;

CREATE VIEW Popust AS
SELECT cena,popust 
FROM ProizvodDodatok
WHERE  cena>500;

CREATE VIEW Namalenie AS
SELECT cena,popust 
FROM ProizvodObleka
WHERE  cena>500;

select distinct p.adresa,d.id_prodavnica,o.id_prodavnica
from prodavnica as p
left join proizvoddodatok as d on p.id_prodavnica=d.id_prodavnica
left join proizvodobleka as o on p.id_prodavnica=o.id_prodavnica
where o.cena>200
group by p.id_prodavnica;


select distinct o.brzaliha,d.zaliha
from proizvodobleka as o
left join prodavnica as p on o.id_prodavnica=p.id_prodavnica
left join proizvoddodatok as d on d.zaliha=o.brzaliha;


select distinct v.id_prodavnica,o.id_prodavnica,o.materijal,d.materijal
from prodavnica as p
inner join vraboten as v on v.id_prodavnica=p.id_prodavnica
right join proizvodobleka as o on p.id_prodavnica=o.id_prodavnica
left join proizvoddodatok as d on d.materijal=o.materijal
group by d.materijal;

