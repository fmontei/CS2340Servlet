<%@ page import="model.Attributes" %>
<%
	session.setAttribute("userid", Attributes.getAttribute(Attributes.CURRENT_USER));
	response.sendRedirect("index.jsp");
%>