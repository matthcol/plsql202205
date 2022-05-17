select pack_movie.movie_count_by_year(1984) from dual;
select pack_movie.movie_count_by_year(2021) from dual;


declare
    v_id number;
begin
    pack_movie.create_movie('The Batman', 2021, v_id);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
    pack_movie.create_movie(p_title => 'The Batman', p_year => 2023, p_id => v_id);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
    pack_movie.create_movie(p_year => 2025, p_title => 'The Batman', p_id => v_id);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
    pack_movie.create_movie(p_title => 'The Batman', p_id => v_id); -- OK for calling but constraint violation
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
end;
/
