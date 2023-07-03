<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int currentPage = 1;
	int pageSize = 15;
	
	
	try
	{
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	catch(Exception exp)
	{
		
	}
	
	try
	{
		pageSize = Integer.parseInt(request.getParameter("pageSize"));
	}
	catch(Exception exp)
	{
		
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/product/list.js"></script>

<title>Insert title here</title>


<style type="text/css">
	.page-number {
		border: 1px solid black;
		margin: 5px;		
		padding: 5px;
		width: 20px;
		display: inline-block;
		width: 5%;
	}
	.page-number:hover
	{
		color: white;
		background-color: skyblue;
		cursor: pointer;
	}
	
	.page-number-current {
		background-color: cyan;
		color: black;
	}
	.page-number-current:hover {
		cursor: default;
	}
</style>


</head>
<body>
	<form id="form" action="<%=request.getContextPath() %>">
		<table border="1" cellpadding="5" cellspacing="1" style="width:90%;margin: 0px auto;">
			<thead>
				<tr>
					<th colspan="8">
						등록한 상품 목록
					</th>
				</tr>
				<tr>
					<th>순번</th>
					<th>카테고리</th>
					<th>이름</th>
					<th>남은 수량</th>
					<th>가격</th>
					<th>할인률</th>
					<th>배송비</th>
					<th>등록일</th>
				</tr>
			</thead>
			<tbody id="list">
			</tbody>
			<tfoot>
				<tr>
					<td colspan="8" align="center" id="pagination" height="50px">
						
					</td>
				</tr>
			</tfoot>			
		</table>
		<input type="hidden" id="currentPage" name="currentPage" value="<%=currentPage %>" />
		<input type="hidden" id="pageSize" name="pageSize" value="<%=pageSize %>" />
	</form>
</body>
</html>