
<%@page import="com.ims.dto.ProductMasterDTO"%>
<%@page import="com.ims.utility.IRequestAttribute"%>
<%@page import="com.ims.utility.Messages"%>
<%
ProductMasterDTO pm=(ProductMasterDTO)	request.getAttribute(IRequestAttribute.PRODUCT_MASTER);
%>
<input type="hidden" name="id" value="<%=pm.getId() %>"/>
<div class="inpu-div" style="width: 50%">
	<span class="label"> <%=Messages.getString("product_group_code")%>
		:
	</span><input type="text" name="productGroupCode" value='<%= (pm.getPrGroupMapDTO()!=null?pm.getPrGroupMapDTO().getCode():"") %>' class="input-text">
</div>
<div class="inpu-div" style="width: 50%">
	<span class="label"> <%=Messages.getString("product_name")%> :
	</span><input type="text" name="productName" value="<%=pm.getProductName() %>" class="input-text">
</div>
<div class="inpu-div" style="width: 50%">

	<span class="label"> <%=Messages.getString("product_code")%> :
	</span> <input type="text" name="productCode" value="<%=pm.getProductCode() %>" class="input-text">
</div>
<div class="inpu-div" style="width: 50%">

	<span class="label"> <%=Messages.getString("mesure_unit")%> :
	</span> <select name="unitOfMesure" class="input-text"
		onchange="fillSelect(this.value,this.form['unitType'])">
		<option value=" ">Select unit type..</option>
		<option value="1">Weight</option>
		<option value="2">Quantity</option>
		<option value="3">Both</option>
	</select>
</div>
<div class="inpu-div" style="width: 50%">

	<span class="label"> <%=Messages.getString("specific_unit")%> :
	</span> <select name="unitType" class="input-text">
		<option value=" ">Select unit..</option>

	</select>

</div>