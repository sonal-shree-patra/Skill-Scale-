<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<header>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <a class="navbar-brand" href="#">Admin Dashboard</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ml-auto admin">
                <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle mr-5" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
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
</header>