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
<table width="100%">
 <tbody>
  <tr>
   <td width="15%"><span class="label">
 <%=Messages.getString("purchase_ref_id")%>
 :
 </span></td>
 <td width="15%">
 <input type="text"
  name="billNo" value="<%=paymentInfoDTO.getBillNo()%>" />
</td>  
<td width="15%"><span class="label">
 <%=Messages.getString("vendor_name")%>
 :
 </span></td><td width="15%">
 <input type="text"
  name="company_name" value="<%=paymentInfoDTO.getCompany_name()%>" />
  </td>
 <th width="80px" rowspan="4" colspan="2"><div
              class="error-div" id="saveMasterError"></div></th>
           </tr>
           <tr>
            <td><span class="label"> 
 <%=Messages.getString("vendor_payment")%>
 :
            </span></td><td>
 <input type="number" step="any"
  name="payment" value="<%=paymentInfoDTO.getPayment()%>" /> </td>
 <td><span class="label">
 <%=Messages.getString("vendor_balance")%> 
 :
            </span></td><td>
 <input type="number" step="any" name="balance" value="<%=paymentInfoDTO.getBalance() %>"> </td></tr><tr>
 <td><span class="label">
 <%=Messages.getString("vendor_advance")%> :
 </span></td><td>
 <input type="number" step="any"
  name="advance" value="<%=paymentInfoDTO.getAdvance()%>" />
</td></tr><tr><th colspan="4">
  <input
  type="submit" name="save"></th></tr></tbody></table>
</form>