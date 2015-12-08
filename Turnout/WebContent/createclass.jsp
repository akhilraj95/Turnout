<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="java.sql.*,java.util.Calendar"%>
<%
	String subject = request.getParameter("subject");
	String classyear = request.getParameter("year");
	String section = request.getParameter("section");
	String password = request.getParameter("password");
	int year = Calendar.getInstance().get(Calendar.YEAR);
	year = year%1000;
	
	//getting the session variables(session var map given at the top)
	String user = (String) session.getAttribute("USER");
	String username =(String)  session.getAttribute("USERNAME");
	String id = (String) session.getAttribute("ID");
	
	//CREATING A CLASSNAME
	String classname = subject+classyear+section+String.valueOf(year);
	out.println(classname);
	
	// JDBC driver name and database URL
    String JDBC_DRIVER = "com.mysql.jdbc.Driver";  
    String DB_URL = "jdbc:mysql://www.virtualhighs.com:3306/turnout";

   //  Database credentials
    String USER = "ateam";
    String PASS = "1191995";

    Connection conn = null;
    PreparedStatement stmt = null;
    String sql = null;
    
    try{
		Class.forName(JDBC_DRIVER);
		conn = DriverManager.getConnection(DB_URL, USER, PASS);
    
		
		
		sql = "select count(*) from class where classname = ?";
    	stmt = conn.prepareStatement(sql);
    	stmt.setString(1,classname);
    	ResultSet rs=stmt.executeQuery();
    	
    	if(rs.next())
    		if(rs.getInt(1)==0)
    		{
    			
    			sql = "insert into class(classname,password,t_id) values(?,?,?)";
    	    	stmt = conn.prepareStatement(sql);
    	    	stmt.setString(1, classname);
    	    	stmt.setString(2, password);
    	    	stmt.setString(3, id);
    	    	int check = stmt.executeUpdate();	
    	    	
	    	    	if(check>0)
	    	    	{
			    		String redirectURL = "index.jsp";
			    	    response.sendRedirect(redirectURL);
	    	    	}
    			
    		}
    		else{
    			
    			   out.println("<script type=\"text/javascript\">");
    			   out.println("alert('Class already exists');");
    			   out.println("location='index.jsp';");
    			   out.println("</script>");
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