<%@page import="com.ims.utility.Messages"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>IMS</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="css/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
<div id="header">
  <h1><a href="#"><%=Messages.getString("company_name") %></a></h1>
  <ul id="menu">
    <li class="active"><a href="#">about application</a></li>
    <li><a href="#">register</a></li>
    <li><a href="#">demo</a></li>
    <li><a href="#">help</a></li>
    <li><a href="#">contact</a></li>
  </ul>
</div>
<div id="bar">
  <div class="wrap"> <span class="step"><a>1</a> sharing</span> <span class="step"><a>2</a> data management</span> <span class="step"><a>3</a> collaboration</span> </div>
</div>
<div class="wrap">
  <div class="col">
    <h3>What's <span class="red">New?</span></h3>
    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Integer porta, ipsum sit amet ultricies congue, ante pede congue pede, id venenatis ante elit et nulla. Ut lectus nisi, convallis in, eleifend vitae, blandit non, orci. Aliquam eget ante. Cras orci ante, interdum ac, euismod et, euismod in, eros. Cras vestibulum elit quis arcu. Suspendisse lectus ligula, posuere ut, ullamcorper eget, lobortis et, tellus. Suspendisse pulvinar metus.</p>
  </div>
  <div class="col">
    <h3>User <span class="red">Statistics</span></h3>
    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Integer porta, ipsum sit amet ultricies congue, ante pede congue pede, id venenatis ante elit et nulla. Ut lectus nisi, convallis in, eleifend vitae, blandit non, orci. Aliquam eget ante. Cras orci ante, interdum ac, euismod et, euismod in, eros. Cras vestibulum elit quis arcu. Suspendisse lectus ligula, posuere ut, ullamcorper eget, lobortis et, tellus. Suspendisse pulvinar metus.</p>
  </div>
  <div class="col last">
    <h3>About <span class="red">Web Application</span></h3>
    <p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Integer porta, ipsum sit amet ultricies congue, ante pede congue pede, id venenatis ante elit et nulla. Ut lectus nisi, convallis in, eleifend vitae, blandit non, orci.</p>
    <p class="info">If you liked this template, you might like some other Free or Commercial CSS templates from Solucija.</p>
  </div>
</div>
<div id="footer">
  <div align=center><p>Copyright&copy;  insonera.com    &middot; All Rights Reserved</p></div>
  <p><!-- Copyright&copy; insonera.com   <a href="http://www.insonera.com">Web Application</a> &middot; All Rights Reserved --></p>
</div>
</body>
</html>