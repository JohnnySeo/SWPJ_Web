<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javamysql.ConnectDB"%>
<%
	// 자바파일이 필요하므로 위 코드처럼 임포트합니다.
%>
<%
	request.setCharacterEncoding("UTF-8");
	String userId = request.getParameter("userId");
	String userName = request.getParameter("userName");
	String userPwd = request.getParameter("userPwd");
	String userPhone = request.getParameter("userPhone");
	String beaconNum = request.getParameter("beaconNum");
	String type = request.getParameter("type");
//로그인 요청인지 회원가입 요청인지를 구분하여 메서드를 실행하도록합니다.

System.out.println("받아온 타입 : " + type);

	//싱글톤 방식으로 자바 클래스를 불러옵니다.
	ConnectDB connectDB = ConnectDB.getInstance();
	if(type.equals("login")) {
		String returns = connectDB.logindb(userId, userPwd);
		out.print(returns);
	} else if(type.equals("join")) {
		String returns = connectDB.joindb(userId, userName, userPwd, userPhone);
		out.print(returns);
	} else if (type.equals("seatIn")) {
		String returns = connectDB.seatInChngdb(beaconNum);
		out.print(returns);		
	} else if(type.equals("seatOut")) {	
		String returns = connectDB.seatOutChngdb(beaconNum);
		out.print(returns);
	} else if(type.equals("seatInTime")) {	
		String returns = connectDB.seatInTimedb(userId, beaconNum);
		out.print(returns);
	} else if(type.equals("seatOutTime")) {	
		String returns = connectDB.seatOutTimedb(userId);
		out.print(returns);
	}
%>

