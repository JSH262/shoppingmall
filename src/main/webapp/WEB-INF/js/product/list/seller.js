
$(() => {
	const CONTEXT_PATH = $("#contextPath").val();
	const CURRENT_PAGE =  parseInt($("#currentPage").val());
	const PAGE_SIZE = parseInt($("#pageSize").val());
	
	
	
	$("#list").empty();
	$("#pagination").empty();
			
	$("#registerProduct").bind('click', function() {
		let cPage = $("#currentPage").val();
		let pSize = $("#pageSize").val();
		location.href = `${CONTEXT_PATH}/product/insert?currentPage=${cPage}&pageSize=${pSize}`;
	});
	let searCat = null;
	let searVal = null;
	
	let successSearchData = function(nCurrentPage, nPageSize, searchCategory, searchValue) 
	{
		if(!nCurrentPage)
			nCurrentPage = CURRENT_PAGE;

		if(!nPageSize)
			nPageSize = PAGE_SIZE;
		
		let data = {
			searchCategory: searchCategory,
			searchValue: searchValue,
			currentPage: nCurrentPage,
			pageSize: nPageSize	 
		};
				
		Ajax(`${CONTEXT_PATH}/product/list`, "POST", JSON.stringify(data), 
			function(resp)
			{
				$("#list").empty();
				$("#pagination").empty();
				
				let list = resp.result.list;
				let currentPage = resp.result.paging.currentPage;
				let pageSize = resp.result.paging.pageSize;
							
				for(let i = 0; i<list.length; i++)
				{
					let item = list[i];
					let tr = $('<tr>');
											
					//tr.append(`<td>${item.id}</td>`);
					tr.append(`<td align="center">${item.rnum}</td>`);
					tr.append(`<td align="center">${item.categoryName}</td>`);				
					tr.append(`<td align="center"><a href="${CONTEXT_PATH}/product/detail?id=${item.id}&pageSize=${pageSize}&currentPage=${currentPage}">${item.name}</a></td>`);				
					
					if(item.amount != 0)
						tr.append(`<td align="center">${item.fmtAmount}</td>`);
					else
						tr.append(`<td class="product-sold-out" align="center">${item.fmtAmount}</td>`);
					
					
					tr.append(`<td align="center">${item.fmtPrice}</td>`);
					tr.append(`<td align="center">${item.fmtDiscount}</td>`);
					tr.append(`<td align="center">${item.fmtDeliveryPrice}</td>`);
					tr.append(`<td align="center">${item.createDate}</td>`);
					
					$("#list").append(tr);
				}
				
				
				//페이지 순번 추가
				let pagination = resp.result.paging;		
							
				//이전
				let prevNode = null;
				if(pagination.startPage == 1)
				{
					prevNode = $(`<span class="page-number page-number-current">이전</span>`);
				}
				else
				{
					prevNode = $(`<span class="page-number">이전</span>`);
					prevNode.bind('click', function() {
						successSearchData(pagination.startPage - 1, pageSize, searchCategory, searchValue);
					});
				}
				$("#pagination").append(prevNode);
				
				//1 ~ 10	
				for(let i = pagination.startPage; i<=pagination.endPage; i++)
				{
					let node = null;
					
					if(i == currentPage)
					{
						node = $(`<span class="page-number page-number-current">${i}</span>`);	
					}
					else
					{
						node = $(`<span class="page-number">${i}</span>`);		
						node.bind('click', function() {
							successSearchData(i, pageSize, searchCategory, searchValue);
						});	
					}
					
					$("#pagination").append(node);
				}						
				
				//다음
				let nextNode = null;
				if(pagination.endPage < pagination.totalPage)
				{
					nextNode = $(`<span class="page-number">다음</span>`);
					nextNode.bind('click', function() {
						successSearchData(pagination.endPage + 1, pageSize, searchCategory, searchValue);
					});
				}
				else
				{
					nextNode = $(`<span class="page-number page-number-current">다음</span>`);
				}
				$("#pagination").append(nextNode);
								
				$("#currentPage").val(currentPage);
				$("#pageSize").val(pageSize);
			},
			function(err)
			{
				console.error(err);
			});		
	};//let successSearchData = function(nCurrentPage, nPageSize, searchCategory, searchValue) 
	
	
	
	successSearchData();
	
	$("#searchProduct").bind('click', function(){
		searVal = $("#searchValue").val();
		if(searVal)
		{
			searCat = $("#searchCategory").val();	
		}
		else
		{
			searCat = null;
			searVal = null;
		}
		
		
		successSearchData(1, PAGE_SIZE, searCat, searVal);
	});	
	
	
	$("#searchValue").bind('keyup', function(e)	{
		
		//Enter
		if(e.keyCode == 13)
		{
			$("#search").trigger('click');
		}
		
	});
	
		
});