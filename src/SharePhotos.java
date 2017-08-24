

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hacku2017.DatabaseAccess;
import hacku2017.LoginCheck;

/**
 * Servlet implementation class SharePhotos
 */
@WebServlet("/SharePhotos")
public class SharePhotos extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public SharePhotos() {
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

		LoginCheck lc = new LoginCheck();

		String strUserId = lc.LogCheck(request, response);

		if(!strUserId.equals("false")){
			DatabaseAccess dba = new DatabaseAccess();

			String sql = "SELECT user_name FROM users "
					+ "WHERE user_id = " + strUserId + ";";
			ResultSet rs = null;
			String strUserName = "";
			try{
				dba.Connect();
				rs = dba.Select(sql);
				while(rs.next()){
					strUserName = rs.getString("user_name");
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

			request.setAttribute("USER", strUserName);
			RequestDispatcher rd = request.getRequestDispatcher("share_photos.jsp");
			rd.forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
