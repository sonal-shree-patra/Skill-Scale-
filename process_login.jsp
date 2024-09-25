<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
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
            String mobileno = request.getParameter("mobileno");
            String password = request.getParameter("password");

            // Database connection details
            String url = "jdbc:oracle:thin:@localhost:1521:xe";
            String dbUser = "system";
            String dbPassword = "admin";
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String message = "";
            String messageType = "";

            try {
                // Load the Oracle driver
                Class.forName("oracle.jdbc.driver.OracleDriver");
                
                // Establish a connection
                conn = DriverManager.getConnection(url, dbUser, dbPassword);

                // Create SQL query
                String sql = "SELECT * FROM users_register WHERE mobileno = ? AND password = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, mobileno);
                pstmt.setString(2, password);

                // Execute the query
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Store user details in session
                    session.setAttribute("userName", rs.getString("name"));
                    session.setAttribute("mobileNo", mobileno);
                    message = "Login successful!";
                    messageType = "success";
                    response.sendRedirect("Homepage.jsp");
                } else {
                    message = "Login failed. Invalid mobile number or password.";
                    messageType = "danger";
                }
            } catch (Exception e) {
                e.printStackTrace();
                message = "Login failed. Error: " + e.getMessage();
                messageType = "danger";
            } finally {
                if (rs != null) {
                    try {
                        rs.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                if (pstmt != null) {
                    try {
                        pstmt.close();
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
