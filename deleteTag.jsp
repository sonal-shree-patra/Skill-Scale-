<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete Tag</title>
</head>
<body>
    <h1>Delete Tag</h1>
    
    <%-- Retrieve the tag name from the request --%>
    <%
        String tagName = request.getParameter("tagName");

        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            
            // Establish connection
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "admin");

            // Check if the tag exists before deleting
            String checkSql = "SELECT COUNT(*) as tagCount FROM questions WHERE tag = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, tagName);
            ResultSet checkRs = checkStmt.executeQuery();
            checkRs.next();
            int tagCount = checkRs.getInt("tagCount");

            if (tagCount > 0) {
                // Perform deletion
                String deleteSql = "DELETE FROM questions WHERE tag = ?";
                PreparedStatement pstmt = conn.prepareStatement(deleteSql);
                pstmt.setString(1, tagName);
                int rowsAffected = pstmt.executeUpdate();

                out.println("<p>Deleted  question(s) for tag: " + tagName + "</p>");
            } else {
                out.println("<p>No questions found for tag: " + tagName + "</p>");
            }

            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    %>
</body>
</html>