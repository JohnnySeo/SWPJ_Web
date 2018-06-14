<%@ page contentType="text/html;charset=euc-kr" %>
<%
   String userId = request.getParameter("userId");
   userId = new String(userId.getBytes("ISO-8859-1"),"euc-kr");   
%>

<script>document.getElementById('datePicker').valueAsDate = new Date();</script>

<form id="certDate" action="certDateInput.jsp">
    <p>인증서 만료일 입력:</p>
    <div><input type="date" id="datePicker" name="userdate"></div>
    <input type="hidden" name="userId" value=<%=userId%>>
    <input type="hidden" name="TF" value="approve">
    <div><input type="submit" value="승인"></div>
</form>
<form id="certReject" action="certDateInput.jsp">
	<input type="hidden" name="userId" value=<%=userId%>>
	<input type="hidden" name="TF" value="reject">
	<input type="submit" value="거절">
</form>


