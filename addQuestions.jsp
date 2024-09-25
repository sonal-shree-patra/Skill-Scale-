<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<%@ include file="adminHeader.jsp" %>
<html>
<head>
    <title>Add Questions</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <style>
        body {
            padding-top: 20px;
        }
        .container {
            max-width: 800px;
        }
        .form-section {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div class="container animate__animated animate__fadeIn">
        <h1 class="text-center">Add Questions for <%= request.getParameter("tag") %></h1>
        <form action="submitQuestions.jsp" method="post">
            <input type="hidden" name="tag" value="<%= request.getParameter("tag") %>">
            <input type="hidden" name="numQuestions" value="<%= request.getParameter("numQuestions") %>">
            <%
                int numQuestions = Integer.parseInt(request.getParameter("numQuestions"));
                for (int i = 1; i <= numQuestions; i++) {
            %>
                <div class="form-section">
                    <h2>Question <%= i %>:</h2>
                    <div class="form-group">
                        <label for="question<%= i %>">Question:</label>
                        <textarea class="form-control" id="question<%= i %>" name="question<%= i %>" rows="4" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="option1_q<%= i %>">Option 1:</label>
                        <input type="text" class="form-control" id="option1_q<%= i %>" name="option1_q<%= i %>" required>
                    </div>
                    <div class="form-group">
                        <label for="option2_q<%= i %>">Option 2:</label>
                        <input type="text" class="form-control" id="option2_q<%= i %>" name="option2_q<%= i %>" required>
                    </div>
                    <div class="form-group">
                        <label for="option3_q<%= i %>">Option 3:</label>
                        <input type="text" class="form-control" id="option3_q<%= i %>" name="option3_q<%= i %>" required>
                    </div>
                    <div class="form-group">
                        <label for="option4_q<%= i %>">Option 4:</label>
                        <input type="text" class="form-control" id="option4_q<%= i %>" name="option4_q<%= i %>" required>
                    </div>
                    <div class="form-group">
                        <label for="correctAnswer_q<%= i %>">Correct answer:</label>
                        <input type="text" class="form-control" id="correctAnswer_q<%= i %>" name="correctAnswer_q<%= i %>" required>
                    </div>
                </div>
            <%
                }
            %>
            <div class="form-group">
                <label for="passMark">Pass Mark (%):</label>
                <input type="number" class="form-control" id="passMark" name="passMark" required>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
        </form>
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
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>
