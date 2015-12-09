/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2015-12-09 06:22:09 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.util.Calendar;

public final class createclass_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\r');
      out.write('\n');

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

    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}