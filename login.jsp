<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
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

        .login-image, .login-form {
            flex: 1;
            padding: 20px;
        }

        .login-image img {
            max-width: 100%;
            height: auto;
            border-radius: 10px;
        }

        h1 {
            text-align: center;
            color: #ff6600;
            margin-bottom: 20px;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        label {
            margin: 5px 0;
            color: #333333;
            font-weight: bold;
        }

        input[type="text"],
        input[type="password"] {
            padding: 10px;
            width: 100%;
            margin-bottom: 10px;
            border: 1px solid #dddddd;
            border-radius: 6px;
            box-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
            font-size: 16px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            padding: 12px 20px;
            background-color: #ff6600;
            border: none;
            border-radius: 6px;
            color: #ffffff;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
            margin-top: 10px;
        }

        input[type="submit"]:hover {
            background-color: #e65c00;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-image">
            <img src="https://static.vecteezy.com/system/resources/thumbnails/022/675/079/small_2x/data-protection-anti-virus-it-security-using-cyber-security-services-to-protect-private-personal-data-credit-card-pin-user-login-account-password-concept-illustration-free-vector.jpg" alt="Admin Login Illustration">
        </div>
        <div class="login-form">
            <h1>Admin Login</h1>
            <form action="authenticate.jsp" method="post" onsubmit="validate(event)">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username">
                <label for="" id="U_error"></label>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password">
                <label for="" id="P_error"></label>
                <input type="submit" value="Login">
            </form>
        </div>
    </div>

    <script>
        function validate(e) {
            let name = document.querySelector("#username").value;
            let error = false;

            if (name.trim() === "") {
                document.querySelector("#U_error").innerHTML = "Please enter your name";
                document.querySelector("#username").style.border = "1px solid red";
                error = true;
            } else {
                document.querySelector("#username").style.border = "1px solid green";
                document.querySelector("#U_error").innerHTML = "";
            }

            if (error) {
                e.preventDefault();
            }
        }
    </script>
</body>
</html>
