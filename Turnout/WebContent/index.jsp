<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*,java.util.ArrayList,java.text.DecimalFormat"%>
  
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

 <!-- Style Sheet-->
	<link rel="stylesheet" type="text/css" href="MainStyle.css">
	

</head>

<body>

<!-- 
		TO DO LIST 
COMMENT TO CHECK IF ABDUL CHANGES ARE UPDTATING OR NOT

done	1) teacher link to register<br>							
done	2) student link to register<br>
done	3) teacher link to add class<br>
done	4) student link to register to class<br>
done		5) teacher link to view attendance<br>
		6) student link to view all of their attendance<br>
		7) teacher link to add class + attendance
		
		do if time permits 
		~ teacher link to edit students
	
Session variable map
	user -> indicates the type of user {student,teacher}
	username -> indicated the logged in email(teacher) or the USN(student) {email,USN}
	id ->  indicated the index to table {t_id ,s_id}

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

	
<div class="container">	
<%
		// checks if logged in , if not redirect to login
		if(session.getAttribute("ID")!=null)
		{
			//getting the session variables(session var map given at the top)
			String user = (String) session.getAttribute("USER");
			String username =(String)  session.getAttribute("USERNAME");
			String id = (String) session.getAttribute("ID");
			
			// JDBC driver name and database URL
  		    String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
  		    String DB_URL = "jdbc:mysql://www.virtualhighs.com:3306/turnout";

  		   //  Database credentials
  		    String USER = "ateam";
  		    String PASS = "1191995";

  		    Connection conn = null;
  		    PreparedStatement stmt = null;
  		    String sql = null;
  		    
			//Differenciates the Teacher and Student views
			if(user.equals("STUDENT"))
			{	
				// STUDENT VIEW
				%>
					<div class="panel panel-default">
						<div class="panel-heading">
					<!-- /////////// MODAL TO JOIN CLASS \\\\\\\\\\\\ --> 
							<div class="container-fluid">
							  <!-- Trigger the modal with a button -->
							  <h4 class ="col-sm-10"><b>Your Classes</b></h4>
							  <button type="button" class="btn btn-info btn-md col-sm-2" data-toggle="modal" data-target="#myModal">Join Class</button>
							
							  <!-- Modal -->
							  <div class="modal fade" id="myModal" role="dialog">
							    <div class="modal-dialog">
							    
							      <!-- Modal content-->
							      <div class="modal-content">
							        <div class="modal-header">
							          <button type="button" class="close" data-dismiss="modal">&times;</button>
							          <h4 class="modal-title">Join Class</h4>
							        </div>
							        <div class="modal-body">
							         		<!-- FORM FOR CREATING CLASS -->
							         		<form class="form-horizontal" role="form" action="joinclass.jsp" method="POST">			 
										    <div class="form-group">
										      <label class="control-label col-sm-2" >Class Name:</label>
										      <div class="col-sm-10">
										        <input type="text" class="form-control" name="classname" placeholder="Enter Subject">
										      </div>
										    </div>
										    <div class="form-group">
										      <label class="control-label col-sm-2" for="pwd">Pass Key:</label>
										      <div class="col-sm-10">          
										        <input type="password" class="form-control" name="password" placeholder="Enter password">
										      </div>
										    </div>
										    <div class="form-group">        
										      <div class="col-sm-offset-2 col-sm-10">
										        <button type="submit" class="btn btn-default">Submit</button>
										      </div>
										    </div>
										  </form>
							         			
							        </div>
							        <div class="modal-footer">
							          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							        </div>
							      </div>
							      
							    </div>
							  </div>
							</div>
					</div>
						<div class="panel-body">
								<!-- /////////// Displays All Of His Classes\\\\\\\\\\\ -->
									<div class="container-fluid">
									  <div class="row">
									  	<div class="table-responsive">
									  		<table class="table table-striped table-hover">
									  			<thead>	
									  			<tr>
									  				<th> Class Name</th>
									  				<th> Attended</th>
									  				<th> View Class</th>
									  			</tr>
									  			</thead>
									  			<tbody>
									  			<%	
									  		
									  		    try{
									  				Class.forName(JDBC_DRIVER);
									  				conn = DriverManager.getConnection(DB_URL, USER, PASS);
									  			
									  				sql = "select classname,classcount,attended,class_id from class c,enrolled e where c.class_id=e.c_id and e.s_id = ?;";
									  		    	stmt = conn.prepareStatement(sql);
									  		    	stmt.setString(1,id);
									  		    	ResultSet rs=stmt.executeQuery();
									
									  		    	while(rs.next())
									  		    	{
									  		    		Float percentage = (Float.parseFloat(rs.getString(3))/Float.parseFloat(rs.getString(2)))*100;
									  		    		
									  		    		DecimalFormat form = new DecimalFormat("00.00");
									  		    		
									  		    		out.println("<tr class='active'>");
									  		    		out.println("<td>"+rs.getString(1)+"</td>");
									  		    		out.println("<td>"+String.valueOf(form.format(percentage))+"%"+"  ("+rs.getString(3)+"/"+rs.getString(2)+")"+"</td>");
						//abdul - view student
									  		    		out.println("<td><form action='studentview.jsp' method='POST'><input type='hidden' name='class_id' value='"+rs.getString(4)+"'><button type='submit' class='btn btn-primary'>View <span class='glyphicon glyphicon-stats'></span></button></td></form>");
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
						</div>
					</div>
	</div>		
				<%
			}
			else if(user.equals("TEACHER"))
			{
				ArrayList<String> classlist = new ArrayList();
				ArrayList<String> idlist = new ArrayList();
				
				// TEACHER VIEW
				
				%>
					
				<div class="panel panel-default">
					<div class="panel-heading">
					<!-- /////////// MODAL TO ADD CLASS \\\\\\\\\\\\ --> 
							<div class="container-fluid">
							  <!-- Trigger the modal with a button -->
							  <h4 class ="col-sm-10"><b>Your Classes</b></h4>
							  <button type="button" class="btn btn-info btn-md col-sm-2" data-toggle="modal" data-target="#myModal">Add Class</button>
							
							  <!-- Modal -->
							  <div class="modal fade" id="myModal" role="dialog">
							    <div class="modal-dialog">
							    
							      <!-- Modal content-->
							      <div class="modal-content">
							        <div class="modal-header">
							          <button type="button" class="close" data-dismiss="modal">&times;</button>
							          <h4 class="modal-title">Add Class</h4>
							        </div>
							        <div class="modal-body">
							         		<!-- FORM FOR CREATING CLASS -->
							         		<form class="form-horizontal" role="form" action="createclass.jsp" method="POST">			 
										    <div class="form-group">
										      <label class="control-label col-sm-2" >Subject:</label>
										      <div class="col-sm-10">
										        <input type="text" class="form-control" name="subject" placeholder="Enter Subject">
										      </div>
										    </div>
										    <div class="form-group">
										      <label class="control-label col-sm-2">Class Year:</label>
										      <div class="col-sm-10">
										        <input type="text" class="form-control" name="year" placeholder="Enter Year">
										      </div>
										    </div>
										    <div class="form-group">
										      <label class="control-label col-sm-2">Class Section:</label>
										      <div class="col-sm-10">
										        <input type="text" class="form-control" name="section" placeholder="Enter Section">
										      </div>
										    </div>
										    <div class="form-group">
										      <label class="control-label col-sm-2" for="pwd">Registration Passkey:</label>
										      <div class="col-sm-10">          
										        <input type="password" class="form-control" name="password" placeholder="Enter password">
										      </div>
										    </div>
										    <div class="form-group">        
										      <div class="col-sm-offset-2 col-sm-10">
										        <button type="submit" class="btn btn-default">Submit</button>
										      </div>
										    </div>
										  </form>
							         			
							        </div>
							        <div class="modal-footer">
							          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							        </div>
							      </div>
							      
							    </div>
							  </div>
							</div>
					</div>
					<div class="panel-body">
					<!-- /////////// Displays All Of His Classes\\\\\\\\\\\ -->
						<div class="container-fluid">
						  <div class="row">
						  	<div class="table-responsive">
						  		<table class="table table-striped table-hover">
						  			<thead>	
						  			<tr>
						  				<th> Class Name</th>
						  				<th> Pass key</th>
						  				<th> Classes held</th>
						  				<th> Students Enrolled</th>
						  				<th> View Class</th>
						  			</tr>
						  			</thead>
						  			<tbody>
						  			<%	
						  		
						  		    	
						  		    try{
						  				Class.forName(JDBC_DRIVER);
						  				conn = DriverManager.getConnection(DB_URL, USER, PASS);
						  			
						  				sql = "select classname,password,classcount,enrollednumber,class_id from class where t_id = ?";
						  		    	stmt = conn.prepareStatement(sql);
						  		    	stmt.setString(1,id);
						  		    	ResultSet rs=stmt.executeQuery();
						  		    	
						  		    		int count=0;
							  		    	while(rs.next())
							  		    	{	
							  		    		classlist.add(rs.getString(1));
							  		    		idlist.add(rs.getString(5));
							  		    		
							  		    		out.println("<tr class=' active'>");
							  		    		out.println("<td>"+rs.getString(1)+"</td>");
							  		    		out.println("<td>"+rs.getString(2)+"</td>");
							  		    		out.println("<td>"+rs.getString(3)+"</td>");
							  		    		out.println("<td>"+rs.getString(4)+"</td>");
							  		    		out.println("<td>"+"<form action='' method='POST'><button type='submit' class='btn btn-primary'>View <span class='glyphicon glyphicon-stats'></span></button></form>"+"</td>");
							  		    		out.println("</tr>");
							  		    		count++;
							  		    	}
							  		    	if(count==0)
							  		    	{
							  		    		out.println("no classes added");
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
					</div>
					</div>
					
					<div class="panel panel-default">
				      <div class="panel-heading"><b>Take Attendance</b></div>
				      <div class="panel-body">
				      		<table class="table table-striped table-hover">
				    			<thead>	
									<tr>
									  		<th> Class Name</th>
									  		<th> Take attendance</th>
									</tr>
								</thead>  			
								<tbody>
									<% 
									for(int i=0;i<classlist.size();i++)
									{
										out.println("<tr>");
											out.println("<td>");
												out.println(classlist.get(i));
											out.println("</td>");

											out.println("<td>");
												out.println("<form action='takeattendance.jsp' method='POST'><input type='hidden' name='class_id' value='"+idlist.get(i)+"'><button type='submit' class='btn btn-primary	'>Take Attendance</button></form>");
											out.println("</td>");
										out.println("</tr>");
									}
									%>
								</tbody>
				      		</table>
				      </div>
				    </div>
									
					
					
				<%
			}
			
			
		}
		else{
			String redirectURL = "login.jsp";
    	    response.sendRedirect(redirectURL);
			
		}
%>


</body>
</html>