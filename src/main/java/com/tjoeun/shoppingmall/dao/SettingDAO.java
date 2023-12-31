package com.tjoeun.shoppingmall.dao;

import org.apache.ibatis.session.SqlSession;

import com.tjoeun.shoppingmall.vo.ProductVO;
import com.tjoeun.shoppingmall.vo.SettingVO;

public class SettingDAO {
	static SettingDAO g_inst = new SettingDAO();
	SettingDAO() {}
	
	static public SettingDAO getInstance()
	{
		return g_inst;
	}
	
	public int insert(SqlSession mapper, ProductVO item)
	{
		return mapper.insert("Setting.insert", item);
	}
	
	public SettingVO select(SqlSession mapper)
	{
		return (SettingVO)mapper.selectOne("Setting.select");
	}
}
