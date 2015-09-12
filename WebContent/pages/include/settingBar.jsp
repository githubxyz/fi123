<%@page import="com.ims.dto.UserDTO"%>
<%@page import="com.ims.utility.ISessionAttribute"%>
<table width=100% style="background-color: #306cab">
			<tr>
			<td width=85%> <font color="#f59a1b" size="4">
			<% UserDTO dto = null;
			dto = (UserDTO)(session.getAttribute(ISessionAttribute.LOGGEDINUSER));
			%>
			Welcome <%=dto.getFirstName()%> <%=dto.getLastName() %>
			</font>
			</td>
			<td>  <font color="White">
			<h3><img src="../../ims/images/setting.png" height="35px" alt="Setting"> &nbsp;&nbsp; <img src="../../ims/images/logout.png" height="35px" alt="Logout">
				</h3> </font>
				</td>
			</tr>
			</table>