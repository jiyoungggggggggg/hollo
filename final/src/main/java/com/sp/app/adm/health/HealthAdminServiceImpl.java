package com.sp.app.adm.health;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;

@Service("adm.health.healthAdminService")
public class HealthAdminServiceImpl implements HealthAdminService {

	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	//challenge 1,2 같이 insert
	@Override
	public void insertChallenge(HealthAdmin dto, String pathname) throws Exception {
		try {
			long seq = dao.selectOne("healthAdmin.challengeSeq");
			dto.setNum(seq);
			
			String challengeFilename = fileManager.doFileUpload(dto.getUpload(), pathname);
			if(challengeFilename!=null) {
				dto.setChallengeFilename(challengeFilename);
			}
			//기본정보 인서트
			dao.insertData("healthAdmin.insertChallenge", dto);
			
			List<String> startDates = dto.getStartDates();
			
			// 상세정보 갯수만큼 for문 실행됨
			int exNum=1;
			for(int i=0; i<startDates.size(); i++) {
				dto.setExNum(exNum);
			    dto.setStartDate(dto.getStartDates().get(i));
			    dto.setEndDate(dto.getEndDates().get(i));
			    dto.setExContent(dto.getExContents().get(i));

			    insertChallengeMore(dto);
			    
			    exNum++;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	//challenge 2만 insert 따로(위에 insert에서 사용)
	@Override
	public void insertChallengeMore(HealthAdmin dto) throws Exception {
		try {
			dao.insertData("healthAdmin.insertChallenge2", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deleteChallenge(int num, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateChallenge(HealthAdmin dto, String pathname) throws Exception {
		// TODO Auto-generated method stub
		
	}


	@Override
	public HealthAdmin readChallenge(int num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<HealthAdmin> listChallenge(Map<String, Object> map) {
		List<HealthAdmin> list = null;
		try {
			list = dao.selectList("healthAdmin.listChallenge", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result= 0;
		try {
			result = dao.selectOne("healthAdmin.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
