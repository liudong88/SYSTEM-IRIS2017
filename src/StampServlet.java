

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hacku2017.DatabaseAccess;
import hacku2017.LoginCheck;

/**
 * Servlet implementation class StampServlet
 */
@WebServlet("/StampServlet")
public class StampServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public StampServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		LoginCheck lc = new LoginCheck();
		String strUserId = lc.LogCheck(request, response);

		if(!strUserId.equals("false")){
			DatabaseAccess dba = new DatabaseAccess();

			ArrayList<String[]> spot = new ArrayList<String[]>();
			ResultSet rs = null;
			String sql = "SELECT * FROM stamp_spots;";
			try{
				dba.Connect();
				rs = dba.Select(sql);
				while(rs.next()){
					String[] rec = {rs.getString("spot_id"),rs.getString("spot_name"),rs.getString("lat"),rs.getString("lng"),rs.getString("area")};
					spot.add(rec);
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

			sql = "SELECT spot_id,spot_photos.photo_id,file_path FROM spot_photos,photos WHERE spot_photos.photo_id = photos.photo_id AND user_id = " + strUserId + ";";
			HashMap<String, String[]> spotImage = new HashMap<String, String[]>();
			try{
				dba.Connect();
				rs = dba.Select(sql);
				while(rs.next()){
					String[] rec = {rs.getString("spot_photos.photo_id"),"./upload/small/" + rs.getString("file_path")};
					spotImage.put(rs.getString("spot_id"), rec);
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

			request.setAttribute("MAPSPOTS", spot);
			request.setAttribute("STAMPMAP", spotImage);
			RequestDispatcher rd = request.getRequestDispatcher("stampRally.jsp");
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
