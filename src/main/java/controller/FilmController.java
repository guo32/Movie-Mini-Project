package controller;

import dbConn.ConnectionMaker;
import model.FilmDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FilmController {
    Connection connection;

    public FilmController(ConnectionMaker connectionMaker) {
        connection = connectionMaker.makeConnection();
    }

    public boolean insert(FilmDTO filmDTO) {
        String query = "INSERT INTO `film`(`title`, `description`, `director`, `rating`, `poster`) VALUES(?, ?, ?, ?, ?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, filmDTO.getTitle());
            pstmt.setString(2, filmDTO.getDescription());
            pstmt.setString(3, filmDTO.getDirector());
            pstmt.setString(4, filmDTO.getRating());
            pstmt.setString(5, filmDTO.getPoster());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public void update(FilmDTO filmDTO) {
        String query = "UPDATE `film` SET `title` = ?, `description` = ?, `director` = ?, `rating` = ?, `poster` = ? WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, filmDTO.getTitle());
            pstmt.setString(2, filmDTO.getDescription());
            pstmt.setString(3, filmDTO.getDirector());
            pstmt.setString(4, filmDTO.getRating());
            pstmt.setString(5, filmDTO.getPoster());
            pstmt.setInt(6, filmDTO.getId());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void delete(int id) {
        String query = "DELETE FROM `film` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public FilmDTO selectById(int id) {
        FilmDTO filmDTO = null;
        String query = "SELECT * FROM `film` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);
            ResultSet resultSet = pstmt.executeQuery();

            if (resultSet.next()) {
                filmDTO = new FilmDTO();
                filmDTO.setId(resultSet.getInt("id"));
                filmDTO.setTitle(resultSet.getString("title"));
                filmDTO.setDescription(resultSet.getString("description"));
                filmDTO.setDirector(resultSet.getString("director"));
                filmDTO.setRating(resultSet.getString("rating"));
                filmDTO.setPoster(resultSet.getString("poster"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return filmDTO;
    }

    public ArrayList<FilmDTO> selectAll() {
        ArrayList<FilmDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `film` ORDER BY `id` DESC";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();

            while (resultSet.next()) {
                FilmDTO filmDTO = new FilmDTO();
                filmDTO.setId(resultSet.getInt("id"));
                filmDTO.setTitle(resultSet.getString("title"));
                filmDTO.setDescription(resultSet.getString("description"));
                filmDTO.setDirector(resultSet.getString("director"));
                filmDTO.setRating(resultSet.getString("rating"));
                filmDTO.setPoster(resultSet.getString("poster"));

                list.add(filmDTO);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
