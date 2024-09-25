<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Submit Questions</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .toast-success {
            position: fixed;
            top: 20px;
            right: 20px;
            min-width: 200px;
            z-index: 1050;
        }
    </style>
</head>
<body>
    <%
        String tag = request.getParameter("tag");
        int numQuestions = Integer.parseInt(request.getParameter("numQuestions"));
        int passMark = Integer.parseInt(request.getParameter("passMark"));

        // Retrieve the username from the session
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        boolean questionsAdded = false;

        try {
            // Load Oracle JDBC driver
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // Establish connection
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "admin");

            // Retrieve the admin name from the login_admin table using the username
            String nameSql = "SELECT name FROM login WHERE name = ?";
            PreparedStatement nameStmt = conn.prepareStatement(nameSql);
            nameStmt.setString(1, username);
            ResultSet nameRs = nameStmt.executeQuery();
            nameRs.next();
            String adminName = nameRs.getString("name");

            // Iterate through each question
            for (int i = 1; i <= numQuestions; i++) {
                String question = request.getParameter("question" + i);
                String option1 = request.getParameter("option1_q" + i);
                String option2 = request.getParameter("option2_q" + i);
                String option3 = request.getParameter("option3_q" + i);
                String option4 = request.getParameter("option4_q" + i);
                String correctAnswer = request.getParameter("correctAnswer_q" + i);

                // Ensure at least one question is provided
                if (question == null || question.isEmpty() ||
                    option1 == null || option1.isEmpty() ||
                    option2 == null || option2.isEmpty() ||
                    option3 == null || option3.isEmpty() ||
                    option4 == null || option4.isEmpty() ||
                    correctAnswer == null || correctAnswer.isEmpty()) {
                    continue;
                }

                // Retrieve the next value from the sequence for id
                String idSql = "SELECT questions_seq.NEXTVAL FROM dual";
                Statement idStmt = conn.createStatement();
                ResultSet idRs = idStmt.executeQuery(idSql);
                idRs.next();
                int newId = idRs.getInt(1);  // Get the next sequence value

                // Retrieve the current highest serial number for the tag
                String serialSql = "SELECT COALESCE(MAX(serialNumber), 0) + 1 AS newSerialNumber FROM questions WHERE tag = ?";
                PreparedStatement serialStmt = conn.prepareStatement(serialSql);
                serialStmt.setString(1, tag);
                ResultSet rs = serialStmt.executeQuery();
                rs.next();
                int newSerialNumber = rs.getInt("newSerialNumber");

                // SQL statement to insert a question
                String sql = "INSERT INTO questions (id, tag, serialNumber, question, option1, option2, option3, option4, correctAnswer, username, passmark) " +
                             "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

                // Prepare statement
                PreparedStatement pstmt = conn.prepareStatement(sql);

                // Set parameters for the question
                pstmt.setInt(1, newId);  // Use the generated id
                pstmt.setString(2, tag);
                pstmt.setInt(3, newSerialNumber);  // Assign the new serial number
                pstmt.setString(4, question);
                pstmt.setString(5, option1);
                pstmt.setString(6, option2);
                pstmt.setString(7, option3);
                pstmt.setString(8, option4);
                pstmt.setString(9, correctAnswer);
                pstmt.setString(10, adminName);
                pstmt.setInt(11, passMark);

                // Execute the insert statement
                pstmt.executeUpdate();
                questionsAdded = true;
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error adding questions: " + e.getMessage() + "</p>");
        }
    %>

    <% if (questionsAdded) { %>
        <div class="toast toast-success" data-delay="500">
            <div class="toast-header">
                <strong class="mr-auto text-success">Success</strong>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
            </div>
            <div class="toast-body">
                Questions added successfully!
            </div>
        </div>
    <% } else { %>
        <div class="toast toast-success" data-delay="500">
            <div class="toast-header">
                <strong class="mr-auto text-danger">Error</strong>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
            </div>
            <div class="toast-body">
                No valid questions were provided. Please add at least one question.
            </div>
        </div>
    <% } %>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function(){
            $('.toast').toast('show');

            // Redirect to displayTags.jsp after the toast disappears
            $('.toast').on('hidden.bs.toast', function () {
                window.location.href = 'displayTags.jsp';
            });
        });
    </script>
</body>
</html>
