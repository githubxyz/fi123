<%@page import="java.util.Iterator"%>
<%@page import="com.ims.utility.Messages"%>
<%@page import="com.ims.utility.ISessionAttribute"%>
<%@page import="com.ims.dto.ProductMasterDTO"%>
<%@page import="java.util.List"%>
<table id="example" cellpadding="0" cellspacing="0" border="1"
	class="display dataTable">

	<thead>

		<tr style="width: 40px">
			<th align="center"
				style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555;">
				<%=Messages.getString("product_group_code")%></th>
			<th align="center"
				style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555;">
				<%=Messages.getString("product_name")%>
			</th>


			<th align="center"
				style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555;">
				<%=Messages.getString("product_code")%></th>


			<th align="center"
				style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555;">
				<%=Messages.getString("unit_quantiity")%></th>
			<th align="center"
				style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555;">
				<%=Messages.getString("unit_weight")%></th>
			<th align="center"
				style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555;">
				<%=Messages.getString("company_gown")%></th>
			<th align="center"
				style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 5% 5% repeat-x; color: #555555;">
				<%=Messages.getString("edit_row")%></th>

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
		<tr style="border: 1px solid #ccc !important;"
			onclick="editProduct(<%=sd.getId()%>)">
			<td align="center"><%=sd.getPrGroupMapDTO().getCode()%></td>
			<td align="center"><%=sd.getProductName()%></td>
			<td align="center"><%=sd.getProductCode()%></td>
			<td align="center"><%=sd.getQty_unit() == null ? "" : sd.getQty_unit()%></td>
			<td align="center"><%=sd.getWeight_unit() == null ? "" : sd.getWeight_unit()%></td>
			<td align="center"><%=sd.getWeight_unit() == null ? "" : sd.getGown()%></td>
			<td align="center" width="5%"><img align="right"
				src="images/edit.png" height="20px" alt="edit field"></img></td>

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
			<th
				style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555; font-size: 11px !important;">
				<input type="text" id="col3" name="col3" value="Type to search"
				class="search_init" />
			</th>
			<th
				style="background: #e6e6e6 url('images/ui-bg_glass_75_e6e6e6_1x400.png') 50% 50% repeat-x; color: #555555; font-size: 11px !important;">
				<input type="text" id="col3" name="col3" value="Type to search"
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
				"aiOrder" : [ 0, 1, 2, 3, 4, 5,6]
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