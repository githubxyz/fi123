<%@page import="com.ims.utility.ISessionAttribute"%>
<%@page import="com.ims.dto.StockDetailDTO"%>
<%@page import="com.ims.utility.Messages"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>IMS</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link href="../css/main.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div id="header">
		<h1>
			<a href="#"><%=Messages.getString("company_name")%></a>
		</h1>
		<ul id="menu">
			<li class="active"><a href="#">about application</a></li>
			<li><a href="#">register</a></li>
			<li><a href="#">demo</a></li>
			<li><a href="#">help</a></li>
			<li><a href="#">contact</a></li>
		</ul>
	</div>

	<div id="bar">
		<div class="wrap">
			<span class="step"><a>1</a> sharing</span> <span class="step"><a>2</a>
				data management</span> <span class="step"><a>3</a> collaboration</span>
		</div>
	</div>
	<div class="wrap">
		<div class="col">
			<ul>
			<% List<StockDetailDTO> stockList=(List<StockDetailDTO>)request.getAttribute(ISessionAttribute.STOCK_LIST);
			if(stockList!=null){
			for(Iterator it=stockList.iterator();it.hasNext();){
				StockDetailDTO sd=(StockDetailDTO)it.next();%>
				<li><%=sd.getProductName() %></li>
			<%}}	%>
			
				
			</ul>
		</div>

		<div class="col2 ">
			<h3>
				About <span class="red">Web Application</span>
			</h3>
			<p>Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
				Integer porta, ipsum sit amet ultricies congue, ante pede congue
				pede, id venenatis ante elit et nulla. Ut lectus nisi, convallis in,
				eleifend vitae, blandit non, orci.</p>
			<p class="info">If you liked this template, you might like some
				other Free or Commercial CSS templates from Solucija.</p>
				
				
			<form action="getAllStockDetail" method="post">
				<%--Product Name :<input type="text" name="productName" value="" ><br>
				Product Code :<input type="text"  name="productCode"  value="">
				Unit of Mesure :<select name="unitOfMesure">
					<option value="1">Weight</option>
					<option value="2">Quantity</option>
				</select> --%>
				<input type="submit" name="submit" value="submit">                            
			</form>

		</div>
	</div>
	<div id="footer">
		<div align=center>
			<p>Copyright&copy; insonera.com &middot; All Rights Reserved</p>
		</div>
		<p>
			<!-- Copyright&copy; insonera.com   <a href="http://www.insonera.com">Web Application</a> &middot; All Rights Reserved -->
		</p>
	</div>

</body>
</html>
