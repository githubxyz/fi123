<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
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
				<form action="saveProduct" method="post" style="paddin-: 20px;">
					<div class="rcorners" style="margin: 20px;height: 120px;">
						<div class="inpu-div">
							<span class="label"> Product Name :</span><input type="text"
								name="productName" value="" class="input-text">
						</div>
						<div class="inpu-div">
							<span class="label"> Product Code :</span> <input type="text"
								name="productCode" value="" class="input-text">
						</div>
						<div class="inpu-div">
							<span class="label"> Unit of Mesure : </span> <select
								name="unitOfMesure" class="input-text">
								<option value="1">Weight</option>
								<option value="2">Quantity</option>
							</select>
						</div>
						<div class="inpu-div" style="width: 80%;float: left;text-align: center"><input type="submit" name="submit" value="submit" class="btn-style"></div>
						<br></br>
						<br></br>
					</div>
				</form>

				<!-- master page view -->
				<div style="margin-bottom:10px;">
					<table id="example" cellpadding="0" cellspacing="0" border="1"
						class="display dataTable">
						<thead>
							<tr>
								<th align="center" style="background: #e6e6e6 url("images/ui-bg_glass_75_e6e6e6_1x400.png") 50% 50% repeat-x;color: #555555;">
									Product Name</th>
								<th align="center"
									style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555;">
									Product Code</th>
								<th align="center"
									style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555;">
									Unit Of Measure</th>

							</tr>
						</thead>

						<tbody>

							<%
								List<ProductMasterDTO> masterList = (List<ProductMasterDTO>) request
										.getAttribute(ISessionAttribute.PRODUCTMASTER_LIST);
								if (masterList != null) {
									for (Iterator it = masterList.iterator(); it.hasNext();) {
										ProductMasterDTO sd = (ProductMasterDTO) it.next();
							%>
							<tr style="border: 1px solid #ccc !important;">
								<td align="center"><%=sd.getProductName()%></td>
								<td align="center"><%=sd.getProductCode()%></td>
								<td align="center"><%=sd.getUnitOfMesure() == 1 ? "Weight" : "Quantity"%></td>
							</tr>
							<%
								}
								}
							%>


						</tbody>

						<tfoot>

							<tr>
								<th
									style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555; font-size: 11px !important;">
									<input type="text" id="col1" name="col1" value="Type to search"
									class="search_init" />
								</th>
								<th
									style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555; font-size: 11px !important;">
									<input type="text" id="col2" name="col2" value="Type to search"
									class="search_init" />
								</th>
								<th
									style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555; font-size: 11px !important;">
									<input type="text" id="col3" name="col3" value="Type to search"
									class="search_init" />
								</th>
							</tr>
						</tfoot>
						<%--</table>--%>
						<%--</ul>--%>
					</table>

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
		var asInitVals = new Array();

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
				"aiOrder" : [ 0, 1, 2 ]
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
				/* alert("jj"); */
				// this.value = asInitVals[$("#example tfoot input").index(this)];
				this.value = asInitVals[id];
			}
		});
	</script>
</body>
</html>
