
<%@page import="com.ims.dto.ProductMasterDTO"%>
<%@page import="com.ims.utility.IRequestAttribute"%>
<%@page import="com.ims.utility.Messages"%>
<%
ProductMasterDTO pm=(ProductMasterDTO)	request.getAttribute(IRequestAttribute.PRODUCT_MASTER);
%>
<input type="hidden" name="id" value="<%=pm.getId() %>" />
<div class="inpu-div">
	<table width="100%">
		<tbody>
			<tr>
				<td width="15%"><span class="label"> <%=Messages.getString("product_group_code")%>
						:
				</span></td>
				<td width="15%"><input type="text" name="productGroupCode"
					value="<%= (pm.getPrGroupMapDTO()!=null?pm.getPrGroupMapDTO().getCode():"") %>"
					class="input-text"></td>
				<td width="15%"><span class="label"> <%=Messages.getString("product_name")%>
						:
				</span></td>
				<td width="15%"><input type="text" name="productName"
					value="<%=pm.getProductName() %>" class="input-text"></td>

				<th width="80px" rowspan="4" colspan="2"><div class="error-div"
						id="saveMasterError"></div></th>
			</tr>
			<tr>
				<td><span class="label"> <%=Messages.getString("product_code")%>
						:
				</span></td>
				<td><input type="text" name="productCode"
					value="<%=pm.getProductCode() %>" class="input-text"></td>
				<td><span class="label"> <%=Messages.getString("subitemtype_req")%>
						:
				</span></td>
				<td><input type="checkbox" name="sub_item_type_req" value="1"></td>
			</tr>
			<tr>
				<td><span class="label"> <%=Messages.getString("unit_quantiity")%>
						:
				</span></td>
				<td><select name="qty_unit" class="input-text">
						<option value=" ">Select unit for quantity..</option>
						<option value="Number">Number</option>
						<option value="Packet">Packet</option>
				</select></td>
				<td><span class="label"> <%=Messages.getString("unit_weight")%>
						:
				</span></td>
				<td><select name="weight_unit" class="input-text" >
						<option value=" ">Select unit for weight..</option>
						<option value="Kilogram">Kilogram</option>
						<option value="Sq Feet">Sq Feet</option>
				</select></td>
			</tr>
			<tr>
				<td><span class="label"> <%=Messages.getString("company_gown")%>
						:
				</span></td>
				<td><input type="text" name="gown" value=<%=pm.getGown() %>></td>
			</tr>
		</tbody>
	</table>


</div>
<br></br>
<br></br>
<br></br>
<br></br>
<div class="inpu-div"
	style="width: 65%; float: left; text-align: center">
	<input type="button" name="submit" value="Submit" class="btn-style"
		onclick="saveProduct()">
</div>
