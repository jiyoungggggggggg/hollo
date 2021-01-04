<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<style>

.set-container {
	width: 1200px;
}

</style>




<section>
<div>
	<div class="set-container" style="width: 1000px;">
	   <div class="body-title">
	      <h3><i class="fas fa-chalkboard"></i> 자유  게시판  </h3>
	   </div>
	
	   <div>
	      <table style="width: 100%; margin-top: 20px; border-spacing: 0px; border-collapse: collapse;">
	         <tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
	            <td colspan="2" align="center">
	               ${dto.subject }
	            </td>
	         </tr>
	
	         <tr height="35" style="border-bottom: 1px solid #cccccc;">
	            <td width="50%" align="left" style="padding-left: 5px;">
	               이름 : ${dto.userName }
	            </td>
	            <td width="50%" align="right" style="padding-right: 5px;">
	               ${dto.created } | 조회 ${dto.hitCount}
	            </td>
	         </tr>
	         
	         <tr style="border-bottom: 1px solid #cccccc;">
	            <td colspan="2" align="left" style="padding: 10px 5px;" valign="top" height="200">
	               ${dto.content }
	            </td>
	         </tr>
	         
	         <tr style="border-bottom: 1px solid #cccccc;">
	            <td colspan="2" height="40" 
	               style="padding-bottom: 15px;" align="center">
	               <button type="button" class="btn btnSendBoardLike" title="좋아요"><i class="fas fa-hand-point-up"></i>&nbsp;&nbsp;<span id="boardLikeCount"></span></button>
	            </td>
	         </tr>
	 
	         <tr height="35" style="border-bottom: 1px solid #cccccc;">
	            <td colspan="2" align="left" style="padding-left: 5px;">
	               이전글 :
	               <c:if test="${not empty preReadDto }">
	                  <a href="${pageContext.request.contextPath }/bbs/article?${query}&num=${preReadDto.num}">${preReadDto.subject }</a>
	               </c:if>
	            </td>
	         </tr>
	
	         <tr height="35" style="border-bottom: 1px solid #cccccc;">
	            <td colspan="2" align="left" style="padding-left: 5px;">
	               다음글 :
	               <c:if test="${not empty nextReadDto }">
	                  <a href="${pageContext.request.contextPath }/bbs/article?${query}&num=${nextReadDto.num}">${nextReadDto.subject }</a>
	               </c:if>
	            </td>
	         </tr>
	      </table>
	
	      <table style="width: 100%; margin: 0px auto 20px; border-spacing: 0px;">
	         <tr height="45">
	            <td width="300" align="left">
	               <button type="button" class="btn" onclick="updateBoard('${dto.num}');">수정</button>
	               <button type="button" class="btn" onclick="deleteBoard('${dto.num}');">삭제</button>
	            </td>
	
	            <td align="right">
	               <button type="button" class="btn" onclick="javascript:location.href='${pageContext.request.contextPath}/bbs/list?${query }';">리스트</button>
	            </td>
	         </tr>
	      </table>
	   </div>
	   
	   <!-- 댓글 쓰기 -->
	       <div>
	      <table style='width: 100%; margin: 15px auto 0px; border-spacing: 0px;'>
	         <tr height='30'> 
	             <td align='left' >
	                <span style='font-weight: bold;' >댓글쓰기</span><span> - 타인을 비방하거나 개인정보를 유출하는 글의 게시를 삼가 주세요.</span>
	             </td>
	         </tr>
	         <tr>
	               <td style='padding:5px 5px 0px;'>
	               <textarea class='boxTA' style='width:99%; height: 70px;'></textarea>
	             </td>
	         </tr>
	         <tr>
	            <td align='right'>
	                 <button type='button' class='btn btnSendReply' style='padding:10px 20px;'>댓글 등록</button>
	             </td>
	          </tr>
	      </table>
	           
	      <div id="listReply"></div>
	    
	    </div>
	   
	
	
	
	
	</div>
</div>
</section>