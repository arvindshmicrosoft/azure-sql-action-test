set xact_abort on;

declare @expectedSchemaVersion int = 0;

declare @schemaVersion int;
declare @dataVersion int;

select top (1)
    @schemaVersion = schema_version,
    @dataVersion = data_version
from 
    dbo.[$__db_version];

if (@schemaVersion != @expectedSchemaVersion) begin
    declare @msg nvarchar(max) = formatmessage('Database already on version %i. Current database version is %i. Skipping.', @expectedSchemaVersion, @schemaVersion);
    return;
end;

create table dbo.users 
(
    id int identity not null constraint pk__users primary key,
    firstname varchar(100) not null,
    lastname varchar(100) not null
);

insert into dbo.users 
	(firstname, lastname) 
values
	('Davide', 'Mauri');
go
