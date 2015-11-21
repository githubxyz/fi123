<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.ims.utility.Messages"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ims.dto.StockDetailDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.ims.utility.IRequestAttribute"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="./css/include-style.css" type="text/css"
	media="all">

	<title>Friends Interior</title> <!-- New Window -->
	<link rel="stylesheet" href="./css/jquery-ui.css">
		<script src="./js/jquery-1.10.2.js"></script>
		<script src="./js/jquery-ui.js"></script>
		<!--  <link rel="stylesheet" href="/resources/demos/style.css"> -->
		<script src="./js/jquery-2.0.3.min.js"></script>
		<link rel="stylesheet" href="./css/styles.css">
			<script src="./js/script.js"></script>

			<script>
				$(function() {
					$("#dialog").dialog({
						autoOpen : false,
						show : {
							effect : "blind",
							duration : 1000
						},
						hide : {
							effect : "explode",
							duration : 1000
						}
					});

					$("#opener").click(function() {
						$("#dialog").dialog("open");
					});
				});
			</script>
			<!-- Table design -->
			<style type="text/css">
table.gradienttable {
	font-family: verdana, arial, sans-serif;
	font-size: 11px;
	color: #333333;
	border-width: 1px;
	border-color: #999999;
	border-collapse: collapse;
}

table.gradienttable th {
	padding: 0px;
	background: #d5e3e4;
	background:
		url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2Q1ZTNlNCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjQwJSIgc3RvcC1jb2xvcj0iI2NjZGVlMCIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiNiM2M4Y2MiIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
	background: -moz-linear-gradient(top, #d5e3e4 0%, #ccdee0 40%, #b3c8cc 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #d5e3e4),
		color-stop(40%, #ccdee0), color-stop(100%, #b3c8cc));
	background: -webkit-linear-gradient(top, #d5e3e4 0%, #ccdee0 40%, #b3c8cc 100%);
	background: -o-linear-gradient(top, #d5e3e4 0%, #ccdee0 40%, #b3c8cc 100%);
	background: -ms-linear-gradient(top, #d5e3e4 0%, #ccdee0 40%, #b3c8cc 100%);
	background: linear-gradient(to bottom, #d5e3e4 0%, #ccdee0 40%, #b3c8cc 100%);
	border: 1px solid #999999;
}

table.gradienttable td {
	padding: 0px;
	background: #ebecda;
	background:
		url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIwJSIgeTI9IjEwMCUiPgogICAgPHN0b3Agb2Zmc2V0PSIwJSIgc3RvcC1jb2xvcj0iI2ViZWNkYSIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjQwJSIgc3RvcC1jb2xvcj0iI2UwZTBjNiIgc3RvcC1vcGFjaXR5PSIxIi8+CiAgICA8c3RvcCBvZmZzZXQ9IjEwMCUiIHN0b3AtY29sb3I9IiNjZWNlYjciIHN0b3Atb3BhY2l0eT0iMSIvPgogIDwvbGluZWFyR3JhZGllbnQ+CiAgPHJlY3QgeD0iMCIgeT0iMCIgd2lkdGg9IjEiIGhlaWdodD0iMSIgZmlsbD0idXJsKCNncmFkLXVjZ2ctZ2VuZXJhdGVkKSIgLz4KPC9zdmc+);
	background: -moz-linear-gradient(top, #ebecda 0%, #e0e0c6 40%, #ceceb7 100%);
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, #ebecda),
		color-stop(40%, #e0e0c6), color-stop(100%, #ceceb7));
	background: -webkit-linear-gradient(top, #ebecda 0%, #e0e0c6 40%, #ceceb7 100%);
	background: -o-linear-gradient(top, #ebecda 0%, #e0e0c6 40%, #ceceb7 100%);
	background: -ms-linear-gradient(top, #ebecda 0%, #e0e0c6 40%, #ceceb7 100%);
	background: linear-gradient(to bottom, #ebecda 0%, #e0e0c6 40%, #ceceb7 100%);
	border: 1px solid #999999;
}

table.gradienttable th p {
	margin: 0px;
	padding: 8px;
	border-top: 1px solid #eefafc;
	border-bottom: 0px;
	border-left: 1px solid #eefafc;
	border-right: 0px;
}

table.gradienttable td p {
	margin: 0px;
	padding: 8px;
	border-top: 1px solid #fcfdec;
	border-bottom: 0px;
	border-left: 1px solid #fcfdec;;
	border-right: 0px;
}
</style>
</head>

<body>
<%
List<StockDetailDTO> list1 = (List<StockDetailDTO>) request
							.getAttribute(IRequestAttribute.LOWALART_LIST);%>

	<div id="container">
		<div id="header">
			<%@ include file="./include/header.jsp"%>
		</div>

		<div id="menu">
			<%@ include file="./include/settingBar.jsp"%>
		</div>

		<div id="leftmenu">
			<%@ include file="./include/sidemenu.jsp"%>

		</div>




		<div id="content">


			<div id="dashboard_content_main">
				<h2>You may use this template in any manner you like. All I ask
					is that you leave the link back to my site at the bottom of the
					page.</h2>
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				<h3>Template Notes</h3>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
					do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
					enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
					reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
					pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
					culpa qui officia deserunt mollit anim id est laborum.</p>
				<p>&nbsp;</p>
				<h3>More information</h3>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
					do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
					enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
					reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
					pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
					culpa qui officia deserunt mollit anim id est laborum.</p>
				<p>&nbsp;</p>
				<h3>Template Notes</h3>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
					do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
					enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
					reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
					pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
					culpa qui officia deserunt mollit anim id est laborum.</p>
				<p></p>
				<p>&nbsp;</p>
				<h3>Template Notes</h3>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
					do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
					enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
					reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
					pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
					culpa qui officia deserunt mollit anim id est laborum.</p>
				<p></p>
				<p>&nbsp;</p>
				<h3>Template Notes</h3>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed
					do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut
					enim ad minim veniam, quis nostrud exercitation ullamco laboris
					nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in
					reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla
					pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
					culpa qui officia deserunt mollit anim id est laborum.</p>
				<p></p>
				<p>&nbsp;</p>

			</div>


		</div>
		<div id="dashboard_side_section">
			<div id="dialog" title="Alert dialog">
				<p>Alert window..</p>
				<table border="1" class="gradienttable" width="100%">

					<tr>
						<td><%=Messages.getString("product_name")%></td>
						<td><%=Messages.getString("company_product_type")%></td>
						<td><%=Messages.getString("product_current_weight")%></td>
						<td><%=Messages.getString("product_current_quantity")%></td>
						<td><%=Messages.getString("product_status")%></td>

					</tr>
					<%
						List<StockDetailDTO> list = (List<StockDetailDTO>) request
								.getAttribute(IRequestAttribute.LOWALART_LIST);
						if (list != null && list.size() > 0) {
							for (Iterator it = list.iterator(); it.hasNext();) {
								StockDetailDTO sd = (StockDetailDTO) it.next();
					%>
					<tr>
						<td><%=sd.getProductName()%></td>
						<td><%=sd.getType() %></td>
						<td><%=sd.getWeight()%></td>
						<td><%=sd.getQuantity()%></td>
						<td><img src="./images/Downarrow.PNG" height="35px"
							alt="under usage"></img></td>
					</tr>
					<%
						}
						}
					%>
				</table>
			</div>
			<% if(list1!=null && list1.size()>0) {%>
			<button id="opener">
				<img src="images/low_stock.jpg" height="35px" ></img>
			</button>
			
			<br></br>
			
			<!-- <img src="images/alert.gif" height="35px"></img> -->
			<table border="1" class="gradienttable" >

				<tr>
					<td width="100%"><%=Messages.getString("product_name")%></td>
					<td><%=Messages.getString("product_status")%></td>

				</tr>
				<%
					
					if (list1 != null && list1.size() > 0) {
						for (Iterator it1 = list1.iterator(); it1.hasNext();) {
							StockDetailDTO sd1 = (StockDetailDTO) it1.next();
				%>
				<tr>
					<td><%=sd1.getProductName()%></td>
					<td><img src="./images/Downarrow.PNG" height="35px"
						alt="under usage"></img></td>
				</tr>
				<%
					}
					}
				%>
			</table>
			<%} %>
		</div>
	</div>

</body>
</html>
