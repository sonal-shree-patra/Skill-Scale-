<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    Class.forName("oracle.jdbc.OracleDriver");
    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "admin");
    
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    ps = conn.prepareStatement("SELECT name FROM login WHERE name=? AND password=?");
    ps.setString(1, username);
    ps.setString(2, password);
    
    rs = ps.executeQuery();
    
    if (rs.next()) {
        session.setAttribute("username", username);
        response.sendRedirect("displayTags.jsp");
    } else {
        out.println("Invalid login credentials.");
    }
} catch (ClassNotFoundException e) {
    e.printStackTrace();
    out.println("Error: unable to load database driver.");
} catch (SQLException e) {
    e.printStackTrace();
    out.println("Error: unable to execute SQL query.");
} finally {
    try {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (conn != null) conn.close();
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Error: unable to close database resources.");
    }
}
%>
