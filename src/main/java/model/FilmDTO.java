package model;

import lombok.Data;

@Data
public class FilmDTO {
    private int id;
    private String title;
    private String description;
    private String director;
    private String rating;
    private String poster;
}
