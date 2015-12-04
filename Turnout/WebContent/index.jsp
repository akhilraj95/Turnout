<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Turnout</title>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap -->
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</head>

<body>

<!-- 
		TO DO LIST 

<div class="container">
			
	<h5>To do:<br>
		1) teacher link to register<br>
		2) student link to register<br>
		3) teacher link to add class<br>
		4) student link to register to class<br>
		5) teacher link to view attendance<br>
		6) student link to view all of their attendance<br>
		
		do if time permits 
		~ teacher link to edit students
	</h5>
</div> 

-->



<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="index.jsp"><span class="glyphicon glyphicon-education"></span><b>&nbspTurnout</b></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="index.jsp">Home</a></li>
        <li><a href="about.jsp">About</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="signup.jsp"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>
        <%	if(session.getAttribute("ID")==null)
        		{	
        			%>
        				<li><a href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
        			<% 
        		}
       		else
       		{
       			%>
				<li><a href="logout.jsp"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
				<% 
       		}
        %>
        
      </ul>
    </div>
  </div>
</nav>


<%
		if(session.getAttribute("ID")!=null)
		{
			out.println(session.getAttribute("USER"));
			out.println(session.getAttribute("USERNAME"));
			out.println(session.getAttribute("ID"));
		}
		else{
			String redirectURL = "login.jsp";
    	    response.sendRedirect(redirectURL);
			
		}
%>


</body>
</html>