package com.sp.app.cook.honCooq.recipe;

import java.math.BigDecimal;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.app.common.MyUtil;
import com.sp.app.cook.honCooq.recipe.Reply;
import com.sp.app.member.SessionInfo;

// 레시피(요리 정보)
@Controller("recipe.recipeController")
@RequestMapping("cook/honCooq/recipe/*")
public class RecipeController {
	@Autowired
	private RecipeService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value = "list")
	public String list(
			@RequestParam(value = "pageNo", defaultValue = "1") int current_page,			
			@RequestParam(defaultValue = "all") String condition,
			@RequestParam(defaultValue = "") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model
			) throws Exception {
		
		System.out.println( "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"+keyword);
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		int rows = 12;	// 한 화면에 보여주는 게시물 수
		int total_page=0;
		int dataCount=0;
		
		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		// 전체 페이지 수
		Map<String, Object> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("userId", info.getUserId());
		
		dataCount = service.dataCount(map);
		if (dataCount!=0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		// 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
		if (total_page < current_page) {
			current_page = total_page;
		}
		
		// 리스트에 출력할 데이터를 가져오기
		int offset = (current_page-1) * rows;
		if (offset<0) offset=0;
		map.put("offset", offset);
		map.put("rows", rows);
		
		// 글 리스트
		List<Recipe> list = service.listRecipe(map);
		
		
		String cp = req.getContextPath();
		String query = "";
//		String listUrl = cp+"/cook/honCooq/recipe/list";
		String articleUrl = cp+"/cook/honCooq/recipe/article?page=" + current_page;
		if (keyword.length() != 0) {
			query = "condition="+condition + "&keyword=" 
						+ URLEncoder.encode(keyword, "utf-8");
		}

		if (query.length()!=0) {
//			listUrl = cp+"/cook/honCooq/recipe/list?"+query;
			articleUrl = cp+"/cook/honCooq/recipe/article?page=" + current_page +"&"+ query;
		}
		
        // ajax 페이징처리
        String paging = myUtil.pagingMethod2(current_page, total_page, "listPage");
        // String paging = myUtil.paging2(current_page, total_page, listUrl);
				
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);		
		
		return "/cook/honCooq/recipe/list";
	}
	
	@RequestMapping(value = "article")
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session,
			Model model) throws Exception {

		keyword = URLDecoder.decode(keyword, "utf-8");

		String query = "page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}		
		
		// 해당 레코드(글 정보) 가져오기
		Recipe dto = service.readRecipe(num);
		if(dto==null) {
			return "redirect:/cook/honCooq/main?"+query;
		}
		
		// 재료 리스트
		List<Recipe> listIngre = service.listRecipeIngre(num);
		// 과정 리스트
		List<Recipe> listProcess = service.listRecipeProcess(num);
		
		for(Recipe dto1  : listProcess) {
			dto1.setStep_tip(dto1.getStep_tip().trim());
		}
			
		// 스마트 에디터인 경우 주석 처리
//      dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
         
		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("recipe_id", num);

//		Recipe preReadDto = service.preReadRecipe(map);
//		Recipe nextReadDto = service.nextReadRecipe(map);
				
		model.addAttribute("dto", dto);
//		model.addAttribute("preReadDto", preReadDto);
//		model.addAttribute("nextReadDto", nextReadDto);
		
		// 좋아요 여부 가져오기
		SessionInfo info=(SessionInfo)session.getAttribute("member");		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("recipe_id", num);
		paramMap.put("userId", info.getUserId());
		
		int readRecipeLike=0;
		
		try {
			readRecipeLike = service.readRecipeLike(paramMap);					
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("userLike", readRecipeLike);		
		model.addAttribute("page", page);
		model.addAttribute("query", query);		
		model.addAttribute("listIngre", listIngre);
		model.addAttribute("listProcess", listProcess);
		
		return ".cook.honCooq.recipe.article";
	}
	
	// 게시글 좋아요 추가(insert) : AJAX-JSON
	@RequestMapping(value="insertRecipeLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertRecipeLike(
			@RequestParam int num,
			HttpSession session
			) {
		String state="true";
		int recipeLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("recipe_id", num);
		paramMap.put("userId", info.getUserId());
		
		try {
			service.insertRecipeLike(paramMap);					
		} catch (Exception e) {
			e.printStackTrace();
			state="false";
		}
			
		recipeLikeCount = service.recipeLikeCount(num);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("recipeLikeCount", recipeLikeCount);
		
		return model;
	}	
	
	// 게시글 좋아요 삭제(delete) : AJAX-JSON
	@RequestMapping(value="deleteRecipeLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteRecipeLike(
			@RequestParam int num,
			HttpSession session
			) {
		String state="true";
		int recipeLikeCount=0;
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> paramMap=new HashMap<>();
		paramMap.put("recipe_id", num);
		paramMap.put("userId", info.getUserId());
		
		try {
			service.deleteRecipeLike(paramMap);					
		} catch (Exception e) {
			e.printStackTrace();
			state="false";
		}
			
		recipeLikeCount = service.recipeLikeCount(num);
		 
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("recipeLikeCount", recipeLikeCount);
		
		
		return model;
	}		
	
	// 댓글 리스트 : AJAX-TEXT
	@RequestMapping(value="listReply")
	public String listReply(
			@RequestParam int num,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			Model model
			) throws Exception {
		
		int rows=5;
		int total_page=0;
		int dataCount=0;
		
		Map<String, Object> map=new HashMap<>();
		map.put("recipe_id", num);
		
		dataCount=service.replyCount(map);
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
		String paging=myUtil.pagingMethod(current_page, total_page, "listPage");
		
		// 포워딩할 jsp로 넘길 데이터
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "cook/honCooq/recipe/listReply";
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
	
	// 댓글 및 댓글의 답글 삭제 : AJAX-JSON
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
			Model model
			) throws Exception {
		
		List<Reply> listReplyAnswer=service.listReplyAnswer(answer);
		for(Reply dto : listReplyAnswer) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		return "cook/honCooq/recipe/listReplyAnswer";
	}
	
	// 댓글의 답글 개수 : AJAX-JSON
	@RequestMapping(value="countReplyAnswer")
	@ResponseBody
	public Map<String, Object> countReplyAnswer(
			@RequestParam(value="answer") int answer
			) {
		
		int count=service.replyAnswerCount(answer);
		
		Map<String, Object> model=new HashMap<>();
		model.put("count", count);
		return model;
	}	
	
	// 댓글의 좋아요/싫어요 추가 : AJAX-JSON
	@RequestMapping(value="insertReplyLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReplyLike(
			@RequestParam Map<String, Object> paramMap,
			HttpSession session
			) {
		String state="true";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Map<String, Object> model=new HashMap<>();
		
		try {
			paramMap.put("userId", info.getUserId());
			service.insertReplyLike(paramMap);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> countMap=service.replyLikeCount(paramMap);
				
		// 마이바티스의 resultType이 map인 경우 int는 BigDecimal로 넘어옴
		int likeCount=((BigDecimal)countMap.get("LIKECOUNT")).intValue();
		int disLikeCount=((BigDecimal)countMap.get("DISLIKECOUNT")).intValue();
		
		model.put("likeCount", likeCount);
		model.put("disLikeCount", disLikeCount);
		model.put("state", state);
		return model;
	}

	// 댓글의 좋아요/싫어요 개수 : AJAX-JSON
	@RequestMapping(value="countReplyLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countReplyLike(
			@RequestParam Map<String, Object> paramMap,
			HttpSession session
			) {
		
		Map<String, Object> countMap=service.replyLikeCount(paramMap);
		// 마이바티스의 resultType이 map인 경우 int는 BigDecimal로 넘어옴
		int likeCount=((BigDecimal)countMap.get("LIKECOUNT")).intValue();
		int disLikeCount=((BigDecimal)countMap.get("DISLIKECOUNT")).intValue();
		
		Map<String, Object> model=new HashMap<>();
		model.put("likeCount", likeCount);
		model.put("disLikeCount", disLikeCount);
			
		return model;
	}	
	
}
