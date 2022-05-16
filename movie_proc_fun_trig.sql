create or replace PROCEDURE DISPLAY_MOVIE(p_title movies.title%type, p_year movies.year%type) IS 
-- here declare section
BEGIN
  DBMS_OUTPUT.put_line('Movie: ' || p_title || ' (' || p_year || ')');
END;
/