<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Questions Form</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #fff3e0;
            color: #ef6c00;
            font-family: 'Arial', sans-serif;
        }
        .container {
            margin-top: 50px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }
        .container:hover {
            transform: scale(1.02);
        }
        .btn-custom {
            background-color: #ef6c00;
            color: #ffffff;
            transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
        }
        .btn-custom:hover {
            background-color: #e65100;
            color: #ffffff;
        }
        h1, h2 {
            color: #ef6c00;
        }
        .form-group label {
            font-weight: bold;
        }
        .form-group input, .form-group textarea {
            transition: border-color 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }
        .form-group input:focus, .form-group textarea:focus {
            border-color: #ef6c00;
            box-shadow: 0 0 5px rgba(239, 108, 0, 0.5);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1 class="text-center">Update Questions</h1>
        
        <%
            String tag = request.getParameter("tag");

            try {
                // Load Oracle JDBC driver
                Class.forName("oracle.jdbc.driver.OracleDriver");
                
                // Establish connection
                Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "admin");

                // Retrieve questions for the given tag
                String sql = "SELECT id, question, option1, option2, option3, option4, correctAnswer FROM questions WHERE tag = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, tag);
                ResultSet rs = pstmt.executeQuery();
                
                // Display questions in a form for editing
                if (rs.next()) {
        %>
                    <form action="updateQuestions.jsp" method="post">
                        <input type="hidden" name="tag" value="<%= tag %>">
                        <%
                            int questionCount = 0;
                            do {
                                int questionId = rs.getInt("id");
                                String question = rs.getString("question");
                                String option1 = rs.getString("option1");
                                String option2 = rs.getString("option2");
                                String option3 = rs.getString("option3");
                                String option4 = rs.getString("option4");
                                String correctAnswer = rs.getString("correctAnswer");
                                questionCount++;
                        %>
                                <h2>Question ID: <%= questionId %></h2>
                                <input type="hidden" name="questionId_<%= questionCount %>" value="<%= questionId %>">
                                <div class="form-group">
                                    <label for="question_<%= questionCount %>">Question:</label>
                                    <textarea class="form-control" id="question_<%= questionCount %>" name="question_<%= questionCount %>" rows="4" required><%= question %></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="option1_<%= questionCount %>">Option 1:</label>
                                    <input type="text" class="form-control" id="option1_<%= questionCount %>" name="option1_<%= questionCount %>" value="<%= option1 %>" required>
                                </div>
                                <div class="form-group">
                                    <label for="option2_<%= questionCount %>">Option 2:</label>
                                    <input type="text" class="form-control" id="option2_<%= questionCount %>" name="option2_<%= questionCount %>" value="<%= option2 %>" required>
                                </div>
                                <div class="form-group">
                                    <label for="option3_<%= questionCount %>">Option 3:</label>
                                    <input type="text" class="form-control" id="option3_<%= questionCount %>" name="option3_<%= questionCount %>" value="<%= option3 %>" required>
                                </div>
                                <div class="form-group">
                                    <label for="option4_<%= questionCount %>">Option 4:</label>
                                    <input type="text" class="form-control" id="option4_<%= questionCount %>" name="option4_<%= questionCount %>" value="<%= option4 %>" required>
                                </div>
                                <div class="form-group">
                                    <label for="correctAnswer_<%= questionCount %>">Correct answer:</label>
                                    <input type="text" class="form-control" id="correctAnswer_<%= questionCount %>" name="correctAnswer_<%= questionCount %>" value="<%= correctAnswer %>" required>
                                </div>
                                <hr>
                        <%
                            } while (rs.next());
                        %>
                        <input type="hidden" name="totalQuestions" value="<%= questionCount %>">
                        <div class="text-center">
                            <input type="submit" class="btn btn-custom" value="Update Questions">
                        </div>
                    </form>
        <%
                } else {
                    out.println("<p class='text-center'>No questions found for the tag: " + tag + "</p>");
                }

                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p class='text-center text-danger'>Error retrieving questions: " + e.getMessage() + "</p>");
            }
        %>
    </div>
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
