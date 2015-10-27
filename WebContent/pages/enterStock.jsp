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
	<script type="text/javascript" src="js/jquery/jquery-1.7.1.min.js"></script>
	<script type="text/javascript"
		src="js/jquery/jquery-ui-1.8.17.custom.min.js"></script>
		<!--  <link rel="stylesheet" href="/resources/demos/style.css"> -->
  <script src="./js/jquery-2.0.3.min.js"></script>
  <link rel="stylesheet" href="./css/styles.css">
   <script src="./js/script.js"></script>
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
			<div id="content_main" >
				<div style="margin-bottom: 20px; height: 220px;" class="rcorners">
				<div class="heading">
					<font size="4px" color="#67a0f5"><b><%=Messages.getString("company_purchase_entry") %></b></font>
					</div>
					<form class="form-2" action="saveStock" method="post" id="saveStockForm">
						<%
							List<ProductMasterDTO> productdtos = (List<ProductMasterDTO>) request
									.getAttribute(IRequestAttribute.PRODUCT_LIST);
						%>
						<div class="inpu-div">
              <table width="100%"><tbody><tr><td width="15%">
                <span class="label"> <%=Messages.getString("company_product") %> :</span></td><td width="15%"><select name="prodId" class="input-text" id="prodId" onchange="changeProduct()">

								<option value="0">Select</option>
								<%
									for (Iterator it = productdtos.iterator(); it.hasNext();) {
										ProductMasterDTO productMasterDTO = (ProductMasterDTO) it.next();
								%>
								<option value="<%=productMasterDTO.getId()%>"><%=productMasterDTO.getProductName()%></option>
								<%
									}
								%>
								
                </select></td><td width="15%">
						
                <span class="label"> <%=Messages.getString("company_product_type") %> :</span> </td><td width="15%"><span id="itemTypeSpan" ><select name="type" class="input-text">
									<option value="0">Select</option>
									<option value="1">Light</option>
									<option value="2">Medium</option>
									<option value="3">Heavy</option>
                </select> </span></td><th width="80px" rowspan="4" colspan="2"><div id="saveMasterError" class="error-div"></div></th></tr><tr><td>
						
                <span class="label"> <%=Messages.getString("company_product_weight") %> :</span></td><td> <input type="text" name="weight"></td><td>
						
							<span class="label"> <%=Messages.getString("company_product_quantity") %> :</span></td><td> <input type="text" name="quantity"></td></tr><tr><td>
						
							<span class="label"> <%=Messages.getString("company_cost_per_item") %> :</span></td><td><input type="text" name="amount"></td><td>
						
							<span class="label"> <%=Messages.getString("company_vat_amount") %> :</span></td><td><input type="text" name="vat"></td></tr><tr width="15%"><td>
						
							<span class="label"> <%=Messages.getString("company_k&p") %> :</span></td><td><input type="text" name="kAndP"></td></tr></tbody></table>
						</div>
						<div class="inpu-div"
							style="width: 80%; float: left; text-align: center">
							<input type="submit" class="btn-style" name="save" value="Submit">
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
	<script type="text/javascript">
		//alert("jj");
		function changeProduct() {
			id=$("#prodId").val();
			var saveSucc = $.ajax({
				type : 'post',
				url : 'saveStock',
				data :"selectType=1&productId="+id,
				error : function(xhr, ajaxOptions, thrownError) {
					//  $('#spinner_buis').hide();
					alert("error from  -> " + thrownError);
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
