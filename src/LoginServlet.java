

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
 * Servlet implementation class LoginCheck
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
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

		String strJspName = "";

		HttpSession session = request.getSession();
		//System.out.println(session);
		session.invalidate();

		session = request.getSession(false);
		//セッションがnullの時の処理
		if(session == null){
			strJspName = "/userlogin.jsp";
			System.out.println("セッションは破棄されました。");
		}
		System.out.println("セッションは破棄されました。2");
		//フォワード
		RequestDispatcher rd = request
				.getRequestDispatcher(strJspName);
		rd.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//↓文字化け対策
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		//中身がtrueで名前がloginにしてセッションにいれる。これをやっておく。

		//リクエストパラメーターを取得
		String username = request.getParameter("username");
		String pass = request.getParameter("pass");

		String sql = "";
		String db_username = "";
		String db_userpass = "";
		String user_id = "";
		String strJspName = "";
		String errormessage = "";

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
			//ユーザー名とパスワードが入力されている時の処理
			if(!(username).equals("") && !(pass).equals("")){
				sql = "select * from users where user_name = '"+username+"' and user_password = '"+pass+"' ;";
				//参照系のSQLを実行
				rs = st.executeQuery(sql);

				while(rs.next()){
					user_id = rs.getString("user_id");
					db_username = rs.getString("user_name");
					db_userpass = rs.getString("user_password");
				}
				//入力されたユーザー名とパスワードがユーザー登録されているものと一致した時の処理
				if(username.equals(db_username) && pass.equals(db_userpass)){
					strJspName = "SharePhotos";
				}else{
					errormessage = "※ユーザー名またはパスワードが正しくありません。もう一度入力してください。";
					strJspName = "/index.jsp";
				}
			}else{
				//ユーザ名が入力されていない時の処理
				if(username.equals("")){
					errormessage = "※ユーザー名は必ず入力してください。<br>";
				}
				//パスワードが入力されていない時の処理
				if(pass.equals("")){
					errormessage = errormessage +"※パスワードは必ず入力してください。";
				}
				strJspName = "/index.jsp";
			}

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
					//Connectionのオブジェクトをクローズ
					con.close();
				} catch (SQLException e) {

				}
			}
		}
		// セッションスコープに登録ユーザーを保存
		HttpSession session = request.getSession();
		session.setAttribute("user", user_id);
		session.setAttribute("login","true");

		request.setAttribute("MESSAGE", errormessage);

		//フォワード
		RequestDispatcher rd = request
				.getRequestDispatcher(strJspName);
		rd.forward(request, response);

	}

}

