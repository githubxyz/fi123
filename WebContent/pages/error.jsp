<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<ul>
	<% Collection<String> errors=(Collection<String>) request.getAttribute("errors");
	for(Iterator it=errors.iterator();it.hasNext();){
		String error=(String)it.next();
	
	%>
	<li style="color:red"><%=error %></li>
	<%} %>
</ul>