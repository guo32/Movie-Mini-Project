package controller;

import dbConn.ConnectionMaker;
import model.NoticeDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

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

    public void update(NoticeDTO noticeDTO) {
        String query = "UPDATE `notice` SET `category_id` = ?, `title` = ?, `content` = ?, `modify_date` = now() WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, noticeDTO.getCategory_id());
            pstmt.setString(2, noticeDTO.getTitle());
            pstmt.setString(3, noticeDTO.getContent());
            pstmt.setInt(4, noticeDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "DELETE FROM `notice` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public NoticeDTO selectById(int id) {
        NoticeDTO noticeDTO = null;
        String query = "SELECT * FROM `notice` WHERE `id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                noticeDTO = new NoticeDTO();
                noticeDTO.setId(resultSet.getInt("id"));
                noticeDTO.setWriter_id(resultSet.getInt("writer_id"));
                noticeDTO.setCategory_id(resultSet.getInt("category_id"));
                noticeDTO.setTitle(resultSet.getString("title"));
                noticeDTO.setContent(resultSet.getString("content"));
                noticeDTO.setEntry_date(resultSet.getTimestamp("entry_date"));
                noticeDTO.setModify_date(resultSet.getTimestamp("modify_date"));
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return noticeDTO;
    }

    public ArrayList<NoticeDTO> selectAll() {
        ArrayList<NoticeDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `notice` ORDER BY `entry_date`";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                NoticeDTO noticeDTO = new NoticeDTO();
                noticeDTO.setId(resultSet.getInt("id"));
                noticeDTO.setWriter_id(resultSet.getInt("writer_id"));
                noticeDTO.setCategory_id(resultSet.getInt("category_id"));
                noticeDTO.setTitle(resultSet.getString("title"));
                noticeDTO.setContent(resultSet.getString("content"));
                noticeDTO.setEntry_date(resultSet.getTimestamp("entry_date"));
                noticeDTO.setModify_date(resultSet.getTimestamp("modify_date"));

                list.add(noticeDTO);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
