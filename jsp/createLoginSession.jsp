<%@ page import="model.Attributes" %>
<%
	session.setAttribute("userid", Attributes.getAttribute(Attributes.WELCOME_NAME));
	response.sendRedirect("index.jsp");
%>