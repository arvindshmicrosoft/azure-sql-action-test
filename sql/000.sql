set xact_abort on;

if object_id('dbo.[$__db_version]') is not null begin	
    print 'Database has been already initialized. Skipping.';
    return;
end;

create table dbo.[$__db_version]
(
    schema_version int not null,
    data_version int not null
);

insert into dbo.[$__db_version] values (0, 0);
