package com.sp.app.interior;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.sp.app.common.FileManager;
import com.sp.app.common.dao.CommonDAO;


@Service("interior.interiorService")
public class InteriorServiceImpl implements InteriorService{
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public void insertInterior(Interior dto ,String pathname) throws Exception {
		try {
			int seq= dao.selectOne("interior.seq");
			dto.setNum(seq);
			
			//메인 이미지 업로드 시 
			 
			MultipartFile mainImg = dto.getMainUpload();
			String mainFilename = fileManager.doFileUpload(mainImg, pathname);
			dto.setMainImg(mainFilename);
			
			dao.insertData("interior.insertInterior", dto);
			
	        
			// 파일 업로드
	         if(! dto.getUpload().isEmpty()) {
	        	
	            for(MultipartFile mf:dto.getUpload()) {
	               String imageFilename=fileManager.doFileUpload(mf, pathname);
	               if(imageFilename==null) continue;   
	               dto.setSaveFilename(imageFilename);
	               int image_seq = dao.selectOne("interior.interiorfile_seq");
	               dto.setFilenum(image_seq);
	               insertFile(dto);
	              
	            }
	         }
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
			
	}
		


	@Override
	public List<Interior> listBoard(Map<String, Object> map) {
		List<Interior> list = null;
		try {
			list = dao.selectList("interior.interiorlist", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("interior.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@Override
	public int mdataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("interior.mdataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public Interior readBoard(int num) {
		Interior dto = null;
		try {
			dto = dao.selectOne("interior.readBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("interior.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertFile(Interior dto) throws Exception {
		   try {
		         dao.insertData("interior.interiorFile", dto);
		      } catch (Exception e) {
		         e.printStackTrace();
		         throw e;
		      }
		      
		
	}



	@Override
	public List<Interior> readBoardImg(int num) {
		List<Interior> fto = null;
		try {
			fto = dao.selectList("interior.readBoardImg", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fto;
	}



	@Override
	public void updateInterior(Interior dto, String pathname) throws Exception {
		try {

			
			//메인 이미지 수정 시  
			if(! dto.getMainUpload().isEmpty()) {
			MultipartFile mainImg = dto.getMainUpload();
			String mainFilename = fileManager.doFileUpload(mainImg, pathname);
			dto.setMainImg(mainFilename);
			
			dao.updateData("interior.interiorUpdate2", dto);
			}else {
				
				dao.updateData("interior.interiorUpdate1", dto);
			}
			
	        
			// 다중파일 업로드 삭제 및 생성
	         if(! dto.getUpload().isEmpty()) {
	        	
	            for(MultipartFile mf:dto.getUpload()) {
	               String imageFilename=fileManager.doFileUpload(mf, pathname);
	               if(imageFilename==null) continue;   
	               dto.setSaveFilename(imageFilename);
	               int image_seq = dao.selectOne("interior.interiorfile_seq");
	               dto.setFilenum(image_seq);
	               insertFile(dto);
	              
	            }
	         }
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
			
	}

	@Override
	public void deleteBoard(Map<String, Object> map) throws Exception{
		try {
			dao.deleteData("interior.deleteBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public Interior readFile(int filenum) {
		Interior dto=null;
		
		try {
			dto=dao.selectOne("interior.readFile", filenum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}



	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("interior.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}



	@Override
	public List<Interior> userlistBoard(Map<String, Object> map) {
		List<Interior> list = null;
		try {
			list = dao.selectList("interior.userinteriorlist", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}
		
	@Override
	public List<Interior> userlistBoard(String userId) {
		List<Interior> list = null;
		try {
			list = dao.selectList("interior.userinteriorlist", userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}


	// 게시판 좋아요 
	@Override
	public void insertInteriorLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("interior.insertInteriorLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}



	@Override
	public int interiorLikeCount(int num) {
		int result=0;
		try {
			result=dao.selectOne("interior.interiorLikeCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}



	@Override
	public int readInteriorLike(Map<String, Object> map) throws Exception {
		int result=0;
		try {
			result=dao.selectOne("interior.readInteriorLike", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}



	@Override
	public void deleteInteriorLike(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("interior.deleteInteriorLike", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	// 게시판 좋아요 
	@Override
	public void insertInteriorZzim(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("interior.insertInteriorZzim", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}



	@Override
	public int interiorZzimCount(int num) {
		int result=0;
		try {
			result=dao.selectOne("interior.interiorZzimCount", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}



	@Override
	public int readInteriorZzim(Map<String, Object> map) throws Exception {
		int result=0;
		try {
			result=dao.selectOne("interior.readInteriorZzim", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}



	@Override
	public void deleteInteriorZzim(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("interior.deleteInteriorZzim", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}
	
	
	
	
	//댓글 추가 

	
	// 댓글 카운트 
	@Override
	public int replyCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("interior.interiorReplyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("interior.insertInteriorReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	//댓글 리스트 
	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		try {
			list = dao.selectList("interior.listInteriorReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//댓글 삭제 
	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("interior.deleteInteriorReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	// 대댓글 리스트
	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list=null;
		try {
			list=dao.selectList("interior.listInteriorReplyAnswer", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}



	@Override
	public Interior readprofile(Map<String, Object> map) throws Exception {
		Interior dto = null;
		try {
			dto = dao.selectOne("interior.readprofile", map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return dto;
	}
	

}
