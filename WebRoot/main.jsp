<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>南科院后台管理</title>
    <link rel="stylesheet" href="css/main.css" type="text/css">
</head>
<script>
    window.onload =function () {
        var oq = document.getElementsByClassName("tt1");
        var ow = document.getElementsByClassName("wenzi");
        for(var i = 0;i<oq.length;i++){
            oq[i].index = i;
            oq[i].onmouseover = function () {
                oq[this.index].style.opacity = 0.2;
            };
            oq[i].onmouseout = function () {
                oq[this.index].style.opacity = 0;
            };
        }
        for(var i = 0;i<ow.length;i++){
        	ow[i].index = i;
        	ow[i].onmouseover = function () {
        		oq[this.index].style.opacity = 0.2;
        	};
        	ow[i].onmouseout = function () {
                oq[this.index].style.opacity = 0;
            };
        }
        
    };
    function f(){
    	alert(1);
    }
</script>
<body>
<div id="b">
    <div class = "q" id="t1" onclick="window.location.href = 'RoleAction'"><div class="tt1"></div><div class="wenzi">角色管理</div></div>
    <div class = "q" id="t2" onclick="window.location.href = 'UserAction'"><div class="tt1"></div><div class="wenzi">用户管理</div></div>
    <div class = "q" id="t3" onclick="window.location.href = 'TopicAction'"><div class="tt1"></div><div class="wenzi">栏目管理</div></div>
    <div class = "q" id="t4" onclick="window.location.href = 'SectionAction'"><div class="tt1"></div><div class="wenzi">科室管理</div></div>
    <div class = "q" id="t5" onclick="window.location.href = 'NewsAction'"><div class="tt1"></div><div class="wenzi">新闻管理</div></div>
    <div class = "q" id="t6" onclick="window.location.href = 'BbsAction'"><div class="tt1"></div><div class="wenzi">评论管理</div></div>
</div>
</body>
</html>

