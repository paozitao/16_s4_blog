/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package database;

import java.io.InputStream;
import java.io.PrintStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public final class DatabaseUtil
{
  private Statement st;
  private ResultSet rs;
  private Connection conn = null;
  private String currentDatabase = "sqlserver";
  private String dbURL = "";
  private String ConfFile = "conf.property";
  private Properties prop;

  public DatabaseUtil()
  {
    this.prop = new Properties();
    try {
      InputStream is = getClass().getResourceAsStream(this.ConfFile);
      this.prop.load(is);
      this.currentDatabase = this.prop.getProperty("databaseType");
      if (is != null) is.close(); 
    } catch (Exception e) { e.printStackTrace(); } 
  }

  public Connection getConnection() {
    try { String driverName = "";
      if ((this.conn == null) || (this.conn.isClosed()))
        try {
          if (this.currentDatabase.toLowerCase().equals("sqlserver2000")) {
            driverName = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
            this.dbURL = "jdbc:microsoft:sqlserver://" + getIp() + ":" + getPort() + ";DatabaseName=" + getDatabase();
          }else if (this.currentDatabase.toLowerCase().equals("sqlserver2005+")) {
            driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
            this.dbURL = "jdbc:microsoft:sqlserver://" + getIp() + ":" + getPort() + ";DatabaseName=" + getDatabase();
          }else if (this.currentDatabase.toLowerCase().equals("sqlserver2005++")) {
            driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
            this.dbURL = "jdbc:sqlserver://" + getIp() + ":" + getPort() + ";DatabaseName=" + getDatabase();
          }
           
          else if (this.currentDatabase.equals("oracle")) {
            driverName = "oracle.jdbc.driver.OracleDriver";
            this.dbURL = "jdbc:oracle:thin:@" + getIp() + ":" + getPort() + ";DatabaseName=" + getDatabase();
          }
          else if (this.currentDatabase.toLowerCase().equals("access")) {
            driverName = "sun.jdbc.odbc.JdbcOdbcDriver";
            this.dbURL = "jdbc:odbc:" + getDatabase();
          }else if(currentDatabase.toLowerCase().equals("mysql")){
             driverName = "com.mysql.jdbc.Driver";
             dbURL ="jdbc:mysql://" + getIp() +  ":" + getPort()+ "/" + getDatabase();
          }
          Driver driver = (Driver)Class.forName(driverName).newInstance();
          DriverManager.registerDriver(driver);
          this.conn = DriverManager.getConnection(this.dbURL, getUsername(), getPassword()); } catch (Exception e) {
          e.printStackTrace();
        }
      return this.conn;
    } catch (SQLException sqlE) {
      sqlE.printStackTrace();
    }return null;
  }

  public ResultSet executeQuery(String sql) {
    try {
      this.st = getConnection().createStatement();
      this.rs = this.st.executeQuery(sql);
    }
    catch (SQLException ex) {
      ex.printStackTrace();
    }

    return this.rs;
  }

  public void executeUpdate(String sql)
  {
    try {
      this.st = getConnection().createStatement();
      this.st.executeUpdate(sql); } catch (SQLException ex) {
      ex.printStackTrace(); sqlclose();
    }
  }
  public void sqlclose() {
    try { if (this.rs != null) this.rs.close();
      if (this.st != null) this.st.close();
      if (this.conn != null) this.conn.close();  } catch (SQLException ex) {
      ex.printStackTrace();
    }
  }
  private String getIp() { return this.prop.getProperty("ip"); }

  private String getPort() {
    return this.prop.getProperty("port");
  }
  private String getUsername() {
    return this.prop.getProperty("username");
  }
  private String getPassword() {
    return this.prop.getProperty("password");
  }
  private String getDatabase() {
    return this.prop.getProperty("database");
  }
  public String[] bgColor() {
    String[] s = { "#eeeeff", "#ddeedd" };
    return s;
  }

  public static String ISOtoGBK(String s) {
    try {
      if (s != null)
        s = new String(s.getBytes("ISO8859_1"), "GB2312");
      else s = ""; 
    } catch (Exception e) { e.printStackTrace(); }
    return s;
  }
  public static String GBKtoISO(String s) {
    try {
      s = new String(s.getBytes("GB2312"), "ISO8859_1"); } catch (Exception e) {
      e.printStackTrace();
    }return s;
  }

  public static String firstUpper(String s) {
    return s.substring(0, 1).toUpperCase() + s.substring(1, s.length());
  }

  public String typeConvert(int i)
  {
    String s;
    switch (i) { case 12:
      s = "String"; break;
    case -1:
      s = "String"; break;
    case 4:
      s = "float"; break;
    case 93:
      s = "String"; break;
    default:
      s = "String";
    }
    return s;
  }

  public Class typeConvertObject(int i) {
    Class c = null;
    try {
      switch (i) {
      case 12:
        c = Class.forName("java.lang.String");
        break;
      case -1:
        c = Class.forName("java.lang.String");
        break;
      case 4:
        c = Float.TYPE;
        break;
      case 93:
        c = Class.forName("java.lang.String");
        break;
      default:
        c = Class.forName("java.lang.String");
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
    return c;
  }
  public Object myCase(String type, String value) {
    Object o = value;
    if (type.equals("int")) o = Integer.valueOf(value);
    if (type.equals("Date")) o = Date.valueOf(value);
    if (type.equals("float")) o = Float.valueOf(value);
    return o;
  }

}