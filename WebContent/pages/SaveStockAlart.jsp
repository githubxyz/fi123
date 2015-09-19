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


	<title>FriendsInterior</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link rel="stylesheet" href="css/include-style.css" type="text/css"
		media="all">
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
			<div style="margin-bottom: 20px; height: 220px;" class="rcorners">
				<form action="SaveStockAlart" method="post">
					<% 						List<ProductMasterDTO> productdtos = (List<ProductMasterDTO>) request.getAttribute(IRequestAttribute.PRODUCT_LIST);%>
					<div class="inpu-div">
							<span class="label">
						Item :</span><select name="prodId" class="input-text">

							<option value="0">Select</option>
							<%
								for (Iterator it = productdtos.iterator(); it.hasNext();) {
									ProductMasterDTO productMasterDTO = (ProductMasterDTO) it.next();
							%>
						<option value="<%=productMasterDTO.getId()%>"><%=productMasterDTO.getProductName()==null?"":productMasterDTO.getProductName()%></option>
							<%
								}
							%>
						</select>
					</div>

					<!-- Product Master ID :<select name="productMaster">
					<option value="1">1</option>
					<option value="2">2</option>
				</select> -->
					<!-- <div class="inpu-div">
							<span class="label">
					 Type :</span><select name="type">
					 
						<option value="1">High</option>
						<option value="2">Medium</option>
						<option value="2">Low</option>
						</select></div> -->
					<div class="inpu-div">
							<span class="label">	
					 Max Value : </span><input type="text" name="maxVal" value=""></div>
					<div class="inpu-div">
							<span class="label">
						Min Value :</span><input type="text" name="minVal" value=""></div>

							<div class="inpu-div"><input type="submit" class="btn-style" name="submit" value="submit"> <br></br>
							</div>
				</form>
</div>
				<!-- master page view -->
				<div>
					<table id="example" cellpadding="0" cellspacing="0" border="1"
						class="display dataTable">
						<thead>
							<tr>
								<th align="center" style="background: #e6e6e6 url("images/ui-bg_glass_75_e6e6e6_1x400.png") 50% 50% repeat-x;color: #555555;">
									Product Name</th>
								<th align="center" style="background: #e6e6e6 url("images/ui-bg_glass_75_e6e6e6_1x400.png") 50% 50% repeat-x;color: #555555;">
									Type</th>
								<th align="center"
									style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555;">
									Max Value</th>
								<th align="center"
									style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555;">
									Min Value</th>

							</tr>
						</thead>

						<tbody>

							<% List<StockAlertDTO> stockAlartList = (List<StockAlertDTO>) request.getAttribute(ISessionAttribute.STOCLALART_LIST);
            if (stockAlartList != null) {
                for (Iterator it = stockAlartList.iterator(); it.hasNext(); ) {
                	StockAlertDTO sad = (StockAlertDTO) it.next();%>
							<tr style="border: 1px solid #ccc !important;">
								<td align="center"><%=sad.getProductMaster().getProductName() %></td>
								<td align="center"><%=(sad.getType()== null ? "" : sad.getType())%></td>
								<td align="center"><%=sad.getMaxVal() %></td>
								<td align="center"><%=sad.getMinVal() %></td>
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
                    "bJQueryUI": true,
                    bRetrieve: true,
                    "sPaginationType": "full_numbers",
                    "oLanguage": {
                        "sSearch": "Search all columns:"
                    },
                    "sDom": 'R<"H"lfr>t<"F"ip>',
                    // "sDom": '<"H"Tfr>t<"F"ip>',
                    // "sDom": 'Rlfrtip',
                    "bStateSave": true,
                    // "bDestroy":true,

                    "oColReorder": {
                        "aiOrder": [0, 1, 2, 3]
                    },
                    sScrollY: "",
                    "bPaginate": true


                });

                $("#example tfoot input").keyup(function () {

                    oTable.fnFilter(this.value, $("#example tfoot input").index(this));
                });

                $("#example tfoot input").each(function (i) {
                    var id = $(this).attr("id").split("-")[1];
                    asInitVals[id] = this.value;
                });

                $("#example tfoot input").focus(function () {
                    if (this.className == "search_init") {
                        this.className = "";
                        this.value = "";
                    }
                });

                $("#example tfoot input").blur(function (i) {
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
