package hacku2017;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseAccess {

	private Connection con = null;
	private Statement st = null;
	private ResultSet rs = null;

	public void Connect(){
		try {
			// MySQLのドライバと接続する
			Class.forName("com.mysql.jdbc.Driver");

			// Connectionにデータベース名、ユーザ名、パスワードを代入することで
			// 使用するデータベースを特定できる
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hacku2017?characterEncoding=utf8", "root",
					"");

			// Statementに使用するデータベース情報を代入する
			st = con.createStatement();
		} catch (ClassNotFoundException e) {

		} catch (SQLException e) {
		}
	}

	public ResultSet Select(String sql){
		try{
			rs = st.executeQuery(sql);
		}catch (SQLException e) {
			// TODO: handle exception
		}
		return rs;
	}

	public void Update(String sql){
		try{
			st.executeUpdate(sql);
		}catch (SQLException e) {
			// TODO: handle exception
			System.out.println("3");
		}
	}

	public void Close(){
		if (rs != null) {
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO: handle exception
			}
		}
		if (st != null) {
			try {
				st.close();
			} catch (SQLException e) {
				// TODO: handle exception
			}
		}
		if (con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO: handle exception
			}
		}
	}

}
