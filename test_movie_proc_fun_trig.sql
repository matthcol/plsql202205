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

-- call without p_id
call create_movie('The Batman', 2022);
call create_movie(p_title => 'The Batman', p_year => 2022);
call create_movie(p_year => 2022, p_title => 'The Batman');
call create_movie(p_title => 'The Batman'); -- OK for calling but constraint violation

declare
    v_id number;
begin
    create_movie('The Batman', 2022, v_id);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
    create_movie(p_title => 'The Batman', p_year => 2022, p_id => v_id);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
    create_movie(p_year => 2022, p_title => 'The Batman', p_id => v_id);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
    -- create_movie(p_title => 'The Batman', p_id => v_id); -- OK for calling but constraint violation
    -- DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
end;
/


select * from movies where title like 'The Batman';
delete from movies where title like 'The Batman';

-- NB: use sequence
select ISEQ$$_73704.nextval from dual;
select ISEQ$$_73704.currval from dual;

