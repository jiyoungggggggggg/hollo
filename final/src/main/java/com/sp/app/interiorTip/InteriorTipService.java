package com.sp.app.interiorTip;

import java.util.List;
import java.util.Map;


import com.sp.app.interior.Reply;






public interface InteriorTipService {
	public void insertBoard(InteriorTip dto) throws Exception;
	public void updateHitCount(int num) throws Exception;
	public InteriorTip readBoard(int num);
	public InteriorTip preReadBoard(Map<String, Object> map);
	public InteriorTip nextReadBoard(Map<String, Object> map);
	public void updateBoard(InteriorTip dto) throws Exception;
	public void deleteBoard(int num , String userId) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<InteriorTip> listBoard(Map<String, Object> map);
	
	public void insertReply(Reply dto) throws Exception;
}