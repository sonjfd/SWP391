/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import javax.sql.DataSource;
/**
 *
 * @author Dell
 */
public class DBContext {

    public static Connection getConnection() throws ClassNotFoundException, SQLException {
        Connection conn = null;
        String url = "jdbc:sqlserver://localhost:1433;databaseName=SWP391;encrypt=true;trustServerCertificate=true";
        String user = "sa";
        String password = "condoc123";
        //loaad driver lên
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        //connection
        conn = DriverManager.getConnection(url, user, password);
        return conn;
    }}
