create or replace PROCEDURE DISPLAY_MOVIE(p_title movies.title%type, p_year movies.year%type) IS 
-- here declare section
BEGIN
  DBMS_OUTPUT.put_line('Movie: ' || p_title || ' (' || p_year || ')');
END;
/

-- function with no parameters

-- count all movies 
create or replace function movie_count RETURN number is
    v_movie_count number;
begin
    select count(*) into v_movie_count from movies;
    return v_movie_count;
end;
/

-- count movies from one year
create or replace function movie_count_by_year(p_year number) return number is
    v_movie_count number;
begin
    select count(*) into v_movie_count from movies where year = p_year;
    return v_movie_count;
end;
/

create or replace procedure create_movie(
    p_title in varchar2, 
    p_year in number := NULL,
    p_id out number
) is
begin
    insert into movies (title, year) values (p_title, p_year);
    -- select ISEQ$$_73704.currval into p_id from dual;
    p_id := ISEQ$$_73704.currval;
end;
/

-- not possible with Oracle 11 and before
create or replace function f_create_movie(
    p_title in varchar2, 
    p_year in number := NULL
) return  number is
begin
    insert into movies (title, year) values (p_title, p_year);
    -- select ISEQ$$_73704.currval into p_id from dual;
    return ISEQ$$_73704.currval;
end;
/

create or replace procedure create_movie_director(
    p_title in varchar2, 
    p_year in number := NULL,
    p_id out number
) is
begin
    insert into movies (title, year) values (p_title, p_year);
    -- select ISEQ$$_73704.currval into p_id from dual;
    p_id := ISEQ$$_73704.currval;
end;
/
