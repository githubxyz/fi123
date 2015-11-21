<%@page import="com.ims.utility.IRequestAttribute"%>
<%@page import="com.ims.dto.ProductMasterDTO"%>
<%
							ProductMasterDTO productdto = (ProductMasterDTO) request
									.getAttribute(IRequestAttribute.PRODUCT_MASTER);
						%>
<select name="type">
	<option value="0">Select</option>
	<% if(productdto!=null && (productdto.isSub_item_type_req())){ %>
	<option value="1">Light</option>
	<option value="2">Medium</option>
	<option value="3">Heavy</option>
	<%} %>
</select>