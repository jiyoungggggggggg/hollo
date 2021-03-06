<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/notice.css" type="text/css">

<script type="text/javascript">
function sendOk() {
	var f = document.noticeForm;

	var str = f.subject.value;
	if(!str) {
		alert("제목을 입력하세요. ");
		f.subject.focus();
		return;
	}

	str = f.content.value;
	if(!str) {
		alert("내용을 입력하세요. ");
		f.content.focus();
		return;
	}

	f.action="${pageContext.request.contextPath}/notice/${mode}";
		
	f.submit();
}
</script>
<script type="text/javascript">

$(function(){
	$("form input[name=upload]").change(function(){
		if(! $(this).val()) return;
		
		var b=false;
		$("form input[name=upload]").each(function(){
			if(! $(this).val()) {
				b=true;
				return;
			}
		});
		if(b) {
			return false;
		}
			
		var $tr = $(this).closest("tr").clone(true); 
		$tr.find("input").val("");
		$("#tb").append($tr);
	});
});

<c:if test="${mode=='update'}">
	function deleteFile(fileNum) {
			var url="${pageContext.request.contextPath}/notice/deleteFile";
			$.post(url, {fileNum:fileNum}, function(data){
				$("#f"+fileNum).remove();
			}, "json");
	}
</c:if>

</script>


<hr>
<div class="body-container">
<div id="tab-content" style="width:1100px;margin:100px auto; clear:both; padding: 20px 10px 20px;">

<form name="noticeForm" method="post" enctype="multipart/form-data">
<div class="noticeTitle">
	<h1>공지사항</h1>
</div>
  <table style="width: 100%; margin: 20px auto 0px; border-spacing: 0px; border-collapse: collapse;">
  <tbody id="tb">
  <tr align="left" height="50" style="border-bottom: 1px solid #cccccc; border-top:1px solid #cccccc;">
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">제&nbsp;&nbsp;&nbsp;&nbsp;목</td>
      <td style="padding-left:10px;"> 
        <input type="text" name="subject" maxlength="100" class="boxTF" style="width: 95%;" value="${dto.subject}">
      </td>
  </tr>
  
  <tr align="left" height="50" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">공지여부</td>
      <td style="padding-left:10px;"> 
            <input type="checkbox" name="notice" value="1" ${dto.notice==1 ? "checked='checked' ":"" } > 공지
      </td>
  </tr>
  
  <tr align="left" height="50" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
      <td style="padding-left:10px;"> 
          ${sessionScope.member.userName}
      </td>
  </tr>

  <tr align="left" style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center; padding-top:5px;" valign="top">내&nbsp;&nbsp;&nbsp;&nbsp;용</td>
      <td valign="top" style="padding:5px 0px 5px 10px;"> 
        <textarea name="content" rows="12" class="boxTA" style="width: 95%;">${dto.content}</textarea>
      </td>
  </tr>
  
    <tr align="left" height="50" style="border-bottom: 1px solid #cccccc;">
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨&nbsp;&nbsp;&nbsp;&nbsp;부</td>
      <td style="padding-left:10px;"> 
          <input type="file" name="upload" multiple="multiple" class="boxTF" size="53" style="width: 95%; height: 25px;">
       </td>
  </tr>
  </tbody>
  
  <c:if test="${mode=='update'}">
   <c:forEach var="vo" items="${listFile}">
		  <tr id="f${vo.fileNum}" height="40" style="border-bottom: 1px solid #cccccc;"> 
		      <td width="100" bgcolor="#eeeeee" style="text-align: center;">첨부된파일</td>
		      <td style="padding-left:10px;">
		        <a href="javascript:deleteFile('${vo.fileNum}');"><i class="far fa-trash-alt"></i></a> 
				${vo.originalFilename}
		      </td>
		  </tr>
   </c:forEach>
  </c:if>	  
  
  </table>

  <table style="width: 100%; margin: 20px auto 30px; border-spacing: 0px;">
     <tr height="45"> 
      <td align="center" >
	        <button type="button" class="btncencle" onclick="javascript:location.href='${pageContext.request.contextPath}/notice/list';">${mode=='update'?'수정취소':'등록취소'}</button>
	        <button type="reset" class="btnreset">다시입력</button>
	        <button type="button" class="btnsubmit" onclick="sendOk();">${mode=='update'?'수정완료':'등록하기'}</button>
	         <c:if test="${mode=='update'}">
	         	 <input type="hidden" name="num" value="${dto.num}">
	        	 <input type="hidden" name="page" value="${page}">
	        </c:if>
      </td>
    </tr>
  </table>
</form>
</div>
</div>
<hr>