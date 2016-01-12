<%@page import="com.ims.utility.Messages"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ims.utility.ISessionAttribute"%>
<%@page import="com.ims.dto.SaleItemDTO"%>
<%@page import="java.util.List"%>
<%
List<SaleItemDTO> saleItemDTOs=(List<SaleItemDTO>) session.getAttribute(ISessionAttribute.SALE_ITEM_LIST);
double totalWithVat=0.0;
double totalVat=0.0;
if(saleItemDTOs!=null && saleItemDTOs.size()>0){
%>

<table width=100%>
	<tr bgcolor="#67a0f5">
		<td width=30%>Item</td>
		<td width=20%>Item Weight</td>
		<td width=20%>Rate</td>
		<td width=20%>Amount</td>
		<td width=10%>Edit</td>
	</tr>
	<%
	
	for (Iterator it = saleItemDTOs.iterator(); it.hasNext();) {
		SaleItemDTO saleItemDTO=(SaleItemDTO)it.next();
	%>
	<tr>
	<td bgcolor="skyblue"><%=saleItemDTO.getProductMaster().getProductName() %></td>
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
	<td bgcolor="#cccccc"><%=mesure %> &nbsp;<%=(onlyQuantity?saleItemDTO.getProductMaster().getQty_unit():saleItemDTO.getProductMaster().getWeight_unit()) %></td>
	<td bgcolor="skyblue"><%=saleItemDTO.getUnitPrice() %></td>
	<% 
	totalWithVat+=(mesure*saleItemDTO.getUnitPrice()+((mesure*saleItemDTO.getUnitPrice()*saleItemDTO.getVatPercentage()))/100);
	totalVat+=(mesure*saleItemDTO.getUnitPrice()*saleItemDTO.getVatPercentage())/100;
	%>
	<td bgcolor="#cccccc"><%=(mesure*saleItemDTO.getUnitPrice()+((mesure*saleItemDTO.getUnitPrice()*saleItemDTO.getVatPercentage()))/100) %></td>
	<td bgcolor="skyblue"><img height="20px" align="right" alt="edit field" src="images/edit.png"/></td>
</tr>
	<%}%>
	</table>
	<% }%>
<form id="saleingDetail" name="SalesProduct" action="SalesProduct" method="post">

<table width=80%>
									<tr>
										<td>
										<input type="hidden" name="requestType" value="saleItem">
										<span class="label"><%=Messages.getString("product_vat_amount")%>
												:</span></td>
										<td><input type="text" name="vatAmount" value="<%=totalVat %>"
											class="input-text"></td>
										<td><span class="label"><%=Messages.getString("customer_vat_no")%>
												:</span></td>
										<td><input type="text" name="customerVatNo" value=""
											class="input-text"></td>

									</tr>
									<tr>
										<td><span class="label"><%=Messages.getString("sub_total_with_vat")%>
												:</span></td>
										<td><input type="text" name="totalWithVat" value="<%=totalWithVat %>"
											class="input-text" readonly="readonly"></td>
										<td><span class="label"><%=Messages.getString("company_buyer_name")%>
												:</span></td>
										<td><input type="text" name="customerName" value=""
											class="input-text"></td>	

									</tr>

									<tr>
										<td><span class="label"><%=Messages.getString("discount_over_total")%>:</span></td>
										<td><input type="number" step="0.1" name="discount" id="discount"  value="" class="input-text" onblur="getDiscount()"></td>
									</tr>
									<tr>
										<td><span class="label"><%=Messages.getString("product_total_cost")%>
												:</span></td>
										<td><input type="text" id="totalCost" value="<%=totalWithVat %>"
											class="input-text"></td>
									</tr>
									<tr>
										<th colspan="2" rowspan="2"><input type="submit"
											name="submit" value="Submit" class="btn-style"
											onclick="saleProduct()"></th>
									</tr>
								</table>
								</form>
