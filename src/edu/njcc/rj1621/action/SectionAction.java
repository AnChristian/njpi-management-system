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
import edu.njcc.rj1621.domain.Section;
import edu.njcc.rj1621.service.SectionSvr;
import edu.njcc.rj1621.service.SectionSvrImpl;

@SuppressWarnings("serial")
public class SectionAction extends HttpServlet {

	SectionSvr sectionSvr;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		sectionSvr = new SectionSvrImpl();
	}
	
	@Override
	public void service(ServletRequest req, ServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=utf-8");
		
		String action = req.getParameter("action");
		String sectionCode = req.getParameter("sectionCode");
		String sectionName = req.getParameter("sectionName");
		String pym = req.getParameter("pym");
		Section section = null;
		Section sectionQ = null;
		
		if(action != null){
			section = new Section();
			section.setSectionCode(sectionCode);
			section.setSectionName(sectionName);
			section.setPym(pym);
		}
		
		if ("add".equals(action)) {
			sectionSvr.addSection(section);
		} else if ("modify".equals(action)) {
			sectionSvr.modifySection(section);
		} else if ("queryOne".equals(action)) {
			resp.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			sectionQ = sectionSvr.querySection(sectionCode);
			PrintWriter out = resp.getWriter();
			Message message = new Message("0", sectionQ);
			
			Gson gson = new Gson();
			String json = gson.toJson(message);
			out.print(json);
			return;
		} else if ("remove".equals(action)) {
			sectionSvr.removeSection(sectionCode);
		}
		
		List<Section> sectionList = sectionSvr.querySectionList();
		
		req.setAttribute("sList", sectionList);
		
		req.getRequestDispatcher("sectionMgr.jsp").forward(req, resp);
	}
	
}
