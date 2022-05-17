create or replace package pack_movie is

    star_homonym exception;
    
    type t_title_year is record (
        title movies.title%type,
        year movies.year%type);
    
    function movie_count_by_year(p_year number, p_year2 number := NULL) return number;
    
    procedure create_movie(
        p_title in varchar2, 
        p_year in number := NULL,
        p_id out number);

end pack_movie;
/

create or replace package body pack_movie is

    function movie_count_by_year(p_year number, p_year2 number) return number is
        v_movie_count number;
    begin
        if p_year is null then
            v_movie_count := -1;
        elsif p_year2 is null then
            select count(*) into v_movie_count from movies where year = p_year;
        else
            select count(*) into v_movie_count from movies 
            where year between p_year and p_year2;
        end if;
        return v_movie_count;
    end;

    procedure create_movie(
        p_title in varchar2, 
        p_year in number,
        p_id out number
    ) is
        v_year number := p_year;
    begin
        if p_year is null then
            v_year := extract(year from current_date);
        end if;
        insert into movies (title, year) values (p_title, v_year);
        p_id := ISEQ$$_73704.currval;
    end;
    
end pack_movie;        
/