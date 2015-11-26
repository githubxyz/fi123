<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.ims.dto.ProductGroupMapDTO"%>
<%@page import="com.ims.utility.IRequestAttribute"%>
<%@page import="com.ims.utility.Messages"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.ims.dto.ProductMasterDTO"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style>
#product:active {
	color: #f78900;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/include-style.css" type="text/css"
	media="all">
<title>Friends Interior</title>

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

	<!--  <link rel="stylesheet" href="/resources/demos/style.css"> -->
	<script src="./js/jquery-2.0.3.min.js"></script>
	<link rel="stylesheet" href="./css/styles.css">

		<script src="./js/script.js"></script>
		<script>
			src = "http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js";
		</script>
		<script>
			$(document).ready(function() {
				$("#productsales").css("background-color", "#f78900");
			});
		</script>
</head>

<body>
	<%
		List<ProductGroupMapDTO> productGroupMapDTOs = (List<ProductGroupMapDTO>) request
				.getAttribute(IRequestAttribute.PRODUCT_GROUP_LIST);
	List<ProductMasterDTO> prMasterDTOs =(List<ProductMasterDTO>)request.getAttribute(IRequestAttribute.PRODUCT_LIST);
	
	%>
	<div id="container">
		<div id="header">
			<%@ include file="./include/header.jsp"%>
		</div>
		<div id="menu">
			<%@ include file="./include/settingBar.jsp"%>
		</div>
		<div id="leftmenu" style="border-color: rgb(204, 204, 204);">
			<%@ include file="./include/sidemenu.jsp"%>
		</div>
		<div id="content">
			<div id="content_main">
				<div class="rcorners"
					style="margin-bottom: 20px; height: 220px; border-color: #cccccc">
					<div class="input-form" style="width: 100%">
						<div class="heading">
							<font size="4px" color="#67a0f5"><b><%=Messages.getString("company_product_sales")%></b></font>
						</div>
						<form action="" method="post" style="paddin-: 20px;" id="">
							<table>
								<div class="inpu-div">
									<table width="100%">
										<tbody>
											<tr>
												<td width="15%"><span class="label"> <%=Messages.getString("product_group_code")%>
														:
												</span></td>
												<td width="15%"><select name="groupCode"
													class="input-text">
														<option value=" ">Select Product Group..</option>
														<%
															for (Iterator it = productGroupMapDTOs.iterator(); it.hasNext();) {
																ProductGroupMapDTO productGroupMapDTO = (ProductGroupMapDTO) it.next();
														%>
														<option value="<%=productGroupMapDTO.getId()%>"><%=productGroupMapDTO.getCode()%></option>
														<%
															}
														%>
												</select></td>
												<td width="15%"><span class="label"> <%=Messages.getString("item_name")%>
														:
												</span></td>
												<td width="15%"><span id="itemSpan"><select
														name="productMasterId" class="input-text" id="productMasterId">
															
															<%
															for (Iterator it = prMasterDTOs.iterator(); it.hasNext();) {
																ProductMasterDTO productMasterDTO = (ProductMasterDTO) it.next();
														%>
														<option value="<%=productMasterDTO.getId()%>"><%=productMasterDTO.getProductName()%></option>
														<%
															}
														%>
													</select></span></td>

												<th width="80px" rowspan="4" colspan="2"><div
														class="error-div" id="saveMasterError"></div></th>
											</tr>
											<tr>
												<td><span class="label"> <%=Messages.getString("company_product_quantity")%>
														:
												</span></td>
												<td><input type="text" name="quantity" value=""
													class="input-text"></td>
												<td><span class="label"><%=Messages.getString("company_product_weight")%>
														:</span></td>
												<td><input type="text" name="weight" value=""
													class="input-text"></td>
											</tr>
											<tr>
												<td><span class="label"> <%=Messages.getString("company_unit_price")%>
														:
												</span></td>
												<td><input type="text" name="unitPrice" value=""
													class="input-text"></td>
												<td><span class="label"> <%=Messages.getString("vat_percentage")%></span>
												</td>
												<td><input type="text" name="unitPrice" value=""
													class="input-text"></td>
											</tr>
										</tbody>
									</table>
								</div>
								<div class="inpu-div"
									style="width: 80%; float: left; text-align: center">
									<input type="button" name="Add Item" value="Add Item"
										class="btn-style" onclick="salesProduct()">
								</div>
								</form>
								</div>
								<!-- master page view -->
								<div style="margin-bottom: 10px;" id="productListDiv">
									<jsp:include page="productList.jsp" />
								</div>
								<table width=80%>
									<tr>
										<td><span class="label"><%=Messages.getString("product_vat_amount")%>
												:</span></td>
										<td><input type="text" name="vatAmount" value=""
											class="input-text"></td>
										<td><span class="label"><%=Messages.getString("customer_vat_no")%>
												:</span></td>
										<td><input type="text" name="subTotal" value=""
											class="input-text"></td>

									</tr>
									<tr>
										<td><span class="label"><%=Messages.getString("product_sub_total")%>
												:</span></td>
										<td><input type="text" name="subTotal" value=""
											class="input-text"></td>

									</tr>

									<tr>
										<td><span class="label"><%=Messages.getString("discount_over_total")%>:</span></td>
										<td><input type="text" name="totalCost" value=""
											class="input-text"></td>
									</tr>
									<tr>
										<td><span class="label"><%=Messages.getString("product_total_cost")%>
												:</span></td>
										<td><input type="text" name="totalCost" value=""
											class="input-text"></td>
									</tr>
									<tr>
										<th colspan="2" rowspan="2"><input type="button"
											name="submit" value="Submit" class="btn-style"
											onclick="salesProduct()"></th>
									</tr>
								</table>

								</div>
								</div>
								<div id="content_bottom"></div>


								</div>

								</div>
								<script type="text/javascript">
									
								</script>
</body>
</html>
