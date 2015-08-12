<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form action="saveStock" method="post">
		Item :<select name="prodId">
			<option value="1">dsfds</option>
		</select>
		
		Type :<select name="type">
			<option value="0">Select</option>
			<option value="1">Light</option>
			<option value="2">Medium</option>
			<option value="3">Heavy</option>
		</select>
		Weight : <input type="text" name="weight">
		Quantity : <input type="text" name="quantity">
		Cost of the item :<input type="text" name="amount">
		Total Vat :<input type="text" name="vat">
		Item Code :<input type="text" name="kAndP">
		<input type="submit" name="save">
	</form>
</body>
</html>