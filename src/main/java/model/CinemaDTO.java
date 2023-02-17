package model;

import lombok.Data;

@Data
public class CinemaDTO {
    private int id;
    private String name;
    private String country;
    private String autonomous_district;
    private String administrative_district;
    private String detailed_address;
    private String phone;
}
