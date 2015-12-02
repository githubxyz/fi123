<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.ims.dto.ProductGroupMapDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ims.dto.ProductMasterDTO"%>
<%@page import="com.ims.dto.ProductDetailDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.ims.utility.IRequestAttribute"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
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
<script type="text/javascript">
	$(document).ready(function() {

		var oTable = $('#example').dataTable({
			"bJQueryUI" : true,
			bRetrieve : true,
			"sPaginationType" : "full_numbers",
			"oLanguage" : {
				"sSearch" : "Search all columns:"
			},
			"sDom" : 'R<"H"lfr>t<"F"ip>',
			// "sDom": '<"H"Tfr>t<"F"ip>',
			// "sDom": 'Rlfrtip',
			"bStateSave" : true,
			// "bDestroy":true,

			"oColReorder" : {
				"aiOrder" : [ 0, 1, 2, 3 ]
			},
			sScrollY : "",
			"bPaginate" : true

		});

		$("#example tfoot input").keyup(function() {

			oTable.fnFilter(this.value, $("#example tfoot input").index(this));
		});

		$("#example tfoot input").each(function(i) {
			var id = $(this).attr("id").split("-")[1];
			asInitVals[id] = this.value;
		});

		$("#example tfoot input").focus(function() {
			if (this.className == "search_init") {
				this.className = "";
				this.value = "";
			}
		});

		$("#example tfoot input").blur(function(i) {
			var id = $(this).attr("id").split("-")[1];
			if (this.value == "") {
				this.className = "search_init";
				/*alert("jj");*/
				// this.value = asInitVals[$("#example tfoot input").index(this)];
				this.value = asInitVals[id];
			}
		});
	});
</script>
<!-- Highlighted menu -->
<script>
	src = "http://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js";
</script>
<script>
	$(document).ready(function() {
		$("#purchaseentry").css("background-color", "#f78900");
	});
</script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<link rel="stylesheet" href="css/include-style.css" type="text/css"
	media="all">

<title>Friends Interior</title>
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
						<font size="4px" color="#67a0f5"><b><%=Messages.getString("company_purchase_entry")%></b></font>
					</div>
					<form class="form-2" action="saveStock" method="post"
						id="saveStockForm">
						<%
							List<ProductMasterDTO> productdtos = (List<ProductMasterDTO>) request
									.getAttribute(IRequestAttribute.PRODUCT_LIST);
							List<ProductGroupMapDTO> groupMapDTOs = (List<ProductGroupMapDTO>) request
									.getAttribute(IRequestAttribute.PRODUCT_GROUP_LIST);
						%>
						<div class="inpu-div">


							<table width="100%">
								<tbody>
									<tr>
										<td width="15%"><span class="label"> <%=Messages.getString("purchase_ref_id")%>
												:
										</span></td>
										<td width="15%"><input type="text" name="billrefid"
											value="" class="input-text"></td>

										<td width="15%"><span class="label"> <%=Messages.getString("product_group_code")%>
												:
										</span></td>
										<td width="15%"><select name="groupId" class="input-text"
											id="groupId" onchange="changeGroup()">

												<option value="0">Select</option>
												<!-- Value fetching from product_group_map  -->
												<%
													for (Iterator it = groupMapDTOs.iterator(); it.hasNext();) {
														ProductGroupMapDTO productGroupMapDTO = (ProductGroupMapDTO) it.next();
												%>
												<option value="<%=productGroupMapDTO.getId()%>"><%=productGroupMapDTO.getCode()%></option>
												<%
													}
												%>
										</select></td>

										<th width="80px" rowspan="4" colspan="2"><div
												class="error-div" id="saveMasterError"></div></th>
									</tr>

									<tr>
										<td><span class="label"> <%=Messages.getString("product_name")%>
												:
										</span></td>
										<td><select name="prodId" class="input-text" id="prodId"
											onchange="changeProduct()">

												<option value="0">Select</option>
												<%
													for (Iterator it = productdtos.iterator(); it.hasNext();) {
														ProductMasterDTO productMasterDTO = (ProductMasterDTO) it.next();
												%>
												<option value="<%=productMasterDTO.getId()%>"><%=productMasterDTO.getProductName()%></option>
												<%
													}
												%>
										</select></td>
										<td><span class="label"><%=Messages.getString("company_product_type")%>
												:</span></td>
										<td><span id="itemTypeSpan" class="input-text"><select
												name="type" class="input-text">
													<option value="0">Select</option>
													<option value="1">Light</option>
													<option value="2">Medium</option>
													<option value="3">Heavy</option>
											</select> </span></td>
									</tr>

									<tr>
										<td><span class="label"> <%=Messages.getString("company_product_weight")%>
												:
										</span></td>
										<td><input type="text" name="weight"></td>
										<td><span class="label"> <%=Messages.getString("company_product_quantity")%>
												:
										</span></td>
										<td><input type="text" name="quantity"></td>
									</tr>
									<tr>
										<td><span class="label"> <%=Messages.getString("company_cost_per_item")%>
												:
										</span></td>
										<td><input type="text" name="amount"></td>
										<td><span class="label"> <%=Messages.getString("company_vat_amount")%>
												:
										</span></td>
										<td><input type="text" name="vat"></td>
									</tr>
									<tr>
										<td><span class="label"> <%=Messages.getString("company_gown")%>
												:
										</span></td>
										<td><input type="text" name="gown"></td>
										<td><span class="label"> <%=Messages.getString("company_k&p")%>
												:
										</span></td>
										<td><input type="text" name="kAndP"></td>
									</tr>
								</tbody>
							</table>


						</div>
						<div class="inpu-div"
							style="width: 65%; float: left; text-align: center">
							<input type="submit" class="btn-style" name="save" value="Submit">
						</div>
					</form>
				</div>

				<div style="margin-bottom: 20px;" id="PurchaseDetailsListDiv">
					<jsp:include page="PurchaseDetailsList.jsp" />
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
			id = $("#prodId").val();
			var saveSucc = $.ajax({
				type : 'post',
				url : 'saveStock',
				data : "selectType=1&productId=" + id,
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
