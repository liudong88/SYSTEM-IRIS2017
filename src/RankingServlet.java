

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
 * Servlet implementation class RankingServlet
 */
@WebServlet("/RankingServlet")
public class RankingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public RankingServlet() {
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

		if(!strUserId.equals("false")){
			DatabaseAccess dba = new DatabaseAccess();

			String strSpotId = request.getParameter("spot_id");

			boolean whereFlag = true;
			if(strSpotId == null){
				whereFlag = false;
				strSpotId = "";
			}

			String sql = "";
			//写真の情報を取得するSQL
			sql = "SELECT file_path,photo_explanation,user_name,"
					+ "CASE WHEN good.good_cnt IS NULL THEN 0 ELSE good.good_cnt END AS g_cnt,p.photo_id "
					+ "FROM ((photos AS p LEFT JOIN (SELECT photo_id,COUNT(*) AS good_cnt FROM photo_good GROUP BY photo_id) AS good ON p.photo_id = good.photo_id) "
					+ "LEFT JOIN spot_photos ON p.photo_id = spot_photos.photo_id) "
					+ "LEFT JOIN users ON p.user_id = users.user_id ";
			if(whereFlag){
				sql += "WHERE spot_id = " + strSpotId+ " ";
			}
			sql += "ORDER BY g_cnt DESC "
					+ "LIMIT 25;";
			System.out.println(sql);

			ResultSet rs = null;

			ArrayList<String[]> tbl = new ArrayList<String[]>();
			try{
				dba.Connect();
				rs = dba.Select(sql);
				while(rs.next()){
					String[] rec = {"./upload/small/" + rs.getString("file_path"),rs.getString("photo_explanation"),rs.getString("g_cnt"),rs.getString("user_name"),rs.getString("p.photo_id")};
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

			sql = "SELECT spot_id,spot_name FROM stamp_spots";
			ArrayList<String[]> spotTbl = new ArrayList<String[]>();
			try{
				dba.Connect();
				rs = dba.Select(sql);
				while(rs.next()){
					String[] rec = {rs.getString("spot_id"),rs.getString("spot_name")};
					spotTbl.add(rec);
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

			request.setAttribute("RANKING", tbl);
			request.setAttribute("SPOTS", spotTbl);
			request.setAttribute("NOWSPOT", strSpotId);
			RequestDispatcher rd = request.getRequestDispatcher("ranking.jsp");
			rd.forward(request, response);

			//【画像パス、画像説明、良いね数、ユーザ名、画像ID】
			//【スポットID、スポット名】
			//NowSpotId
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
