package edu.njcc.rj1621.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import edu.njcc.rj1621.action.form.Message;
import edu.njcc.rj1621.domain.Role;
import edu.njcc.rj1621.domain.User;
import edu.njcc.rj1621.service.RoleSvr;
import edu.njcc.rj1621.service.RoleSvrImpl;
import edu.njcc.rj1621.service.UserSvr;
import edu.njcc.rj1621.service.UserSvrImpl;

@SuppressWarnings("serial")
public class MainAction extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String userName = request.getParameter("username");
		String password = request.getParameter("password");
		
		UserSvr userSvr = new UserSvrImpl();
		User user = userSvr.queryUser(userName);
		boolean success = isSuccess(user, password);
		
		Gson gson = new Gson();
		response.setContentType("text/json;charset=utf-8");
		PrintWriter out = response.getWriter();
		Message message;
		
		if (success == true) {
			request.setAttribute("username", userName);
			RoleSvr roleSvr = new RoleSvrImpl();
			List<Role> roleList = roleSvr.queryRoleList();
			request.getSession().setAttribute("rList", roleList);
			message = new Message("0", "main.jsp");
			String json = gson.toJson(message);
			out.print(json);
			out.flush();
			out.close();
			return;
		}else {
			message = new Message("1", "<h1>µÇÂ¼Ê§°Ü...</h1>");
			String json = gson.toJson(message);
			out.print(json);
			out.flush();
			out.close();
			return;
		}
		
	}

	private boolean isSuccess(User user, String passWord) {

		if (user == null) {
			return false;
		} else if (passWord.equals(user.getPassword())) {
			return true;
		} else {
			return false;
		}
		
	}
	
}
