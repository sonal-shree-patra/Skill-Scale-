<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>Quiz Attempt</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css" integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e" crossorigin="anonymous" />
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
            color: #333;
        }
        .container {
            margin-top: 50px;
        }
        .countdown {
            font-size: 48px;
            font-weight: bold;
            text-align: center;
            margin-bottom: 20px;
        }
        .card {
            border: none;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .card-header {
            background-color: orange;
            color: #fff;
        }
        .btn-primary {
            background-color: orange;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .progress-bar {
            background-color: orange;
            border:3px solid orange;
            padding:0;
        }
        .btn_clear{
        	padding:5px;
        	background-color:grey;
        	border-radius:10px;
        	color:white;
        }
        .marks{
        	 font-style: italic;
        	 color:grey;
        	font-size:15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card">
            <div class="card-header text-center">
                <h1>Quiz Attempt</h1>
            </div>
            <div class="card-body">
                <div id="countdown" class="countdown">Your quiz starts in 3</div>
                <div class="progress" style="height: 4px; display: none;">
                    <div id="progressBar" class="progress-bar" role="progressbar" style="width: 100%;" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                </div>
                <form id="quizForm" action="QuizResult.jsp" method="post" style="display:none;">
                    <input type="hidden" name="selectedTag" value="<%= request.getParameter("tag") %>">
                    <% 
                        // Retrieve selected tag from form submission
                        String selectedTag = request.getParameter("tag");
                        
                        // Validate if a tag was selected
                        if (selectedTag == null || selectedTag.isEmpty()) {
                    %>
                        <p>Please select a tag to start the quiz.</p>
                        <form action="quiz.jsp">
                            <input type="submit" value="Go Back" class="btn btn-primary">
                        </form>
                    <% 
                        } else {
                            // Database connection parameters
                            String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:xe";
                            String dbUsername = "system";
                            String dbPassword = "admin";
                            
                            // Initialize variables
                            Connection conn = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;
                            
                            try {
                                // Load Oracle JDBC driver
                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                
                                // Establish connection
                                conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
                                
                                // Prepare SQL to fetch questions and options for selected tag
                                String sql = "SELECT id, question, option1, option2, option3, option4 FROM questions WHERE tag = ?";
                                pstmt = conn.prepareStatement(sql);
                                pstmt.setString(1, selectedTag);
                                
                                // Execute query to get questions and options
                                rs = pstmt.executeQuery();
                                
                                // Display questions and options
                                while (rs.next()) {
                                    int questionId = rs.getInt("id");
                                    String question = rs.getString("question");
                                    String option1 = rs.getString("option1");
                                    String option2 = rs.getString("option2");
                                    String option3 = rs.getString("option3");
                                    String option4 = rs.getString("option4");
                                    
                                    // Use unique name for radio buttons based on question id
                                    String radioGroupName = "answers_" + questionId;
                    %>  
                                    <div class="form-group">
                                        <p><%= question %> <span class="marks muted"><span style="color:red">*</span>1 mark</span></p>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="<%= radioGroupName %>" value="1_<%= option1 %>">
                                            <label class="form-check-label"><%= option1 %></label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="<%= radioGroupName %>" value="2_<%= option2 %>">
                                            <label class="form-check-label"><%= option2 %></label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="<%= radioGroupName %>" value="3_<%= option3 %>">
                                            <label class="form-check-label"><%= option3 %></label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="<%= radioGroupName %>" value="4_<%= option4 %>">
                                            <label class="form-check-label"><%= option4 %></label>
                                        </div>
                                        <button type="button" class="btn_clear" onclick="clearResponse('<%= radioGroupName %>')">Clear Response</button>
                                    </div>
                    <% 
                                }
                    %>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">Submit Answers</button>
                    </div>
                    <% 
                            } catch (Exception e) {
                                e.printStackTrace();
                                // Handle database errors
                                out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                            } finally {
                                // Close resources
                                try {
                                    if (rs != null) rs.close();
                                    if (pstmt != null) pstmt.close();
                                    if (conn != null) conn.close();
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                    out.println("<p class='text-danger'>Error closing database resources: " + e.getMessage() + "</p>");
                                }
                            }
                        }
                    %>
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

    <!-- Custom JS for Countdown and Clear Response -->
    <script>
        let countdownElement = document.getElementById('countdown');
        let quizForm = document.getElementById('quizForm');
        let progressBar = document.getElementById('progressBar');
        let countdownValue = 3;

        function startQuizCountdown() {
            if (countdownValue > 0) {
                countdownElement.innerHTML = "Your quiz starts in " + countdownValue;
                countdownValue--;
                setTimeout(startQuizCountdown, 1000);
            } else {
                countdownElement.innerHTML = '';
                document.querySelector('.progress').style.display = 'block';
                quizForm.style.display = 'block';
                startQuizTimer();
            }
        }

        function startQuizTimer() {
            let timer = 180; // Set your quiz duration in seconds
            let totalTime = timer;
            let timerInterval = setInterval(function() {
                let minutes = Math.floor(timer / 60);
                let seconds = timer % 60;
                countdownElement.innerHTML = minutes + ":" + (seconds < 10 ? "0" : "") + seconds;
                timer--;

                let width = (timer / totalTime) * 100; // Calculate the width as a percentage
                progressBar.style.width = width + '%';

                if (timer < 0) {
                    clearInterval(timerInterval);
                    quizForm.submit(); // Automatically submit the quiz when the timer is up
                }
            }, 1000);
        }

        function clearResponse(groupName) {
            let options = document.getElementsByName(groupName);
            for (let i = 0; i < options.length; i++) {
                options[i].checked = false;
            }
        }

        startQuizCountdown();
    </script>
</body>
</html>
