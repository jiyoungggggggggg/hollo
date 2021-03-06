package com.sp.app.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller("member.memberController")
@RequestMapping(value="/member/*")
public class MemberController {
	@Autowired
	private MemberService service;
	
	@RequestMapping(value="member", method=RequestMethod.GET)
	public String memberForm(Model model) {
		model.addAttribute("mode", "member");
		
		
		return ".member.member";
	}
	
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(
			String userId,
			Model model) {
		
		Member dto = service.readMember(userId);
		
		String tel[] = dto.getTel().trim().split("-");
		int tel2 = Integer.parseInt(tel[1]);
		int tel3 = Integer.parseInt(tel[2]);
		
		String email[] = dto.getEmail().trim().split("@");
		String email1 = email[0];
		String email2 = email[1];
		
		model.addAttribute("mode", "update");
		
		model.addAttribute("email1", email1);
		model.addAttribute("email2", email2);
		model.addAttribute("tel3", tel3);
		model.addAttribute("tel2", tel2);
		model.addAttribute("dto", dto);
		
		return ".member.member";
	}

/*
    * RedirectAttributes 
      RedirectAttributes에 데이터등을 저장하면 Redirect 된 후 즉시 사라지게 되고
	    사용자가 F5등을 눌러 리로드 하더라도 서버로 다시 submit 되어 저장되지 않게할 수 있다.
*/
	@RequestMapping(value="member", method=RequestMethod.POST)
	public String memberSubmit(Member dto,
			final RedirectAttributes reAttr,
			Model model) {

		try {
			service.insertMember(dto);
		} catch (DuplicateKeyException e) {
			// 기본키 중복에 의한 제약 조건 위반
			model.addAttribute("mode", "member");
			model.addAttribute("message", "아이디 중복으로 회원가입이 실패했습니다.");
			return ".member.member";
		} catch (DataIntegrityViolationException e) {
			// 데이터형식 오류, 참조키, NOT NULL 등의 제약조건 위반
			model.addAttribute("mode", "member");
			model.addAttribute("message", "제약 조건 위반으로 회원가입이 실패했습니다.");
			return ".member.member";
		} catch (Exception e) {
			model.addAttribute("mode", "member");
			model.addAttribute("message", "아이디 중복으로 회원가입이 실패했습니다.");
			return ".member.member";
		}	
		
		return ".member.complete";
	}
	
/*
    * @ModelAttribute
      - 스프링에서 JSP파일에 반환되는 Model 객체에 속성값을 주입하거나 바인딩할 때 사용되는 어노테이션
      - RedirectAttributes 에 저장된 데이터를 자바 메소드(리다이렉트로 매핑된 메소드)
               에서 넘겨 받기 위해서는 메소드 인자에 @ModelAttribute("속성명")을 사용해야 한다.
*/
	@RequestMapping(value="complete")
	public String complete(@ModelAttribute("message") String message) throws Exception{
		
		// 컴플릿 페이지(complete.jsp)의 출력되는 message와 title는 RedirectAttributes 값이다. 
		// F5를 눌러 새로 고침을 하면 null이 된다.
		
		if(message==null || message.length()==0) // F5를 누른 경우
			return "redirect:/";
		
		return ".member.complete";
	}
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String loginForm() {
		return ".member.login";
	}
	
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String loginSubmit(
			@RequestParam String userId,
			@RequestParam String userPwd,
			HttpSession session,
			Model model
			) {
		
		Member dto=service.loginMember(userId);
		if(dto==null ||  !  userPwd.equals(dto.getUserPwd())) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
			return ".member.login";
		}
		
		if(dto==null || dto.getEnabled()==0) {
			model.addAttribute("message", "정지된 계정입니다.");
			return ".member.login";
		}
		
		// 세션에 로그인 정보 저장
		SessionInfo info=new SessionInfo();
		info.setUserId(dto.getUserId());
		info.setUserName(dto.getUserName());
		
		session.setMaxInactiveInterval(30*60); // 세션유지시간 30분, 기본:30분
		
		session.setAttribute("member", info);
		
		// 로그인 이전 URI로 이동
		String uri=(String)session.getAttribute("preLoginURI");
		session.removeAttribute("preLoginURI");
		if(uri==null)
			uri=".home";
		else
			uri="redirect:"+uri;
		
		return uri;
	}
	
	@RequestMapping(value="logout")
	public String logout(HttpSession session) {
		// 세션에 저장된 정보 지우기
		session.removeAttribute("member");
		
		// 세션에 저장된 모든 정보 지우고, 세션초기화
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value="pwd", method=RequestMethod.GET)
	public String pwdForm(String dropout, Model model) {
		
		if(dropout==null) {
			model.addAttribute("mode", "update");
		} else {
			model.addAttribute("mode", "dropout");
		}
		
		return ".member.pwd";
	}
	
	@RequestMapping(value="pwd", method=RequestMethod.POST)
	public String pwdSubmit(
			@RequestParam String userPwd,
			@RequestParam String mode,
			final RedirectAttributes reAttr,
			Model model,
			HttpSession session
	     ) {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Member dto=service.readMember(info.getUserId());
		if(dto==null) {
			session.invalidate();
			return "redirect:/";
		}
		
		if(! dto.getUserPwd().equals(userPwd)) {
			if(mode.equals("update")) {
				model.addAttribute("mode", "update");
			} else {
				model.addAttribute("mode", "dropout");
			}
			model.addAttribute("message", "패스워드가 일치하지 않습니다.");
			return ".member.pwd";
		}
		
		if(mode.equals("dropout")){
			// 게시판 테이블등 자료 삭제
			
			// 회원탈퇴 처리
			/*
			Map<String, Object> map = new HashMap<>();
			map.put("memberIdx", info.getMemberIdx());
			map.put("userId", info.getUserId());
			*/

			// 세션 정보 삭제
			session.removeAttribute("member");
			session.invalidate();

			StringBuilder sb=new StringBuilder();
			sb.append(dto.getUserName()+ "님의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
			
			reAttr.addFlashAttribute("title", "회원 탈퇴");
			reAttr.addFlashAttribute("message", sb.toString());
			
			return "redirect:/member/complete";
		}

		// 회원정보수정폼
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		return ".member.member";
	}

	@RequestMapping(value="update", method=RequestMethod.POST)
	public String updateSubmit(
			Member dto,
			final RedirectAttributes reAttr,
			Model model) {
		
		try {
			service.updateMember(dto);
		} catch (Exception e) {
		}
		
		
		String title = dto.getUserName()+ "님의 회원정보가 정상적으로 변경되었습니다.";
		String message ="메인화면으로 이동 하시기 바랍니다.";
		
		model.addAttribute("title", title);
		model.addAttribute("message", message);
		
		return ".member.complete2";
	}

	// @ResponseBody : 자바 객체를 HTTP 응답 몸체로 전송(AJAX에서 JSON 전송 등에 사용)
	@RequestMapping(value="userIdCheck", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> idCheck(
			@RequestParam String userId
			) throws Exception {
		
		String p="true";
		Member dto=service.readMember(userId);
		if(dto!=null) {
			p="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("passed", p);
		return model;
	}
	
	
	//아이디 찾기

	
	@RequestMapping(value="findId", method=RequestMethod.GET)
	public String findId() {
		
		return ".member.findId";
	}
	
	
	@RequestMapping(value="findId", method=RequestMethod.POST)
	public String findId(
			@RequestParam String userName,
			@RequestParam String tel,
			Model model
			) throws Exception{
		
		String usertel="";
		
		if(tel.length()>11) {
			String tels[] = tel.split("-");
			usertel=tels[0]+tels[1]+tels[2];
		}else {
			usertel=tel;
		}
		
		
		try {
			Member dto=service.findId(userName);
			String dtotelS[]=dto.getTel().split("-");
			
			String dtotel=dtotelS[0]+dtotelS[1]+dtotelS[2];
			
			if(!userName.equals(dto.getUserName()) || !usertel.equals(dtotel)) {
				model.addAttribute("message", "가입하지 않은 회원입니다");
				return ".member.findId";
			}else {
				model.addAttribute("message", "아이디는 ["+ dto.getUserId()+"] 입니다");
				return ".member.findId";
			}
			
		} catch (DataIntegrityViolationException e) {
			// 데이터형식 오류, 참조키, NOT NULL 등의 제약조건 위반
			e.printStackTrace();
			model.addAttribute("message", "가입하지 않은 회원입니다");
			return ".member.findId";
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
		return ".member.findId";
		
	}
	
	
	
	
	
	
	
	
	
	
	
}