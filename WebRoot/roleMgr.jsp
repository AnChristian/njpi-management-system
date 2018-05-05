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

        <title>角色管理</title>

        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
        <!--
        <link rel="stylesheet" type="text/css" href="styles.css">
        -->
        <link rel="stylesheet" type="text/css" href="css/roleMgr.css">
		<script type="text/javascript" src="js/JQuery-1.4.1/jquery-1.4.1.js"></script>
		<script type="text/javascript">
			function y(){
				var form = document.getElementById("form1");
				form.submit();
			}	
			
			function modify(roleCode) {
				var form = document.getElementById("form1");
				form.action = "RoleAction?action=modify";
				$.ajax({
					url: "RoleAction?action=queryOne",
					type: "post",
					data: {roleCode:roleCode},
					dataType: "json",
					success: callback					
				});
			}	
			
			function callback(data){
				$("input[name = roleCode]").val(data.object.roleCode);
				$("input[name = roleName]").val(data.object.roleName);
			}
			
			function remove1(roleCode) {
				var form = document.getElementById("form1");
				var flag = confirm("确定删除roleCode为  "+roleCode+"  的记录吗？");
				if(flag){
					form.action = "RoleAction?action=remove&roleCode="+roleCode;
					form.submit();
				}
			}
			
			function add() {
				var form = document.getElementById("form1");
				form.action = "RoleAction?action=add";
			}
			function back() {
				window.location.href = "main.jsp";
			}
		</script>
        </head>

<body>
<div id="back" style="border-radius:20px; margin:20px; height:100px; width:100px; background-image: url('img/back.png');" onclick="back()"></div>
<div id="role">
  <div id="title">
	<h1>南科院后台角色管理 by梁晓琪</h1>
  </div>
    <hr />
    <div id="t1D">
  <table  id="t1" width="300px" border="2" cellspacing="0" cellpadding="2">
          <tr id="top">
            <td width="69px">角色代码</td>
            <td width="101px">角色名</td>
            <td width="120px">操作</td>
          </tr>
          <c:forEach items="${rList }" var="role">
          	<tr>
          		<td>
          			${role.roleCode }
          		</td>
          		<td>
          			${role.roleName }
          		</td>
          		<td>
          			<a id="deleteB" onclick="remove1('${role.roleCode }')">删除</a>&nbsp;&nbsp;
          			<a id="modifyB" onclick="modify('${role.roleCode }')">修改</a>
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
								角色代码
                            </td>
							<td>
								<input type="text" name="roleCode">
                            </td >
						</tr>
						<tr>
							<td>
								角色名
                            </td>
							<td>
								<input type="text" name="roleName">
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

</div>
</body>
</html>
