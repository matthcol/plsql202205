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
