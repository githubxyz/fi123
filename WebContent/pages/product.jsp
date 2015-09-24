<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.ims.utility.Messages"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.ims.dto.ProductMasterDTO"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/include-style.css" type="text/css"
	media="all">


	<script type="text/javascript" src="js/jquery/jquery-1.7.1.min.js"></script>
	<script type="text/javascript"
		src="js/jquery/jquery-ui-1.8.17.custom.min.js"></script>
	<script type="text/javascript" src="js/jquery/jquery.dataTables.js"></script>
	<script type="text/javascript" src="js/jquery/ColReorder.js"></script>
	<script type="text/javascript" src="js/jquery/ColReorderWithResize.js"></script>
	<script type="text/javascript" src="js/jquery/TableTools.js"></script>
	<link media="all" rel="stylesheet"
		href="css/jquery-ui-1.8.9.custom/jquery-ui-1.8.9.custom.css"
		type="text/css" />
	<link media="all" rel="stylesheet" href="css/ColReorder.css"
		type="text/css" />

	<link media="all" rel="stylesheet" href="css/demo_table_jui.css"
		type="text/css" />
	<link media="all" rel="stylesheet" href="css/TableTools.css"
		type="text/css" />


	<title>Insonera.com</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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



			<div id="content_main">
				<div class="rcorners" style="margin-bottom: 20px; height: 220px;">
					<div class="input-form" >
					<div style="align:center">
					<font size="6px" color="#67a0f5"><b><%=Messages.getString("company_master_entry") %></b></font>
					</div>
						<form action="saveProduct" method="post" style="paddin-: 20px;"
							id="saveProductForm">

							<div class="inpu-div" style="width:50%">
								<span class="label" > <%=Messages.getString("product_name") %> :</span><input type="text"
									name="productName" value="" class="input-text">
							</div>
							<div class="inpu-div" style="width:50%">
							
								<span class="label"> <%=Messages.getString("product_code") %> :</span> <input type="text"
									name="productCode" value="" class="input-text">
							</div>
							<div class="inpu-div" style="width:50%">
							
								<span class="label"> <%=Messages.getString("mesure_unit") %> : </span> <select
									name="unitOfMesure" class="input-text">
									<option value="1">Weight</option>
									<option value="2">Quantity</option>
									<option value="3">Both</option>
								</select>
							</div>
							<div class="inpu-div" style="width:50%">
							
								<span class="label"> <%=Messages.getString("specific_unit") %> : </span> <select
									name="unitOfMesure" class="input-text">
									<option value="1">KG</option>
									<option value="2">Number</option>
									<option value="3">Packet</option>
								</select>
							</div>
							<div class="inpu-div"
								style="width: 80%; float: left; text-align: center">
								<input type="button" name="submit" value="submit"
									class="btn-style" onclick="saveProduct()">
							</div>
							<br></br> 

						</form>
					</div>
					<div class="error-div" id="saveMasterError"></div>

				</div>
				<!-- master page view -->
				<div style="margin-bottom: 10px;" id="productListDiv">
					<jsp:include page="productList.jsp" />
				</div>

			</div>
			<div id="content_bottom"></div>

			<div id="footer">
				<%@ include file="include/footer.jsp"%>
			</div>
		</div>

	</div>
	<script type="text/javascript">
		//alert("jj");
				function saveProduct() {
			var saveSucc = $.ajax({
				type : 'post',
				url : 'saveProduct',
				data : $('#saveProductForm').serialize(),
				error : function(xhr, ajaxOptions, thrownError) {
					//  $('#spinner_buis').hide();
					alert("error from  -> "
							+ thrownError);
				},
				success : function(data) {
					if(saveSucc.getResponseHeader('error') == '1'){
						$("#saveMasterError").html(data);
					}else{
						$("#productListDiv").html(data);
						$("#saveMasterError").html("");
					}
					
				}
			});
		}
	</script>
</body>
</html>
