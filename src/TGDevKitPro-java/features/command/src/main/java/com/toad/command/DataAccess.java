//package com.toad.command;
//
//
//import java.sql.*;
//
//public class DataAccess {
////    private Connection connection;
//
//
//    public void openDB() throws ClassNotFoundException{
//
//        Connection connection = null;
//        String filePath = "";
//        String url = "jdbc:sqlite:" + filePath;
//        int timeout = 30;
//        try {
//            Class.forName("org.sqlite.JDBC");
//            connection = DriverManager.getConnection(url);
//            Statement statement = connection.createStatement();
//            statement.setQueryTimeout(timeout);
//
//            statement.executeUpdate("");
//
//            ResultSet resultSet =  statement.executeQuery("");
//
//            while (resultSet.next()) {
//                System.out.println("name:" + resultSet.getString("name"));
//            }
//        }
//        catch (SQLException e){
//            System.out.println(e);
//        }
//        catch (Exception e){
//            System.out.println(e);
//        }
//        finally {
//            try{
//                if (null != connection) {
//                    connection.close();
//                }
//            }
//            catch (Exception e){
//                System.out.println(e);
//            }
//        }
//    }
//}
