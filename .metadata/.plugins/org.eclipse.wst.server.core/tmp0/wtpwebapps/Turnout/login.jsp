<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import ="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Turnout -Login</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

 <!-- Bootstrap -->
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<!-- Style Sheet-->
	<link rel="stylesheet" type="text/css" href="MainStyle.css">
	
</head>
</head>
<body>
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

<div class="container">
<%
		String usn = request.getParameter("usn");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
		String user = request.getParameter("user");
		
		// JDBC driver name and database URL
		    String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
		    String DB_URL = "jdbc:mysql://www.virtualhighs.com:3306/turnout";
		
		   //  Database credentials
		    String USER = "ateam";
		    String PASS = "1191995";
		
		    Connection conn = null;
		    PreparedStatement stmt = null;
		    String sql = null;
		    
		    if((usn!= null || email!=null) && password!=null)
		    {	
		    	
				    try{
						Class.forName(JDBC_DRIVER);
						conn = DriverManager.getConnection(DB_URL, USER, PASS);
						
						
						if(user.equals("STUDENT"))
						{
								//checking for the excistance of the username
								sql = "select password,s_id from student where usn=?";
						    	stmt = conn.prepareStatement(sql);
						    	stmt.setString(1,usn);
						    	ResultSet rs=stmt.executeQuery();
						    	
						    	if(rs.next())
						    		if(rs.getString("password").equals(password))
						    		{
						    				//out.println("success");
								    		String redirectURL = "index.jsp";
								    	    session.setAttribute("USER",user);
								    	    session.setAttribute("USERNAME",usn);
								    	    session.setAttribute("ID",rs.getString("s_id"));
								    	    response.sendRedirect(redirectURL);
								    	
						    		}
						    		else
						    		{
						    			%>
						    			<script language="javascript">
						    			alert("Incorrect Credential");	
						    			</script>
						    			<%
						    		}
						    	
						
						   }
						    else if(user.equals("TEACHER")){
						    	


						    	//checking for the excistance of the username
								sql = "select password,t_id from teacher where username=?";
						    	stmt = conn.prepareStatement(sql);
						    	stmt.setString(1,email);
						    	//out.println(stmt);
						    	ResultSet rs=stmt.executeQuery();
						    	
						    	if(rs.next())
						    		if(rs.getString("password").equals(password))
						    		{
							    		String redirectURL = "index.jsp";
							    	    session.setAttribute("USER",user);
							    	    session.setAttribute("USERNAME",email);
							    	    session.setAttribute("ID",rs.getString("t_id"));
							    	    response.sendRedirect(redirectURL);
							    	    
						    		}
						    		else
						    		{
						    			out.println("Oops : Try Again :p");
						    			
						    		}
						    	
								
							
						   }
				    	
				    	
				    }catch(SQLException se){
				    	out.println("Oops : Technical Error , please try again later");
				        se.printStackTrace();
				    }catch(Exception e){
				    	out.println("Oops : Technical Error , please try again later");
				        e.printStackTrace();
				    }finally{
					        
				    	 try{
				    		 if(conn!=null)
				    	            conn.close();
					        }catch(SQLException se){
					           se.printStackTrace();
					        }
				}
}
%>
</div>

<div class="container">

  <h2>Lets Login now</h2>
  <ul class="nav nav-tabs">
    <li class="active"><a data-toggle="tab" href="#home">Teacher</a></li>
    <li><a data-toggle="tab" href="#menu1">Student</a></li>
  </ul>

  <div class="tab-content">
    <div id="home" class="tab-pane fade in active">
	      	<!-- ### TEACHER FORM ### -->
	      	<h3>Teacher</h3>
	      	
	      	<form class="form-horizontal" role="form"  action="login.jsp" method="POST">
			    <div class="form-group">
			      	  <label class="control-label col-sm-2" for="email">Email:</label>
				      <div class="col-sm-8">
				        <input type="text" class="form-control" name="email" placeholder="Enter email id">
				      </div>
			    </div>
			    <div class="form-group">
			      	  <label class="control-label col-sm-2" for="pwd">Password:</label>
				      <div class="col-sm-8">
				        <input type="password" class="form-control" name="password" placeholder="choose password">
				      </div>	
			    </div>
			    <div class="form-group">        
			      <div class="col-sm-offset-2 col-sm-10">
			        <button type="submit" class="btn btn-default">Submit</button>
			      </div>
			    </div>
			    <input type="hidden" name="user" value="TEACHER">
			</form>
    	 
    </div>
    <div id="menu1" class="tab-pane fade">
		<!-- ### STUDENT FORM ### -->
      	<h3>Student</h3>
      	<form class="form-horizontal" role="form" action="login.jsp" method="POST">
			    <div class="form-group">
			      	  <label class="control-label col-sm-2" >USN:</label>
				      <div class="col-sm-8">
				        <input type="text" class="form-control" name="usn" placeholder="Enter USN">
				      </div>
			    </div>
			    <div class="form-group">
			      	  <label class="control-label col-sm-2" for="pwd">Password:</label>
				      <div class="col-sm-8">
				        <input type="password" class="form-control" name="password" placeholder="choose password">
				      </div>
			    </div>
			    <div class="form-group">        
			      <div class="col-sm-offset-2 col-sm-10">
			        <button type="submit" class="btn btn-default">Submit</button>
			      </div>
			    </div>
			     <input type="hidden" name="user" value="STUDENT">
		</form>
      
    </div>
  </div>
</div>

</body>
</html>