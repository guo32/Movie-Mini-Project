package model;

import lombok.Data;

@Data
public class TheaterDTO {
    private int id;
    private int cinema_id;
    private String name;
    private int capacity;
}
