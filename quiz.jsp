<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ include file="Header.jsp" %>
<!DOCTYPE html>

<html>
<head>
    <title>Select Tags for Quiz</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
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
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #f8f9fa;
            color: #333;
        }
        .container {
            margin-top: 50px;
        }
        .card {
            border: none;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .card-header, .btn-primary {
            background-color: #ff5722;
            color: #fff;
        }
        .btn-primary:hover {
            background-color: #e64a19;
        }
        .form-control:focus {
            border-color: #ff5722;
            box-shadow: 0 0 0 0.2rem rgba(255, 87, 34, 0.25);
        }
        .dur {
            color: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="card mx-auto" style="max-width: 600px;">
            <div class="card-header text-center">
                <h1>Select Tag for Quiz</h1>
                <%-- Display current user's name --%>
                <% HttpSession currentSession = request.getSession(false); // Retrieve existing session
                   if (currentSession != null && currentSession.getAttribute("userName") != null) {
                       out.println("<p>Welcome, " + currentSession.getAttribute("userName") + "</p>");
                   }
                %>
            </div>
            <div class="card-body">
                <form action="QuizAttempt.jsp" method="post">
                    <div class="form-group">
                        <label>Select Tag:</label><br>
                        <% 
                            Connection conn = null;
                            PreparedStatement pstmt = null;
                            ResultSet rs = null;
                            
                            try {
                                // Define database connection parameters
                                String jdbcUrl = "jdbc:oracle:thin:@localhost:1521:xe";
                                String dbUsername = "system";
                                String dbPassword = "admin";
                                
                                // Load Oracle JDBC driver
                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                
                                // Establish connection
                                conn = DriverManager.getConnection(jdbcUrl, dbUsername, dbPassword);
                                
                                // Query to fetch distinct tags from questions table
                                String sql = "SELECT DISTINCT tag FROM questions";
                                pstmt = conn.prepareStatement(sql);
                                rs = pstmt.executeQuery();
                                
                                // Iterate through result set and display radio buttons for each tag
                                while (rs.next()) {
                                    String tag = rs.getString("tag");
                        %>
                        <div class="form-check">
                            <input type="radio" name="tag" value="<%= tag %>" class="form-check-input" id="tag_<%= tag %>">
                            <label class="form-check-label" for="tag_<%= tag %>"><%= tag %></label><br>
                        </div>
                        <%
                                }
                            } catch (ClassNotFoundException | SQLException e) {
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
                        %>
                        
                     <p><strong>Note : </strong><span class="dur">The Quiz duration is 60 seconds</span></p>
                    </div>
                    <button type="submit" class="btn btn-primary w-100">Start Quiz</button>
                </form>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>
