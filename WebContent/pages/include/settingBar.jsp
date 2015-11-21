<%@page import="com.ims.utility.Messages"%>
<%@page import="com.ims.dto.UserDTO"%>
<%@page import="com.ims.utility.ISessionAttribute"%>
<table width=100% style="">
			<tr>
			<td width=95%> <font color="#f59a1b" size="4">
			<% UserDTO dto = null;
			dto = (UserDTO)(session.getAttribute(ISessionAttribute.LOGGEDINUSER));
			%>
			<%=Messages.getString("company_welcome") %> <%=dto.getFirstName()%> <%=dto.getLastName() %>
			</font>
			</td>
			<td>  <font color="#f59a1b" size="3" align="right"><b><i>Logout</i></b>
			
			<!-- <h3><img src="images/setting.png" height="35px" alt="Setting"> &nbsp;&nbsp; <img src="images/logout.png" height="35px" alt="Logout">
				</h3> --> </font>
				</td>
			</tr>
			</table>