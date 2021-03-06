<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.ims.utility.IRequestAttribute"%>
<%@page import="com.ims.dto.StockAlertDTO"%>
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
	<!--  <link rel="stylesheet" href="/resources/demos/style.css"> -->
	<script src="./js/jquery-2.0.3.min.js"></script>
	<link rel="stylesheet" href="./css/styles.css">
		<script src="./js/script.js"></script>
<title>Friends Interior</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/include-style.css" type="text/css"
	media="all">
	<!-- Highlighted menu -->
	<script>
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js";
		</script>
	<script>
		$(document).ready(function(){
			$("#itemconfig").css("background-color", "#f78900");
		});
		
		</script>
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
			<%@ include file="./include/sidemenu.jsp"%>
		</div>
		<div id="content">
			<div id="content_main">
				<div style="margin-bottom: 20px; height: 220px;" class="rcorners">
					<div class="heading">
						<font size="4px" color="#67a0f5"><b><%=Messages.getString("company_item_configuration")%></b></font>
					</div>
					
									<form action="SaveStockAlart" method="post"
										style="paddin-: 20px;" id="saveStockAlartForm">
										<%
											List<ProductMasterDTO> productdtos = (List<ProductMasterDTO>) request
													.getAttribute(IRequestAttribute.PRODUCT_LIST);
										%>
										<div class="inpu-div">
										
										<table width="100%">
<tbody>
	<tr>
<td width="15%"><span class="label"> <%=Messages.getString("product_name")%> :</span></td>
<td width="15%"><select name="prodId" class="input-text" id="prodId" onchange="changeProduct()">

<option value="0">Select</option>
<%
	for (Iterator it = productdtos.iterator(); it.hasNext();) {
		ProductMasterDTO productMasterDTO = (ProductMasterDTO) it.next();
%>
<option value="<%=productMasterDTO.getId()%>"><%=productMasterDTO.getProductName() == null ? "" : productMasterDTO.getProductName()%></option>
<%
	}
%>
</select></td>
<td width="15%"><span class="label"><%=Messages.getString("company_product_type") %> :</span></td>
	<td width="15%"><select class="input-text" id="itemTypeSpan"
	name="type">
		<option value="0">Select</option>
		<option value="1">Light</option>
		<option value="2">Medium</option>
		<option value="3">Heavy</option>
</select></td>


<th width="80px" rowspan="4" colspan="2">
<div class="error-div" id="SaveStockAlartError"></div></th>
	</tr>
	
	<tr>
	<td><span class="label"> <%=Messages.getString("company_product_max_value")%> : </span></td>
<td><input type="text"
name="maxVal" value=""></td>
<td><span class="label"> <%=Messages.getString("company_product_min_value")%> :</span></td>
<td><input type="text"
name="minVal" value=""></td>
</td>
	</tr>
	
	</tbody>
</table>
											</div> 
										
										<div class="inpu-div"
												style="width: 65%; float: left; text-align: center">
												<input type="button" name="submit" value="Submit" class="btn-style" onclick="SaveStockAlart()">
											</div>
										
										
									</form>
								
				</div>
				<!-- master page view -->
				<div style="margin-bottom: 10px;" id="saveStockAlartListDiv">
					<jsp:include page="SaveStockAlartList.jsp" />
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
		function SaveStockAlart() {
			var saveSucc = $.ajax({
				type : 'post',
				url : 'SaveStockAlart',
				data : $('#saveStockAlartForm').serialize(),
				error : function(xhr, ajaxOptions, thrownError) {
					//  $('#spinner_buis').hide();
					/* alert("error from  -> " + thrownError); */
					alert("Please provide proper value in all fields");
					$(':input','#saveStockAlartForm')
					  .removeAttr('checked')
					  .removeAttr('selected')
					  .not(':button, :submit, :reset, :hidden, :radio, :checkbox')
					  .val('');
				},
				success : function(data) {
					if (saveSucc.getResponseHeader('error') == '1') {
						$("#SaveStockAlartError").html(data);
					} else {
						//alert(data)
						$("#saveStockAlartListDiv").html(data);
						$("#SaveStockAlartError").html("");
					}
					alert("Item saved successfully");
					$(':input','#saveStockAlartForm')
					  .removeAttr('checked')
					  .removeAttr('selected')
					  .not(':button, :submit, :reset, :hidden, :radio, :checkbox')
					  .val(''); 

				}
			});
		}
		
		function changeProduct() {
			id=$("#prodId").val();
			var saveSucc = $.ajax({
				type : 'post',
				url : 'saveStock',
				data :"selectType=1&productId="+id,
				error : function(xhr, ajaxOptions, thrownError) {
					//  $('#spinner_buis').hide();
					/* alert("error from  -> " + thrownError); */
					
				},
				success : function(data) {
					//alert(data);
					$("#itemTypeSpan").html(data);
					
				}
			});
		}
	</script>
</body>
</html>
