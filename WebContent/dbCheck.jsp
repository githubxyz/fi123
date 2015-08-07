<%@page import="org.apache.log4j.Logger"%>
<%@page import="com.ims.utility.Messages"%>
<%@page import="com.ims.dto.UserDTO"%>
<%@page import="org.hibernate.Session"%>
<%@page import="com.ims.persistence.hibernate.PersistenceManagerImpl"%>
<%@page import="com.ims.persistence.hibernate.IPersistenceManager"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
 <%
 IPersistenceManager per=new PersistenceManagerImpl();
 Session ses= per.openSessionAndBeginTransaction();
 UserDTO user=(UserDTO)ses.load(UserDTO.class, 1);
   Logger logger = Logger.getLogger("com.biz");
   logger.info("gjk");
   Messages.getInstance("ims");
 %>
 <%=Messages.getString("company_name") %>
 <%=user %>
</body>
</html>