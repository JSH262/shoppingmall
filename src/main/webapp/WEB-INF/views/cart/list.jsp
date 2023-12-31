<%@page import="org.apache.ibatis.session.SqlSession"%>
<%@page import="java.util.List"%>
<%@page import="com.tjoeun.shoppingmall.service.CartService"%>
<%@page import="com.tjoeun.shoppingmall.vo.CartVO"%>
<%@page import="com.tjoeun.helper.UsersType"%>
<%@page import="com.tjoeun.shoppingmall.vo.UsersVO"%>
<%@page import="com.tjoeun.helper.AttributeName"%>
<%@page import="com.tjoeun.shoppingmall.service.ProductService"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<%-- <link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css"/> --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-3.7.0.js"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js"></script>

<%-- <script type="text/javascript" src="<%=request.getContextPath() %>/js/bootstrap.js"></script> --%>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/product/cart/cart.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/bootstrap.css"/>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/bootstrap.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.3/font/bootstrap-icons.css">
<script>
       function productAmount(node, value)
       {
           let item = $(node).siblings('input[name=amount]');    
           let amount = parseInt(item.val()) + value;
            
           item.val(amount);
       }
    </script>
<style>
	.product-container {
		max-width: 1200px;
		display: grid;
		grid-template-columns: 47% auto 47%;
		grid-template-rows: 100%;
		margin: 0px auto;
	}
	
	.product-info-container {
		display: grid;						
		grid-template-rows: 10% 1% 1fr 1fr 1fr 1fr 10%;
		margin-left: 30px;
	}
	
	.product-image {
		text-align: center;
		justify-content: center;
		display: flex;
		align-items: center;
	}
	.product-cart {
		grid-column: 1/4;
		text-align: center;
		display:flex;
		align-items: center;
		justify-content: center;
							
	}
	.product-contents {
		text-align: center;
		justify-content: center;
		display: flex;
		align-items: center;
		margin-top: 100px;
	}
	
	
	span[name=score], span[name=review] {
		opacity: 0.0;
	}
	
				
	input[name=amount] {
		width: 40px;
		text-align: center;
		-moz-appearance: textfield;
	}
	input[name=amount]::-webkit-outer-spin-button, input[name=amount]::-webkit-inner-spin-button {
  			-webkit-appearance: none;
  			-moz-appearance: none;
  			appearance: none;
	}
			
	div[name=companyName] {
		font-size: 13pt;
		text-align: left;
		align-items: center;
		justify-content: flex-start;						
		display: flex;
	}
	div[name=name] {
		font-size: 28pt;
		align-items: center;
		justify-content: flex-start;						
		display: flex;
	}
	
	span[name=fmtDiscountPrice] {
		font-size: 18pt;
		font-weight: bold;
	}
	
	span[name=fmtPrice] {
		text-decoration: line-through;
	}
	
	span[name=fmtDiscount] {
		color: crimson;
		font-size: 14pt;
	
	}
	span[name=fmtPoint] {
		opacity: 0.0;
		color: skyblue;
	}				
	span[name=fmtPoint]:after {
		color: black;
		content: ' 적립'
	}
	span[name=amountGroup] {
	}

	
</style>
</head>
<%

//////////////////////////////////////////////////////////////// cart/list.jsp에서 상품이 비어있을 경우 비어있다고 표시하기
//////////////////////////////////////////////////////////////// cart/list.jsp 배송비 무료배송 표시

	UsersVO user = AttributeName.getUserData(request);
	String currentPage = request.getParameter("currentPage");
	// 카트로 수정
	CartVO params = new CartVO();
	params.setUserId(user.getId());
	List<CartVO> vo = CartService.getInstance().selectList(params);
	int count = CartService.getInstance().count(user.getId());
	for (int i = 0; i < count; i++) {
	    Integer amount = vo.get(i).getAmount();
	    String sellerId = vo.get(i).getSellerId();
	    String thumbnail = vo.get(i).getThumbnail();
	    String productName = vo.get(i).getProductName();
	    int discountPrice = vo.get(i).getDiscountPrice();
	    String companyName = vo.get(i).getCompanyName();
	    int delivery = vo.get(i).getDeliveryPrice();
		Long productId = vo.get(i).getProductId();
	    
	    if (thumbnail != null) {
	        thumbnail = request.getContextPath() + "/image/" + thumbnail;
	    } else {
	        thumbnail = "/resources/default/noimg.png";
	    }

%>
<body>
<div class="container gap-3 mt-5">
    <div class="row justify-content-center">
    <%-- 
        <div class="col-md-1">
            <!-- 체크박스 추가 -->
            <input type="checkbox" name="selectedProduct" value="<%= productId %>" />
        </div>
         --%>
        <div class="col-md-5">
            <img style="max-width:100%" src="<%= thumbnail %>" />
        </div>
        <div class="col-md-1">
            &nbsp;
        </div>
        <div class="col-md-5">
            <div class="row"><%= companyName %></div>
            <div class="row">
                <hr />
            </div>
            <div class="row">
                <div class="col-sm-12 fs-1">
                    <span><%= productName %></span>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <span name="score">★★★★☆</span>
                    <span name="review">(1,000)</span>
                </div>
            </div>
            <div class="row">
                <div class="row">&nbsp;</div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12">
                    <span name="delivery"><%= delivery %></span>
                </div>
            </div>
            <div class="row">
                <span name="fmtPoint">100P</span>
            </div>
        </div>
    </div>
    <div class="row pt-3 pb-3 bg-light" style="position: sticky; top:30px;">
        <div class="col-md-6">
            <span class="input-group mb-3 justify-content-end">
                <label class="input-group-text" for="amount">수량</label>
                <input class="form-control" style="max-width: 15%;" type="number" id="amount" name="amount" min="1" value="<%= amount %>" />
                <input class="btn btn-outline-secondary" type="button" value="-" onclick="productAmount(this, -1)"/>
                <input class="btn btn-outline-secondary" type="button" value="+" onclick="productAmount(this, 1)"/>
	            <input type="hidden" id="userId" name="userId" value="<%= user.getId() %>">
	            <input type="hidden" id="productId" name="productId" value="<%= productId %>">
	            <input class="btn btn-primary" type="button" value="적용하기" onclick="updateAmount(this)" />
	            <input class="btn btn-primary" type="button" value="삭제하기" onclick="deleteProduct(this)" />
            </span>
        </div>
        <div class="col-md-1">                  
            <span>&nbsp;</span>
        </div>
        <div class="col-md-5">
            <span class="input-group mb-3">
                <% if (amount == 0) { %>
                <input class="btn btn-secondary" type="button" value="품절" disabled />
                <% } %>                               
            </span>
        </div>
    </div>
</div>
<!-- 상품 컨테이너 끝 -->
<%
	}
%>
<!-- from사용 -->
<%-- 
<%
    StringBuilder productIdsBuilder = new StringBuilder();
    for (int i = 0; i < count; i++) {
        Integer productId = vo.get(i).getProductId();
        productIdsBuilder.append(productId);
        if (i != count - 1) {
            productIdsBuilder.append(",");
        }
    }
    String productIds = productIdsBuilder.toString();
%>
<!-- 버튼 -->
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <form action="order.jsp" method="get">
                <input type="hidden" name="ProductIds" value="<%= productIds %>" />
                <input class="btn btn-primary" type="submit" value="결제하기" />
            </form>
        </div>
    </div>
</div>
 --%>
 
 <!--  onclick 사용 -->
 <%
    // 변수를 선언하여 productid 값을 모두 저장
    StringBuilder productIdsBuilder = new StringBuilder();
    for (int i = 0; i < count; i++) {
        // 이전 코드 내용
        Long productId = vo.get(i).getProductId();
        productIdsBuilder.append(productId);
        if (i != count - 1) {
            productIdsBuilder.append(",");
        }
    }
    String productIds = productIdsBuilder.toString();
%>
<!-- 선택 상품 결제하기 버튼 -->
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <input type="hidden" name="ProductIds" value="<%= productIds %>" />
            <!-- 주석부분이 실사용(경로) -->
            <%-- <input class="btn btn-primary" type="button" value="결제하기" onclick="location.href='/product/order.jsp?ProductIds=<%= productIds %>'" /> --%>
            <!-- 테스트용 -->
            <input class="btn btn-primary" type="button" value="결제하기" onclick="location.href='<%=request.getContextPath() %>/product/order'" />
        </div>
    </div>
</div>

<div id="messageModal" class="modal fade" role="dialog" aria-hidden="true">
	<div class="vertical-alignment-helper">
		<div class="modal-dialog vertical-align-center">
			<!-- 모달 창의 종류(색상)를 설정한다. -->
			<!-- messageCheck라는 id를 추가하고 class를 제거한다. -->
			<div id="messageCheck">
				<div class="modal-header panel-heading">
					<button class="close" type="button" data-dismiss="modal">
						<span aria-hidden="true">&times;</span>
						<span class="sr-only">Close</span>
					</button>
					<!-- messageType이라는 id를 추가한다. -->
					<h4 id="messageType" class="modal-title">
						<%-- ${messageType} --%>
					</h4>
				</div>
				<!-- messageContent라는 id를 추가한다. -->
				<div id="messageContent" class="modal-body">
					<%-- ${messageContent} --%>
				</div>
				<div class="modal-footer">
					<button class="btn btn-primary" type="button" data-dismiss="modal">닫기</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
    $('#messageModal').on('hidden.bs.modal', function () {
        location.reload(); // 모달이 닫힐 때 페이지 리프레시
    });
</script>

</body>
</html>