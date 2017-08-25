
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.FileUploadBase.FileSizeLimitExceededException;

import hacku2017.DatabaseAccess;
import hacku2017.LoginCheck;

/**
 * Servlet implementation class PhotoServlet
 */
@WebServlet("/PhotoServlet")
@MultipartConfig(location = "", maxFileSize = 1024 * 1024 * 10)
public class PhotoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public PhotoServlet() {
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
		// 文字化け対策
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");

		//ログインチェック
		LoginCheck lc = new LoginCheck();

		//ユーザーログインの確認
		String strUserId = lc.LogCheck(request, response);

		if(!strUserId.equals("false")){

			//値の取得
			String strLat = request.getParameter("lat");
			String strLng = request.getParameter("lng");
			String strText = request.getParameter("text");

			System.out.println(strLat);
			System.out.println(strLng);
			System.out.println(strText);

			String strFilePath = "";

			System.out.println("1");

			//画像を保存してファイル名を取得
			try{
				strFilePath = photoSave(request,response,strUserId);
			}catch (Exception e) {
				// TODO: handle exception
				/*response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<html><body>");
				out.println("写真のサイズは、10MB以内でお願いします");
				out.println("</body></html>");*/
				return;
			}
			System.out.println("2");

			String sql = "";
			sql = "INSERT INTO photos(file_path,latitude,longitude,user_id,photo_explanation)VALUES(";
			sql += "'" + strFilePath + "'," + strLat + "," + strLng + "," + strUserId + ",'" + strText + "');";
			System.out.println(sql);

			//データベースに接続し、データを挿入する
			DatabaseAccess dba = new DatabaseAccess();
			ResultSet rs = null;
			String lastId = "";
			try{
				dba.Connect();
				dba.Update(sql);
				sql = "SELECT LAST_INSERT_ID() AS last;";
				rs = dba.Select(sql);
				while(rs.next()){
					lastId = rs.getString("last");
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
			//スタンプ判定処理
			ArrayList<ArrayList<String>> tbl = new ArrayList<ArrayList<String>>();
			sql = "SELECT * FROM stamp_spots;";
			try{
				dba.Connect();
				rs = dba.Select(sql);
				while(rs.next()){
					ArrayList<String> rec = new ArrayList<String>();
					rec.add(rs.getString("spot_id"));
					rec.add(rs.getString("lat"));
					rec.add(rs.getString("lng"));
					rec.add(rs.getString("area"));
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

			//現在日付の取得
			Date date = new Date();
			SimpleDateFormat fDate = new SimpleDateFormat("yyyy/MM/dd");
			String strDate = fDate.format(date);
			float lat1 = Float.parseFloat(strLat);
			float lng1 = Float.parseFloat(strLng);
			for(ArrayList<String> rec : tbl){
				float lat2 = Float.parseFloat(rec.get(1));
				float lng2 = Float.parseFloat(rec.get(2));
				float range = getDistance(lat1, lng1, lat2, lng2, 3);
				range *= 1000;
				System.out.println("range"+range);
				float area = Float.parseFloat(rec.get(3));
				System.out.println("area"+area);
				if(range <= area){
					sql = "INSERT INTO spot_photos(photo_id,spot_id)VALUES("
							+ lastId + "," + rec.get(0) + ");";
					System.out.println(sql);
					dba.Connect();
					dba.Update(sql);
					dba.Close();
					sql = "INSERT INTO user_stamps(user_id,spot_id,stamp_day)VALUES("
							+ strUserId + "," + rec.get(0) + ",'" + strDate + "');";
					System.out.println(sql);
					dba.Connect();
					dba.Update(sql);
					dba.Close();
				}
			}
			System.out.println("OK");
			response.sendRedirect("share_photos.jsp");
		}
	}

	private String photoSave(HttpServletRequest request, HttpServletResponse response, String userId)
			throws ServletException, IOException, FileSizeLimitExceededException {
		// パラメータ"filename"のマルチパートデータ値を取得
		Part part = request.getPart("filename");

		// HTTPヘッダの値を取得
		String contentDisposition = part.getHeader("content-disposition");
		String contentType = part.getHeader("content-type");

		// ファイルサイズの取得
		//long size = part.getSize();

		// uploadフォルダの絶対パスを調べる
		String path = getServletContext().getRealPath("upload");

		/* アップロードしたファイル名の取得 */
		// 変数contentDispositionから"filename="以降を抜き出す
		int filenamePosition = contentDisposition.indexOf("filename=");
		String filename = contentDisposition.substring(filenamePosition);

		// "filename="と"を除く
		filename = filename.replace("filename=", "");
		filename = filename.replace("\"", "");

		// 絶対パスからファイル名のみ取り出す
		filename = new File(filename).getName();

		//ファイルの拡張子を取得
		String fileType = "";
	    int point = filename.lastIndexOf(".");
	    if (point != -1) {
	        fileType = filename.substring(point + 1);
	    }

		//boolean isJpegFile = false;
		// JPEG形式のチェック
		if ((contentType.equals("image/jpeg")) || (contentType.equals("image/pjpeg")) || (contentType.equals("image/png"))) {
			//現在日付の取得
			Date date = new Date();
			SimpleDateFormat fDate = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String strDate = fDate.format(date);

			//画像名を"ユーザー名_現在日時.拡張子に変更"
			filename = userId + "_" + strDate + "." + fileType;

			// 画像ファイルをpath+filenameとして保存
			part.write(path + "/" + filename);
			//isJpegFile = true;

			// サムネール画像の作成
			createThumbnail(path + "/" + filename, path + "/small/" + filename, fileType, 512);
		}
		//System.out.println("保存場所: " + path + "/" + filename);
/*
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<html><body>");

		if (isJpegFile) {
			out.println("アップロードファイルを保存しました。<br><br>");
			out.println("■ファイル情報<br><br>");
			out.println("HTTPヘッダ: " + contentDisposition);
			out.println("<br><br>MIMEタイプ: " + contentType);
			out.println("<br><br>ファイルサイズ: " + size);
			out.println("<br><br>保存場所: " + path + "/" + filename);
			out.println("<br><br>");
			out.println("<img src=\"upload/" + filename + "\">");
		} else {
			out.println("JPEG形式の画像をアップロードしてください。");
		}

		out.println("<br><br>");
		out.println("</body></html>");*/
		return filename;
	}

	private void createThumbnail(String originFile, String thumbFile, String fileType, int width) {
		try {
			// 元画像の読み込み
			BufferedImage image = ImageIO.read(new File(originFile));

			// 元画像の情報を取得
			int originWidth = image.getWidth();
			int originHeight = image.getHeight();
			int type = image.getType();

			// 縮小画像の高さを計算
			int height = originHeight * width / originWidth;
			if(height > 512){
				height = 512;
				width = originWidth * height / originHeight;
			}

			// 縮小画像の作成
			BufferedImage smallImage = new BufferedImage(width, height, type);
			Graphics2D g2 = smallImage.createGraphics();

			// 描画アルゴリズムの設定(品質優先、アンチエイリアスON)
			g2.setRenderingHint(RenderingHints.KEY_RENDERING, RenderingHints.VALUE_RENDER_DEFAULT);
			g2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);

			// 元画像の縮小&保存
			g2.drawImage(image, 0, 0, width, height, null);
			ImageIO.write(smallImage, fileType, new File(thumbFile));
		} catch (Exception e) {
			log("画像の縮小に失敗: " + e);
		}
	}

	//距離判定
	public static float getDistance(double lat1, double lng1, double lat2, double lng2, int precision) {
	    int R = 6371; // km
	    double lat = Math.toRadians(lat2 - lat1);
	    double lng = Math.toRadians(lng2 - lng1);
	    double A = Math.sin(lat / 2) * Math.sin(lat / 2) + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) * Math.sin(lng / 2) * Math.sin(lng / 2);
	    double C = 2 * Math.atan2(Math.sqrt(A), Math.sqrt(1 - A));
	    double decimalNo = Math.pow(10, precision);
	    double distance = R * C;
	    distance = Math.round(decimalNo * distance / 1) / decimalNo;
	    return (float) distance;
	}

}
