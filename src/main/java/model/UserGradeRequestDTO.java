package model;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class UserGradeRequestDTO {
    private int id;
    private int user_id;
    private int request_grade;
    private Timestamp request_date;
    private String status;
}
