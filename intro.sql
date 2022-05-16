alter session set nls_date_format = 'YYYY-MM-DD';

select user, current_date from dual;

select * from movies where year = 2019;

select * 
from stars 
where extract(year from birthdate) = 1930
order by name;

-- add movie Sonic the Hedgehog 2 (2022) from director Jeff Fowler (1978-07-27)
select * from stars where name like '%Fowler'; -- not here
insert into stars (name, birthdate) values ('Jeff Fowler', '1978-07-27');
insert into movies (title, year, duration, id_director) 
    values ('Sonic the Hedgehog 2', 2022, 122, 11749102);
select * from movies where title like 'Sonic%';

select * from stars where name like '%Carrey';

insert into play (id_movie, id_actor, role) values (12771924,120,'Dr. Robotnik');

select m.title, m.year, p.role
from movies m join play p on m.id = p.id_movie
where p.id_actor in (select id from stars where name like 'Jim Carrey')
order by m.year desc;

set SERVEROUTPUT ON;

declare
    v_id_star integer;
begin
    select id into v_id_star from stars where name like 'Jim Carrey';
    DBMS_OUTPUT.put_line('Jim Carrey found with id: ' || v_id_star);
end;
/

declare
begin
    dbms_output.put_line('Hello World');
end;
/

-- create table t(c boolean); -- ORA-00902: type de données non valide

select m.*, s.name
from movies m left join stars s on m.id_director = s.id
where m.id = 7131622;

declare
    type t_title_year_name is record (
        title movies.title%type,
        year movies.year%type,
        name stars.name%type
    );

    v_counter number(10);
    v_found boolean := false;
    v_title movies.title%type; -- same type as column movies.title
    v_movie movies%rowtype; -- same as 1 row of table movies (record)
    v_name stars.name%type;
    v_year movies.year%type;
    v_title_year_name t_title_year_name; -- variable of type record custom
begin
    DBMS_OUTPUT.put_line('Counter: ' || v_counter); -- v_counter NULL
    
    v_found := true;
    -- NB : boolean is not printable
    DBMS_OUTPUT.put_line('Found: ' || case v_found when true then 'true' else 'false' end);
    
    select title into v_title from movies where id = 764648;
    DBMS_OUTPUT.put_line('Movie title: ' || v_title);
    
    select * into v_movie from movies where id = 7131622;
    DBMS_OUTPUT.put_line('Movie title: ' || v_movie.title || ' (' || v_movie.year || ')');
    
    select m.title, m.year, s.name into v_title, v_year, v_name
        from movies m left join stars s on m.id_director = s.id
        where m.id = 7131622;
    DBMS_OUTPUT.put_line('Movie title: ' || v_title || ' (' || v_year || ') by ' || v_name);

    select m.title, m.year, s.name into v_title_year_name
        from movies m left join stars s on m.id_director = s.id
        where m.id = 7131622;
    DBMS_OUTPUT.put_line('Movie title: ' || v_title_year_name.title 
        || ' (' || v_title_year_name.year || ') by ' || v_title_year_name.name);
    
    dbms_output.new_line;
end;
/






