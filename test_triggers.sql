drop trigger trg_tvseries_id;
drop sequence seq_tvseries;
drop table episodes;
drop table tvseries;


create table tvseries (
    id number constraint pk_tvseries primary key,
    title varchar2(250) not null,
    count_episodes number default 0 not null
);

create sequence seq_tvseries;

select seq_tvseries.nextval from dual;
select seq_tvseries.currval from dual;

create or replace trigger trg_tvseries_id
before insert on tvseries
for each row
begin
    :new.id := seq_tvseries.nextval;
end;
/

-- wrong version : after instead of before
create or replace trigger trg_tvseries_id
after insert on tvseries
for each row
begin
    :new.id := seq_tvseries.nextval;
end;
/

-- wrong version : without for each row
create or replace trigger trg_tvseries_id
before insert on tvseries
begin
    :new.id := seq_tvseries.nextval;
end;
/

insert into tvseries (title) values ('Bosch');
insert into tvseries (title) values ('Bosch Legacy');
select * from tvseries where title like 'Bosch%';
delete from tvseries where title like 'Bosch%';

drop table logs;
create table logs (
    timestamp timestamp,
    who varchar2(50),
    entity varchar2(50),
    type varchar2(10)
);

create or replace trigger trg_log_tvseries
after insert or update or delete on tvseries
declare
    v_type logs.type%type;
begin
    case
                when inserting then v_type := 'inserting';
                when updating then  v_type := 'updating';
                when deleting then v_type := 'deleting';
    end case;
    insert into logs (timestamp,who,entity,type) 
        values (current_timestamp, user, 'tvseries', v_type);
end;
/

select current_timestamp  from dual;

insert into tvseries (title) values ('Stranger Things');
update tvseries set count_episodes = 39 where title = 'Stranger Things';
delete tvseries where title = 'Stranger Things';

select * from logs;

drop table episodes;
create table episodes (
    id number 
        generated always as identity
        constraint pk_episodes primary key,
    ep_number varchar2(15) NOT NULL,
    title varchar2(250) NULL,
    id_tvseries 
        constraint FK_episodes_tvseries REFERENCES tvseries(id)
);



create or replace trigger trg_count_episode
after insert or delete or update of id_tvseries on episodes
for each row
begin
    if inserting or updating then
        update tvseries set count_episodes = count_episodes + 1 where id = :new.id_tvseries;
    end if;
    if updating or deleting then
        update tvseries set count_episodes = count_episodes - 1 where id = :old.id_tvseries;
    end if;
end;
/

insert into episodes (ep_number, id_tvseries) values ('S01E01',1);

declare
begin
    for i in 1 .. 13 loop
        insert into episodes (ep_number, id_tvseries) values ('S01E' || to_char(i, '00'), 2);
    end loop;
end;
/

delete from episodes where id_tvseries in (1,2);
update episodes set id_tvseries = 1 where id_tvseries = 2 and ep_number = 'S01E 13';

select '#' || substr(to_char(3, '00'),2,2) || '#' from dual;

select *
from 
    tvseries t
    left join episodes e on e.id_tvseries = t.id
where t.title like 'Bosch%';
