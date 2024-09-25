<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>User Login</title>
    <style>
	        body {
    font-family: sans-serif;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
    background-color: #f0f2f5;
}

.login-container {
    display: flex;
    align-items: center;
    background-color: #fff;
    padding: 20px;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    max-width: 800px;
    width: 100%;
}

.login-image img {
    max-width: 100%;
    height: auto;
    border-radius: 10px;
}

.login-form {
    padding: 20px;
    max-width: 400px;
    width: 100%;
}

.login-form h2 {
    margin-bottom: 20px;
    font-weight: 600px;
    color: #ff6600;
    text-align: center;
}

.form-group {
    margin-bottom: 15px;
}

.form-group label {
    display: block;
    margin-bottom: 5px;
}

.form-group input {
    width: 100%;
    padding: 8px;
    box-sizing: border-box;
}

.form-group input[type="submit"] {
    background-color: #ff6600;
    color: #fff;
    border: none;
    cursor: pointer;
}

.form-group input[type="submit"]:hover {
    background-color: #e65c00;
}
    </style>
</head>
<body>
   <div class="login-container">
        <div class="login-image">
            <img src="https://static.vecteezy.com/system/resources/previews/006/405/794/non_2x/account-login-flat-illustration-vector.jpg" alt="Login Illustration">
        </div>
        <div class="login-form">
            <h2 class="text-center">Sign In</h2>
            <form action="process_login.jsp" method="post">
                <div class="form-group">
                    <label for="mobileno">Mobile No:</label>
                    <input type="text" id="mobileno" name="mobileno" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                <div class="form-group">
                    <input type="submit" value="Login">
                </div>
            </form>
        </div>
    </div>

</body>
</html>