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
import edu.njcc.rj1621.domain.Topic;
import edu.njcc.rj1621.service.TopicSvr;
import edu.njcc.rj1621.service.TopicSvrImpl;

@SuppressWarnings("serial")
public class TopicAction extends HttpServlet {

	TopicSvr topicSvr;
	
	@Override
	public void init(ServletConfig config) throws ServletException {
		topicSvr = new TopicSvrImpl();
	}
	
	@Override
	public void service(ServletRequest req, ServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		resp.setContentType("text/html;charset=utf-8");
		
		String action = req.getParameter("action");
		String topicCode = req.getParameter("topicCode");
		String topicName = req.getParameter("topicName");
		Topic topic = null;
		Topic topicQ = null;
		
		if(action != null){
			topic = new Topic();
			topic.setTopicCode(topicCode);
			topic.setTopicName(topicName);
		}
		
		if ("add".equals(action)) {
			topicSvr.addTopic(topic);
		} else if ("modify".equals(action)) {
			topicSvr.modifyTopic(topic);
		} else if ("queryOne".equals(action)) {
			resp.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=UTF-8");
			topicQ = topicSvr.queryTopic(topicCode);
			PrintWriter out = resp.getWriter();
			Message message = new Message("0", topicQ);
			
			Gson gson = new Gson();
			String json = gson.toJson(message);
			out.print(json);
			return;
		} else if ("remove".equals(action)) {
			topicSvr.removeTopic(topicCode);
		}
		
		List<Topic> topicList = topicSvr.queryTopicList();
		req.setAttribute("tList", topicList);
		req.setAttribute("topicQ", topicQ);
		req.getRequestDispatcher("topicMgr.jsp").forward(req, resp);
	}
	
}
