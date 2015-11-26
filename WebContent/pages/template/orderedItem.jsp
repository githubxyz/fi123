<%@page import="com.ims.utility.Messages"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ims.utility.ISessionAttribute"%>
<%@page import="com.ims.dto.SaleItemDTO"%>
<%@page import="java.util.List"%>
<%
List<SaleItemDTO> saleItemDTOs=(List<SaleItemDTO>) session.getAttribute(ISessionAttribute.SALE_ITEM_LIST);
if(saleItemDTOs!=null && saleItemDTOs.size()>0){
%>

<table>
	<tr>
		<td>Item</td>
		<td>Quantity</td>
		<td>Rate</td>
		<td>Amount</td>
	</tr>
	<%
	for (Iterator it = saleItemDTOs.iterator(); it.hasNext();) {
		SaleItemDTO saleItemDTO=(SaleItemDTO)it.next();
	%>
	<tr>
	<td><%=saleItemDTO.getProductMaster().getProductName() %></td>
	<%
	double mesure=0.0;
	boolean onlyQuantity=true;
	if(saleItemDTO.getMesure()!=null && saleItemDTO.getMesure()!=0.0){
		mesure=saleItemDTO.getMesure();
		onlyQuantity=false;
	}else{
		mesure=saleItemDTO.getQuantity();
	}
	%>
	<td><%=mesure %> &nbsp;<%=(onlyQuantity?saleItemDTO.getProductMaster().getQty_unit():saleItemDTO.getProductMaster().getWeight_unit()) %></td>
	<td><%=saleItemDTO.getUnitPrice() %></td>
	<td><%=(mesure*saleItemDTO.getUnitPrice()) %></td>
</tr>
	<%}
	
	}%>
</table>

<table width=80%>
									<tr>
										<td><span class="label"><%=Messages.getString("product_vat_amount")%>
												:</span></td>
										<td><input type="text" name="vatAmount" value=""
											class="input-text"></td>
										<td><span class="label"><%=Messages.getString("customer_vat_no")%>
												:</span></td>
										<td><input type="text" name="subTotal" value=""
											class="input-text"></td>

									</tr>
									<tr>
										<td><span class="label"><%=Messages.getString("product_sub_total")%>
												:</span></td>
										<td><input type="text" name="subTotal" value=""
											class="input-text"></td>

									</tr>

									<tr>
										<td><span class="label"><%=Messages.getString("discount_over_total")%>:</span></td>
										<td><input type="text" name="totalCost" value=""
											class="input-text"></td>
									</tr>
									<tr>
										<td><span class="label"><%=Messages.getString("product_total_cost")%>
												:</span></td>
										<td><input type="text" name="totalCost" value=""
											class="input-text"></td>
									</tr>
									<tr>
										<th colspan="2" rowspan="2"><input type="button"
											name="submit" value="Submit" class="btn-style"
											onclick="salesProduct()"></th>
									</tr>
								</table>
