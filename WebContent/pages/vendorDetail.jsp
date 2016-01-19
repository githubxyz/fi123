
<%@page import="com.ims.dto.PurchasePaymentInfoDTO"%>
<%@page import="com.ims.utility.IRequestAttribute"%>
<%@page import="com.ims.utility.Messages"%>
<%
	PurchasePaymentInfoDTO paymentInfoDTO = (PurchasePaymentInfoDTO) request
			.getAttribute(IRequestAttribute.EDIT_VENDOR_DETAIL);
%>
<form id="vendorDetailForm" action="vendorInfo" method="post">

	<input type="hidden" name="id" value="<%=paymentInfoDTO.getId()%>" />
	<input type="hidden" name="type" value="save" />
	<%=Messages.getString("purchase_ref_id")%><input type="text" 
		name="billNo" value="<%=paymentInfoDTO.getBillNo()%>" /> <br>
	<%=Messages.getString("vendor_name")%><input type="text"
		name="company_name" value="<%=paymentInfoDTO.getCompany_name()%>" />
	<br>
	<%=Messages.getString("vendor_payment")%><input type="number" step="any"
		name="payment" value="<%=paymentInfoDTO.getPayment()%>" /> <br>
	<%=Messages.getString("vendor_balance")%> 
	<input type="number" step="any" name="balance" value="<%=paymentInfoDTO.getBalance() %>"> <br>
	<%=Messages.getString("vendor_advance")%><input type="number" step="any"
		name="advance" value="<%=paymentInfoDTO.getAdvance()%>" /> <input
		type="submit" name="save">
</form>