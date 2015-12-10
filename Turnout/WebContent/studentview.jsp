<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">


 <!-- Bootstrap -->
	<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
 	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

 <!-- Style Sheet-->
	<link rel="stylesheet" type="text/css" href="MainStyle.css">
	
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
	  <div class="row">
	  	<div class="table-responsive">
	  		<table class="table table-striped table-hover">
	  			<thead>	
	  			<tr>
	  				<th> Date</th>
	  				<th> Attendance</th>
	  			</tr>
	  			</thead>
	  			<tbody>

<%
	//getting the session variables(session var map given at the top)
	String user = (String) session.getAttribute("USER");
	String username =(String)  session.getAttribute("USERNAME");
	String id = (String) session.getAttribute("ID");

	String class_id = request.getParameter("class_id");
	
	
	
	//JDBC driver name and database URL
	String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
	String DB_URL = "jdbc:mysql://www.virtualhighs.com:3306/turnout";
	
	//Database credentials
	String USER = "ateam";
	String PASS = "1191995";
	
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = null;
	
	try{
		Class.forName(JDBC_DRIVER);
		conn = DriverManager.getConnection(DB_URL, USER, PASS);
		
		sql = "select date , s_id from recordclass rc left join record r on rc.rc_id=r.rc_id and r.s_id=? where rc.c_id=?";
	  	stmt = conn.prepareStatement(sql);
	  	stmt.setString(1,id);
	  	stmt.setString(2,class_id);
	  	//out.println(stmt);
	  	
	  	ResultSet rs=stmt.executeQuery();
	  	
	  	while(rs.next())
	  	{
	  			out.println("<tr>");
	  			out.println("<td>"+rs.getString(1)+"</td>");
	  			out.println("<td>");
	  			if(rs.getString(2)==null)
	  				out.println("<h4><span class='glyphicon glyphicon-remove'></span></h4>");
	  			else
	  				out.println("<h4><span class='glyphicon glyphicon-ok'></span></h4>");
	  			out.println("</td>");
	  			out.println("</tr>");
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
		
	
%>
</tbody>
  		</table>
  	</div>
  </div>
</div>		
</body>
</html>