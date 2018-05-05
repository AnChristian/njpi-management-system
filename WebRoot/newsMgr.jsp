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

    <title>News管理</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    
    
<link href="css/newsMgr.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="js/JQuery-1.4.1/jquery-1.4.1.js"></script>
<script type="text/javascript" src="fckeditor/fckeditor.js"></script>


<script type="text/javascript">
	function f(){
//S1:创建渲染对象
		var oFCKeditor = new FCKeditor('content');
//S2:设置几个关键属性
		oFCKeditor.BasePath = "fckeditor/";
		oFCKeditor.Width = "100%";
		oFCKeditor.Height = "400";
//S3:替换textarea
		oFCKeditor.ReplaceTextarea();		
	}
	
	function y(){
		var form = document.getElementById("form1");
		form.submit();
	}
	
	function add(){
		var formTag = document.getElementById("form1");
		formTag.action = "NewsAction?action=add";
	}
	
	function remove1(){
		var formTag = document.getElementById("form1");
		var flag = confirm("确定删除选中的记录吗？");
		if(flag){
			formTag.action = "NewsAction?action=remove";
			formTag.submit();
		}
	}
	
	function modify(newsId){
		var form = document.getElementById("form1");
		form.action = "NewsAction?action=modify";
		$.ajax({
			url:"NewsAction?action=queryOne",
			data:{newsId:newsId},
			dataType:"json",
			type:"post",
			success:callback
		});
	}
	
	function callback(data){
		$("#newsId").val(data.object.newsId);
		$("#username").val(data.object.username);
		$("#author").val(data.object.author);
		$("#title").val(data.object.title);
		$("#sectionCode").val(data.object.sectionCode);
		$("#topicCode").val(data.object.topicCode);
		$("#isRed").val(data.object.isRed);
		$("#isTop").val(data.object.isTop);
		FCKeditorAPI.GetInstance("content").SetHTML(data.object.content);
	}
	function back() {
		window.location.href = "main.jsp";
	}
</script>
</head>



<body onLoad="f()">
<div id="back" style="border-radius:20px; margin:20px; height:100px; width:100px; background-image: url('img/back.png');" onclick="back()"></div>
<div id="all">
<form id="form1" method="post">
<div id="news">
		<table align="center">
		<tr>
			<td>选中</td>
			<td>ID</td>
			<td>用户名</td>
			<td>处室</td>
			<td>栏目</td>
			<td>标题</td>
			<td>作者</td>
			<td>日期</td>
			<td>红色</td>
			<td>置顶</td>
		</tr>
		<c:forEach items="${nList}" var="news">
			<tr onDblClick="modify('${news.newsId}')" class="tr">
				<td><input type="checkbox" name="selected" value="${news.newsId }"/></td>
				<td>${news.newsId }</td>
				<td>${news.username }</td>
				<td>${news.sectionCode }</td>
				<td>${news.topicCode }</td>
				<td title="${news.title }">${news.title }</td>
				<td title="超级帅">${news.author }</td>
				<td>${news.pdate }</td>
				<td>${news.isRed }</td>
				<td>${news.isTop }</td>
			</tr>
		</c:forEach>
	</table>
</div>
	<br><br> 
	<a style="font-size: 20px; margin-left: 30px">新闻管理 By汪世明</a>
	 <div id="server" style="margin-top: 20px">
	新闻ID:<input type="text" name="newsId" id="newsId" value="" readonly="readonly"><br><br>
	作者:<input type="text" name="author" id="author" value="" size="10"><br><br>
	标题:<input type="text" name="title" id="title" value="" size="30"><br><br>
	用户名:<select name="username" id="username">
		<c:forEach items="${uList }" var="user">
			<option value="${user.username }">${user.username }</option>
		</c:forEach>
	</select><br><br>
	发布处室:<select name="sectionCode" id="sectionCode"> 
		<c:forEach items="${sList}" var="section"> 
			<option value="${section.sectionCode }">${section.sectionName }</option> 
		</c:forEach> 
	</select><br><br>
	发布栏目:<select name="topicCode" id="topicCode"> 
		<c:forEach items="${tList}" var="topic"> 
			<option value="${topic.topicCode }">${topic.topicName }</option> 
		</c:forEach> 
	</select><br><br>
	红色:<input type="checkbox"  name="isRed">&nbsp;&nbsp;&nbsp; 
	置顶:<input type="checkbox"  name="isTop"><br><br>
	
	<div id="sub" align="center">
	<input type="button" name="ok" value="提交" onclick="y()">
	<input type="button" name="insert" value="插入" onClick="add()">
	<input type="button" name="delete" value="删除" onClick="remove1()">
	<input type="reset" name="reset" value="取消">
	</div>
    </div><br><br>
     <div class="clear"></div>
	新闻内容:<textarea id="content" name="content" rows="20" cols="50">${news.content }</textarea><br><br><br>
    
</form>
</div>

</body>
</html>