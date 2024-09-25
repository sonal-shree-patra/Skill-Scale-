<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SkillScale - Assessment Portal</title>
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

    <link rel="stylesheet" href="style.css" />
  </head>
  <style>
	  	.navbar-nav {
	  margin: auto;
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
	
	/* Carousel css */
	
	.carousel-inner {
	  position: relative;
	  height: 85vh;
	}
	
	.carousel-inner .carousel-item {
	  height: 100%;
	  position: relative;
	}
	
	.carousel-inner .carousel-item .carousel-overlay {
	  position: absolute;
	  top: 0;
	  left: 0;
	  width: 100%;
	  height: 100%;
	  background-color: rgba(0, 0, 0, 0.5);
	}
	
	.carousel-inner img {
	  width: 100%;
	  height: 100%;
	  object-fit: cover;
	}
	
	.carousel-caption {
	  position: absolute;
	  top: 50%;
	  left: 180px;
	  transform: translateY(-50%);
	  text-align: left;
	  width: calc(
	    100% - 180px
	  ); /* Adjust width considering left padding and spacing */
	  color: white;
	}
	
	.carousel-caption h1 {
	  font-size: 3rem;
	  margin-bottom: 35px;
	}
	
	.btn-orange {
	  background-color: orange;
	  color: white;
	  border: none;
	  padding: 10px 20px;
	  border-radius: 5px;
	  cursor: pointer;
	}
	
	.btn-orange:hover {
	  background-color: #e68a00;
	}
	
	/* About */
	
	body,
	h1,
	h2,
	h3,
	h4,
	h5,
	h6,
	p,
	ul,
	ol,
	li {
	  margin: 0;
	  padding: 0;
	}
	
	.about-section {
	  display: flex;
	  align-items: center;
	  max-width: 1550px;
	  padding: 50px;
	  background-color: #f2f2f2;
	}
	
	.about-image {
	  flex: 1; /* Take up 1/2 of the available space */
	  padding-left: 20px;
	}
	
	.about-image img {
	  width: 80%; 
	  border-radius: 10px;
	}
	
	.about-content {
	  flex: 1;
	  padding-left: 20px; 
	}
	
	.about-content h3 {
	  color: orange; 
	  font-size: 24px; 
	}
	
	.about-content h1 {
	  font-size: 36px; 
	  margin-bottom: 20px; 
	}
	
	.about-content p {
	  font-size: 18px; 
	  line-height: 1.6; 
	}
	
	/* Text slider and image  */
	
	.container-1 {
	  display: flex;
	  background-color: #1a2130;
	  color: white;
	  padding: 20px;
	  height: 75vh;
	  overflow: hidden;
	  margin-bottom: 20px;
	}
	.left-1 {
	  flex: 1;
	  display: flex;
	  flex-direction: column;
	  justify-content: center;
	  opacity: 0;
	  transform: translateX(100%);
	  transition: opacity 1s, transform 1s;
	}
	.container:hover .left-1 {
	  opacity: 1;
	  transform: translateX(0);
	}
	.right-1 {
	  flex: 1;
	  display: flex;
	  align-items: center;
	  justify-content: center;
	}
	h1 {
	  margin: 0;
	  font-size: 2.5em;
	}
	p {
	  font-size: 1.2em;
	  margin: 20px 0;
	}
	.btn-1 {
	  background: orange;
	  border: 2px solid orange;
	  color: white;
	  padding: 10px 20px;
	  font-size: 1em;
	  cursor: pointer;
	  transition: background 0.3s, color 0.3s;
	  align-self: start;
	}
	.btn-1:hover {
	  background: #e68a00;
	  color: white;
	}
	img {
	  max-width: 100%;
	  height: auto;
	}
	
	.main-container {
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  height: 80vh;
	  margin: 0;
	  padding: 0;
	}
	
	.container-2 {
	  display: flex;
	  width: 90%; 
	  max-width: 1400px; 
	  border: 1px solid #ccc;
	  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	  background-color: #ffffff;
	  border-radius: 8px;
	  overflow: hidden;
	  margin: 20px 0;
	}
	
	.box1,
	.box2 {
	  padding: 70px; 
	  flex: 1;
	  display: flex;
	  flex-direction: column;
	  justify-content: center;
	}
	
	.box1 {
	  background-color: #f5f7f8;
	}
	
	.box2 {
	  background-color: #d3d3d3;
	}
	
	.heading-box1,
	.heading-box2 {
	  margin: 0 0 20px 0;
	  font-size: 28px;
	  font-weight: bold;
	}
	
	.para-box1,
	.para-box2 {
	  margin: 0 0 30px 0;
	  font-size: 18px;
	  line-height: 1.6;
	}
	
	.join-btn,
	.demo-btn {
	  align-self: start;
	  padding: 14px 28px;
	  border: none;
	  cursor: pointer;
	  font-size: 18px;
	  border-radius: 5px;
	  transition: background-color 0.3s ease;
	}
	
	.join-btn {
	  background-color: #007bff;
	  color: white;
	}
	
	.join-btn:hover {
	  background-color: #0056b3;
	}
	
	.demo-btn {
	  background-color: orange;
	  color: white;
	}
	
	.demo-btn:hover {
	  background-color: #cc6600;
	}
	
	/* Testimonial */
	
	@import url("https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;600;700&display=swap");
	
	.testimonial {
	  width: 100%;
	  height: 90vh;
	  background-color: #153448;
	  position: relative;
	  padding-bottom: 100px;
	}
	.section-heading {
	  font-size: 35px;
	  font-weight: bold;
	  /* margin-top: 20px; */
	  text-transform: capitalize;
	  color: #dee2e6;
	}
	.carousel-item {
	  min-height: 400px;
	  position: relative;
	}
	.carousel-img {
	  position: absolute;
	  width: 100px;
	  height: 100px;
	  border-radius: 50%;
	  left: 50%;
	  top: 30%;
	  transform: translate(-50%, -50%);
	  border: 2px solid #dee2e6;
	}
	.carousel-img img {
	  width: 100%;
	  height: 100%;
	  border-radius: 50%;
	}
	.carousel-caption {
	  position: absolute;
	  right: 15%;
	  left: 15%;
	  bottom: 50px;
	  padding: 50px 0;
	  color: white;
	}
	.testimonial-name {
	  font-size: 25px;
	  font-weight: 400;
	  text-transform: capitalize;
	}
	.testimonial-icon {
	  font-size: 40px;
	  color: #dee2e6;
	  margin-top: -5px;
	  margin-right: 5px;
	}
	.carousel-control-next-icon {
	  background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='white' viewBox='0 0 8 8'%3E%3Cpath d='M2.75 0l-1.5 1.5 2.5 2.5-2.5 2.5 1.5 1.5 4-4-4-4z'/%3E%3C/svg%3E");
	}
	
	.carousel-control-prev-icon {
	  background-image: url("data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' fill='white' viewBox='0 0 8 8'%3E%3Cpath d='M5.25 0l-4 4 4 4 1.5-1.5-2.5-2.5 2.5-2.5-1.5-1.5z'/%3E%3C/svg%3E");
	}
	
	/* Footer */
	
	.main-footer {
	  background-color: #373a40;
	  padding: 20px;
	}
	
	.btn-outline-white {
	  color: #000;
	  background-color: #fff;
	  border-color: #fff;
	}
	
	.btn-outline-white:hover {
	  color: #fff;
	  background-color: #000;
	  border-color: #000;
	}
	
	.text-orange {
	  color: orange;
	}
  
  </style>
  <body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid px-4">
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
      
      <% HttpSession currentSession = request.getSession(false); // Retrieve existing session %>
      <% if (currentSession != null && currentSession.getAttribute("userName") != null) { %>
        <li style="list-style:none;margin-right:20px;background-color:orange;padding:10px;border-radius:10px" class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Welcome, <%= currentSession.getAttribute("userName") %>
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


    <!-- Carousel -->

    <div id="carouselExample" class="carousel slide" data-bs-ride="carousel">
      <div class="carousel-inner">
        <div class="carousel-item active">
          <div class="carousel-overlay"></div>
          <img
            src="https://images.theconversation.com/files/539990/original/file-20230728-21-i20d5f.jpg?ixlib=rb-4.1.0&rect=146%2C82%2C1863%2C1324&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip"
            class="d-block w-100"
            alt="..."
          />
          <div class="carousel-caption">
            <h1>Assess your skills with <br />ease</h1>
            <button class="btn btn-orange">Learn More</button>
          </div>
        </div>
        <div class="carousel-item">
          <div class="carousel-overlay"></div>
          <img
            src="https://img.freepik.com/premium-photo/smiling-asian-teenager-student-studying-library_171337-95277.jpg"
            class="d-block w-100"
            alt="..."
          />
          <div class="carousel-caption">
            <h1>
              Track your progress,<br />
              achieve your goals
            </h1>
            <button class="btn btn-orange">Learn More</button>
          </div>
        </div>
        <div class="carousel-item">
          <div class="carousel-overlay"></div>
          <img
            src="https://www.shutterstock.com/image-photo/student-girl-prepare-test-makes-600nw-2139744615.jpg"
            class="d-block w-100"
            alt="..."
          />
          <div class="carousel-caption">
            <h1>Test your knowledge <br />effortlessly</h1>
            <button class="btn btn-orange">Learn More</button>
          </div>
        </div>
      </div>
      <button
        class="carousel-control-prev"
        type="button"
        data-bs-target="#carouselExample"
        data-bs-slide="prev"
      >
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Previous</span>
      </button>
      <button
        class="carousel-control-next"
        type="button"
        data-bs-target="#carouselExample"
        data-bs-slide="next"
      >
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="visually-hidden">Next</span>
      </button>
    </div>

    <!-- About -->

    <div class="about-section" id="about">
      <div class="about-image">
        <img
          src="https://images.pexels.com/photos/1290141/pexels-photo-1290141.jpeg?cs=srgb&dl=pexels-ivo-rainha-527110-1290141.jpg&fm=jpg"
          alt="About Us Image"
        />
      </div>
      <div class="about-content">
        <h3>ABOUT US</h3>
        <h1>Innovative Way to Learn</h1>
        <p>
          Welcome to SkillScale, the premier platform for comprehensive skill
          assessment and development. At SkillScale, we empower individuals and
          organizations to enhance their capabilities through precise
          assessments and personalized learning paths. Whether you're looking to
          advance your career or optimize your team's skills, our intuitive
          interface provides deep insights into strengths and areas for growth.
          SkillScale offers a diverse range of assessments tailored to various
          industries and roles, ensuring accuracy and relevance in evaluating
          competencies. Our platform guides users with detailed analytics,
          helping them identify strengths, pinpoint areas needing improvement,
          and chart effective learning journeys. From technical proficiency to
          soft skills refinement, SkillScale supports continuous professional
          growth.
        </p>
      </div>
    </div>

    <!-- Text Slider and Image -->

    <div class="container mt-5 px-5 container-1">
      <div class="left-1">
        <h1>Explore and expand your skills.</h1>
        <p>
          Every idea has a first line of code. Prep for jobs and sharpen your
          skills alongside a global community of developers. Access the content
          you need to develop new skills - and land the job you've dreamed of.
        </p>
        <button class="btn-1"><a href="quiz.jsp" style="text-decoration:none;color:white">Sign up and practice</a></button>
      </div>
      <div class="right-1">
        <img
          src="https://www.hackerrank.com/wp-content/uploads/2022/09/contenders.png"
          alt="Coding illustration"
        />
      </div>
    </div>

    <!-- Two different cards -->

    <div class="main-container">
      <div class="container-2">
        <div class="box1">
          <h1 class="heading-box1">Enhance Your Assessment Process</h1>
          <p class="para-box1">
            Streamline your assessments with our comprehensive tools and
            detailed analytics. Start improving your evaluation methods today.
          </p>
          <button class="join-btn">Join the community</button>
        </div>
        <div class="box2">
          <h2 class="heading-box2">Secure and Reliable Assessments</h2>
          <p class="para-box2">
            Ensure data security and reliability with our trusted assessment
            portal. Protect candidate information while maintaining compliance.
          </p>
          <button class="demo-btn">Explore Features</button>
        </div>
      </div>
    </div>

    <!-- Testimonial -->
    <section class="testimonial mb-5">
      <div class="container">
        <div
          id="carouselExampleControls"
          class="carousel slide"
          data-bs-ride="carousel"
        >
          <div class="carousel-indicators">
            <button
              type="button"
              data-bs-target="#carouselExampleControls"
              data-bs-slide-to="0"
              class="active"
              aria-current="true"
              aria-label="Slide 1"
            ></button>
            <button
              type="button"
              data-bs-target="#carouselExampleControls"
              data-bs-slide-to="1"
              aria-label="Slide 2"
            ></button>
            <button
              type="button"
              data-bs-target="#carouselExampleControls"
              data-bs-slide-to="2"
              aria-label="Slide 3"
            ></button>
          </div>
          <div class="carousel-inner">
            <div class="carousel-item active">
              <div class="carousel-img">
                <img
                  src="https://cdn-icons-png.freepik.com/512/3686/3686930.png"
                  alt="pic-1"
                />
              </div>
              <div class="carousel-caption">
                <h5 class="testimonial-name">Mark Smith</h5>
                <p style="font-style: italic">
                  <i class="bi bi-quote testimonial-icon"></i>As a user of the
                  SkillScale, I find it incredibly efficient and user-friendly.
                  The interface is intuitive,<br />
                  making navigation seamless and straightforward. The variety of
                  assessment tools available caters to different <br />
                  needs, allowing for comprehensive evaluation. I appreciate the
                  detailed feedback provided <br />post-assessment, which helps
                  me understand my performance better. Overall, the portal
                  enhances my <br />
                  learning experience by providing valuable insights and tools
                  for continuous improvement.
                </p>
              </div>
            </div>
            <div class="carousel-item">
              <div class="carousel-img">
                <img
                  src="https://cdn-icons-png.flaticon.com/512/3870/3870822.png"
                  alt="pic-2"
                />
              </div>
              <div class="carousel-caption">
                <h5 class="testimonial-name">William Jack</h5>
                <p style="font-style: italic">
                  <i class="bi bi-quote testimonial-icon"></i>The assessment
                  portal is a game-changer for me. It not only simplifies the
                  process of taking assessments <br />
                  but also offers a range of features that enhance my learning
                  journey. The ability to track my progress over time <br />
                  is invaluable, and the interactive nature of the platform
                  keeps me engaged. The detailed analytics provided are
                  <br />enlightening, helping me identify areas for improvement
                  and celebrate successes. I highly recommend this <br />portal
                  for anyone looking to streamline their learning and assessment
                  experience.
                </p>
              </div>
            </div>
            <div class="carousel-item">
              <div class="carousel-img">
                <img
                  src="https://cdn-icons-png.flaticon.com/512/8792/8792047.png"
                  alt="pic-3"
                />
              </div>
              <div class="carousel-caption">
                <h5 class="testimonial-name">Jennifer Lui</h5>
                <p style="font-style: italic">
                  <i class="bi bi-quote testimonial-icon"></i>SkillScale has
                  revolutionized my learning experience with its robust features
                  and user-friendly interface. <br />The platform offers a wide
                  range of assessments that cater perfectly to my academic and
                  professional goals. <br />
                  I particularly appreciate the detailed insights provided by
                  SkillScale's analytics, which help me track my <br />progress
                  effectively and identify areas for improvement. The platform's
                  reliability and intuitive design make it a <br />
                  standout choice for anyone serious about skill development and
                  continuous learning.
                </p>
              </div>
            </div>
          </div>
          <button
            class="carousel-control-prev"
            type="button"
            data-bs-target="#carouselExampleControls"
            data-bs-slide="prev"
          >
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
          </button>
          <button
            class="carousel-control-next"
            type="button"
            data-bs-target="#carouselExampleControls"
            data-bs-slide="next"
          >
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
          </button>
        </div>
      </div>
    </section>

    <!-- Footer -->

    <div class="main-footer mt-5">
      <footer class="text-center text-lg-start mt-3 pt-4">
        <div class="container p-4">
          <div class="row">
            <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
              <h5 class="text-uppercase mb-4 text-white">OUR WORLD</h5>

              <ul class="list-unstyled mb-4">
                <li>
                  <a href="#!" class="text-white">About us</a>
                </li>
                <li>
                  <a href="#!" class="text-white">Collections</a>
                </li>
                <li>
                  <a href="#!" class="text-white">Environmental philosophy</a>
                </li>
                <li>
                  <a href="#!" class="text-white">Artist collaborations</a>
                </li>
              </ul>
            </div>

            <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
              <h5 class="text-uppercase mb-4 text-white">Assistance</h5>

              <ul class="list-unstyled">
                <li>
                  <a href="#!" class="text-white">Contact us</a>
                </li>
                <li>
                  <a href="#!" class="text-white">Size Guide</a>
                </li>
                <li>
                  <a href="#!" class="text-white">Shipping Information</a>
                </li>
                <li>
                  <a href="#!" class="text-white">Returns & Exchanges</a>
                </li>
                <li>
                  <a href="#!" class="text-white">Payment</a>
                </li>
              </ul>
            </div>

            <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
              <h5 class="text-uppercase mb-4 text-white">Careers</h5>

              <ul class="list-unstyled">
                <li>
                  <a href="#!" class="text-white">Jobs</a>
                </li>
              </ul>
            </div>

            <div class="col-lg-3 col-md-6 mb-4 mb-lg-0">
              <h5 class="text-uppercase mb-4 text-white">
                Sign up to our newsletter
              </h5>

              <div class="form-outline form-white mb-4">
                <input
                  type="email"
                  id="form5Example2"
                  class="form-control"
                  placeholder="Email address"
                />
              </div>

              <button type="submit" class="btn btn-outline-white btn-block">
                Subscribe
              </button>
            </div>
          </div>
        </div>

        <div class="text-center p-3 border-top border-white">
          <span class="text-white">© 2024 Copyright:</span>
          <a style="text-decoration:none" class="text-white" href="https://mdbootstrap.com/"
            >SkillScale.com</a
          >
        </div>
      </footer>
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