

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import hacku2017.DatabaseAccess;
import hacku2017.LoginCheck;

/**
 * Servlet implementation class PhotoListServlet
 */
@WebServlet("/PhotoListServlet")
public class PhotoListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PhotoListServlet() {
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
		DatabaseAccess dba = new DatabaseAccess();
		LoginCheck lc = new LoginCheck();

		//ユーザーIDの取得
		String strUserId = lc.LogCheck(request, response);

		//値の取得
		String strMinPhotoId = request.getParameter("min_id");

		//最新の5件の場合
		Boolean whereFlag = true;
		if(strMinPhotoId == null){
			whereFlag = false;
		}

		//SQLを入れる変数
		String sql = "";

		//写真の情報を取得するSQL
		sql = "SELECT p.photo_id,file_path,latitude,longitude,user_name,photo_post_time,photo_explanation,"
				+ "CASE WHEN good.good_cnt IS NULL THEN 0 ELSE good.good_cnt END AS g_cnt,"
				+ "CASE WHEN com.com_cnt IS NULL THEN 0 ELSE com.com_cnt END AS c_cnt,"
				+ "CASE WHEN gbool.bool IS NULL THEN 'false' WHEN gbool.bool = 0 THEN 'false' WHEN gbool.bool = 1 THEN 'true' else 'error' END AS user_good "
				+ "FROM (((photos AS p LEFT JOIN (SELECT photo_id,COUNT(*) AS good_cnt FROM photo_good GROUP BY photo_id) AS good ON p.photo_id = good.photo_id) "
				+ "LEFT JOIN (SELECT photo_id,COUNT(*) AS com_cnt FROM photo_comments GROUP BY photo_id) AS com ON p.photo_id = com.photo_id) "
				+ "LEFT JOIN (SELECT photo_id,COUNT(*) AS bool FROM photo_good WHERE user_id = " + strUserId + " GROUP BY photo_id) AS gbool ON p.photo_id = gbool.photo_id) "
				+ "LEFT JOIN users ON p.user_id = users.user_id ";
		if(whereFlag){
			sql += "WHERE p.photo_id < " + strMinPhotoId + " ";
		}
		sql += "ORDER BY photo_post_time DESC "
				+ "LIMIT 5;";
		System.out.println(sql);

		ResultSet rs = null;

		ArrayList<ArrayList<String>> tbl = new ArrayList<ArrayList<String>>();
		ArrayList<String> arrayId = new ArrayList<String>();
		try{
			dba.Connect();
			rs = dba.Select(sql);
			while(rs.next()){
				ArrayList<String> rec = new ArrayList<String>();
				arrayId.add(rs.getString("p.photo_id"));
				rec.add(rs.getString("p.photo_id"));
				rec.add(rs.getString("file_path"));
				rec.add(rs.getString("latitude"));
				rec.add(rs.getString("longitude"));
				rec.add(rs.getString("user_name"));
				rec.add(rs.getString("photo_post_time"));
				rec.add(rs.getString("photo_explanation"));
				rec.add(rs.getString("g_cnt"));
				rec.add(rs.getString("c_cnt"));
				rec.add(rs.getString("user_good"));
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

		//コメントを取得するSQL
		sql = "SELECT photo_id,user_name,photo_comment_time,photo_comment FROM photo_comments,users "
				+ "WHERE photo_comments.user_id = users.user_id "
				+ "AND photo_id IN(";
		int cnt = 0;
		for(String pid : arrayId){
			if(cnt != 0){
				sql += ",";
			}
			sql += pid;
			cnt++;
		}
		sql += ") ORDER BY photo_id DESC;";
		//System.out.println(sql);

		ArrayList<ArrayList<String>> comTbl = new ArrayList<ArrayList<String>>();
		try{
			dba.Connect();
			rs = dba.Select(sql);
			while(rs.next()){
				ArrayList<String> rec = new ArrayList<String>();
				rec.add(rs.getString("photo_id"));
				rec.add(rs.getString("user_name"));
				rec.add(rs.getString("photo_comment_time"));
				rec.add(rs.getString("photo_comment"));
				comTbl.add(rec);
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

		//JSONを作成する
		response.setContentType("application/json; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.print("{");
		out.println("\"photo\":[");
		cnt = 0;
		String minId = "";
		for(ArrayList<String> rec : tbl){
			if(cnt != 0){
				out.println(",");
			}
			minId = rec.get(0);
			out.println("{\"photo_id\":\"" + rec.get(0) + "\",");
			out.println("\"path\":\"" + rec.get(1) + "\",");
			out.println("\"latitude\":\"" + rec.get(2) + "\",");
			out.println("\"longitude\":\"" + rec.get(3) + "\",");
			out.println("\"user\":\"" + rec.get(4) + "\",");
			out.println("\"time\":\"" + rec.get(5) + "\",");
			out.println("\"explanation\":\"" + rec.get(6) + "\",");
			out.println("\"good_cnt\":\"" + rec.get(7) + "\",");
			out.println("\"com_cnt\":\"" + rec.get(8) + "\",");
			out.println("\"user_good\":\"" + rec.get(9) + "\",");
			out.print("\"comments\":[");
			int comCnt = 0;
			for(ArrayList<String> comRec : comTbl){
				if(minId.equals(comRec.get(0))){
					if(comCnt != 0){
						out.println(",");
					}
					out.println("{\"com_name\":\"" + comRec.get(1) + "\",");
					out.println("\"com_time\":\"" + comRec.get(2) + "\",");
					out.print("\"comment\":\"" + comRec.get(3) + "\"}");
					comCnt++;
				}
			}
			out.print("]}");
			cnt++;
		}
		out.println("],");
		out.println("\"min_id\":\"" + minId + "\"");
		out.println("}");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
