

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hacku2017.DatabaseAccess;
import hacku2017.LoginCheck;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//文字化け対策
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		//インスタンスの生成
		LoginCheck lc = new LoginCheck();

		String strUserId = lc.LogCheck(request, response);


		DatabaseAccess dba = new DatabaseAccess();
		String sql = "";
		//写真の情報を取得するSQL
		sql = "SELECT photo_id,file_path "
				+ "FROM photos ";
		sql += "WHERE user_id = " + strUserId+ " ";
		sql += "ORDER BY photo_id DESC;";
		System.out.println(sql);

		ResultSet rs = null;

		ArrayList<String[]> tbl = new ArrayList<String[]>();
		try{
			dba.Connect();
			rs = dba.Select(sql);
			while(rs.next()){
				String[] rec = {rs.getString("photo_id"), "./upload/small/" + rs.getString("file_path")};
				tbl.add(rec);
			}
		}catch (SQLException e) {
			// TODO: handle exception
		}finally{
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO: handle exception
				}
			}
			dba.Close();
		}

		rs = null;
		sql = "SELECT user_name FROM users WHERE user_id = " + strUserId + "";
		String userName = "";
		try{
			dba.Connect();
			rs = dba.Select(sql);
			while(rs.next()){
				userName = rs.getString("user_name");
			}
		}catch (SQLException e) {
			// TODO: handle exception
		}finally{
			if(rs != null){
				try {
					rs.close();
				} catch (SQLException e) {
					// TODO: handle exception
				}
			}
			dba.Close();
		}

		request.setAttribute("IMAGES", tbl);
		request.setAttribute("USERNAME", userName);
		RequestDispatcher rd = request.getRequestDispatcher("user.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
