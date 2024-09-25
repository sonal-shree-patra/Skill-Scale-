<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<% HttpSession currentsession = request.getSession(false); // Retrieve existing session
   if (session != null) {
       session.invalidate(); // Invalidate the session
   }
%>

<!-- Redirect to login page -->
<% response.sendRedirect("login.jsp"); %>
