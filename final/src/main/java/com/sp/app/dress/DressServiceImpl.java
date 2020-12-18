package com.sp.app.dress;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.dao.CommonDAO;

@Service("dress.dressService")
public class DressServiceImpl implements DressService{
	
	@Autowired
	private CommonDAO dao;
	
	
	
	@Override
	public void insertDress(Dress dto, String pathname) throws Exception {
		try {
			dao.insertData("dress.insertDress",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Dress> listDress(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Dress readDress(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateDress(Dress dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteDress(int num, String pathname, String userId) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
