package controller;

import dbConn.ConnectionMaker;

import java.sql.Connection;

public class ScreenInformationController {
    private Connection connection;

    public ScreenInformationController(ConnectionMaker connectionMaker) {
        connection = connectionMaker.makeConnection();
    }
}
