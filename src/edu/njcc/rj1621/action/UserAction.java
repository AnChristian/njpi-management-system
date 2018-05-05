package edu.njcc.rj1621.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

import com.google.gson.Gson;

import edu.njcc.rj1621.action.form.Message;
import edu.njcc.rj1621.action.form.UserForm;
import edu.njcc.rj1621.domain.User;
import edu.njcc.rj1621.service.RoleSvr;
import edu.njcc.rj1621.service.RoleSvrImpl;
import edu.njcc.rj1621.service.UserSvr;
import edu.njcc.rj1621.service.UserSvrImpl;

@SuppressWarnings("serial")
public class UserAction extends HttpServlet {

	UserSvr userSvr;
	RoleSvr roleSvr;
	@Override
	public void init(ServletConfig config) throws ServletException {
		userSvr = new UserSvrImpl();
		roleSvr = new RoleSvrImpl();
	}
	
	@Override
	public void service(ServletRequest req, ServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=utf-8");
		
		String action = req.getParameter("action");
		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String name = req.getParameter("name");
		String petname = req.getParameter("petname");
		String qq = req.getParameter("qq");
		String email = req.getParameter("email");
		String mobile = req.getParameter("mobile");
		String roleCode = req.getParameter("roleCode");
		
		User user = null;
		User userQ = null;
		
		if(action != null){
			user = new User();
			
			user.setUsername(username);
			user.setPassword(password);
			user.setName(name);
			user.setPetName(petname);
			user.setQq(qq);
			user.setRoleCode(roleCode);
			user.setMobile(mobile);
			user.setEmail(email);
		}
		
		if ("add".equals(action)) {
			userSvr.AddUser(user);
		} else if ("modify".equals(action)) {
			userSvr.modfiyUser(user);
		} else if ("queryOne".equals(action)) {
			resp.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			userQ = userSvr.queryUser(username);
			PrintWriter out = resp.getWriter();
			Message message = new Message("0", userQ);
			
			Gson gson = new Gson();
			String json = gson.toJson(message);
			out.print(json);
			return;
		} else if ("remove".equals(action)) {
			userSvr.removeUser(username);
		}
		
		UserForm userForm;
		List<User> userList = userSvr.queryUserList();
		ArrayList<UserForm> userFList = new ArrayList<UserForm>();
		
		for (User userF : userList) {
			userForm = new UserForm();
			userForm.setUsername(userF.getUsername());
			userForm.setPassword(userF.getPassword());
			userForm.setName(userF.getName());
			userForm.setPetname(userF.getPetName());
			userForm.setQq(userF.getQq());
			userForm.setEmail(userF.getEmail());
			userForm.setMobile(userF.getMobile());
			userForm.setRoleName(roleSvr.queryRole(userF.getRoleCode()).getRoleName());
			
			userFList.add(userForm);
		}
		
		req.setAttribute("uFList", userFList);
		req.setAttribute("rList", roleSvr.queryRoleList());
		req.getRequestDispatcher("userMgr.jsp").forward(req, resp);
	}
	
}
