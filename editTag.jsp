<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Tag</title>
</head>
<body>
    <h1>Edit Tag: <%= request.getParameter("tagName") %></h1>
    
    <%-- Retrieve the tag name from the request --%>
    <%
        String tagName = request.getParameter("tagName");

        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");
            
            // Establish connection
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "admin");

            // Fetch tag details for editing
            String sql = "SELECT * FROM questions WHERE tag = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, tagName);
            ResultSet rs = pstmt.executeQuery();

            // Assuming there is only one tag and loop through the results
            if (rs.next()) {
                // Retrieve existing question and options
                int questionId = rs.getInt("id");
                String question = rs.getString("question");
                String option1 = rs.getString("option1");
                String option2 = rs.getString("option2");
                String option3 = rs.getString("option3");
                String option4 = rs.getString("option4");
                String correctAnswer = rs.getString("correctAnswer");
    %>
                <form action="updateQuestion.jsp" method="post">
                    <input type="hidden" name="questionId" value="<%= questionId %>">
                    <label for="question">Question:</label><br>
                    <textarea id="question" name="question" rows="4" cols="50" required><%= question %></textarea><br><br>
                    <label for="option1">Option 1:</label>
                    <input type="text" id="option1" name="option1" value="<%= option1 %>" required><br><br>
                    <label for="option2">Option 2:</label>
                    <input type="text" id="option2" name="option2" value="<%= option2 %>" required><br><br>
                    <label for="option3">Option 3:</label>
                    <input type="text" id="option3" name="option3" value="<%= option3 %>" required><br><br>
                    <label for="option4">Option 4:</label>
                    <input type="text" id="option4" name="option4" value="<%= option4 %>" required><br><br>
                    <label for="correctAnswer">Correct answer:</label>
                    <input type="text" id="correctAnswer" name="correctAnswer" value="<%= correctAnswer %>" required><br><br>
                    <input type="submit" value="Save Changes">
                </form>
    <%
            }

            conn.close();
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    %>
</body>
</html>