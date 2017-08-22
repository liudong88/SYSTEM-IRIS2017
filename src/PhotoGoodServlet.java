

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hacku2017.DatabaseAccess;
import hacku2017.LoginCheck;

/**
 * Servlet implementation class PhotoGoodServlet
 */
@WebServlet("/PhotoGoodServlet")
public class PhotoGoodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PhotoGoodServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//文字化け対策
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		LoginCheck lc = new LoginCheck();
		String strUserId = lc.LogCheck(request, response);

		String strPhotoId = request.getParameter("photo_id");
		String strSignal = request.getParameter("signal");

		if(strSignal.equals("good")){//いいねが押された場合
			DatabaseAccess dba = new DatabaseAccess();

			String sql = "INSERT INTO photo_good("
					+ "photo_id,user_id)VALUES("
					+ strPhotoId + "," + strUserId + ");";
			dba.Connect();
			dba.Update(sql);
			dba.Close();
		}else if(strSignal.equals("cancel")){//いいねを解除する場合
			DatabaseAccess dba = new DatabaseAccess();
			String sql = "DELETE FROM photo_good "
					+ "WHERE photo_id = " + strPhotoId + " "
					+ "AND user_id = " + strUserId + ";";
			dba.Connect();
			dba.Update(sql);
			dba.Close();
		}
	}

}
