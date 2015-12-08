<%@page import="java.util.Iterator"%>
<%@page import="com.ims.utility.IRequestAttribute"%>
<%@page import="com.ims.dto.ProductMasterDTO"%>
<%@page import="java.util.List"%>
<%
	List<ProductMasterDTO> productdtos2 = (List<ProductMasterDTO>) request
			.getAttribute(IRequestAttribute.PRODUCT_LIST);

%>

<select name="productMasterId" class="input-text" id="productMasterId" onchange="changeProduct()">

	<option value="0">Select</option>
	<%
		for (Iterator it = productdtos2.iterator(); it.hasNext();) {
			ProductMasterDTO productMasterDTO = (ProductMasterDTO) it.next();
			
	%>
	<option value="<%=productMasterDTO.getId()%>"><%=productMasterDTO.getProductName()%></option>
	<%
		}
	%>
</select>