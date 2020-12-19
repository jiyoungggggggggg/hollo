<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	
<script type="text/javascript">
	function searchList(){
		const f = document.dressCreatedFrom;
		f.submit();
	}
</script>
    <div class="dress-Body">
                <div class="dress-MainBody">
                    <div class="dress-InnerBody">
                        <div class="dress-MainContent">
                            <div class="dress-BestContentName">
                                <p>
                                    <i class="fas fa-crown fa-3x"></i>
                                </p>
                                <span class="dress-Text">인기</span><span>게시글</span>

                            </div>
                            <div class="dress-BestContent">
                                <div class="dress-subContent-InnerImage">
                                </div>
                                <div class="dress-subContent-InnerText">
                                    <span>오늘 출근 할때 입었던 옷이에요 정말입고 싶었던 옷인데</span>
                                </div>
                            </div>
                            <div class="dress-BestContentText">여기에 무엇을 넣어야 할까?</div>
                        </div>
                        <c:forEach var="dto" items="${list}">
                            <div class="dress-subContent">
                                <div class="dress-subContent-InnerImage">
                                    <span class="dress-subContent-InnerUserName">작성자:이경태</span>
                                    <span class="dress-subContent-InnerHitCount">조회수:12</span>
                                </div>
                                <div class="dress-subContent-InnerText">
                                    <span>제목: ${dto.subject}</span>
                                </div>
                            </div>

                        </c:forEach>
                    </div>
                    <form action="${pageContext.request.contextPath}/dress/list" name="dressCreatedFrom" method="post">
                        <div class="dress-searchFormBody">
                            <div class="dress-pagingNum">
                               ${dataCount==0?"등록된 게시물이 없습니다.":paging}
                            </div>
                            <div class="dress-searchBody">
                                <button class="dress-Resetbtn dress-Btn" type="button" onclick="javascript:location.href='${pageContext.request.contextPath}/dress/list'">
                                    <i class="fas fa-redo-alt fa-2x"></i>
                                </button>
                                <select class="dress-Selectbtn" name="condition">
                                    <option value="all">모두</option>
                                    <option value="subject">제목</option>
                                    <option value="content">내용</option>
                                    <option value="userName">작성자</option>
                                    <option value="created">등록일</option>
                                </select> <input class="dress-Search" type="text" name="keyword" value="${keyword}">
                                <button class="dress-Searchbnt dress-Btn" type="button" onclick="searchList()">검색</button>
                                <button class="dress-Createdbtn dress-Btn" type="button"
                                    onclick="javascript:location.href='${pageContext.request.contextPath}/dress/created'">글쓰기</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>