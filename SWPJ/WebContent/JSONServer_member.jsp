 <%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8" import="org.json.simple.*" import="java.net.URLEncoder"%>


<%@ page import="javamysql.ConnectDB"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("UTF-8");
	String userId = request.getParameter("userId");

//로그인 요청인지 회원가입 요청인지를 구분하여 메서드를 실행하도록합니다.

	//싱글톤 방식으로 자바 클래스를 불러옵니다.
	ConnectDB connectDB = ConnectDB.getInstance();

	JSONArray returns = connectDB.getUserInfodb(userId);
	out.print(returns);

%>




