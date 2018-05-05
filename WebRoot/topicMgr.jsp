    <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

        <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
        <html>
        <head>
        <base href="<%=basePath%>">

        <title>topic管理</title>

        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
        <!--
        <link rel="stylesheet" type="text/css" href="styles.css">
        -->
        <link rel="stylesheet" type="text/css" href="css/topicMgr.css">
        <script type="text/javascript" src="js/JQuery-1.4.1/jquery-1.4.1.js"></script>
		<script type="text/javascript">
			function y(){
				var form = document.getElementById("form1");
				form.submit();
			}	
			
			function modify(topicCode) {
				var form = document.getElementById("form1");
				form.action = "TopicAction?action=modify";
				$.ajax({
					url: "TopicAction?action=queryOne",
					type: "post",
					data: {topicCode:topicCode},
					dataType: "json",
					success: callback					
				});
			}	
			
			function callback(data){
				$("input[name = topicCode]").val(data.object.topicCode);
				$("input[name = topicName]").val(data.object.topicName);
			}
			
			function remove1(topicCode) {
				var form = document.getElementById("form1");
				var flag = confirm("确定删除topicCode为  "+topicCode+"  的记录吗？");
				if(flag){
					form.action = "TopicAction?action=remove&topicCode="+topicCode;
					form.submit();
				}
			}
			
			function add() {
				var form = document.getElementById("form1");
				form.action = "TopicAction?action=add";
			}
			function back() {
				window.location.href = "main.jsp";
			}
		</script>
        </head>


<body>
<div id="back" style="border-radius:20px; margin:20px; height:100px; width:100px; background-image: url('img/back.png');" onclick="back()"></div>
    <div id="box">
        <div id="title">
            <h1>
                南科院后台栏目管理 by李青
            </h1>
            <hr style="margin: 30px 0;">
        </div>
    </div>
    <div id="ta">
        <table id="t1">
            <tr style="background: #699bff">
                <td>
                    	栏目代码
                </td>
                <td>
                    	栏目名
                </td>
                <td>
                		操作
                </td>
            </tr>
            
            <c:forEach items="${tList }" var="topic">
            	<tr>
            		<td>${topic.topicCode }</td>
            		<td>${topic.topicName }</td>
            		<td>
            			<a id="deleteB" onclick="remove1('${topic.topicCode }')">删除</a>&nbsp;&nbsp;
          				<a id="modifyB" onclick="modify('${topic.topicCode }')">修改</a>
            		</td>
            	</tr>
            </c:forEach>
            
        </table>
    </div>
    <div id="ta2">
    	<form id="form1" method="post">
	        <table>
	            <tr>
	                <td>
	                    栏目代码
	                </td>
	                <td>
	                    <input type="text" name="topicCode">
	                </td>
	            </tr>
	            <tr>
	                <td>
	                    栏 目 名
	                </td>
	                <td>
	                    <input type="text" name="topicName">
	                </td>
	            </tr>
	        </table>
	        <div id="queding">
	            <input type="button" value="确定" onclick="y()">
	            <input type="button" value="插入" onclick="add()">
	            <input type="reset" value="取消">
	        </div>
		</form>
    </div>

</body>
</html>