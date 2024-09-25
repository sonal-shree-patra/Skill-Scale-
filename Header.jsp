<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!-- Header.jsp -->
<header>
<style>
		.navbar-nav {
	  margin: 0;
	}
	.header{
		background-color:white !important;
		padding:10px !important;
		margin:0px !important;
	}
	
	.navbar-nav li {
	  margin: 0 10px;
	}
	
	.navbar-nav .nav-link {
	  position: relative;
	}
	
	.navbar-nav .nav-link:hover {
	  text-decoration: none;
	}
	
	.navbar-nav .nav-link::after {
	  content: "";
	  position: absolute;
	  left: 0;
	  bottom: 0;
	  width: 0;
	  height: 2px;
	  background-color: orange;
	  transition: width 0.3s ease;
	}
	
	.navbar-nav .nav-link:hover::after {
	  width: 100%;
	}
	
	.navbar-brand {
	  color: orange;
	  font-size: 1.5rem;
	}
	
	.book-now-btn {
	  background-color: orange;
	  
	  color: white;
	  transition: background-color 0.3s, color 0.3s;
	}
	
	.book-now-btn:hover {
	  background-color: orange;
	  color: white;
	}
	
</style>
   <nav class="navbar navbar-expand-lg bg-body-tertiary ">
  <div class="container-fluid px-4 header">
    <a class="navbar-brand fw-bold" href="Homepage.jsp">SkillScale</a>
    <button
      class="navbar-toggler"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#navbarSupportedContent"
      aria-controls="navbarSupportedContent"
      aria-expanded="false"
      aria-label="Toggle navigation"
    >
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">HOME</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#about">ABOUT</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#contact">CONTACT</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#">FEEDBACK</a>
        </li>
      </ul>
      
      <% HttpSession currentSessions = request.getSession(false); // Retrieve existing session %>
      <% if (currentSessions != null && currentSessions.getAttribute("userName") != null) { %>
        <li style="list-style:none;margin-right:20px;background-color:orange;padding:10px;border-radius:10px" class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Welcome, <%= currentSessions.getAttribute("userName") %>
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="userDashboard.jsp">Profile</a></li>
            <li><a class="dropdown-item" href="quiz.jsp">Take Quiz</a></li>
            <li><hr class="dropdown-divider"></li>
            <li><a class="dropdown-item" href="logout.jsp">Logout</a></li>
          </ul>
        </li>
      <% } else { %>
        <!-- Redirect unauthorized access to login page -->
        <% response.sendRedirect("userLogin.jsp"); %>
      <% } %>
    </div>
  </div>
</nav>
</header>
