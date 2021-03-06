<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
	$(document).ready(
			function() {
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
		<div id="leftmenu" style="border-color: rgb(204, 204, 204);">
			<%@ include file="./include/sidemenu.jsp"%>
		</div>
		<div id="content">
			<div id="content_main">
				<div class="rcorners"
					style="margin-bottom: 20px; height: 220px; border-color: #cccccc">

					<div class="input-form" style="width: 100%">
						<div class="heading">
							<font size="4px" color="#67a0f5"><b><%=Messages.getString("vendor_payment_menu")%></b></font>
						</div>
						<div id="vendorDetail">
						
						</div>

					</div>


				</div>
				<!-- master page view -->
				<div style="margin-bottom: 20px;" id="productListDiv">
					<jsp:include page="vendorList.jsp" />
				</div>


			</div>
			<div id="content_bottom"></div>

			<div id="footer">
				<%@ include file="include/footer.jsp"%>
			</div>
		</div>

	</div>
<script>
function editVendor(id){
	var saveSucc = $.ajax({
		type : 'post',
		url : 'vendorInfo',
		data : 'type=edit&billNo=' + id,
		error : function(xhr, ajaxOptions, thrownError) {
			//  $('#spinner_buis').hide();
			alert("error from  -> " + thrownError);
		},
		success : function(data) {
			$("#vendorDetail").html(data);

		}
	});

}
</script>
</body>
</html>
