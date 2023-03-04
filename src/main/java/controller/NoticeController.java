package controller;

import dbConn.ConnectionMaker;
import model.NoticeDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class NoticeController {
    private Connection connection;

    public NoticeController(ConnectionMaker connectionMaker) {
        connection = connectionMaker.makeConnection();
    }

    public boolean insert(NoticeDTO noticeDTO) {
        String query = "INSERT INTO `notice`(`writer_id`, `category_id`, `title`, `content`)";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, noticeDTO.getWriter_id());
            pstmt.setInt(2, noticeDTO.getCategory_id());
            pstmt.setString(3, noticeDTO.getTitle());
            pstmt.setString(4, noticeDTO.getContent());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }
}
