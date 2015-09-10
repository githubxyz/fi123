<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/include-style.css" type="text/css" media="all">

<title>Insonera.com</title>
</head>

<body>
<div id="container">
		<div id="header">
        	<%@ include file="./include/header.jsp"%>
        </div>   
        
        <div id="menu">
        	<%@ include file="./include/settingBar.jsp"%>
        </div>
        
        <div id="leftmenu">
			<%@ include file="./include/sidemenu.htm"%>
				
        </div>
        
        
        
        
		<div id="content">
        
        
        <div id="content_top"></div>
        <div id="content_main">
        	<form class="form-2" action="saveStock" method="post">
	
	<p class="float">
		Item :<select name="prodId">
			<option value="1">dsfds</option>
		</select> 
		</p>
		<p class="float">
		Type :<select name="type">
			<option value="0">Select</option>
			<option value="1">Light</option>
			<option value="2">Medium</option>
			<option value="3">Heavy</option>
		</select> 
		</p><p class="float">
		Weight : <input type="text" name="weight"> </p>
		<p class="float">
		Quantity : <input
			type="text" name="quantity"> </p>
			<p class="float"> 
			Cost of the item :<input type="text" name="amount"> 
			</p><p class="float">
			Total Vat :<input type="text" name="vat"> </p>
			<p class="float">Item Code :<input type="text" name="kAndP"></p>
			
			<p class="clearfix">
		<input type="submit" name="save">
		</p>
	</form>

        </div>
<div id="content_bottom"></div>
            
            <div id="footer">
			<%@ include file="include/footer.jsp"%>
			</div>
      </div>
	  
   </div>
   
</body>
</html>
