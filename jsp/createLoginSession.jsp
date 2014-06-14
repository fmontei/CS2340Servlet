<%@ page import="model.UserAccount" %>
<%
  ServletContext appContext = request.getServletContext();
  UserAccount currentUser = (UserAccount) appContext.getAttribute("currentUser");
  session.setAttribute("userid", currentUser);
  response.sendRedirect("index.jsp");
%>