package hacku2017;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginCheck {

	public String LogCheck(HttpServletRequest request, HttpServletResponse response){
		HttpSession session = request.getSession(false);

		String strUserId = "false";
		if(session == null){
			try{
				response.sendRedirect("uploadTest.html");
			}catch (IOException e) {
				// TODO: handle exception
			}
		}else{
			String loginCheck = (String)session.getAttribute("login");
			if(loginCheck.equals("true")){
				strUserId = (String)session.getAttribute("user");
				return strUserId;
			}else{
				try{
					response.sendRedirect("uploadTest.html");
				}catch (IOException e) {
					// TODO: handle exception
				}
			}
		}
		return strUserId;
	}


}