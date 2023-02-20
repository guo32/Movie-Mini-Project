package controller;

import dbConn.ConnectionMaker;
import model.FilmDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class FilmController {
    private Connection connection;
    private final int PAGE_SIZE = 5;

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

    public ArrayList<FilmDTO> selectAll(int pageNo) {
        ArrayList<FilmDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `film` ORDER BY `id` DESC LIMIT ?, ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, (pageNo - 1) * PAGE_SIZE);
            pstmt.setInt(2, PAGE_SIZE);
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

    public int countTotalPage() {
        int totalPage = 0;
        String query = "SELECT COUNT(*) FROM `film`";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();

            int count = 0;
            if (resultSet.next()) {
                count = resultSet.getInt(1);
            }

            totalPage = count / PAGE_SIZE;
            if (count % PAGE_SIZE != 0) {
                totalPage++;
            }
            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return totalPage;
    }
}
