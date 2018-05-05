<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@	taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    
    <title>Bbs管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="css/bbsMgr.css">
	<script type="text/javascript" src="js/JQuery-1.4.1/jquery-1.4.1.js"></script>
	<script type="text/javascript">
	function y(){
		var form = document.getElementById("form1");
		form.submit();
	}
	
	function add(){
		var formTag = document.getElementById("form1");
		formTag.action = "BbsAction?action=add";
	}
	
	function remove1(){
		var formTag = document.getElementById("form1");
		var flag = confirm("确定删除选中的记录吗？");
		if(flag){
			formTag.action = "BbsAction?action=remove";
			formTag.submit();
		}
	}
	
	function modify(bbsId){
		var form = document.getElementById("form1");
		form.action = "BbsAction?action=modify&bbsId="+bbsId;
		$.ajax({
			url:"BbsAction?action=queryOne",
			data:{bbsId:bbsId},
			dataType:"json",
			type:"post",
			success:callback
		});
	}
	
	function callback(data){
		$("#newsId").val(data.object.newsId);
		$("#username").val(data.object.username);
		$("#bbsPid").val(data.object.bbsPid);
		$("#content").val(data.object.content);
	}
	function back() {
		window.location.href = "main.jsp";
	}
	</script>
</head>

<body>
<div id="back" style="border-radius:20px; margin:20px; height:100px; width:100px; background-image: url('img/back.png');" onclick="back()"></div>
<div id="box">
	<div id="h"><a>Bbs管理 by费礼敏</a></div>
	<form id="form1" method="post">
	<div id="c">
		<div id="list">
			<table id="t1">
				<tr id="top" style="background-color: #699bff">
					<td>选中</td>
					<td>bbsId</td>
					<td>newsId</td>
					<td>username</td>
					<td>bbsPid</td>
					<td>content</td>
					<td>pdate</td>
				</tr>
				<c:forEach items="${bList }" var="bbs">
					<tr onDblClick="modify('${bbs.bbsId}')" class="tr">
						<td><input type="checkbox" name="selected" value="${bbs.bbsId }"/></td>
						<td>${bbs.bbsId }</td>
						<td>${bbs.newsId }</td>
						<td>${bbs.username }</td>
						<td>${bbs.bbsPid }</td>
						<td>${bbs.content }</td>
						<td>${bbs.pdate }</td>
					</tr>
				</c:forEach>
			</table>
		</div>

		<div id="listMgr">
			
				<table id="t2">
					<tr>
						<td>newsId</td>
						<td>
							<select id="newsId" name="newsId" class="slec">
								<c:forEach items="${nList }" var="news">
									<option value="${news.newsId }">${news.newsId }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>username</td>
						<td>
							<select id="username" name="username" class="slec">
								<c:forEach items="${uList }" var="user">
									<option value="${user.username }">${user.username }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>bbsPid</td>
						<td>
							<select id="bbsPid" name="bbsPid" class="slec">
								<option value="0">0</option>
								<c:forEach items="${bList }" var="bbs">
									<option value="${bbs.bbsId }">${bbs.bbsId }</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td>content</td>
						<td><textarea id="content" name="content"></textarea></td>
					</tr>
				</table>


				<div id="queding">
					<input type="button" value="确定" onclick="y()">

					<input type="button" value="插入" onclick="add()">

					<input type="button" value="删除" onclick="remove1()">

					<input type="reset" value="取消">
				</div>

		</div>
	</div>
	</form>
</div>
</body>
</html>
