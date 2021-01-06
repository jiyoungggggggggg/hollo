package com.sp.app.interior;


import java.io.File;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.FileManager;
import com.sp.app.common.MyUtil;
import com.sp.app.interiorTip.InteriorTip;
import com.sp.app.interiorTip.InteriorTipService;
import com.sp.app.member.SessionInfo;
import com.sp.app.mypage.Mypage;
import com.sp.app.mypage.MypageService;

@Controller("interior.interiorController")
@RequestMapping("/interior/*")
public class InteriorController {
	
	@Autowired
	private InteriorService service;
	
	@Autowired
	private MypageService mypageSerivce;
	
	@Autowired
	private InteriorTipService itService;
	
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping("main")
	public String InteriorList(
			@RequestParam(value = "page", defaultValue = "1") int current_page,			
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception{

		int rows = 16;
		int total_page=0;
		int dataCount=0;
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("keyword", keyword);
		
		dataCount = service.dataCount(map);
		if (dataCount!=0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if (total_page < current_page) {
			current_page = total_page;
		}
		
		int offset = (current_page-1) * rows;
		if (offset<0) offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		List<Interior> list = service.listBoard(map);
			
		String cp = req.getContextPath();
		String query = "";
		String listUrl = cp+"/interior/main";
		String articleUrl = cp+"/interior/boardItem?page=" + current_page;
		if (keyword.length() != 0) {
			query =  "&keyword=" 
						+ URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length()!=0) {
			listUrl += "?"+query;
			articleUrl += "&" + query;
		}
		
		String paging = myUtil.paging3(current_page, total_page, listUrl);
		
		
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("keyword", keyword);
		
		
		return ".interior.InteriorMain";
	}
	
	@RequestMapping(value="created" , method = RequestMethod.GET)
	public String InteriorForm(
			Model model
			) throws Exception{
		
		model.addAttribute("pageNo", "1");
		model.addAttribute("mode", "created");
		
		return ".interior.interior_created";
	}
	
	@RequestMapping(value="created" , method = RequestMethod.POST)
	public String Interiorsubmit(
			Interior dto,
			HttpSession session,
			Model model ,
			@RequestParam(value="category" ,defaultValue = "" , required = true) List<String> categorys)

			 throws Exception{
		
		
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String root = session.getServletContext().getRealPath("/");
	    String pathname=root+"uploads"+File.separator+"interior";
		
		try {
			String tags = "" ;
			for(String category : categorys) {
				
				tags += category.trim() + ",";
			}
			
			dto.setUserId(info.getUserId());
			dto.setCategory(tags);
			service.insertInterior(dto , pathname);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		 
		 
		return "redirect:/interior/main";
		
	}
	
	@RequestMapping(value = "boardItem")
	public String boardItem(
			@RequestParam (defaultValue = "1")int num,
			@RequestParam (defaultValue = "1")String page,
			@RequestParam(defaultValue = "") String keyword,
			HttpSession session,
			Model model
			) throws Exception {
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query = "page="+page;
		if (keyword.length()!=0) {
			query+="&keyword="
					+URLEncoder.encode(keyword, "utf-8");
		}
		
		service.updateHitCount(num);

		Interior dto = service.readBoard(num);
		List<Interior> flist = service.readBoardImg(num);
		if (dto==null && flist==null) {
			return "redirect:/interior/main?"+query;
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("userId", dto.getUserId());
		map.put("rows", 4);
		
		
		
		List<Interior> ublist = service.userlistBoard(map);
		int ublistCount = ublist.size();
		
		//좋아요  가져오기 
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("num", num);
		paramMap.put("userId", info.getUserId());
		
		Interior logindto = service.readprofile(paramMap);
		
		int replyCount=service.replyCount(paramMap);
		
		int readinteriorLike=0;
		int interiorLikecount =0;
		try {
			readinteriorLike = service.readInteriorLike(paramMap);	
			interiorLikecount = service.interiorLikeCount(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("userLike", readinteriorLike);
		model.addAttribute("interiorLikeCount", interiorLikecount);
		
		int readinteriorZzim=0;
		int interiorZzimcount =0;
		try {
			readinteriorZzim = service.readInteriorZzim(paramMap);	
			interiorZzimcount = service.interiorZzimCount(num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("userZzim", readinteriorZzim);
		model.addAttribute("interiorZzimCount", interiorZzimcount);

		map.put("num", num);
			
		map.put("keyword", keyword);
		
		model.addAttribute("logindto",logindto);
		model.addAttribute("replyCount",replyCount);
		model.addAttribute("ublist", ublist);
		model.addAttribute("ublistCount", ublistCount);		
		model.addAttribute("dto", dto);
		model.addAttribute("flist",flist);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		String category = dto.getCategory();
		
		if(category!=null) {
			String categorylist[] = dto.getCategory().trim().split(",");			
			model.addAttribute("categorylist", categorylist);
		}
			

		return ".interior.boardItem";
	}
	
	@RequestMapping(value="update" , method = RequestMethod.GET)
	public String updateForm(
			Interior dto,
			int num,
			Model model
			) throws Exception{
		
		dto = service.readBoard(num);
		List<Interior> flist = service.readBoardImg(num);
		
		if (dto==null && flist==null) {
			return "redirect:/interior/main";
		}
		int flistCount = flist.size(); //파일 길이 수정시 사진이 전부없으면 추가 박스를 만들기위한 변수값
		
		model.addAttribute("dto", dto);
		model.addAttribute("flist",flist);
		model.addAttribute("flistCount",flistCount);
		model.addAttribute("mode", "update");
		
		
		String category = dto.getCategory();
		
		if(category!=null) {
			String categorylist[] = dto.getCategory().trim().split(",");			
			model.addAttribute("categorylist", categorylist);
		}
	
		
			
		return ".interior.interior_update";
	}
	
	@RequestMapping(value = "update" , method = RequestMethod.POST)
	public String updateSubmit(
			Interior dto,
			HttpSession session,
			@RequestParam(value="category" ,defaultValue = "" , required = true) List<String> categorys
			)	throws Exception{
		
		String root = session.getServletContext().getRealPath("/");
	    String pathname=root+"uploads"+File.separator+"interior";
		
		try {
			String tags = "" ;
			for(String category : categorys) {
				
				tags += category.trim() + ",";
			} 
			
			
			dto.setCategory(tags);
			service.updateInterior(dto, pathname);
			
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
		
		return "redirect:/interior/main";
	}
	
	@RequestMapping(value = "deleteInterior")
	@ResponseBody
	public Map<String, Object> deleteInterior(
			@RequestParam Map<String, Object> paramMap
			) {
		
		String state="true";
		try {
			//service.deleteReply(paramMap);
			service.deleteBoard(paramMap);

			
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		
		return map;
	}
	
	@RequestMapping(value="deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int filenum,
			HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "interior";
		
		Interior dto=service.readFile(filenum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "filenum");
		map.put("num", filenum);
		service.deleteFile(map);
		
		return map;
	}
	
	@RequestMapping(value="deleteMainFile", method=RequestMethod.POST)
	@ResponseBody
	public void deleteMainFile(
			@RequestParam int num,
			HttpSession session) throws Exception {
		
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "interior";
		
		Interior dto=service.readBoard(num);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getMainImg(), pathname);
		}
		
	}
	
	@RequestMapping(value="mList" ,method = RequestMethod.GET)
	public String memberList(
			@RequestParam String userId,
			Model model
			) throws Exception {
		
		
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);	
		int mdataCount = service.mdataCount(map);
		map.put("rows" , 4);
			
		Mypage dto = new Mypage();
		dto.setUserId(userId);
				
		dto = mypageSerivce.readProfile(dto);
		
		List<Interior> list = service.userlistBoard(map);
		
		Map<String, Object> tipMap = new HashMap<>();
		tipMap.put("usertd", userId);
		tipMap.put("offset", 0); 
		tipMap.put("rows", 4);
		
		List<InteriorTip> listTip = itService.listBoard(tipMap);
		
		List<String> images;
		for(InteriorTip tto : listTip) {
			
			images = myUtil.getImgSrc(tto.getContent());
			if(images.size()>0) {
				tto.setSaveFilename(images.get(0));
			}
		}
		
		
		model.addAttribute("mdataCount", mdataCount);
		model.addAttribute("dto", dto);
		model.addAttribute("list", list);
		model.addAttribute("listTip", listTip);
		model.addAttribute("userId", userId);
		
		
		return ".interior.memberList";
	}
	
	@RequestMapping(value="mListAll" ,method = RequestMethod.GET)
	public String memberListAll(
			@RequestParam String userId,
			Model model
			) throws Exception {
		
		
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("rows" , 0);
		
		List<Interior> list = service.userlistBoard(map);
		
		Mypage dto = new Mypage();
		dto.setUserId(userId);
				
		dto = mypageSerivce.readProfile(dto);
		
		model.addAttribute("dto", dto);
		model.addAttribute("list", list);
		
		
		return ".interior.interiorList";
	}
	
	@RequestMapping(value="tListAll" ,method = RequestMethod.GET)
	public String memberListAll2(
			@RequestParam String userId,
			Model model
			) throws Exception {
		
		
		Map<String, Object> map = new HashMap<>();
		map.put("userId", userId);
		map.put("rows" , 0);
		
		List<InteriorTip> listTip = itService.listAllBoard(map);
		
		List<String> images;
		for(InteriorTip tto : listTip) {
			
			images = myUtil.getImgSrc(tto.getContent());
			if(images.size()>0) {
				tto.setSaveFilename(images.get(0));
			}
		}
		
		Mypage dto = new Mypage();
		dto.setUserId(userId);
				
		dto = mypageSerivce.readProfile(dto);
		
		model.addAttribute("dto", dto);
		model.addAttribute("listTip", listTip);
		
		
		return ".interior.interiorTipList";
	}
	
	@RequestMapping(value="insertInteriorLike", method=RequestMethod.POST) //포스트방식으로 왔을때 
	@ResponseBody //에이작스 제이슨 등 쓸때는 리스폰스 바디필수 자동연결 
	public Map<String, Object> insertInteriorLike(
			@RequestParam int num,  
			HttpSession session
			) {
		String state="true";   // 처음은 무조건 좋아요가 진행된 상태가아니니 true 넘기게 디폴트 ture 로 작성한다.
		int interiorLikeCount=0; 
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("num", num); // 게시물의 번호 
		paramMap.put("userId", info.getUserId()); //현재 로그인된 아이디 
		
		try {
			service.insertInteriorLike(paramMap);// 맵에 셋팅한 넘버와 아이디 테이블에 추가 	
		} catch (Exception e) {
			e.printStackTrace();  // 실패시 false 출력 
			state="false";
		}
			
		interiorLikeCount = service.interiorLikeCount(num); // 추가된 테이블의 총 카운트 입력 
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);   // jsp 에서 잘 작동하였는지 확인하기 위한 메세지
		model.put("interiorLikeCount", interiorLikeCount); // 좋아요 총 수를 담은 변수 
		
		return model;
	}
	
	@RequestMapping(value="insertInteriorZzim", method=RequestMethod.POST) //포스트방식으로 왔을때 
	@ResponseBody //에이작스 제이슨 등 쓸때는 리스폰스 바디필수 자동연결 
	public Map<String, Object> insertInteriorZzim(
			@RequestParam int num,  
			HttpSession session
			) {
		String state="true";   // 처음은 무조건 좋아요가 진행된 상태가아니니 true 넘기게 디폴트 ture 로 작성한다.
		int interiorZzimCount=0; 
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("num", num); // 게시물의 번호 
		paramMap.put("userId", info.getUserId()); //현재 로그인된 아이디 
		
		try {
			service.insertInteriorZzim(paramMap);// 맵에 셋팅한 넘버와 아이디 테이블에 추가 	
		} catch (Exception e) {
			e.printStackTrace();  // 실패시 false 출력 
			state="false";
		}
			
		interiorZzimCount = service.interiorZzimCount(num); // 추가된 테이블의 총 카운트 입력 
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);   // jsp 에서 잘 작동하였는지 확인하기 위한 메세지
		model.put("interiorZzimCount", interiorZzimCount); // 좋아요 총 수를 담은 변수 
		
		return model;
	}
	
	// 게시글 좋아요 삭제(delete) : AJAX-JSON
		@RequestMapping(value="deleteInteriorZzim", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> deleteInteriorZzim(
				@RequestParam int num,
				HttpSession session
				) {
			String state="true";
			int interiorZzimCount=0; //좋아요의 총 수를 담을 변수 
			SessionInfo info=(SessionInfo)session.getAttribute("member"); //로그인된 회원정보
			
			Map<String, Object> paramMap=new HashMap<>();
			paramMap.put("num", num); //게시판의 시퀸스 번호 
			paramMap.put("userId", info.getUserId()); // 접속중인 아이디 
			
			try {
				service.deleteInteriorZzim(paramMap);	// map 설정한 정보 테이블에서 삭제 
			} catch (Exception e) {
				e.printStackTrace();
				state="false";   // 삭제 실패 시 메시지 전송을 위한 변수 
			}
				
			interiorZzimCount = service.interiorZzimCount(num);
			 
			Map<String, Object> model=new HashMap<>();
			model.put("state", state);  // 상태의 성공 실패 여부 
			model.put("interiorZzimCount", interiorZzimCount); // 실행 후 좋아요의 수 를 담은 변수
			
			return model;
		}
	
		// 댓글 및 댓글의 답글 등록 : AJAX-JSON
		@RequestMapping(value="insertReply", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> insertReply(
				Reply dto,
				HttpSession session
				) {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			String state="true";
			
			try {
				dto.setUserId(info.getUserId());
				service.insertReply(dto);
			} catch (Exception e) {
				state="false";
			}
			
			Map<String, Object> model = new HashMap<>();
			model.put("state", state);
			
			return model;
		}	
		
		// 댓글 리스트 
		@RequestMapping(value="listReply")
		public String listReply(
				@RequestParam int num,
				@RequestParam(value="pageNo", defaultValue="1") int current_page,
				Model model
				) throws Exception {
			
			int rows=4;
			int total_page=0;
			int dataCount=0;
			
			Map<String, Object> map=new HashMap<>();
			map.put("num", num);
			
			dataCount = service.replyCount(map);

			total_page = myUtil.pageCount(rows, dataCount);
			if(current_page>total_page)
				current_page=total_page;
			
	        int offset = (current_page-1) * rows;
			if(offset < 0) offset = 0;
	        map.put("offset", offset);
	        map.put("rows", rows);
			List<Reply> listReply=service.listReply(map);
			
			for(Reply dto : listReply) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			// AJAX 용 페이징
			String paging=myUtil.pagingMethod3(current_page, total_page, "listPage");
			
			// 포워딩할 jsp로 넘길 데이터
			model.addAttribute("listReply", listReply);
			model.addAttribute("pageNo", current_page);
			model.addAttribute("replyCount", dataCount);
			model.addAttribute("total_page", total_page);
			model.addAttribute("paging", paging);
			
			return "interior/listReply";
		}	
		
		@RequestMapping(value="deleteReply", method=RequestMethod.POST)
		@ResponseBody
		public Map<String, Object> deleteReply(
				@RequestParam Map<String, Object> paramMap
				) {
			
			String state="true";
			try {
				service.deleteReply(paramMap);
			} catch (Exception e) {
				state="false";
			}
			
			Map<String, Object> map = new HashMap<>();
			map.put("state", state);
			return map;
		}	
		
		 // 댓글의 답글 리스트 : AJAX-TEXT
		@RequestMapping(value="listReplyAnswer")
		public String listReplyAnswer(
				@RequestParam int answer,
				HttpSession session,
				Model model
				) throws Exception {
			
			List<Reply> listReplyAnswer=service.listReplyAnswer(answer);

			
			for(Reply dto : listReplyAnswer) {
				dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			}
			
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			Map<String, Object> map = new HashMap<>();
			map.put("userId", info.getUserId());
			
			Interior mto = service.readprofile(map);
			
		
			
			model.addAttribute("mto", mto);
			model.addAttribute("listReplyAnswer", listReplyAnswer);
			model.addAttribute("replyNum",answer);
			return "interior/listReplyAnswer";
		}
}
