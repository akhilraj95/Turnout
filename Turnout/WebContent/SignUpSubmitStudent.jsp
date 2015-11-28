<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>turnout</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
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
        <li><a href="login.jsp"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
<b>
<%
	String usn = request.getParameter("usn");
	String password = request.getParameter("password");
	
	// JDBC driver name and database URL
	    String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	    String DB_URL = "jdbc:mysql://www.virtualhighs.com:3306/turnout";

	   //  Database credentials
	    String USER = "ateam";
	    String PASS = "1191995";
	
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    String sql = null;
	    
	    if(usn!= null && password!= null)
	    {	
			    try{
					Class.forName(JDBC_DRIVER);
					conn = DriverManager.getConnection(DB_URL, USER, PASS);
					
					//checking for the excistance of the username
					sql = "select count(*) from student where usn=?";
			    	stmt = conn.prepareStatement(sql);
			    	stmt.setString(1,usn);
			    	//out.println(stmt);
			    	ResultSet rs=stmt.executeQuery();
			    	
			    	if(rs.next())
			    		if(rs.getInt(1)==0)
			    		{
			    			// inserting to db
							sql = "insert into student(usn,password) values(?,?)";
					    	stmt = conn.prepareStatement(sql);
					    	stmt.setString(1,usn);
					    	stmt.setString(2,password);
					    	//out.println(stmt);
					    	int check =stmt.executeUpdate();
					    	
					    	if(check>0)
					    	{
					    		String redirectURL = "login.jsp";
					    	    response.sendRedirect(redirectURL);
					    	}
					    	else
					    	{
					    		out.println("Oops: Our minions have failed to update our database! please try later");
					    	}
			    		}
			    		else
			    		{
			    			out.println("Oops : Username already exists!  Try with another :P");
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
</b>
</div>
</body>
</html>
