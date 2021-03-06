<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 수정하기</title>
<meta name="viewport" content="width=device, initial-scale=1" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css" type="text/css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="<%=request.getContextPath()%>/css/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/ckeditor/ckeditor.js"></script>
<style>
	.container{
		width: 900px;	
	}
	#top{
		margin: 15px;
		padding: 15px;
		text-align: center;
		font-size: 30px;
	}
	#content{
		height: 300px;
	}

</style>
<script>
$(function(){
	CKEDITOR.replace("content",{filebrowserUploadUrl:'/dbmon/imageUpload.do'});
	
	$("b").click(function(){
		$(this).parent().next().attr("type", "file");
		$(this).parent().next().next().attr("name", "delfile");
		
		$(this).parent().remove();	
	});
	
	$("#noticeBoardEditFrm").submit(function(){
		if($("#subject").val()==""){
			alert("글제목을 입력하세요.");
			$("#subject").focus();
			return false;
			
		}
		if(CKEDITOR.instances.content.getData()==""){
			alert("글내용을 입력하세요.");
			$("#content").focus();
			return false;
		}
		return true;
	});
});

</script>
</head>
<body>
<%@include file="/WEB-INF/views/top.jsp"%>
<div class="container">
<div id="top">
<b>게시판 글 수정하기</b>
</div>
	<form method="post" action="/dbmon/noticeBoardEditOk" id="noticeNoticeEditFrm" enctype="multipart/form-data">
		<input type="hidden" name="no" value="${vo.no}"/>
		<div class="form-group">
	 		<label for="subject">제목</label>
			<input type="text" maxlength="60" class="form-control" id="subject" name="subject" value="${vo.subject}"><br/>
			<div>
			<label for="content">글내용</label><br/>
				<textarea class="form-control" id="content" name="content">${vo.content}</textarea>
			</div>
			<br/>
			<!-- 
			<!-- 첫번째 첨부파일이 있을 때 -->			
			<c:if test="${vo.filename1!=null}">
				<div>${vo.filename1} <b>X</b></div>
				<input type="hidden" name="filename" id="filename1"/>
				<input type="hidden" name="" id="delfile1" value="${vo.filename1}"/>
			</c:if>
			<!-- 첫번째 첨부파일이 없을 때 -->
			<c:if test="${vo.filename1==null}">
				<input type="file" name="filename" id="filename3"/>
			</c:if>
			<br/>
			<!-- 두번째 첨부파일이 있을 때 -->
			<c:if test="${vo.filename2!=null}">
				<div>${vo.filename2} <b>X</b></div>
				<input type="hidden" name="filename" id="filename2"/>
				<input type="hidden" name="" id="delfile2" value="${vo.filename2}"/>		
			</c:if>
			<!-- 두번째 첨부파일이 없을 때 -->
			<c:if test="${vo.filename2==null}">
				<input type="file" name="filename" id="filename4"/>
			</c:if>
			<br/>
			<div class="form-check">
			<br/>
			<input class="form-check-input" type="checkbox" value="Y" id="expose" name="expose">
			<label class="form-check-label" for="expose">
			전체 게시판 등록하기
			</label>
			</div>
			<br/>
		 	<input type="submit" class="btn btn-warning btn-lg btn-block" value="수정"/>
		</div>
	</form>
</div>
</body>
</html>