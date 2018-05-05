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

    <title>section管理</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <!--
    <link rel="stylesheet" type="text/css" href="styles.css">
    -->
    <link rel="stylesheet" type="text/css" href="css/sectionMgr.css">
    <script type="text/javascript" src="js/JQuery-1.4.1/jquery-1.4.1.js"></script>
    <script type="text/javascript">
	    function y(){
			var form = document.getElementById("form1");
			form.submit();
		}	
		
		function modify(sectionCode) {
			var form = document.getElementById("form1");
			form.action = "SectionAction?action=modify";
			$.ajax({
				url: "SectionAction?action=queryOne",
				type: "post",
				data: {sectionCode:sectionCode},
				dataType: "json",
				success: callback					
			});
		}	
		
		function callback(data){
			$("input[name = sectionCode]").val(data.object.sectionCode);
			$("input[name = sectionName]").val(data.object.sectionName);
			$("input[name = pym]").val(data.object.pym);
		}
		
		function remove1(sectionCode) {
			var form = document.getElementById("form1");
			var flag = confirm("确定删除sectionCode为  "+sectionCode+"  的记录吗？");
			if(flag){
				form.action = "SectionAction?action=remove&sectionCode="+sectionCode;
				form.submit();
			}
		}
		
		function add() {
			var form = document.getElementById("form1");
			form.action = "SectionAction?action=add";
		}
		function back() {
			window.location.href = "main.jsp";
		}
    </script>
    </head>


<body>
<div id="back" style="z-index:80; border-radius:20px; margin:20px; height:100px; width:100px; background-image: url('img/back.png');" onclick="back()"></div>
<div id="box">
    <div id="header">
        <h1>南科院后台科室管理 by朱寅辰</h1>
        <hr color="#999999"/>
    </div>
    <div id="button">
        <div id="bleft">
          <table width="582px" height="50px" border="1" cellpadding="0" cellspacing="0" id="t1">
            <tr>
              <td width="62" bgcolor="#0066FF"><div align="center">sectionCode</div></td>
              <td width="59" bgcolor="#0066FF"><div align="center">sectionName</div></td>
              <td width="57" bgcolor="#0066FF"><div align="center">pym</div></td>
              <td width="23" bgcolor="#0066FF"><div align="center">操作</div></td>
            </tr>
			<c:forEach items="${sList }" var="section">
				<tr>
					<td>${section.sectionCode }</td>
					<td>${section.sectionName }</td>
					<td>${section.pym }</td>
					<td>
          				<a id="deleteB" onclick="remove1('${section.sectionCode}')">删除</a>&nbsp;&nbsp;
          				<a id="modifyB" onclick="modify('${section.sectionCode}')">修改</a>
          			</td>
				</tr>
			</c:forEach>
			

          </table>
        </div>
      <div id="bright">

        <form id="form1" method="post">

            <table width="73%" height="323" border="0" cellpadding="0" cellspacing="0" id="t2">
              <tr>
                <td width="23%"><div align="left">sectionCode</div></td>
                <td width="77%"><input type="text" name="sectionCode"></td>
              </tr>
              <tr>
                <td><div align="left">sectionName</div></td>
                <td><input type="text" name="sectionName"></td>
              </tr>
              <tr>
                <td><div align="left">pym</div></td>
                <td><input type="text" name="pym"></td>
              </tr>
            </table>
            <div id="rbb">
            	<input type="button" value="确定" onclick="y()">
				<input type="button" value="插入" onclick="add()">
				<input type="reset" value="取消">
            </div>

        </form>

      </div>
    </div>
</div>
</body>
</html>