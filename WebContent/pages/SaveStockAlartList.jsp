<%@page import="com.ims.utility.ISessionAttribute"%>
<%@page import="com.ims.utility.IRequestAttribute"%>
<%@page import="com.ims.dto.StockAlertDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="com.ims.dto.ProductMasterDTO"%>

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

							<%
								List<StockAlertDTO> stockAlartList = (List<StockAlertDTO>) request
										.getAttribute(ISessionAttribute.STOCLALART_LIST);
								if (stockAlartList != null) {
									for (Iterator it = stockAlartList.iterator(); it.hasNext();) {
										StockAlertDTO sad = (StockAlertDTO) it.next();
							%>
							<tr style="border: 1px solid #ccc !important;">
								<td align="center"><%=sad.getProductMaster().getProductName()%></td>
								<td align="center"><%=(sad.getType() == null ? "" : sad.getType())%></td>
								<td align="center"><%=sad.getMaxVal()%></td>
								<td align="center"><%=sad.getMinVal()%></td>
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
				/* alert("jj"); */
				// this.value = asInitVals[$("#example tfoot input").index(this)];
				this.value = asInitVals[id];
			}
		});
	</script>
