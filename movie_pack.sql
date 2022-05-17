create or replace package pack_movie is

    star_homonym exception;
    
    type t_title_year is record (
        title movies.title%type,
        year movies.year%type);
    
    function movie_count_by_year(p_year number) return number;
    
    procedure create_movie(
        p_title in varchar2, 
        p_year in number := NULL,
        p_id out number);

end pack_movie;
/

create or replace package body pack_movie is

    function movie_count_by_year(p_year number) return number is
    begin
        return 0;
    end;

    procedure create_movie(
        p_title in varchar2, 
        p_year in number := NULL,
        p_id out number
    ) is
    begin
        p_id := -1;
    end;
    
end pack_movie;        
/