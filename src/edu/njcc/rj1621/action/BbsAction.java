package edu.njcc.rj1621.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

import com.google.gson.Gson;

import edu.njcc.rj1621.action.form.Message;
import edu.njcc.rj1621.domain.Bbs;
import edu.njcc.rj1621.domain.News;
import edu.njcc.rj1621.domain.User;
import edu.njcc.rj1621.service.BbsSvr;
import edu.njcc.rj1621.service.BbsSvrImpl;
import edu.njcc.rj1621.service.NewsSvr;
import edu.njcc.rj1621.service.NewsSvrImpl;
import edu.njcc.rj1621.service.UserSvr;
import edu.njcc.rj1621.service.UserSvrImpl;

@SuppressWarnings("serial")
public class BbsAction extends HttpServlet {

	BbsSvr bbsSvr;
	UserSvr userSvr;
	NewsSvr newsSvr;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		bbsSvr = new BbsSvrImpl();
		userSvr = new UserSvrImpl();
		newsSvr = new NewsSvrImpl();
	}
	
	@Override
	public void service(ServletRequest req, ServletResponse resp)
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=utf-8");
		
		String action = req.getParameter("action");
		String bbsId = req.getParameter("bbsId");
		String newsId = req.getParameter("newsId");
		String username = req.getParameter("username");
		String bbsPid = req.getParameter("bbsPid");
		String content = req.getParameter("content");
		
		String[] values = req.getParameterValues("selected");
		
		Bbs bbs = null;
		Bbs bbsQ = null;
		
		if(action != null && (action.equals("add") || action.equals("modify"))){
			bbs = new Bbs();
			bbs.setNewsId(Integer.parseInt(newsId.trim()));
			bbs.setUsername(username);
			bbs.setBbsPid(Integer.parseInt(bbsPid.trim()));
			bbs.setContent(content);
			bbs.setPdate(new Date());
		}
		
		if ("add".equals(action)) {
			bbsSvr.addBbs(bbs);
		} else if ("remove".equals(action)) {
			if(values != null){
				for (String rId : values) {
					bbsSvr.removeBbs(Integer.parseInt(rId));
				}
			}
		} else if ("modify".equals(action)) {
			bbs.setBbsId(Integer.parseInt(bbsId));
			bbsSvr.modifyBbs(bbs);
		} else if ("queryOne".equals(action)) {
			resp.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			bbsQ = bbsSvr.queryBbs(Integer.parseInt(bbsId));
			PrintWriter out = resp.getWriter();
			Message message = new Message("0", bbsQ);
			
			Gson gson = new Gson();
			String json = gson.toJson(message);
			out.print(json);
			return;
		} 
		
		List<News> newsList = newsSvr.queryNewsList();
		List<User> userList = userSvr.queryUserList();
		ArrayList<Bbs> bbsListAll = new ArrayList<Bbs>();
		for (News news : newsList) {
			List<Bbs> queryBbsList = bbsSvr.queryBbsList(news.getNewsId());
			bbsListAll.addAll(queryBbsList);
		}
		
		req.setAttribute("nList", newsList);
		req.setAttribute("uList", userList);
		req.setAttribute("bList", bbsListAll);
		
		req.getRequestDispatcher("bbsMgr.jsp").forward(req, resp);
	}
}
