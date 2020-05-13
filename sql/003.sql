set xact_abort on;

declare @expectedSchemaVersion int = 2;

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

create sequence dbo.[global-sequence]
as integer
start with 1;

declare @pkName sysname;
select @pkName = [name] from sys.indexes where [object_id] = object_id('dbo.users');

declare @sql nvarchar(max);
set @sql = 'alter table dbo.users drop constraint ' + quotename(@pkName);
exec(@sql);

alter table dbo.users
drop column id;

alter table dbo.users
add id int not null default next value for dbo.[global-sequence];

alter table dbo.users
add constraint pk__users primary key (id);

delete from dbo.[$__db_version];
insert into dbo.[$__db_version] values (3, 1);

commit;
