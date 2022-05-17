select pack_movie.movie_count_by_year(1984) from dual;
select pack_movie.movie_count_by_year(2021) from dual;
select pack_movie.movie_count_by_year(1980,1989) from dual;
select pack_movie.movie_count_by_year(NULL,NULL) from dual;
select pack_movie.movie_count_by_year(NULL,1989) from dual;



declare
    v_id number;
begin
    pack_movie.create_movie('The Batman', 2021, v_id);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
    pack_movie.create_movie(p_title => 'The Batman', p_year => 2023, p_id => v_id);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
    pack_movie.create_movie(p_year => 2025, p_title => 'The Batman', p_id => v_id);
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
    pack_movie.create_movie(p_title => 'The Batman', p_id => v_id); 
    DBMS_OUTPUT.put_line('Movie created with id: ' || v_id);
end;
/

select * from movies where title = 'The Batman';
delete from movies where title = 'The Batman';
