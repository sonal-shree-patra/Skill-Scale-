<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <script>
        function showQuestionForm() {
            document.getElementById("questionForm").style.display = "block";
        }
    </script>
</head>	
<body>
    <h1>Admin Dashboard</h1>
    <p>Welcome, <%= session.getAttribute("username") %></p>
    <button onclick="showQuestionForm()">Add Questions</button>
    
    <div id="questionForm" style="display:none;">
        <form action="addQuestions.jsp" method="post">
            <input type="hidden" name="username" value="<%= session.getAttribute("username") %>">
            <label for="tag">Tag:</label>
            <input type="text" id="tag" name="tag" required><br><br>
            <label for="numQuestions">No of questions:</label>
            <input type="number" id="numQuestions" name="numQuestions" required><br><br>
            <input type="submit" value="Submit">
        </form>
    </div>
</body>
</html>