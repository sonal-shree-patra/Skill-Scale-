<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        h1 {
            margin-bottom: 20px;
        }
        table {
            width: 100%;
            margin-bottom: 20px;
        }
        th {
            background-color: #343a40;
            color: white;
        }
        .btn {
            margin-right: 5px;
        }
        .action-buttons form {
            display: inline;
        }
        #questionForm {
            background-color: #ffffff;
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
        }
        #questionForm input[type="text"],
        #questionForm input[type="number"],
        #questionForm input[type="submit"] {
            margin-bottom: 10px;
        }
        .fade-in {
            animation: fadeIn 1s;
        }
        .admin{
        	margin-right:40px !important;
        }
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
    <script>
        function showQuestionForm() {
            document.getElementById("questionForm").style.display = "block";
            document.getElementById("questionForm").classList.add("fade-in");
        }
    </script>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Admin Dashboard</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto admin">
                <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Welcome, <%= session.getAttribute("username") %>
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#"><button class="btn btn-primary" onclick="showQuestionForm()">Add Questions</button></a></li>
            <li><a class="dropdown-item" href="showQuizResults.jsp">Dashboard</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="adminlogout.jsp">Logout</a></li>
          </ul>
        </li>
            </ul>
        </div>
    </nav>

    <div id="questionForm" class="fade-in" style="display:none;">
        <form action="addQuestions.jsp" method="post">
            <input type="hidden" name="username" value="<%= session.getAttribute("username") %>">
            <div class="form-group">
                <label for="tag">Tag:</label>
                <input type="text" class="form-control" id="tag" name="tag" required>
            </div>
            <div class="form-group">
                <label for="numQuestions">No of questions:</label>
                <input type="number" class="form-control" id="numQuestions" name="numQuestions" required>
            </div>
            <input type="submit" class="btn btn-success" value="Submit">
        </form>
    </div>

    <h1 class="mt-5">Tags</h1>
    <table class="table table-striped table-hover">
        <thead class="thead-dark">
            <tr>
                <th>Serial Number</th>
                <th>Tag Name</th>
                <th>Number of Questions</th>
                <th>Number of People Took the Test</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Retrieve the username from the session
                String username = (String) session.getAttribute("username");
                if (username == null) {
                    response.sendRedirect("login.jsp");
                    return;
                }

                // Connect to the database
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "admin");

                    // Query to retrieve tag information including numPeopleTookTest
                    String sql = "SELECT q.tag, COUNT(q.tag) AS numQuestions, q.numPeopleTookTest AS numPeopleTookTest " +
                                 "FROM questions q " +
                                 "JOIN login l ON q.username = l.name " +
                                 "WHERE l.name = ? " +
                                 "GROUP BY q.tag, q.numPeopleTookTest";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, username);
                    rs = pstmt.executeQuery();

                    int serialNumber = 1; // Initialize serial number counter

                    // Iterate through result set and display tags
                    while (rs.next()) {
                        String tagName = rs.getString("tag");
                        int numQuestions = rs.getInt("numQuestions");
                        int numPeopleTookTest = rs.getInt("numPeopleTookTest");
            %>
            <tr>
                <td><%= serialNumber %></td>
                <td><%= tagName %></td>
                <td><%= numQuestions %></td>
                <td><%= numPeopleTookTest %></td>
                <td class="action-buttons">
                    <form action="updateQuestionsForm.jsp" method="post">
                        <input type="hidden" name="tag" value="<%= tagName %>">
                        <input type="submit" class="btn btn-warning" value="Update Questions">
                    </form>

                    <form action="deleteTag.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="tagName" value="<%= tagName %>">
                        <input type="submit" class="btn btn-danger" value="Delete" onclick="return confirm('Are you sure you want to delete this tag?');">
                    </form>
                </td>
            </tr>
            <% 
                        serialNumber++; // Increment serial number for the next row
                    }

                } catch (ClassNotFoundException | SQLException e) {
                    out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
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

    <div class="text-center">
        <form action="showQuizResults.jsp" method="post">
            <input type="submit" class="btn btn-info" value="View Quiz Results">
        </form>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
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
