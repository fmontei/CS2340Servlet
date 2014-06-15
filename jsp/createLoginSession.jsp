<%@ page import="model.UserAccount" %>
<%
    UserAccount currentUser = (UserAccount) session.getAttribute("currentUser");
	session.setAttribute("userid", currentUser);
	response.sendRedirect("index.jsp");
%>