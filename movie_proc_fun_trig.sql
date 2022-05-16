create or replace PROCEDURE DISPLAY_MOVIE(p_title movies.title%type, p_year movies.year%type) IS 
-- here declare section
BEGIN
  DBMS_OUTPUT.put_line('Movie: ' || p_title || ' (' || p_year || ')');
END;
/

-- function with no parameters
create or replace function movie_count RETURN number is
    v_movie_count number;
begin
    select count(*) into v_movie_count from movies;
    return v_movie_count;
end;
/