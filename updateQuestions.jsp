<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Questions</title>
</head>
<body>
    <h1>Update Questions</h1>
    
    <%-- Retrieve parameters from the request --%>
    <%
        String tag = request.getParameter("tag");
        int totalQuestions = Integer.parseInt(request.getParameter("totalQuestions"));

        try {
           
            Class.forName("oracle.jdbc.driver.OracleDriver");
            
           
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "admin");

            
            int questionsUpdated = 0;

            for (int i = 1; i <= totalQuestions; i++) {
                int questionId = Integer.parseInt(request.getParameter("questionId_" + i));
                String question = request.getParameter("question_" + i);
                String option1 = request.getParameter("option1_" + i);
                String option2 = request.getParameter("option2_" + i);
                String option3 = request.getParameter("option3_" + i);
                String option4 = request.getParameter("option4_" + i);
                String correctAnswer = request.getParameter("correctAnswer_" + i);


                String sql = "UPDATE questions SET question = ?, option1 = ?, option2 = ?, option3 = ?, option4 = ?, correctAnswer = ? WHERE id = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, question);
                pstmt.setString(2, option1);
                pstmt.setString(3, option2);
                pstmt.setString(4, option3);
                pstmt.setString(5, option4);
                pstmt.setString(6, correctAnswer);
                pstmt.setInt(7, questionId);

                int rowsUpdated = pstmt.executeUpdate();
                if (rowsUpdated > 0) {
                    questionsUpdated++;
                }
            }

            conn.close();


            if (questionsUpdated > 0) {
                out.println("<p>"+" questions updated successfully!</p>");
            } else {
                out.println("<p>No questions were updated. Please provide valid data for at least one question.</p>");
            }
        } catch (ClassNotFoundException e) {
            out.println("<p>Error loading Oracle JDBC driver: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } catch (SQLException e) {
            out.println("<p>Error connecting to database or executing SQL: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } catch (NumberFormatException e) {
            out.println("<p>Error parsing question ID: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } catch (Exception e) {
            out.println("<p>General error updating questions: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    %>
</body>
</html>