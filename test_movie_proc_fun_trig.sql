-- tests code pl/sql
set SERVEROUTPUT ON;

declare
begin
    display_movie('Terminator', 1984);
end;
/

call display_movie('Terminator', 1984);

declare
    v_title movies.title%type := 'Terminator 2';
    v_year movies.year%type := 1991;
begin
    display_movie(v_title, v_year);
end;
/

select movie_count from dual;

declare
    v_movie_count number;
begin
    v_movie_count := movie_count;
    dbms_output.put_line('Movie count: ' || v_movie_count);
end;
/

select movie_count_by_year(1984) from dual;
select movie_count_by_year(2021) from dual;
select movie_count_by_year(1980,1989) from dual;
select movie_count_by_year(NULL,NULL) from dual;
select movie_count_by_year(NULL,1989) from dual;

-- call without p_id
call create_movie('The Batman', 2022);
call create_movie(p_title => 'The Batman', p_year => 2022);
call create_movie(p_year => 2022, p_title => 'The Batman');
call create_movie(p_title => 'The Batman'); -- OK for calling but constraint violation

declare
    v_id number;
begin
    create_movie('The Batman', 2021, v_id);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
    create_movie(p_title => 'The Batman', p_year => 2023, p_id => v_id);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
    create_movie(p_year => 2025, p_title => 'The Batman', p_id => v_id);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
    create_movie(p_title => 'The Batman', p_id => v_id); -- OK for calling but constraint violation
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
end;
/

-- select f_create_movie('The Batman', 2022) from dual;  -- not DML possible insde function
declare
    v_id number;
begin
    v_id := f_create_movie('The Batman', 2022);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
end;
/

select * from movies where title like 'The Batman';
delete from movies where title like 'The Batman';

-- NB: use sequence
select ISEQ$$_73704.nextval from dual;
select ISEQ$$_73704.currval from dual;

-- exemple d'erreurs Oracle

-- following statement has no rows : it's not an error
select * from movies where id = 1; 

-- same statement in a pl/sql block with fetch .. into
-- error -1403 : aucune donnée trouvée / no data found
declare
    v_movie movies%rowtype;
begin
    select * into v_movie from movies where id = 1;
end;
/

-- handle with predefined exception no_data_found
declare
    v_movie movies%rowtype;
    -- v_id number := 1; 
    v_id number := 499549;
begin
    select * into v_movie from movies where id = v_id;
    DBMS_OUTPUT.PUT_LINE('Movie found: ' || v_movie.title);
exception
    when NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('Movie not found with id: ' || v_id);
end;
/

-- find by title
-- if there are homonyms : error ORA - 1422 : TOO_MANY_ROWS
declare
    v_movie movies%rowtype;
    -- v_title movies.title%type  := 'The Terminator';
    -- v_title movies.title%type  := 'Terminator 10';
    v_title movies.title%type  := 'The Man Who Knew Too Much';
begin
    select * into v_movie from movies where title = v_title;
    DBMS_OUTPUT.PUT_LINE('Movie found: ' 
            || v_movie.id 
            || ' - ' || v_movie.title
            || ' (' || v_movie.year || ')');
exception
    when NO_DATA_FOUND then
        DBMS_OUTPUT.PUT_LINE('Movie not found with title: ' || v_title);
    when TOO_MANY_ROWS then
        DBMS_OUTPUT.PUT_LINE('More than one movie found with this title: ' || v_title);
end;
/

-- in SQL : a sub-query returning 0-1 rows is not a problem with operator =, <, >, ... 
select * from stars where id = (select id_director from movies where id = 1);
select * from stars where id = (select id_director from movies where id = 499549);

select * from stars where id = (select id_director from movies where title = 'The Terminator');
-- Too many rows in subquery : ORA-1427
select * from stars where id = (select id_director from movies where title = 'The Man Who Knew Too Much');
-- OK with IN operator (  >ANY, >ALL, .... )
select * from stars where id IN (select id_director from movies where title = 'The Man Who Knew Too Much');
select * from stars where id IN (select id_director from movies where title = 'The Lion King');

select * from stars where name = 'Steve McQueen';
















