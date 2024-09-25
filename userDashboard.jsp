<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.List, java.util.ArrayList, com.fasterxml.jackson.databind.ObjectMapper, com.fasterxml.jackson.core.JsonProcessingException" %>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
      crossorigin="anonymous"
    />
    
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.2/font/bootstrap-icons.css"
      integrity="sha384-b6lVK+yci+bfDmaY1u0zE8YYJt0TZxLEAFyYSLHId4xoVvsrQu3INevFKo+Xir8e"
      crossorigin="anonymous"
    />
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
        }
        .container {
            margin-top: 20px;
            animation: fadeIn 1s ease-in-out;
        }
        h2 {
            text-align: center;
            color: #ff6600;
            margin-bottom: 40px;
        }
        .card-deck .card {
            margin-bottom: 30px;
        }
        .card-deck .card {
            margin: 15px;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Your Quiz Results</h2>
        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Total Scores by Quiz</h5>
                        <canvas id="totalScoresChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Quiz Attempts Breakdown</h5>
                        <canvas id="quizAttemptsChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <% 
                // Database connection parameters
                String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:xe";
                String dbUsername = "system";
                String dbPassword = "admin";

                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                List<String> quizLabels = new ArrayList<>();
                List<Integer> totalScores = new ArrayList<>();
                List<String> tagNames = new ArrayList<>();
                
                // Initialize passedCount and failedCount variables
                int passedCount = 0;
                int failedCount = 0;

                try {
                    // Load Oracle JDBC driver
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    
                    // Establish connection
                    conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);

                    // Query to join dashboard and users_register tables
                    String sql = "SELECT d.*, u.name AS user_name " +
                                 "FROM dashboard d " +
                                 "JOIN users_register u ON d.name = u.name " +
                                 "WHERE u.name = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, (String) session.getAttribute("userName"));
                   
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String result = rs.getString("result");
                        Date attemptDate = rs.getDate("attempt_date");
                        int totalScore = rs.getInt("total_score");
                        String tagName = rs.getString("tag");
                        String userName = rs.getString("user_name");

                        // Count passed and failed quizzes
                        if ("Pass".equalsIgnoreCase(result)) {
                            passedCount++;
                        } else {
                            failedCount++;
                        }

                        quizLabels.add("Quiz " + id);
                        totalScores.add(totalScore);
                        tagNames.add(tagName);
            %>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Quiz ID: <%= id %></h5>
                        <p class="card-text"><strong>Result:</strong> <%= result %></p>
                        <p class="card-text"><strong>Attempt Date:</strong> <%= attemptDate %></p>
                        <p class="card-text"><strong>Total Score:</strong> <%= totalScore %></p>
                        <p class="card-text"><strong>Tag:</strong> <%= tagName %></p>
                        <p class="card-text"><strong>User Name:</strong> <%= userName %></p>
                    </div>
                </div>
            </div>
            <% 
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            // Dynamic data for charts from the server
            const quizLabels = <%= new ObjectMapper().writeValueAsString(quizLabels) %>;
            const totalScores = <%= new ObjectMapper().writeValueAsString(totalScores) %>;
            const passedCount = <%= passedCount %>;
            const failedCount = <%= failedCount %>;

            const totalScoresData = {
                labels: quizLabels,
                datasets: [{
                    label: 'Total Scores',
                    data: totalScores,
                    backgroundColor: quizLabels.map((_, index) => {
                        const colors = ['rgba(255, 99, 132, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 206, 86, 0.2)'];
                        return colors[index % colors.length];
                    }),
                    borderColor: quizLabels.map((_, index) => {
                        const colors = ['rgba(255, 99, 132, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)'];
                        return colors[index % colors.length];
                    }),
                    borderWidth: 1
                }]
            };

            const quizAttemptsData = {
                labels: ['Passed', 'Failed'],
                datasets: [{
                    label: '# of Attempts',
                    data: [passedCount, failedCount],
                    backgroundColor: ['rgba(75, 192, 192, 0.2)', 'rgba(255, 99, 132, 0.2)'],
                    borderColor: ['rgba(75, 192, 192, 1)', 'rgba(255, 99, 132, 1)'],
                    borderWidth: 1
                }]
            };

            const totalScoresChart = new Chart(document.getElementById('totalScoresChart'), {
                type: 'bar',
                data: totalScoresData,
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });

            const quizAttemptsChart = new Chart(document.getElementById('quizAttemptsChart'), {
                type: 'pie',
                data: quizAttemptsData
            });
        </script>
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
    </div>
</body>
</html>
