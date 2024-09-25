<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Results</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Quiz Results</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Result</th>
                <th>Attempt Date</th>
                <th>Total Score</th>
                <th>Tag Name</th>
                <th>User Name</th>
                
            </tr>
        </thead>
        <tbody>
            <% 
                // Connect to the database
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "admin");

                    // Query to retrieve quiz results
                    String sql = "SELECT  * FROM dashboard";
                    pstmt = conn.prepareStatement(sql);
                    rs = pstmt.executeQuery();

                    // Iterate through result set and display quiz results
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String result = rs.getString("result");
                        Date attemptDate = rs.getDate("attempt_date");
                        int totalScore = rs.getInt("total_score");
                        String tagName = rs.getString("tag");

                        String userName = rs.getString("name");
            %>
            <tr>
                
                <td><%= id %></td>
                <td><%= result %></td>
                <td><%= attemptDate %></td>
                <td><%= totalScore %></td>
                <td><%= tagName %></td> 
                <td><%= userName %></td>
                </tr>
            <% 
                    }

                } catch (ClassNotFoundException | SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    // Close resources
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </tbody>
    </table>
</body>
</html>