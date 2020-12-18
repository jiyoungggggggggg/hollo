package com.sp.app.cook.honCooq.cookTip;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;

@Service("honCooq.cookTipService")
public class CookTipServiceImpl implements CookTipService{
	@Autowired
	private CommonDAO dao;

	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertCookTip(CookTip dto, String pathname) throws Exception {
		try {
			dao.insertData("cookTip.insertCookTip", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}		
	}

	@Override
	public List<CookTip> listCookTip(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public CookTip readCookTip(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public CookTip preReadCookTip(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public CookTip nextReadCookTip(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateCookTip(CookTip dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteCookTip(int num, String pathname, String userId) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void insertCookTipLike(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public int CookTipLikeCount(int num) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int replyAnswerCount(int answer) {
		// TODO Auto-generated method stub
		return 0;
	}	
	
}