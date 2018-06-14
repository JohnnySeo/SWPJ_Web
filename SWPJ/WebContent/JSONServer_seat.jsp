 <%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding="UTF-8" import="org.json.simple.*" import="java.net.URLEncoder"%>


<%@ page import="javamysql.ConnectDB"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("UTF-8");
	String bTrainNo = request.getParameter("bTrainNo");


	//싱글톤 방식으로 자바 클래스를 불러옵니다.
	ConnectDB connectDB = ConnectDB.getInstance();
	System.out.println("bTrainNo = "+bTrainNo);

	JSONArray returns = connectDB.getSeatInfodb(bTrainNo);	
	out.print(returns);
	returns.clear();
%>


