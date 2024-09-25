<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Result</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous"/>
    <style>
        #chartContainer {
            width: 80%;
            height: 80%;
            margin: auto;
        }
        .quiz-div{
            margin:20px;
            gap:20px;
        }
        .sub1-div{
            box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
            padding:15px;
            border-radius:20px;
            margin:5px;
        }
        .result-pass {
            color: green;
        }
        .result-fail {
            color: red;
        }
    </style>
</head>
<body>
    <div class="container quiz-div" >
        <div class="row">
            <div class="col-md-6 sub1-div">
                <h1>Quiz Result</h1>

                <%!
                    // Method to get question text based on questionId
                    String getQuestionText(Connection conn, int questionId) throws SQLException {
                        String questionText = null;
                        String sql = "SELECT question FROM questions WHERE id = ?";
                        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                            pstmt.setInt(1, questionId);
                            ResultSet rs = pstmt.executeQuery();
                            if (rs.next()) {
                                questionText = rs.getString("question");
                            }
                        }
                        return questionText;
                    }

                    // Method to get option text based on questionId and option number
                    String getOptionText(Connection conn, int questionId, int optionNumber) throws SQLException {
                        String optionText = null;
                        String sql = "SELECT option" + optionNumber + " FROM questions WHERE id = ?";
                        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                            pstmt.setInt(1, questionId);
                            ResultSet rs = pstmt.executeQuery();
                            if (rs.next()) {
                                optionText = rs.getString(1);
                            }
                        }
                        return optionText;
                    }
                %>

                <%
                    // Retrieve selected tag from form submission
                    String selectedTag = request.getParameter("selectedTag");
                    
                    String userName = (String) session.getAttribute("userName");

                    if (selectedTag == null || selectedTag.isEmpty()) {
                %>
                    <p>Error: No tag selected for quiz.</p>
                    <form action="quiz.jsp">
                        <input type="submit" value="Go Back">
                    </form>
                <%
                    } else {
                        // Database connection parameters
                        String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:xe";
                        String dbUsername = "system";
                        String dbPassword = "admin";
                        
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        try {
                            // Load Oracle JDBC driver
                            Class.forName("oracle.jdbc.driver.OracleDriver");
                            
                            // Establish connection
                            conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

                            // Prepare SQL to fetch correct answers for selected tag
                            String sql = "SELECT id, correctAnswer, passmark FROM questions WHERE tag = ?";
                            pstmt = conn.prepareStatement(sql);
                            pstmt.setString(1, selectedTag);
                            
                            // Execute query to get correct answers
                            rs = pstmt.executeQuery();
                            
                            // Retrieve passmark
                            int passmark = 0;
                            if (rs.next()) {
                                passmark = rs.getInt("passmark");
                            }

                            // Map to store correct answers (questionId -> correctAnswer)
                            Map<Integer, String> correctAnswers = new HashMap<>();
                            
                            do {
                                int questionId = rs.getInt("id");
                                String correctAnswer = rs.getString("correctAnswer");
                                correctAnswers.put(questionId, correctAnswer);
                            } while (rs.next());

                            int correctCount = 0;
                            int totalQuestions = correctAnswers.size();
                            
                            // Iterate through request parameters to check answers
                            Enumeration<String> parameterNames = request.getParameterNames();
                            while (parameterNames.hasMoreElements()) {
                                String paramName = parameterNames.nextElement();
                                if (paramName.startsWith("answers_")) {
                                    int questionId = Integer.parseInt(paramName.substring("answers_".length()));
                                    String userAnswer = request.getParameter(paramName);
                                    int userOptionNumber = Integer.parseInt(userAnswer.split("_")[0]);
                                    String userOptionText = userAnswer.split("_")[1];
                                    String correctAnswer = correctAnswers.get(questionId);
                                    String correctAnswerText = getOptionText(conn, questionId, Integer.parseInt(correctAnswer));

                                    if (userAnswer != null && userOptionNumber != Integer.parseInt(correctAnswer)) {
                                        out.println("<p><b>Question:</b> " + getQuestionText(conn, questionId) + "</p>");
                                        out.println("<p><b>Your Answer:</b> " + userOptionText + "</p>");
                                        out.println("<p><b>Correct Answer:</b> " + correctAnswerText + "</p>");
                                        out.println("<hr>");
                                    } else {
                                        correctCount++;
                                    }
                                }
                            }

                            out.println("<p>Number of correct answers: " + correctCount + "</p>");

                            // Calculate percentage and determine pass/fail
                            double percentage = (double) correctCount / totalQuestions * 100;
                            String result = percentage >= passmark ? "Pass" : "Fail";
                            String resultClass = result.equals("Pass") ? "result-pass" : "result-fail";
                            out.println("<p>Your Score: " + percentage + "%</p>");
                            
                            out.println("<h2 class='" + resultClass + "'>Result: " + result + "</h2>");

                            if (result.equals("Fail")) {
                                out.println("<p class='result-fail'>You did not pass the quiz. Please try again. <button class='btn btn-primary'><a href='quiz.jsp' class='text-white' style='text-decoration:none'>Go to Quiz <i class='fa-solid fa-arrow-right'></i></a></button></p>");
                            }

                            // Store the result in the dashboard table with selectedTag
                            String insertResultSql = "INSERT INTO dashboard (id, name, result, attempt_date, total_score, tag) VALUES (dashboard_seq.nextval, ?, ?, ?, ?, ?)";
                            try (PreparedStatement insertPstmt = conn.prepareStatement(insertResultSql)) {
                                insertPstmt.setString(1, userName);
                                insertPstmt.setString(2, result);
                                insertPstmt.setDate(3, new java.sql.Date(System.currentTimeMillis())); // Current date
                                insertPstmt.setInt(4, correctCount); // Total score based on correct answers
                                insertPstmt.setString(5, selectedTag); // Selected tag
                                insertPstmt.executeUpdate();
                            } catch (SQLException e) {
                                e.printStackTrace();
                                out.println("<p>Error storing quiz result: " + e.getMessage() + "</p>");
                            }

                            // Update numpeopletooktest for questions related to the selected tag
                            // Update numpeopletooktest for questions related to the selected tag
								try {
								    String updateSql = "UPDATE questions SET numpeopletooktest = numpeopletooktest + 1 WHERE tag = ?";
								    try (PreparedStatement updatePstmt = conn.prepareStatement(updateSql)) {
								        updatePstmt.setString(1, selectedTag);
								        updatePstmt.executeUpdate();
								    }
								} catch (SQLException e) {
								    // Handle SQL exception
								    e.printStackTrace();
								    out.println("<p>Error updating numpeopletooktest: " + e.getMessage() + "</p>");
								}


                            // Display the chart
                %>
                <button class="btn btn-primary" style="color: white"><a style="color: white;text-decoration:none" href="userDashboard.jsp">Go to User Dashboard <i class="fa-solid fa-arrow-right"></i></a></button>
            </div>
            <div class="col-md-5 sub1-div">
                <div id="chartContainer">
                    <h2>Statistics</h2>
                    <canvas id="resultChart"></canvas>
                </div>
            </div>
        </div>
    </div>
    <script>
        var ctx = document.getElementById('resultChart').getContext('2d');
        var chart = new Chart(ctx, {
            type: 'pie',
            data: {
                labels: ['Correct Answers', 'Incorrect Answers'],
                datasets: [{
                    label: 'Quiz Result',
                    data: [<%= correctCount %>, <%= totalQuestions - correctCount %>],
                    backgroundColor: ['rgba(75, 192, 192, 0.2)', 'rgba(255, 99, 132, 0.2)'],
                    borderColor: ['rgba(75, 192, 192, 1)', 'rgba(255, 99, 132, 1)'],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                var label = context.label || '';
                                var value = context.raw || 0;
                                var total = context.dataset.data.reduce(function(a, b) { return a + b; }, 0);
                                var percentage = ((value / total) * 100).toFixed(2);
                                return label + ': ' + value + ' (' + percentage + '%)';
                            }
                        }
                    }
                }
            }
        });
    </script>
    <%
            } catch (Exception e) {
                e.printStackTrace();
                // Handle database errors
                out.println("<p>Error: " + e.getMessage() + "</p>");
            } finally {
                // Close resources
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Error closing database resources: " + e.getMessage() + "</p>");
                }
            }
        }
    %>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
     <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
      integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
      crossorigin="anonymous"
    ></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
      integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
      crossorigin="anonymous"
    ></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>
