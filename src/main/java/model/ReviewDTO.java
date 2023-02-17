package model;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class ReviewDTO {
    private int id;
    private int writer_id;
    private int film_id;
    private int rating;
    private String review_content;
    private Timestamp entry_date;
    private Timestamp modify_date;
}
