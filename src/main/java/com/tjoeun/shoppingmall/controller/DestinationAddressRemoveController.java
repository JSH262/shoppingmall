package com.tjoeun.shoppingmall.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.gson.Gson;
import com.tjoeun.helper.Util;
import com.tjoeun.shoppingmall.service.DestinationAddressService;
import com.tjoeun.shoppingmall.vo.DestinationAddressVO;
import com.tjoeun.shoppingmall.vo.SettingVO;

/**
 * Servlet implementation class ImageController
 */
@Controller
public class DestinationAddressRemoveController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	SettingVO setting = null;

	@RequestMapping(value="/destaddr/remove", method=RequestMethod.POST)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		JSONObject retval = new JSONObject();
		DestinationAddressService service = DestinationAddressService.getInstance(); 
		
		
		try 
		{
			DestinationAddressVO params = new Gson().fromJson(Util.toBody(request), DestinationAddressVO.class);
			if(service.delete(params) == 1)
			{
				retval.put("code", 0);
			}
			else
			{
				retval.put("code", -998);
				retval.put("msg", "error");
			}
		}
		catch (Exception exp) 
		{
			exp.printStackTrace();
			retval.put("code", -999);
			retval.put("msg", exp.getMessage());
		}
		
		response.setContentType("application/json; charset=UTF-8");
		response.getWriter().write(retval.toJSONString());
		
	}

}
