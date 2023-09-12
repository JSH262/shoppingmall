<%@page import="com.tjoeun.shoppingmall.vo.UsersVO"%>
<%@page import="com.tjoeun.helper.AttributeName"%>
<%@page import="com.tjoeun.helper.Util"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>shoppingmall</title>
	
	<%@ include file="/WEB-INF/component/header/common.jsp" %>
	
	<script src="<%=request.getContextPath() %>/js/customAlert.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/index.js"></script>
	
	<style>
		#carousel-body img {
		  	object-fit: none;
		  	height: 300px;
		}
		
		.newProductCursor {
			cursor:pointer;
		}
		.newProductImageDuration {
			transition-duration: .2s;
		}
		
		.newProductImageDuration-hover {
			transform: scale(1.1, 1.1);
		}
		
		.newProductShadow {
			box-shadow: 3px 3px 3px 3px lightgray;
		}
		.overlay-contents {
			position: absolute;
		    background-color: rgba(0,0,0,0.1);
	    	width: 100%;
	    	height: 100%;
	   	 	font-size: xx-large;
	   	 	text-align: center;
	   	 	justify-content: center;
	    	align-items: center;
	    	display: flex;
		}
		div[name=overlayContents] 
		{
			position: absolute;
			right:40%;
			bottom:50%
			
		}
		
		
		div[name=newProductItem]:hover {
			cursor: pointer;
		}
		
		#carousel-body {
			cursor: pointer;
		}
		
		#newProductGup {
			max-width: 1200px;
			margin: auto;
		}
		
	</style>
</head>
<body>
	<%@ include file="/WEB-INF/component/header.jsp" %>

	<div class="p-5">
		<div id="carouselLotSellGup">
			<div id="carouselLotSellTitle" class="fs-1">
				많이 팔린 상품
			</div>
			<div id="carouselLotSell" class="carousel carousel-dark slide" data-bs-ride="carousel">
				
				<%-- 이미지 밑의 선택된 이미지 및 이미지 목록들 --%>
				<div class="carousel-indicators" id="carousel-indicator">
					<%--			
					<button class="active" aria-current="true"  
							type="button" data-bs-target="#carouselLotSell" data-bs-slide-to="0" aria-label="Slide 1"></button>
					<button type="button" data-bs-target="#carouselLotSell" data-bs-slide-to="1" aria-label="Slide 2"></button>
					<button type="button" data-bs-target="#carouselLotSell" data-bs-slide-to="2" aria-label="Slide 3"></button>
					<button type="button" data-bs-target="#carouselLotSell" data-bs-slide-to="3" aria-label="Slide 4"></button>
					 --%>
				</div>
				
				<%-- 이미지들 --%>
				<div class="carousel-inner" id="carousel-body">
					<div class="carousel-item active placeholder-glow" name="carousel-loading">
						<img class="placeholder col-12 ratio ratio-21x9 mx-auto d-block d-block w-100" src="">
					</div>
					<%--
					<div class="carousel-item active" data-bs-interval="3000">
						<img class="ratio ratio-21x9 mx-auto d-block" src="<%=request.getContextPath() %>/image/11ee340654fc4111b956dd7a96c7332c" class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item" data-bs-interval="3000">
						<img class="ratio ratio-21x9 mx-auto d-block" src="<%=request.getContextPath() %>/image/11ee340585123d80b956651ffe5e5aa3" class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item" data-bs-interval="3000">
						<img class="ratio ratio-21x9 mx-auto d-block" src="<%=request.getContextPath() %>/image/11ee34057f5e4775b9564175e94239a8" class="d-block w-100" alt="...">
					</div>
					<div class="carousel-item" data-bs-interval="3000">
						<img class="ratio ratio-21x9 mx-auto d-block" src="<%=request.getContextPath() %>/image/11ee34057f5e4775b9564175e94239a8" class="d-block w-100" alt="...">
					</div>
					 --%>
				</div>
				
				<%-- 이미지 왼쪽에 있는 이동 버튼 --%>
				<button class="carousel-control-prev" type="button" data-bs-target="#carouselLotSell" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span> 
					<span class="visually-hidden">Previous</span>
				</button>
				
				<%-- 이미지 오른쪽에 있는 이동 버튼 --%>
				<button class="carousel-control-next" type="button" data-bs-target="#carouselLotSell" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
		</div>
		<hr />
	
		<div id="newProductGup">
			<div id="newProductTitle" class="fs-1">
				신상품
			</div>
			<div class="row row-cols-1 row-cols-md-4 g-4" id="newProductsBody">
			
				<%-- 상품 로딩중 표시 --%>
				<div class="col" name="newProductLoading">
					<div class="card" aria-hidden="true">
						<div class="carousel-item active placeholder-glow" name="carousel-loading">
							<img class="placeholder col-12 ratio ratio-1x1 mx-auto d-block d-block w-100" src="">
						</div>					
						<div class="card-body">
							<h5 class="card-title placeholder-glow">
								<span class="placeholder col-6"></span>
							</h5>
							<p class="card-text placeholder-glow">
								<span class="placeholder col-7"></span> 
								<span class="placeholder col-4"></span> 
								<span class="placeholder col-4"></span> 
								<span class="placeholder col-6"></span> 
								<span class="placeholder col-8"></span>
							</p>
							<a href="#" tabindex="-1" class="btn btn-primary disabled placeholder col-6"></a>
						</div>
					</div>
				</div>
				<div class="col" name="newProductLoading">
					<div class="card" aria-hidden="true">
						<div class="carousel-item active placeholder-glow" name="carousel-loading">
							<img class="placeholder col-12 ratio ratio-1x1 mx-auto d-block d-block w-100" src="">
						</div>					
						<div class="card-body">
							<h5 class="card-title placeholder-glow">
								<span class="placeholder col-6"></span>
							</h5>
							<p class="card-text placeholder-glow">
								<span class="placeholder col-7"></span> 
								<span class="placeholder col-4"></span> 
								<span class="placeholder col-4"></span> 
								<span class="placeholder col-6"></span> 
								<span class="placeholder col-8"></span>
							</p>
							<a href="#" tabindex="-1" class="btn btn-primary disabled placeholder col-6"></a>
						</div>
					</div>
				</div>
				<div class="col" name="newProductLoading">
					<div class="card" aria-hidden="true">
						<div class="carousel-item active placeholder-glow" name="carousel-loading">
							<img class="placeholder col-12 ratio ratio-1x1 mx-auto d-block d-block w-100" src="" />
						</div>
						<div class="card-body">
							<h5 class="card-title placeholder-glow">
								<span class="placeholder col-6"></span>
							</h5>
							<p class="card-text placeholder-glow">
								<span class="placeholder col-7"></span> 
								<span class="placeholder col-4"></span> 
								<span class="placeholder col-4"></span> 
								<span class="placeholder col-6"></span> 
								<span class="placeholder col-8"></span>
							</p>
							<a href="#" tabindex="-1" class="btn btn-primary disabled placeholder col-6"></a>
						</div>
					</div>
				</div>
				<div class="col" name="newProductLoading">
					<div class="card" aria-hidden="true">
						<div class="carousel-item active placeholder-glow" name="carousel-loading">
							<img class="placeholder col-12 ratio ratio-1x1 mx-auto d-block d-block w-100" src="">
						</div>					
						<div class="card-body">
							<h5 class="card-title placeholder-glow">
								<span class="placeholder col-6"></span>
							</h5>
							<p class="card-text placeholder-glow">
								<span class="placeholder col-7"></span> 
								<span class="placeholder col-4"></span> 
								<span class="placeholder col-4"></span> 
								<span class="placeholder col-6"></span> 
								<span class="placeholder col-8"></span>
							</p>
							<a href="#" tabindex="-1" class="btn btn-primary disabled placeholder col-6"></a>
						</div>
					</div>
				</div>
				<div class="col" name="newProductLoading">
					<div class="card" aria-hidden="true">
						<div class="carousel-item active placeholder-glow" name="carousel-loading">
							<img class="placeholder col-12 ratio ratio-1x1 mx-auto d-block d-block w-100" src="">
						</div>					
						<div class="card-body">
							<h5 class="card-title placeholder-glow">
								<span class="placeholder col-6"></span>
							</h5>
							<p class="card-text placeholder-glow">
								<span class="placeholder col-7"></span> 
								<span class="placeholder col-4"></span> 
								<span class="placeholder col-4"></span> 
								<span class="placeholder col-6"></span> 
								<span class="placeholder col-8"></span>
							</p>
							<a href="#" tabindex="-1" class="btn btn-primary disabled placeholder col-6"></a>
						</div>
					</div>
				</div>
				<div class="col" name="newProductLoading">
					<div class="card" aria-hidden="true">
						<div class="carousel-item active placeholder-glow" name="carousel-loading">
							<img class="placeholder col-12 ratio ratio-1x1 mx-auto d-block d-block w-100" src="">
						</div>					
						<div class="card-body">
							<h5 class="card-title placeholder-glow">
								<span class="placeholder col-6"></span>
							</h5>
							<p class="card-text placeholder-glow">
								<span class="placeholder col-7"></span> 
								<span class="placeholder col-4"></span> 
								<span class="placeholder col-4"></span> 
								<span class="placeholder col-6"></span> 
								<span class="placeholder col-8"></span>
							</p>
							<a href="#" tabindex="-1" class="btn btn-primary disabled placeholder col-6"></a>
						</div>
					</div>
				</div>
				
			</div>
		</div>
	</div>

	<%@ include file="/WEB-INF/component/footer.jsp" %>

</body>
</html>