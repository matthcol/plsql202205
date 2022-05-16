-- tests code pl/sql
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