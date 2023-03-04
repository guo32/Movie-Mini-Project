package model;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class NoticeDTO {
    private int id;
    private int writer_id;
    private int category_id;
    private String title;
    private String content;
    private Timestamp entry_date;
    private Timestamp modify_date;
}
