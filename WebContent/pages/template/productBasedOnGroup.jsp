<%@page import="com.ims.dto.ProductGroupMapDTO"%>
<%@page import="java.util.Iterator"%>
<%@page import="com.ims.dto.ProductMasterDTO"%>
<%@page import="com.ims.dto.ProductDetailDTO"%>
<%@page import="com.ims.utility.IRequestAttribute"%>
<%@page import="java.util.List"%>
<%
	List<ProductMasterDTO> productdtos2 = (List<ProductMasterDTO>) request
			.getAttribute(IRequestAttribute.PRODUCT_LIST);
ProductMasterDTO productdtos1 = (ProductMasterDTO) request
.getAttribute(IRequestAttribute.PRODUCT_MASTER);
%>
<select name="prodId" class="input-text" id="prodId"
	onchange="changeProduct()">

	<option value="0">Select</option>
	<%
		for (Iterator it = productdtos2.iterator(); it.hasNext();) {
			ProductMasterDTO productMasterDTO = (ProductMasterDTO) it.next();
			if(productMasterDTO.getPrGroupMapDTO().getId()==productdtos1.getPrGroupMapDTO().getId()){
	%>
	<option value="<%=productMasterDTO.getId()%>"><%=productMasterDTO.getProductName()%></option>
	<%
		}}
	%>
</select>