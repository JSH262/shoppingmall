package com.tjoeun.shoppingmall.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.tjoeun.helper.AttributeName;
import com.tjoeun.mybatis.MySession;
import com.tjoeun.shoppingmall.dao.CartDAO;
import com.tjoeun.shoppingmall.dao.CategoryDAO;
import com.tjoeun.shoppingmall.dao.MyPageDAO;
import com.tjoeun.shoppingmall.dao.ProductDAO;
import com.tjoeun.shoppingmall.vo.CartVO;
import com.tjoeun.shoppingmall.vo.CategoryVO;
import com.tjoeun.shoppingmall.vo.ProductVO;
import com.tjoeun.shoppingmall.vo.UsersVO;

public class MyPageService 
{
	static MyPageService g_inst = new MyPageService();
	MyPageService() {}
	static public MyPageService getInstance()
	{
		return g_inst;
	}
	
	static MyPageDAO dao = MyPageDAO.getInstance();
	
	public int passwordCheck(UsersVO vo) {
		SqlSession mapper = MySession.getSession();
		int res = 0;
		try {
			res = dao.passwordCheck(mapper, vo);
			mapper.commit();
		} catch (Exception e) {
			e.printStackTrace();
			mapper.rollback();
		}
		mapper.close();
		return res;
	}
	public int passwordUpdate(UsersVO vo) {
		SqlSession mapper = MySession.getSession();
		int res = 0;
		try {
			res = dao.passwordUpdate(mapper, vo);
			mapper.commit();
		} catch (Exception e) {
			e.printStackTrace();
			mapper.rollback();
		}
		mapper.close();
		return res;
	}
	public int unregister(UsersVO vo) {
		SqlSession mapper = MySession.getSession();
		int res = 0;
		try {
			res = dao.unregister(mapper, vo);
			mapper.commit();
		} catch (Exception e) {
			mapper.rollback();
		}
		mapper.close();
		return res;
	}
	public int userUpdate(UsersVO vo) {
		SqlSession mapper = MySession.getSession();
		int res = 0;
		try {
			res = dao.userUpdate(mapper, vo);
			mapper.commit();
		} catch (Exception e) {
			e.printStackTrace();
			mapper.rollback();
		}
		mapper.close();
		return res;
	}
	
	
}
