
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.ims.dto.ProductGroupMapDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ims.dto.ProductMasterDTO"%>
<%@page import="com.ims.dto.ProductDetailDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.ims.utility.IRequestAttribute"%>
<%@page import="com.ims.utility.Messages"%>
<%
	ProductDetailDTO pd = (ProductDetailDTO) request.getAttribute(IRequestAttribute.PRODUCT_DETAILS_LIST_BY_ID);
%>
<input type="hidden" name="id" value="<%=pd.getId()%>" />
<div class="inpu-div">

	<%
		List<ProductMasterDTO> productdtos2 = (List<ProductMasterDTO>) request
				.getAttribute(IRequestAttribute.PRODUCT_LIST);
		List<ProductGroupMapDTO> groupMapDTOs = (List<ProductGroupMapDTO>) request
				.getAttribute(IRequestAttribute.PRODUCT_GROUP_LIST);
	%>
	<table width="100%">
		<tbody>
			<tr>
				<td width="15%"><span class="label"> <%=Messages.getString("purchase_ref_id")%>
						:
				</span></td>
				<td width="15%"><input type="text" name="billrefid"
					value="<%=pd.getPurchaseRef()%>" class="input-text"></td>

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

				<th width="80px" rowspan="4" colspan="2"><div class="error-div"
						id="saveMasterError"></div></th>
			</tr>

			<tr>
				<td><span class="label"> <%=Messages.getString("product_name")%>
						:
				</span></td>
				<td><select name="prodId" class="input-text" id="prodId"
					onchange="changeProduct()">

						<option value="0">Select</option>
						<%
							for (Iterator it = productdtos2.iterator(); it.hasNext();) {
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
				<td><input type="text" name="weight" value= "<%=pd.getWeight()%>"></input></td>
				<td><span class="label"> <%=Messages.getString("company_product_quantity")%>
						:
				</span></td>
				<td><input type="text" name="quantity" value="<%=pd.getQuantity()%>"></td>
			</tr>
			<tr>
				<td><span class="label"> <%=Messages.getString("company_cost_per_item")%>
						:
				</span></td>
				<td><input type="text" name="amount" value="<%=pd.getAmount()%>"></td>
				<td><span class="label"> <%=Messages.getString("company_vat_amount")%>
						:
				</span></td>
				<td><input type="text" name="vat" value="<%=pd.getVat()%>"></td>
			</tr>
			<tr>
				<td><span class="label"> <%=Messages.getString("company_k&p")%>
						:
				</span></td>
				<td><input type="text" name="kAndP" value="<%=pd.getkAndP()%>"></td>
			</tr>
		</tbody>
	</table>


</div>
<div class="inpu-div"
	style="width: 65%; float: left; text-align: center">
	<input type="submit" class="btn-style" name="save" value="Submit">
</div>
