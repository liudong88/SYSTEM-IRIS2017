

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
 * Servlet implementation class HakcuUser
 */
@WebServlet("/HakcuUser")
public class HakcuUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public HakcuUser() {
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

				//リクエストパラメーターを取得
				String username = request.getParameter("username");
				String pass = request.getParameter("pass");


				String strJspName = "";
				String errormessage = "";
				String sql = "";
				String db_username = "";

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

					//ユーザー名が入力されている時の処理
					if(!(username).equals("")){
						sql = "select user_name from users where user_name = '"+username+"' ;";
						rs = st.executeQuery(sql);
						while(rs.next()){
							db_username = rs.getString("user_name");
						}
						//入力されたユーザー名が既に登録されているユーザー名と同じ時の処理
						if(username.equals(db_username)){
							errormessage = "※このユーザー名は既に存在しています。別のユーザー名で登録してください。<br>";
							strJspName = "/input.jsp";
						}else{//入力されたユーザー名が既に登録されているユーザー名と違う時の処理
							errormessage = "";
							strJspName = "/check.jsp";
						}
					}else{//ユーザー名が入力されていない時の処理
						errormessage = "※ユーザー名は必ず入力してください。<br>";
						strJspName = "/input.jsp";
					}
					//パスワードが入力されていない時の処理
					if(pass.equals("")){
						errormessage = errormessage + "※パスワードは必ず入力してください。<br>";
						strJspName = "/input.jsp";
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
				session.setAttribute("USERNAME", username);
				session.setAttribute("PASS", pass);

				request.setAttribute("MESSAGE", errormessage);

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

	}

}
