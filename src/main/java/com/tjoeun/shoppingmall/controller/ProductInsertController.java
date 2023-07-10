package com.tjoeun.shoppingmall.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.tjoeun.helper.AttributeName;
import com.tjoeun.helper.UsersType;
import com.tjoeun.shoppingmall.service.ProductService;
import com.tjoeun.shoppingmall.service.SettingService;
import com.tjoeun.shoppingmall.vo.ProductVO;
import com.tjoeun.shoppingmall.vo.SettingVO;
import com.tjoeun.shoppingmall.vo.UsersVO;

/**
 * Servlet implementation class ProductController
 */
@WebServlet("/product/insert")
public class ProductInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String JSP_PATH = "/WEB-INF/product/";
    SettingVO setting = null;
    
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductInsertController() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    @Override
	public void init() throws ServletException {

		super.init();
		
		this.setting = SettingService.getInstance().select();		
	}


	public String getCmd(HttpServletRequest request)
    {
    	String uri = request.getRequestURI();
    	int start = uri.lastIndexOf("/");
    	
    	return uri.substring(start + 1);
    }
    
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{				
		response.getWriter().write("???");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject retval = new JSONObject();
		
		try
		{
			UsersVO user = AttributeName.getUserData(request);
			if(UsersType.SELLER.equals(user.getType()))
			{
				String sellerId = user.getId();
				
				MultipartRequest mr = new MultipartRequest(request, this.getServletContext().getRealPath(""), 8000000, "UTF-8", new DefaultFileRenamePolicy());
				String uploadUrl = setting.getUploadPath() + "/image/";
				ProductVO item = new ProductVO(mr);
				File uploadFile = mr.getFile("file");
				
				if(uploadFile != null)
				{
					String uploadResult = com.tjoeun.helper.Util.SendPostImage(new File[] {uploadFile}, "file", uploadUrl, null);
					org.json.simple.parser.JSONParser parser = new org.json.simple.parser.JSONParser();
					JSONObject jUploadResult = (JSONObject)parser.parse(uploadResult);
								
					if(jUploadResult.get("code").equals(0) || jUploadResult.get("code").equals(0L))
					{
						// 3. 상품 정보를 저장한다.
						JSONArray arrResult = (JSONArray)jUploadResult.get("result");
						item.setThumbnail((String)arrResult.get(0));		
						retval.put("uploadCode", 0);
					}
					else
					{
						//업로드 실패
						retval.put("uploadCode", jUploadResult.get("code"));
						retval.put("uploadMsg", jUploadResult.get("msg"));
						item.setThumbnail("");
					}
				}
				else
				{
					item.setThumbnail("");
				}
				
				item.setSellerId(sellerId);
							
				if(ProductService.getInstance().insert(item) == 1)
				{
					retval.put("code", 0);
					retval.put("msg", "상품등록 성공");
					retval.put("result", request.getContextPath() + "/product/list.jsp");
				}
				else
				{
					retval.put("code", -3);
					retval.put("msg", "상품등록 실패");
				}
			}
			else
			{
				retval.put("code", -99);
				retval.put("msg", "잘못된 접근입니다.");
			}
			
		}
		catch(Exception exp)
		{
			retval.put("code", -2);
			retval.put("msg", exp.getMessage());
			
			exp.printStackTrace();
		}
		
		
		response.setContentType("applicatoin/json; charset=UTF-8");
		
		response.getWriter().write(retval.toJSONString());
	}
	
	/*
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		JSONObject retval = new JSONObject();
		
		try
		{
			MultipartRequest mr = new MultipartRequest(request, this.getServletContext().getRealPath(""), 8000000, "UTF-8", new DefaultFileRenamePolicy());
			String uploadUrl = setting.getUploadPath() + "/image/";
			ProductVO item = new ProductVO(mr);
			File uploadFile = mr.getFile("file");
			
///////////////////////////////////////////////////////////////////////////////////////// 테스트 용
			String sellerId = "asdf1234";
			
			if(uploadFile != null)
			{
				String uploadResult = com.tjoeun.helper.Util.SendPostImage(new File[] {uploadFile}, "file", uploadUrl, null);
				org.json.simple.parser.JSONParser parser = new org.json.simple.parser.JSONParser();
				JSONObject jUploadResult = (JSONObject)parser.parse(uploadResult);
							
				if(jUploadResult.get("code").equals(0) || jUploadResult.get("code").equals(0L))
				{
					// 3. 상품 정보를 저장한다.
					JSONArray arrResult = (JSONArray)jUploadResult.get("result");
					item.setThumbnail((String)arrResult.get(0));		
					retval.put("uploadCode", 0);
				}
				else
				{
					//업로드 실패
					retval.put("uploadCode", jUploadResult.get("code"));
					retval.put("uploadMsg", jUploadResult.get("msg"));
				}
			}
			
			item.setSellerId(sellerId);
						
			if(ProductService.getInstance().insert(item) == 1)
			{
				retval.put("code", 0);
				retval.put("msg", "상품등록 성공");
				retval.put("result", request.getContextPath() + "/product/list.jsp");
			}
			else
			{
				retval.put("code", -3);
				retval.put("msg", "상품등록 실패");
			}
		}
		catch(Exception exp)
		{
			retval.put("code", -2);
			retval.put("msg", exp.getMessage());
			
			exp.printStackTrace();
		}
		
		
		response.setContentType("applicatoin/json; charset=UTF-8");
		
		response.getWriter().write(retval.toJSONString());
	}
	*/
	

}