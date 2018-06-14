<%@ page language="java" contentType="text/html; charset=UTF-8" import = "java.sql.*"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
   	String certPeriod = request.getParameter("userdate");	
	String userId = request.getParameter("userId");
	String trueFalse = request.getParameter("TF");

	Class.forName("com.mysql.jdbc.Driver"); 
	String DB_URL = "jdbc:mysql://localhost:3306/swpj?useUnicode=true&characterEncoding=utf8";
	String DB_USER = "swpjid"; 				
	String DB_PASSWORD= "swpjpass";
	
	String sql = "";	
	Connection conn= null;				
	Statement stmt = null;						
	
	try {			
	    conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);		
	    stmt = conn.createStatement();			
	    if(trueFalse.equals("approve")){	 //승인인 경우
	    	sql = "UPDATE member SET certPeriod=\'"+certPeriod+"\', certAprvTF=1 WHERE userId=\'"+userId+"\'";	    	
	    }else{								//거절인 경우
	    	sql = "UPDATE member SET certAprvTF=0, certPeriod='null' WHERE userId=\'"+userId+"\'";	
	    }
		stmt.executeUpdate(sql);
	    stmt.close();  
	    conn.close(); 	
	} catch (SQLException e) {
	      out.println("err:"+e.toString());
	} 
   
%>
<script>opener.location.href='certMng.jsp'; 
		window.close();
</script>


</body>
</html>