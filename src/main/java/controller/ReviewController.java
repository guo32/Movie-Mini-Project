package controller;

import dbConn.ConnectionMaker;
import model.ReviewDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ReviewController {
    private Connection connection;

    public ReviewController(ConnectionMaker connectionMaker) {
        connection = connectionMaker.makeConnection();
    }

    public boolean insert(ReviewDTO reviewDTO) {
        String query = "INSERT INTO `review`(`writer_id`, `film_id`, `rating`, `review_content`) VALUES(?, ?, ?, ?)";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, reviewDTO.getWriter_id());
            pstmt.setInt(2, reviewDTO.getFilm_id());
            pstmt.setInt(3, reviewDTO.getRating());
            pstmt.setString(4, reviewDTO.getReview_content());

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            return false;
        }

        return true;
    }

    public void update(ReviewDTO reviewDTO) {

    }

    public boolean delete(int id) {
        String query = "DELETE FROM `review` WHERE `id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            pstmt.executeUpdate();
            pstmt.close();
        } catch (SQLException e) {
            return false;
        }
        return true;
    }

    public ArrayList<ReviewDTO> selectByFilmId(int film_id) {
        ArrayList<ReviewDTO> list = new ArrayList<>();
        String query = "SELECT * FROM `review` WHERE `film_id` = ? ORDER BY `id` DESC";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, film_id);

            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                ReviewDTO reviewDTO = new ReviewDTO();
                reviewDTO.setId(resultSet.getInt("id"));
                reviewDTO.setWriter_id(resultSet.getInt("writer_id"));
                reviewDTO.setFilm_id(resultSet.getInt("film_id"));
                reviewDTO.setRating(resultSet.getInt("rating"));
                reviewDTO.setReview_content(resultSet.getString("review_content"));
                reviewDTO.setEntry_date(resultSet.getTimestamp("entry_date"));

                list.add(reviewDTO);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public double calculateRatingAverageByFilmId(int film_id) {
        double average = 0.0;
        String query = "SELECT AVG(`rating`) FROM `review` WHERE `film_id` = ?";
        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, film_id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                average = resultSet.getDouble(1);
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return average;
    }

    public boolean validateRegisterReview(int film_id, int writer_id) {
        boolean result = true;
        String query = "SELECT `id` FROM `review` WHERE `film_id` = ? AND `writer_id` = ?";

        try {
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, film_id);
            pstmt.setInt(2, writer_id);

            ResultSet resultSet = pstmt.executeQuery();
            if (resultSet.next()) {
                result = false;
            }

            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}
