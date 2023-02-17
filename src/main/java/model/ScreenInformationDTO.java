package model;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class ScreenInformationDTO {
    private int id;
    private int cinema_id;
    private int film_id;
    private Timestamp start_time;
    private Timestamp end_time;
}
