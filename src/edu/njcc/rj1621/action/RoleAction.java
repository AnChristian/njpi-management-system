package edu.njcc.rj1621.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

import com.google.gson.Gson;

import edu.njcc.rj1621.action.form.Message;
import edu.njcc.rj1621.domain.Role;
import edu.njcc.rj1621.service.RoleSvr;
import edu.njcc.rj1621.service.RoleSvrImpl;

@SuppressWarnings("serial")
public class RoleAction extends HttpServlet {

	RoleSvr roleSvr;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		roleSvr = new RoleSvrImpl();
	}
	
	@Override
	public void service(ServletRequest req, ServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=utf-8");
		
		String action = req.getParameter("action");
		String roleCode = req.getParameter("roleCode");
		String roleName = req.getParameter("roleName");
		Role role = null;
		Role roleQ = null;

		if(action != null){
			role = new Role();
			role.setRoleCode(roleCode);
			role.setRoleName(roleName);
		}
		
		if ("add".equals(action)) {
			roleSvr.addRole(role);
		} else if ("modify".equals(action)) {
			roleSvr.modifyRole(role);
		} else if ("queryOne".equals(action)) {
			resp.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			roleQ = roleSvr.queryRole(roleCode);
			PrintWriter out = resp.getWriter();
			Message message = new Message("0", roleQ);
			
			Gson gson = new Gson();
			String json = gson.toJson(message);
			out.print(json);
			return;
		} else if ("remove".equals(action)) {
			roleSvr.removeRole(roleCode);
		}
		
		List<Role> roleList = roleSvr.queryRoleList();
		
		req.setAttribute("rList", roleList);
		req.setAttribute("roleQ", roleQ);
		
		req.getRequestDispatcher("roleMgr.jsp").forward(req, resp);
	}
	
}
