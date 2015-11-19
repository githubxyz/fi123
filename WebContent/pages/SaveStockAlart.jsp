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
<title>FriendsInterior</title>
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
			<%@ include file="./include/sidemenu.htm"%>
		</div>
		<div id="content">
			<div id="content_main">
				<div style="margin-bottom: 20px; height: 220px;" class="rcorners">
					<div class="heading">
						<font size="4px" color="#67a0f5"><b><%=Messages.getString("company_item_configuration")%></b></font>
					</div>
					<table>
						<tbody>
							<tr>
								<td width="70%">
									<form action="SaveStockAlart" method="post"
										style="paddin-: 20px;" id="saveStockAlartForm">
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
												<option value="<%=productMasterDTO.getId()%>"><%=productMasterDTO.getProductName() == null ? "" : productMasterDTO.getProductName()%></option>
												<%
													}
												%>
											</select>
										</div>

										<div class="inpu-div">
											<span class="label"> Max Value : </span><input type="text"
												name="maxVal" value="">
										</div>
										<div class="inpu-div">
											<span class="label"> Min Value :</span><input type="text"
												name="minVal" value="">
										</div>

										<!-- <div class="inpu-div">
											<input type="submit" class="btn-style" name="submit"
												value="Submit"> <br></br>
										</div> -->
										
										<div class="inpu-div"
												style="width: 80%; float: left; text-align: center">
												<input type="button" name="submit" value="Submit"
													class="btn-style" onclick="SaveStockAlart()">
											</div>
										
										
									</form>
								</td>
								<td>
									<div class="error-div" id="SaveStockAlartError"></div>
								</td>
							</tr>
						</tbody>
					</table>
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
					alert("error from  -> " + thrownError);
				},
				success : function(data) {
					if (saveSucc.getResponseHeader('error') == '1') {
						$("#SaveStockAlartError").html(data);
					} else {
						$("#saveStockAlartListDiv").html(data);
						$("#SaveStockAlartError").html("");
					}

				}
			});
		}
	</script>
</body>
</html>
