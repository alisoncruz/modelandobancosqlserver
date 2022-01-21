/*Criando as tabelas relacionadas do projeto*/

create table planetas(
id_planeta int not null,
nome varchar(50) not null,
rotacao float not null,
orbita float not null,
diametro float not null,
clima varchar(50) not null,
populacao int not null
);

go
--adicionando chave primária
alter table planetas add constraint pk_planetas primary key (id_planeta);

create table naves(
id_nave int not null,
nome varchar(100) not null,
modelo varchar(150) not null,
passageiros int not null,
carga float not null,
classe varchar(100) not null
);
-- adicionando chave primária
go 
alter table naves add constraint pk_naves primary key (id_nave)

go
create table pilotos(
id_piloto int not null,
nome varchar(200) not null,
ano_nascimento varchar(10) not null,
id_planeta int not null
);

-- adicionando chave primária
go
alter table pilotos add constraint pk_pilotos primary key(id_piloto);

--adicionando chave estrangeira
go
alter table pilotos add constraint fk_pilotos_planetas foreign key(id_planeta) references planetas(id_planeta);

-- criando tabela de relacionamento
go
create table pilotos_naves(
id_piloto int not null,
id_nave int not null,
flag_autorizado bit not null
)
-- adicionando chave primária
go
alter table pilotos_naves add constraint pk_pilotos_naves primary key(id_piloto,id_nave);

-- adicionando chave estrangeira
go
alter table pilotos_naves add constraint fk_pilotos_naves_pilotos foreign key(id_piloto) references pilotos(id_piloto);

-- adicionando chave estrangeira
go
alter table pilotos_naves add constraint fk_pilotos_naves_naves foreign key(id_nave) references naves(id_nave);

go
alter table pilotos_naves add constraint df_pilotos_naves_flag_autorizado default(1) for flag_autorizado;

-- criando tabela de histórico de viagens

go
create table historico_viagens (
id_nave int not null,
id_piloto int not null,
dt_saida datetime not null,
dt_chegada datetime null
);

-- adicionando chave estrangeira
go
alter table historico_viagens add constraint fk_historico_viagens_pilotos_naves foreign key (id_piloto, id_nave)
references pilotos_naves (id_piloto, id_nave);

-- o histórico será gerado somente se o piloto for autorizado(flag_autorizado)
go
alter table historico_viagens check constraint fk_historico_viagens_pilotos_naves;

select * from pilotos
select * from naves
select * from planetas
select * from pilotos_naves
select * from historico_viagens