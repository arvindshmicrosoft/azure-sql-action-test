set xact_abort on;

if object_id('dbo.[$__db_version]') is not null begin	
    throw 50000, 'Database has been already initialized with version 1', 16;
end;

create table dbo.[$__db_version]
(
    schema_version int not null,
    data_version int not null
);

insert into dbo.[$__db_version] values (1, 1);

create table dbo.users 
(
    id int identity not null primary key,
    firstname varchar(100) not null,
    lastname varchar(100) not null
);

insert into dbo.users 
	(firstname, lastname) 
values
	('Davide', 'Mauri');
go

/*
drop table dbo.[$__db_version];
drop table dbo.users 
*/