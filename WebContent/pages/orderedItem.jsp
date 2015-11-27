
<%@page import="com.ims.utility.Messages"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ims.utility.ISessionAttribute"%>
<%@page import="com.ims.dto.SaleItemDTO"%>
<%@page import="java.util.List"%>
<%
List<SaleItemDTO> saleItemDTOs=(List<SaleItemDTO>) session.getAttribute(ISessionAttribute.SALE_ITEM_LIST);
if(saleItemDTOs!=null && saleItemDTOs.size()>0){
%>
<div class="rcorners"
					style="margin-bottom: 20px; height: 180px; border-color: #cccccc">
<table width=100% hight="180px" ><tr><td width=50%>
<table width=100%>
	<tr bgcolor="#67a0f5">
		<td width=30%>Item</td>
		<td width=20%>Quantity</td>
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
	<td bgcolor="#cccccc"><%=(mesure*saleItemDTO.getUnitPrice()) %></td>
	<td bgcolor="skyblue"><img height="20px" align="right" alt="edit field" src="images/edit.png"/></td>
</tr>
	<%}
	
	}%>
</table>
</td><td width=50%>
<table width=100%>
									<tr>
										<td><span class="label"><%=Messages.getString("product_vat_amount")%>
												:</span></td>
										<td><input type="text" name="vatAmount" value=""
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
									
								</table>
</td></tr></table></div>
