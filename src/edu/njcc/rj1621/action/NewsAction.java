package edu.njcc.rj1621.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

import com.google.gson.Gson;

import edu.njcc.rj1621.action.form.Message;
import edu.njcc.rj1621.domain.News;
import edu.njcc.rj1621.domain.Section;
import edu.njcc.rj1621.domain.Topic;
import edu.njcc.rj1621.domain.User;
import edu.njcc.rj1621.service.NewsSvr;
import edu.njcc.rj1621.service.NewsSvrImpl;
import edu.njcc.rj1621.service.SectionSvr;
import edu.njcc.rj1621.service.SectionSvrImpl;
import edu.njcc.rj1621.service.TopicSvr;
import edu.njcc.rj1621.service.TopicSvrImpl;
import edu.njcc.rj1621.service.UserSvr;
import edu.njcc.rj1621.service.UserSvrImpl;

@SuppressWarnings("serial")
public class NewsAction extends HttpServlet {

	NewsSvr newsSvr;
	TopicSvr topicSvr;
	SectionSvr sectionSvr;
	UserSvr userSvr;

	@Override
	public void init(ServletConfig config) throws ServletException {
		newsSvr = new NewsSvrImpl();
		topicSvr = new TopicSvrImpl();
		sectionSvr = new SectionSvrImpl();
		userSvr = new UserSvrImpl();
	}
	
	@Override
	public void service(ServletRequest req, ServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=utf-8");
		
		String newsId = req.getParameter("newsId");
		String action = req.getParameter("action");
		String username = req.getParameter("username");
		String author = req.getParameter("author");
		String title = req.getParameter("title");
		String sectionCode = req.getParameter("sectionCode");
		String topicCode = req.getParameter("topicCode");
		String content = req.getParameter("content");
		
		String[] values = req.getParameterValues("selected");
		String[] red = req.getParameterValues("isRed");
		String[] top = req.getParameterValues("isTop");
		
		News news = null;
		News newsQ = null;
		
		if(action != null){
			news = new News();
			news.setUsername(username);
			news.setAuthor(author);
			news.setTitle(title);
			news.setPdate(new Date());
			news.setContent(content);
			news.setSectionCode(sectionCode);
			news.setTopicCode(topicCode);
			if(red == null){
				news.setIsRed(0);
			}else {
				news.setIsRed(1);
			}
			if(top == null){
				news.setIsTop(0);
			}else {
				news.setIsTop(1);
			}
		}
		
		if("add".equals(action)){
			newsSvr.addNews(news);
		} else if ("remove".equals(action)) {
			if(values != null){
				for (String rId : values) {
					newsSvr.removeNews(Integer.parseInt(rId));
				}
			}
		}else if ("modify".equals(action)) {
			news.setNewsId(Integer.parseInt(newsId));
			newsSvr.modifyNews(news);
		}else if ("queryOne".equals(action)) {
			newsQ = new News();
			Gson gson = new Gson();
			resp.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			newsQ = newsSvr.queryNews(Integer.parseInt(newsId));
			PrintWriter out = resp.getWriter();
			Message message = new Message("0", newsQ);
			String json = gson.toJson(message);
			out.print(json);
			return;
		}
		
		List<News> newsList = newsSvr.queryNewsList();
		List<Section> sectionList = sectionSvr.querySectionList();
		List<Topic> topicList = topicSvr.queryTopicList();
		List<User> userList = userSvr.queryUserList();
		
		req.setAttribute("uList", userList);
		req.setAttribute("sList", sectionList);
		req.setAttribute("tList", topicList);
		req.setAttribute("nList", newsList);
		req.getRequestDispatcher("newsMgr.jsp").forward(req, resp);
	}
	
}
