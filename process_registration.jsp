<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Registration</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .toast {
            position: fixed;
            top: 20px;
            right: 20px;
            min-width: 250px;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div id="toastContainer" aria-live="polite" aria-atomic="true">
            <!-- Toast will be dynamically added here -->
        </div>

        <%
            String name = request.getParameter("name");
            String mobileno = request.getParameter("mobileno");
            String password = request.getParameter("password");

            // Database connection details
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String dbUser = "system";
            String dbPassword = "admin";
            
            Connection conn = null;
            PreparedStatement pstmtCheck = null;
            PreparedStatement pstmtInsert = null;
            String message = "";
            String messageType = "";

            try {
                // Load the Oracle JDBC driver
                Class.forName("oracle.jdbc.driver.OracleDriver");
                
                // Establish a connection
                conn = DriverManager.getConnection(url, dbUser, dbPassword);

                // Check if the combination of mobileno and password already exists
                String sqlCheck = "SELECT * FROM users_register WHERE mobileno = ? AND password = ?";
                pstmtCheck = conn.prepareStatement(sqlCheck);
                pstmtCheck.setString(1, mobileno);
                pstmtCheck.setString(2, password);
                ResultSet rs = pstmtCheck.executeQuery();
                
                if (rs.next()) {
                    // Combination of mobileno and password already exists
                    message = "User with this mobile number and password combination already exists. Please use different details.";
                    messageType = "danger";
                } else {
                    // Insert new user if combination does not exist
                    String sqlInsert = "INSERT INTO users_register (name, mobileno, password) VALUES (?, ?, ?)";
                    pstmtInsert = conn.prepareStatement(sqlInsert);
                    pstmtInsert.setString(1, name);
                    pstmtInsert.setString(2, mobileno);
                    pstmtInsert.setString(3, password);

                    // Execute the query
                    int rows = pstmtInsert.executeUpdate();
                    
                    if (rows > 0) {
                        message = "Registration successful!";
                        messageType = "success";
                    } else {
                        message = "Registration failed. Please try again.";
                        messageType = "danger";
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                message = "Registration failed. Error: " + e.getMessage();
                messageType = "danger";
            } finally {
                if (pstmtCheck != null) {
                    try {
                        pstmtCheck.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (pstmtInsert != null) {
                    try {
                        pstmtInsert.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (conn != null) {
                    try {
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            }
        %>

        <div class="toast" role="alert" aria-live="assertive" aria-atomic="true">
            <div class="toast-header text-white <%= messageType.equals("success")? "bg-success" : "bg-danger"  %>">
                <strong class="mr-auto"><%= messageType.equals("success") ? "Success" : "Error" %></strong>
                <button type="button" class="ml-2 mb-1 close" data-dismiss="toast" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="toast-body">
                <%= message %>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function() {
            $('.toast').toast({ delay: 5000 });
            $('.toast').toast('show');
        });
    </script>
</body>
</html>
