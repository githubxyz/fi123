<%@page import="com.ims.utility.IRequestAttribute"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ims.utility.ISessionAttribute"%>
<%@page import="com.ims.dto.PurchasePaymentInfoDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.ims.utility.Messages"%>
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

	</tr>
</thead>
<tbody>
<%
List<PurchasePaymentInfoDTO> purchasePaymentInfoDTOs = (List<PurchasePaymentInfoDTO>) request.getAttribute(IRequestAttribute.VENDOR_LIST);
			if (purchasePaymentInfoDTOs != null) {
				for (Iterator it = purchasePaymentInfoDTOs.iterator(); it.hasNext();) {
					PurchasePaymentInfoDTO purchasePayment = (PurchasePaymentInfoDTO) it.next();
		%>
<tr style="border: 1px solid #ccc !important;"
			onclick="editProduct(<%=purchasePayment.getId()%>)">
			<td align="center"><%=purchasePayment.getBillNo()%></td>
			<td align="center"><%=purchasePayment.getCompany_name()%></td>
		
</tr>
<%}} %>
</tbody>
</table>