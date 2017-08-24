

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class HackuRegister
 */
@WebServlet("/HackuRegister")
public class HackuRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public HackuRegister() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//↓文字化け対策
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		// セッションスコープに登録ユーザーを保存
		HttpSession session = request.getSession(true);
		String username = (String)session.getAttribute("USERNAME");
		String pass = (String)session.getAttribute("PASS");
		String sql = null;

		Connection con = null;
		Statement st = null;
		ResultSet rs = null;

		try {
			//Mysqlのドライバーと接続する
			Class.forName("com.mysql.jdbc.Driver");

			//Connectionにデータベース名、ユーザー名、パスワードを代入する事で
			//使用するデータベースを特定できる
			con = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/hacku2017?useUnicode=true&characterEncoding=utf-8",
					"root", "");

			//Statementに使用するデータベース情報を代入する
			st = con.createStatement();

			//System.out.println(pass);

			sql = "select * from users for update;";
			rs = st.executeQuery(sql);

			//-----ここからがINSERT文----------------------------------------------------------
			sql="insert into users";
			sql+="(user_name, ";
			sql+="user_password) ";
			sql+="values ";
			sql+="('"+username+"', ";
			sql+= "'"+pass+"'); ";
			//-----ここまでがINSERT文----------------------------------------------------------
			System.out.println(sql);
			//参照系SQL以外を実行する
			int cnt = st.executeUpdate(sql);

		}catch (ClassNotFoundException e) {

		} catch (SQLException e) {

		} finally {
			if (rs != null) {
				try {
					st.close();
					//cnt_st.close();
				} catch (SQLException e) {

				}
			}
			if (con != null) {
				try {
					//トランザクションをコミットして、更新を反映
					con.commit();
					//Connectionのオブジェクトをクローズ
					con.close();
				} catch (SQLException e) {

				}
			}
		}
		//フォワード
		RequestDispatcher rd = request
				.getRequestDispatcher("/output.jsp");
		rd.forward(request, response);
		//セッションを破棄する
		session.invalidate();

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
