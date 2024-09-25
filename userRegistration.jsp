<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    <title>User Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .registration-form {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            width:100%;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width:400px;
            padding-top:30px;
        }
        .registration-form h2 {
            margin-bottom: 20px;
            color: #ff6600;
            font-weight:600;
            
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
            background-color: #5cb85c;
            color: #fff;
            border: none;
            cursor: pointer;
            background-color:#ff6600;
        }
        .form-group input[type="submit"]:hover {
            background-color: #4cae4c;
        }
        .error {
            color: red;
            margin-top: 5px;
            display: none;
        }
        .main-div{
        	background-color:white;
        	box-shadow: rgba(149, 157, 165, 0.2) 0px 8px 24px;
        	margin:10px;
        	padding:40px;
        	border-radius:10px;	
        }
        .sub-div{
        	box-shadow: rgba(149, 157, 165, 0.1) 0px 5px 10px;
        }
        .image{
        width:100% !important;
        height:100%;
        }
        
    </style>
    <script>
        function validateForm() {
            var valid = true;
            
            var name = document.getElementById("name").value;
            var mobileno = document.getElementById("mobileno").value;
            var password = document.getElementById("password").value;

            if (name === "" || name == null) {
                document.getElementById("nameError").style.display = "block";
                document.getElementById("name").style.border = "1px solid red"
                valid = false;
            } else {
                document.getElementById("nameError").style.display = "none";
                document.getElementById("name").style.border = "1px solid green"
            }
            if (mobileno === "" || mobileno == null) {
                document.getElementById("mobilenoError").style.display = "block";
                document.getElementById("mobileno").style.border = "1px solid red"
                valid = false;
            } else {
                document.getElementById("mobilenoError").style.display = "none";
                document.getElementById("mobileno").style.border = "1px solid green"
            }
            
            let passerror = ""
            let validpass = true
            
           	if(!password.match(/[a-z]/)){
                    passerror += 'Password should contain at least one lowercase letter';
                    validpass = false
                }
           	if(!password.match(/[A-Z]/)){
                passerror += '<br>Password should contain at least one uppercase letter';
                validpass = false
            }
           	
           	if(!password.match(/[0-9]/)){
                passerror += '<br>Password should contain at least one digit';
                validpass = false
            }
           	
           	if(!password.match(/[!@#%^&*()_+]/)){
                passerror += '<br>Password should contain at least one special character';
                validpass = false
            }
           	
           	if(password.length < 8){
                passerror += '<br>Password should be minimum of 8 characters';
                validpass = false
            }
           	
           	if(!validpass){
                document.querySelector("#passwordError").innerHTML = passerror
                document.querySelector("#password").style.border = "1px solid red";
          	
            } else {
            	document.getElementById("password").style.border = "1px solid green"	
                document.getElementById("passwordError").style.display = "none";
            }

            return valid;
        }
    </script>
</head>
<body>
    <div class="container">
    	<div class="row main-div">
    	<div class="col-md-10 mx-auto">
    		<div class="row">
    			<div class="col-md-5">
					<div class="registration-form">
        <h2 class="text-center">User Registration</h2>
        <form action="process_registration.jsp" method="post" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" >
                <label id="nameError" class="error">Please enter your name.</label>
            </div>
            <div class="form-group">
                <label for="mobileno">Mobile No:</label>
                <input type="text" id="mobileno" name="mobileno" >
                <label id="mobilenoError" class="error">Please enter your mobile number.</label>
            </div>
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" >
                <label id="passwordError" class="error">Please enter your password.</label>
            </div>
            <div class="form-group">
                <input type="submit" value="Register">
            </div>
            <p>Already have an account? <span><a style="color:#ff6600" href="userLogin.jsp">SignIn</a></span></p>
        </form>
    </div> 			
    			</div>
    			<div class="col-md-5 mx-auto sub-div">
				    <img class="image" src="https://png.pngtree.com/png-clipart/20220125/original/pngtree-college-entrance-examination-png-image_7218213.png" alt="">
				</div>
    		</div>
    	</div>
    </div>
    
    </div>
    
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
