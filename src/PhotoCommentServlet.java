

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hacku2017.DatabaseAccess;
import hacku2017.LoginCheck;

/**
 * Servlet implementation class PhotoCommentServlet
 */
@WebServlet("/PhotoCommentServlet")
public class PhotoCommentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PhotoCommentServlet() {
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

		if(!strUserId.equals("false")){
			String strPhotoId = request.getParameter("photo_id");
			String strComment = request.getParameter("p_comment");

			System.out.println("1"+strPhotoId);
			System.out.println("2"+strComment);

			DatabaseAccess dba = new DatabaseAccess();

			String sql = "INSERT INTO photo_comments("
					+ "photo_id,user_id,photo_comment)VALUES("
					+ strPhotoId + "," + strUserId + ",'" + strComment + "');";
			dba.Connect();
			dba.Update(sql);
			dba.Close();
		}
	}

}
