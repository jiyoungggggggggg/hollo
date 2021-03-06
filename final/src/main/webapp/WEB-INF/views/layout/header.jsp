<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script>
	function mypage_send(){
		f = document.mypage_sendform;
		
		f.action = "${pageContext.request.contextPath}/mypage/main";
		f.submit();
	}

</script>


 <nav>
                <div class="logo">
                  <c:if test="${empty sessionScope.member}">
                      <a href="${pageContext.request.contextPath}"></a>
                  </c:if>
                  <c:if test="${not empty sessionScope.member}">
                      <a href="${pageContext.request.contextPath}/home"></a>
                  </c:if>
              </div>
              
              <div class="menuBox"> <a href="${pageContext.request.contextPath}/dress/main">오늘 뭐 입어?</a></div>
              <div class="menuBox"> <a href="${pageContext.request.contextPath}/cook/honCooq/recipe">혼자 뭐 먹지?</a></div>
              <div class="menuBox"> <a href="${pageContext.request.contextPath}/room/roomlist">방 구할래?</a></div>
              <div class="menuBox"> <a href="${pageContext.request.contextPath}/interior/main">인테리어</a></div>
              <div class="menuBox"> <a href="${pageContext.request.contextPath}/supplement/list">건강챙기기</a></div>
              <div class="loginBox">
                  <div class="loginName">
                        <c:if test="${not empty sessionScope.member}">
                            ${sessionScope.member.userName} 님
                      </c:if>
                        <c:if test="${empty sessionScope.member}">
                          <a href="${pageContext.request.contextPath}/member/login">로그인</a>
                        </c:if> 
                  </div>
                  
                      <c:if test="${sessionScope.member.userId =='admin'}">
                          <a href="${pageContext.request.contextPath}/adm/chart/chart" style="padding-left :10px; line-height: 100px; font-size: 0px;"><img style="width: 32px; height: 29px;" src="${pageContext.request.contextPath}/resources/images/setcon_1.jpg"></img></a>
                      </c:if>
                  <div class="mypage">
                      <i class="fas fa-house-user fa-2x"></i>
                         <c:if test="${not empty sessionScope.member}">
                              <form name="mypage_sendform" method="post">
                             <div class="userBox">
	                              <ul>
	                                   <li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>   
	                                   <li>
	                                  		<a style="cursor: pointer;" onclick="mypage_send();" >마이페이지</a>
	                                  		<input type="hidden" name="userId" value="${sessionScope.member.userId}">
	                                   </li>            
	                                   <li><a href="${pageContext.request.contextPath}/infos/infos">고객센터</a></li>
	                             </ul>
                          </div>
                             </form>
                       </c:if>
                      <!-- 유저아이디 admin 이면 버튼생성 구간  -->

                  </div>
              </div>
          </nav>
          <div class="hideNav">
              <div class="innerhideNav">
                  <div class="PermenuObject">
                  <ul class="menuObject">
                      <li> <a href="${pageContext.request.contextPath}/dressMain/main">오늘의 옷차림</a></li>
                      <li> <a href="${pageContext.request.contextPath}/dress/list">코디자랑</a></li>
                      <li> <a href="${pageContext.request.contextPath}/dressTip/list">팁</a></li>

                  </ul>
                  <ul class="menuObject">
                      <li> <a href="${pageContext.request.contextPath}/cook/honCooq/recipe">HONCOOQ</a></li>
                      <li> <a href="${pageContext.request.contextPath}">우리집 냉장고</a></li>
                      <li> <a href="${pageContext.request.contextPath}">우리동네 마트</a></li>
<%--                       <li> <a href="${pageContext.request.contextPath}">나만의 요리 후기</a></li> --%>
                  </ul>
                  <ul class="menuObject">
                      <li> <a href="${pageContext.request.contextPath}/room/roomlist">방 구할래?</a></li>
                      <li> <a href="${pageContext.request.contextPath}/room/roomtip">부동산 팁</a></li>
                      <li> <a href="${pageContext.request.contextPath}/room/roomChecklist">방 체크리스트</a></li>
                      <li> <a href="${pageContext.request.contextPath}/room/security">보안 테스트&amp;서비스</a></li>
                  </ul>
                  <ul class="menuObject">
                      <li> <a href="${pageContext.request.contextPath}/interior/main">내집자랑</a></li>
                      <li> <a href="${pageContext.request.contextPath}/interiorTip/list">생활 팁</a></li>
                      <li> <a href="${pageContext.request.contextPath}/itEstimate/main">견적 받아보기</a></li>
                 </ul>
                  <ul class="menuObject">
                      <li> <a href="${pageContext.request.contextPath}/supplement/list">영양제 뭐 먹을까?</a></li>
                      <li> <a href="${pageContext.request.contextPath}/challenge/list">하루운동 챌린지</a></li>
                      <li> <a href="${pageContext.request.contextPath}/healthStory/list">오늘 운동을 보여줘</a></li>
                  </ul>
              </div>
              </div>
          </div>
 
