set xact_abort on;

declare @expectedSchemaVersion int = 1;

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

begin tran;

alter table dbo.users 
add email nvarchar(1024) null;

alter table dbo.users 
alter column firstname nvarchar(100) not null;

alter table dbo.users 
alter column lastname nvarchar(100) not null;

update dbo.users
set email = 'damauri@microsoft.com'
where id = 1

delete from dbo.[$__db_version];
insert into dbo.[$__db_version] values (2, 1);

commit;

