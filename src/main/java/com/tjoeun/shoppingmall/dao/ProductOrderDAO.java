package com.tjoeun.shoppingmall.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.SqlSession;

import com.tjoeun.shoppingmall.vo.CartVO;
import com.tjoeun.shoppingmall.vo.CategoryVO;
import com.tjoeun.shoppingmall.vo.PaymentVO;
import com.tjoeun.shoppingmall.vo.ProductOrderVO;

@Mapper
public interface ProductOrderDAO 
{
	public int insert(ProductOrderVO item);
	public long selectId(ProductOrderVO item);
	public List<ProductOrderVO> selectList(ProductOrderVO item);
	public int update(ProductOrderVO item);
	public int totalCount(ProductOrderVO item);
	public ProductOrderVO select(ProductOrderVO item);
}


/*

public class ProductOrderDAO 
{
	static ProductOrderDAO g_inst = new ProductOrderDAO();
	ProductOrderDAO() {}
	
	static public ProductOrderDAO getInstance()
	{
		return g_inst;
	}

	public int insert(SqlSession mapper, ProductOrderVO item)
	{
		return mapper.insert("ProductOrder.insert", item);
	}
	
	public long selectId(SqlSession mapper, ProductOrderVO item)
	{
		return (long) mapper.selectOne("ProductOrder.selectId", item);
	}
	
	public List<ProductOrderVO> selectList(SqlSession mapper, ProductOrderVO item)
	{
		return mapper.selectList("ProductOrder.selectList", item);
	}
	
	public int update(SqlSession mapper, ProductOrderVO item)
	{
		return mapper.update("ProductOrder.update", item);
	}
	

	public int totalCount(SqlSession mapper, ProductOrderVO item)
	{
		return (int)mapper.selectOne("ProductOrder.totalCount", item);
	}

	public ProductOrderVO select(SqlSession mapper, ProductOrderVO item) 
	{
		return (ProductOrderVO) mapper.selectOne("ProductOrder.select", item);
	}
}
//*/
