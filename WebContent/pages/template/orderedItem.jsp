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