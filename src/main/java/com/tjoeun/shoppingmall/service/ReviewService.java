package com.tjoeun.shoppingmall.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.tjoeun.exception.ErrorCodeException;
import com.tjoeun.helper.TransactionHelper;
import com.tjoeun.shoppingmall.dao.ReviewDAO;
import com.tjoeun.shoppingmall.vo.ReviewVO;

@Service
@Transactional(readOnly=true)
public class ReviewService {
	
	Logger log = LoggerFactory.getLogger(this.getClass());
	
	/*
	@Autowired
	org.mybatis.spring.SqlSessionTemplate sqlSession;

	@Autowired
	org.springframework.jdbc.datasource.DataSourceTransactionManager transactionManager;
	//*/
	
	@Autowired
	ReviewDAO reviewDAO;
	
	@Transactional
	public int ReviewInsert(ReviewVO vo) throws ErrorCodeException
	{
		/*
		TransactionHelper th = new TransactionHelper(this.sqlSession, this.transactionManager);
	    int result = 0;
	    
	    try {
	    	ReviewDAO dao = th.getMapper(ReviewDAO.class);
	        result = dao.insert(vo); // �꽦怨� �떆 1 �븷�떦
	        
	        th.commit();
	    } catch (Exception e) {
	    	th.rollback();
			log.error("", e);
	        result = 2; // �떎�뙣 �떆 2 �븷�떦
	    }
	    
	    return result;
	    //*/
		
		try
		{
			return reviewDAO.insert(vo);
		}
		catch(Exception exp)
		{
			throw new ErrorCodeException(2, exp.getMessage());
		}
	}
	public List<Object> selectByUserId(String userId) {
		/*
		TransactionHelper th = new TransactionHelper(this.sqlSession, this.transactionManager);
		List<Object> list = null;  
		try 
		{
			ReviewDAO dao = th.getMapper(ReviewDAO.class);
			list = dao.selectByUserId(userId);
			th.commit();
	    } catch (Exception e) {
	    	th.rollback();
			log.error("", e);
	    } finally {
	    }
		
		return list;
		//*/
		
		return reviewDAO.selectByUserId(userId);
	}
	
	@Transactional
	public int deleteReview(ReviewVO vo) {
		/*
		int retval = 0;
		TransactionHelper th = new TransactionHelper(this.sqlSession, this.transactionManager);
		
		try
		{
			ReviewDAO dao = th.getMapper(ReviewDAO.class);
			retval = dao.deleteReview(vo);
	        th.commit();
		}
		catch(Exception exp)
		{
	    	th.rollback();
			log.error("", exp);
		}
		
		return retval;
		//*/
		return reviewDAO.deleteReview(vo);
	}
	
	public int already(int orderId) {
		/*
		int res = 0;
		TransactionHelper th = new TransactionHelper(this.sqlSession, this.transactionManager);
		
		try {
			ReviewDAO dao = th.getMapper(ReviewDAO.class);
			res = dao.already(orderId);
			th.commit();
		} catch (Exception e) {
	    	th.rollback();
			log.error("", e);
		}
		return res;
		//*/
		return reviewDAO.already(orderId);
	}




}
