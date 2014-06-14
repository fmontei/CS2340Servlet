<%@ page import="model.UserAccount" %>
<%
  UserAccount currentUser = (UserAccount) request.getSession().getAttribute("currentUser");
  session.setAttribute("userid", currentUser);
  response.sendRedirect("index.jsp");
%>