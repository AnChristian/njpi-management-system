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

        <title>User管理</title>

        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
        <!--
        <link rel="stylesheet" type="text/css" href="styles.css">
        -->
        <link rel="stylesheet" type="text/css" href="css/userMgr.css">
        <script type="text/javascript" src="js/JQuery-1.4.1/jquery-1.4.1.js"></script>
        <script type="text/javascript"> 
        	function y(){
				var form = document.getElementById("form1");
				form.submit();
			}	
			
			function modify(username) {
				var form = document.getElementById("form1");
				form.action = "UserAction?action=modify";
				$.ajax({
					url: "UserAction?action=queryOne",
					type: "post",
					data: {username:username},
					dataType: "json",
					success: callback					
				});
			}	
			
			function callback(data){
				$("input[name = username]").val(data.object.username);
				$("input[name = password]").val(data.object.password);
				$("input[name = name]").val(data.object.name);
				$("input[name = petname]").val(data.object.petName);
				$("input[name = qq]").val(data.object.qq);
				$("input[name = email]").val(data.object.email);
				$("input[name = mobile]").val(data.object.mobile);
				$("#roleCode").val(data.object.roleCode);
			}
			
			function remove1(username) {
				var form = document.getElementById("form1");
				var flag = confirm("确定删除username为  "+username+"  的记录吗？");
				if(flag){
					form.action = "UserAction?action=remove&username="+username;
					form.submit();
				}
			}
			 
			function add() {
				var form = document.getElementById("form1");
				form.action = "UserAction?action=add";
			}
			function back() {
				window.location.href = "main.jsp";
			}
        </script>
        </head>

<body>
<div id="back" style="border-radius:20px; margin:20px; height:100px; width:100px; background-image: url('img/back.png');" onclick="back()"></div>
<div id="box">
    <div id="header">
        <h1>南科院后台用户管理  by朱寅辰</h1>
        <hr color="#999999"/>
    </div>
    <div id="bmtton">
        <div id="bleft">
          <table border="1" cellpadding="0" cellspacing="0" id="t1">
            <tr>
              <td width="60" bgcolor="#0066FF"><div align="center">用户名</div></td>
              <td width="61" bgcolor="#0066FF"><div align="center">密码</div></td>
              <td width="47" bgcolor="#0066FF"><div align="center">姓名</div></td>
              <td width="47" bgcolor="#0066FF"><div align="center">昵称</div></td>
              <td width="81" bgcolor="#0066FF"><div align="center">QQ号</div></td>
              <td width="100" bgcolor="#0066FF"><div align="center">邮箱</div></td>
              <td width="87" bgcolor="#0066FF"><div align="center">手机</div></td>
              <td width="52" bgcolor="#0066FF"><div align="center">角色</div></td>
              <td width="86" bgcolor="#0066FF"><div align="center">操作</div></td>
            </tr>
			<c:forEach items="${uFList }" var="user">
				<tr>
					<td>${user.username }</td>
					<td>${user.password }</td>
					<td>${user.name }</td>
					<td>${user.petname }</td>
					<td>${user.qq }</td>
					<td>${user.email }</td>
					<td>${user.mobile }</td>
					<td>${user.roleName }</td>
					<td>
						<a id="deleteB" onclick="remove1('${user.username }')">删除</a>&nbsp;&nbsp;
          				<a id="modifyB" onclick="modify('${user.username }')">修改</a>
					</td>
				</tr>
			</c:forEach>         
          </table>
        </div>
      <div id="bright">
      <form id="form1" method="post">
        <table width="73%" height="323" border="0" cellpadding="0" cellspacing="0" id="t2">
          <tr>
            <td>用户名</td>
            <td><label>
              <input type="text" name="username" id="username">
            </label></td>
          </tr>
          <tr>
            <td>密码</td>
            <td><label>
              <input type="text" name="password" id="password">
            </label></td>
          </tr>
          <tr>
            <td>姓名</td>
            <td><label>
              <input type="text" name="name" id="name">
            </label></td>
          </tr>
          <tr>
            <td>角色</td>
            <td><label>
				<select name="roleCode" id="roleCode">
					<c:forEach items="${rList }" var="role">
						<option value="${role.roleCode }">${role.roleName }</option>
					</c:forEach>
				</select>
            </label></td>
          </tr>
          <tr>
            <td>QQ</td>
            <td><label>
              <input type="text" name="qq" id="qq">
            </label></td>
          </tr>
          <tr>
            <td>手机</td>
            <td><label>
              <input type="text" name="mobile" id="mobile">
            </label></td>
          </tr>
          <tr>
            <td>邮箱</td>
            <td><label>
              <input type="text" name="email" id="email">
            </label></td>
          </tr>
          <tr>
            <td>昵称</td>
            <td><label>
              <input type="text" name="petname" id="petname">
            </label></td>
          </tr>
        </table>
        <div id="rbb">
          <input type="button" value="确定" onclick="y()">
          <input type="button" value="插入" onclick="add()">
          <input type="button" value="删除" onclick="remove1()">
        </div>
        </form>
      </div>
    </div>
</div>
</body>
</html>