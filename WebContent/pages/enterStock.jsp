<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Iterator"%>
<%@page import="com.ims.dto.ProductMasterDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.ims.utility.IRequestAttribute"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/include-style.css" type="text/css"
	media="all">

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
			<div id="content_main" style="height: 400px;">
				<div style="margin-bottom: 20px; height: 220px;" class="rcorners">
					<form class="form-2" action="saveStock" method="post">
						<%
							List<ProductMasterDTO> productdtos = (List<ProductMasterDTO>) request
									.getAttribute(IRequestAttribute.PRODUCT_LIST);
						%>
						<div class="inpu-div">
							<span class="label"> Item :</span><select name="prodId"
								class="input-text">

								<option value="0">Select</option>
								<%
									for (Iterator it = productdtos.iterator(); it.hasNext();) {
										ProductMasterDTO productMasterDTO = (ProductMasterDTO) it.next();
								%>
								<option value="<%=productMasterDTO.getId()%>"><%=productMasterDTO.getProductName()%></option>
								<%
									}
								%>
							</select>
						</div>
						<div class="inpu-div">
							<span class="label"> Type :</span><select name="type">
								<option value="0">Select</option>
								<option value="1">Light</option>
								<option value="2">Medium</option>
								<option value="3">Heavy</option>
							</select>
						</div>
						<div class="inpu-div">
							<span class="label"> Weight :</span> <input type="text"
								name="weight">
						</div>
						<div class="inpu-div">
							<span class="label"> Quantity :</span> <input type="text"
								name="quantity">
						</div>
						<div class="inpu-div">
							<span class="label"> Cost of the item :</span><input type="text"
								name="amount">
						</div>
						<div class="inpu-div">
							<span class="label"> Total Vat :</span><input type="text"
								name="vat">
						</div>
						<div class="inpu-div">
							<span class="label"> K&P :</span><input type="text" name="kAndP">
						</div>
						<div class="inpu-div"
							style="width: 80%; float: left; text-align: center">
							<input type="submit"  class="btn-style" name="save" value="Submit">
						</div>
					</form>
				</div>
			</div>
			<div id="content_bottom"></div>

			<div id="footer">
				<%@ include file="include/footer.jsp"%>
			</div>
		</div>

	</div>

</body>
</html>
