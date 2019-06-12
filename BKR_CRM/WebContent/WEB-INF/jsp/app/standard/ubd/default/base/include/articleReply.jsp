<%--
 *
 *  파 일 명 :  articleReply.jsp
 *  설    명 :  게시물상세화면 댓글영역
 *  작 성 자 :  김병기
 *  작 성 일 :  2016-03-10
 *  버    전 :  1.0  
 *  기타사항 :  
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*#
--%>
<%@page import="com.ubone.framework.ConstantHolder"%>
<%@page import="com.ubone.standard.ubboard.common.domain.BoardType"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@page import="com.ubone.framework.data.DataList"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	BoardType boardType = (BoardType) ViewUtil.getResult().getExtendAttribute("boardType");
	int replyRowSeq = 20;
	Boolean reReply = false;
%>

<%
	if (boardType.isReplyYn()) {
%>
<div class="ub-layout comment">
	<div class="pre-cmt" style="display: none;" id="preReplyBtn">
		<a href="#none">이전 댓글 보기</a>
	</div>
	<!-- replyList Start : 댓글 리스트 동적 생성 -->
	<ul id="replyList"></ul>
	<!-- replyList End -->  
	
	<!-- new-re Start    : 새로운 댓글 작성 폼 -->   
	<div class="new-re">
		<form id="replyForm" name="replyForm">
			<div class="reply-area">
				<textarea class="ub-control textarea" id="DS_CONTENT_REPLY" metalength="2000"
					name="DS_CONTENT_REPLY"></textarea>
				<span class="re-write" id="registReply"><a href="#none">댓글<br />쓰기
				</a></span>
			</div>
			<div class="file-list">
				<span class="stxt">첨부파일 :</span>
				<ul></ul>
				<a href="#none" id="replyFile"><img src="../page/images/board/btn_upload.png" alt="upload" /></a>
			</div>
		</form>
		<form id="replyFileForm" name="replyFileForm" method="POST" encoding="multipart/form-data" enctype="multipart/form-data">
			<p class="upload" style="display: none;">
				<input type="file">
			</p>
		</form>
	</div>
	<!-- new-re End -->
</div>

<script type="text/javascript">
var replyRowSeq = <%=replyRowSeq%>;
eventBus.addListener({
	  id : 'articleBody'
	, onLoad : function(){
		//댓글등록 버튼 이벤트 바인딩
		$('#registReply').click(function(){
			fnRegistReply();
		});

		//이전댓글보기 버튼 이벤트 바인딩
		$('#preReplyBtn').click(function(){
			fnGetReplyList();
		});

		//댓글 조회
		fnGetReplyList();
		
		// fileReply에 대한 해당 엘리멘트 이벤트 바인딩
		fileReply.action('replyFile', 'replyFileForm');  

	}
	, onSearch : function(){


	}
});
/**
 * fnRegistReply() 댓글 등록을 한다.
 */
function fnRegistReply(){
	// 댓글 등록시 Text Area 공백 체크 
	if(uxl.isEmpty($('#DS_CONTENT_REPLY').val())){
		uxl.showMessage('댓글을 입력해주세요.');
		$('#DS_CONTENT_REPLY').focus();
		return;
	}  
	
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			data:{ID_BOARD:'${paramMap.ID_BOARD}', ID_ARTICLE:'${paramMap.ID_ARTICLE}', ID_SUB:'${paramMap.ID_SUB}'}
		  , success:function(result) {
			  	/* 등록된후 폼 리셋 */
			  	$('#replyFileForm')[0].reset();
				  
			  	var strHtml = '';
				var replyId      = result.getResultKey()[2];
				var replyContent = result.getResultKey()[4];
				var nowDate = new Date();
				var now = nowDate.getFullYear();
				now += "-" + (nowDate.getMonth().toString().length < 2 ? "0"+(nowDate.getMonth() + 1):(nowDate.getMonth()+1));
				now += "-" + (nowDate.getDate().toString().length < 2 ? "0"+nowDate.getDate():nowDate.getDate());
				now += " " + nowDate.getHours() + ":" + nowDate.getMinutes();

				replyRowSeq = replyRowSeq + 1;

				strHtml += '<li name="reply_'+replyId+'">';  
				strHtml += '<div class="default">';
				strHtml += '	<dl class="writer-info">';
				//strHtml += '		<dt><strong><a href="#none" onclick="boardCommon.callManLayer(\'${user.id}\', event)">[${user.partName}] ${user.name}</a></strong></dt>';
				strHtml += '		<dt><strong>[${user.partName}] ${user.name}</strong></dt>';
				strHtml += '		<dd class="date">' + now + '</dd>';
				strHtml += '	</dl>';
				strHtml += '	<div class="cmt-cont"><pre>'+replyContent+'</pre></div>';

				var replyFiles = new Array();
				var fileInfos = $('li', replyForm);
				for(var i = 0 ; i < fileInfos.length ; i ++){
					replyFiles[i] = fileInfos[i].getAttribute('fileid');
				}

				if(replyFiles.length != 0){
					for(var i = 0 ; i < replyFiles.length ; i++){
						var fileInfo = fnGetFileInfo(replyFiles[i]);
						if(fileInfo.contentType.indexOf('image') != -1){
							strHtml += '<img src="/boardfile/thumbnail.ub?imageId='+fileInfo.id+'&wSize=106&hSize=74" alt="" />';
						}
					}

					strHtml += '<div class="file-list"><span class="stxt">첨부파일 : </span>';
					strHtml += '<ul>';

					for(var i = 0 ; i < replyFiles.length ; i ++){
						strHtml += '<li><a href="/file/download.ub?fileId='+replyFiles[i]+'">'+fileInfos[i].getAttribute('title');
						if(i+1 != replyFiles.length){
							strHtml += '<span class="comma">,</span>';
						}
						strHtml += '</a></li>';
					}

					strHtml += '</ul></div>';
				}
				strHtml += '<span class="cmt-btn">';
	  			strHtml += ' 	<a href="#none" class="btn-icon mod" onclick="javascript:setUpdateReplyForm(\''+replyId+'\');"><span>수정</span></a>';
	  			strHtml += '	<a href="#none" class="btn-icon del" onclick="javascript:deleteReply(\''+replyId+'\');"><span>삭제</span></a>';
	  			strHtml += '</span>';
				strHtml += '</div></li>';
				
				$('#replyList').append(strHtml);

				//댓글등록폼 내용 초기화
				$('#DS_CONTENT_REPLY', $('#replyForm')).val('');
				$('.file-list > ul > li', $('#replyForm')).remove();

				//스크롤 최하단으로 내림
				window.scrollTo(0,99999);
			}
		  , async:true
	};
	uxl.callSubmitFunction('replyForm', url, option);
}

<%if (reReply) {%>
/**
 * fnRegistReReply() 대댓글을 등록한다.
 */
function fnRegistReReply(formId, parentReplyId){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			data:{ID_BOARD:'${paramMap.ID_BOARD}', ID_ARTICLE:'${paramMap.ID_ARTICLE}', ID_PARENT_REPLY:parentReplyId, ID_SUB:'${paramMap.ID_SUB}'}
		  , success:function(result) {
			  	$('#replyList').children().remove();
			  	fnGetReplyList();
			  	$('#DS_CONTENT_REPLY').val('');
			  	$('.file-list > ul > li', $('#'+formId)).remove();
			}
		  , async:true
	};
	uxl.callSubmitFunction(formId, url, option);  
}
<%}%>
/**   
 * deleteReply
 * @param replyId replyID를 넘겨받는다. 해당 게시판의 1번 덧글인 경우 deleteReply('1') 이런식으로 호출된다.
 */
function deleteReply(replyId){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED5');
	var option = {
			data:{ID_BOARD:'${paramMap.ID_BOARD}', ID_ARTICLE:'${paramMap.ID_ARTICLE}', ID_REPLY:replyId, ID_SUB:'${paramMap.ID_SUB}'}
		  , success:function(result) {
				$('li[name="reply_'+replyId+'"]', $('#replyList')).remove();
				replyRowSeq = replyRowSeq - 1;
			}
		  , async:true
		  , message : {
			  	confirm : uxl.getMessage('@message.common.delete.confirm'),
				fail : uxl.getMessage('@message.common.delete.fail')
			}
	};
	uxl.callFunction(url, option);
}
/**
 * setUpdateReplyForm 댓글을 수정할시에 입력폼을 동적으로 생성한다.
 * @param replyId replyID를 넘겨받아 호출된다. 1번 덧글인 경우 setUpdateReplyForm('1') 이런식으로 호출한다.
 * 				  					
 */  
function setUpdateReplyForm(replyId){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REPLYDETAIL');
	var option = {
			data:{ID_BOARD:'${paramMap.ID_BOARD}', ID_ARTICLE:'${paramMap.ID_ARTICLE}', ID_REPLY:replyId, ID_SUB:'${paramMap.ID_SUB}'}
		  , success:function(result) {
			  	replyUpdateCancelAll();
			  	
				var targetReply = $('li[name="reply_'+replyId+'"]>div');
				var detailData = result.getDataList("replyDetail").rows[0];
				var fileInfo = result.getDataList('<%=ConstantHolder.KEY_FILEINFO%>');

				var updateFormId     = 'replyUpdateForm_'+replyId;
				var updateFileFormId = 'replyUpdateFileForm_'+replyId;
				var updateFileId     = 'updateReplyFile_'+replyId;
				var updateReplyId    = 'updateReply_'+replyId;
				
				var strHtml = '';                
				strHtml += '<span class="upd-cmt"><a href="#none" onclick="javascript:replyUpdateCancel(\''+replyId+'\'\,this\);">수정취소</a></span>';
				strHtml += '<div class="upd-re">';
				strHtml += '    <form id="'+updateFormId+'" name="'+updateFormId+'">';
				strHtml += '	    <div class="reply-area">';
				strHtml += '		    <textarea class="ub-control textarea" id="DS_CONTENT_REPLY" name="DS_CONTENT_REPLY" metalength="2000">'+detailData.DS_CONTENT_REPLY+'</textarea>';
				strHtml += '		    <span class="re-write" id="'+updateReplyId+'"><a href="#none">댓글<br />수정</a></span>';
				strHtml += '	    </div>	';
				strHtml += '	    <div class="file-list">';
				strHtml += '		    <span class="stxt">첨부파일 :</span>';
				strHtml += '		    <ul></ul>	';
				strHtml += '		    <a href="#none" id="'+updateFileId+'"><img src="../page/images/board/btn_upload.png" alt="upload" /></a>';
				strHtml += '	    </div>';
				strHtml += '	</form>';

				strHtml += '	<form id="'+updateFileFormId+'" name="'+updateFileFormId+'" method="POST" encoding="multipart/form-data" enctype="multipart/form-data">';
				strHtml += '	    <p class="upload" style="display: none;">';
				strHtml += '	        <input type="file">';
				strHtml += '	    </p>';
				strHtml += '	</form>';

				strHtml += '</div>';

				//기존 댓글 View 영역 숨김
				targetReply.children().hide();

				//기존 댓글 등록 영역 숨김
				$('#replyForm').hide();

				//댓글 수정 Form 생성
				targetReply.append(strHtml);

				//첨부파일 로딩
				fileReply.loadingFile(fileInfo, $('div.file-list > ul', $('#'+updateFormId)));

				//첨부파일 기능 Load
				fileReply.action(updateFileId, updateFileFormId);

				$('#'+updateReplyId, targetReply).click(function(event){
					fnUpdateReply(updateFormId, replyId);
				});
		  }
		  , async:true
	};
	uxl.callFunction(url, option);
}


/**
 * replyUpdateCancel() 댓글 수정 취소
 * @param replyId 댓글ID
 * @Param selectCancelBtn 수정취소버튼에 참조값
 */
function replyUpdateCancel(replyId,selectCancelBtn){
	var targetReply = $('li[name="reply_'+replyId+'"]>div');
	var updateFormId = 'replyUpdateForm_'+replyId;
	var updateFileFormId = 'replyUpdateFileForm_'+replyId;
	    
	/* 기존 수정폼 삭제 변경 -> 부모의 엘리멘트까지 삭제하여 수정 취소시 불필요 엘리멘트 삭제함 */
	//수정폼 삭제   
	$('#'+updateFormId, targetReply).parent().remove();
	//$('#'+updateFileFormId, targetReply).remove();
	$(selectCancelBtn).parent().remove(); // -> 수정 취소 버튼도 삭제 
	
	//기존 댓글 View 영역 보임
	targetReply.children().show();

	//기존 댓글 등록 영역 보임      
	$('#replyForm').show();
}

/**
 * replyUpdateCancelAll() 현재 수정하는 덧글 외 모든  덧글 수정폼을 삭제한다.
 */
function replyUpdateCancelAll(){
	//모든 수정폼 삭제 변경 추가      
	$('li[name^="reply_"]>div>span.upd-cmt').remove();
	$('li[name^="reply_"]>div>div.upd-re').remove();
	//모든 기존 댓글 View 영역 보임
	$('li[name^="reply_"]>div').children().show();
	//기존 댓글 등록 영역 보임
	$('#replyForm').show();  
}

/**
 * fnUpdateReply() 댓글을 수정한다.
 * @param formId  formID 
 * @param replyId 댓글ID
 */
function fnUpdateReply(formId, replyId){
	// TextArea 공백 체크
	if(uxl.isEmpty($('#DS_CONTENT_REPLY', $('#' + formId)).val())){
		uxl.showMessage('댓글을 입력해주세요.');
		$('#DS_CONTENT_REPLY', $('#' + formId)).focus();
		return;
	}
	
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REPLYUPDATE');
	var option = {
			data:{ID_BOARD:'${paramMap.ID_BOARD}', ID_ARTICLE:'${paramMap.ID_ARTICLE}', ID_REPLY:replyId, ID_SUB:'${paramMap.ID_SUB}'}
		  , success:function(result) {
			    // resultTest = result;  
			  	var targetReply = $('li[name="reply_'+replyId+'"]>div');
			  	var updateForm = $('#replyUpdateForm_'+replyId);
				
			  	// 서버를 통해서 치환된 문자열을 받아서 처리한다.
				var replyContent = result.getResultKey()[0];
				$('.cmt-cont>pre', targetReply).html(replyContent);
				
				
			  	var replyFiles = new Array();
			  	var replyFilesName = new Array(); // file 명 추가
				var fileInfos = $('li', updateForm); 
				var seq = 0;
				for(var i = 0 ; i < fileInfos.length ; i ++){
					if(fileInfos[i].style.display != 'none'){
						replyFiles[seq] = fileInfos[i].getAttribute('fileid');
						replyFilesName[seq] = fileInfos[i].getAttribute('title');
						seq++;
					}
				}
          
				//수정폼 및 기존 파일 및 이미지 썸네일 삭제
				updateForm.remove();
				$('.file-list>ul>li', targetReply).remove();
				$('img', targetReply).remove();
				
				/* 수정폼 입력후 수정 취소 관련 엘리멘트 삭제  */
				$('.upd-cmt', targetReply).remove();  
				$('.upd-re', targetReply).remove();  
				      
				var strHtml = '';
				if(replyFiles.length != 0){ // 파일 추가 여부 확인
					for(var i = replyFiles.length-1 ; i >= 0 ; i--){
						var fileInfo = fnGetFileInfo(replyFiles[i]);
						if(fileInfo.contentType.indexOf('image') != -1){
							$('div.cmt-cont', targetReply).after('<img src="/boardfile/thumbnail.ub?imageId='+fileInfo.id+'&wSize=106&hSize=74" alt="" />');
						}
					}

					for(var i = 0 ; i < replyFiles.length ; i ++){
						strHtml += '<li><a href="/file/download.ub?fileId='+replyFiles[i]+'">'+replyFilesName[i];
						if(i+1 != replyFiles.length){
							strHtml += '<span class="comma">,</span>';
						}
						strHtml += '</a></li>';
					}
				}
                     
				/* fileList인 엘레멘트가 없을 경우 추가, 파일이 존재하지 않을 경우 file-list 엘리멘트 삭제 */  
				var isExistFileList = $('.file-list', targetReply);         
				if(isExistFileList.length ==0 && replyFiles.length !=0 ){   // FileList 엘리멘트가 존재하지 않고 실제 파일이 존재한다면 추가
					$('div.cmt-cont',targetReply).after('<div class="file-list"><span class="stxt">첨부파일 :</span><ul></ul><div>');   
				} else if( replyFiles.length ==0 ){							//  실제 파일이 존재하지 않는다면 file-list 를 제거 
					$('.file-list', targetReply).remove();        
				}
				
				    	
				$('.file-list>ul', targetReply).append(strHtml);
				
			  	targetReply.children().show();

			  	//기존 댓글 등록 영역 보임
				$('#replyForm').show();
			}
		  , async:true
	};
	uxl.callSubmitFunction(formId, url, option);
}
/**
 * fnGetReplyList() 댓글 리스트를 가져온다.
 */
function fnGetReplyList(){
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED3');
	var option = {
			data:{ID_BOARD:'${paramMap.ID_BOARD}', ID_ARTICLE:'${paramMap.ID_ARTICLE}', ID_SUB:'${paramMap.ID_SUB}', ROW_SEQ:replyRowSeq}
		  , success:function(result) {
			  	var replyList = result.getDataList("replyList");
			  	var replyFileList = result.getDataList("replyFileList");
			  	var replyInfo = result.getDataList("replyInfo").rows[0];

			  	//현재 호출된 댓글 수 보다 존재하는 댓글 수가 많을 경우 이전댓글보기 버튼 활성화
			  	if(replyRowSeq < parseInt(replyInfo.MAX_COUNT, 10)){
			  		$('#preReplyBtn').css('display','');
			  	}else{
			  		$('#preReplyBtn').css('display','none');
			  	}

			  	//다음조회댓글 최대수 설정
			  	replyRowSeq = replyRowSeq + <%=replyRowSeq%>;

				for(var i = parseInt(replyList.rowCount, 10)-1 ; i > -1 ; i--){
			  		var replyData = replyList.rows[i];
			  		var replyDepth = replyData.DEPTH;
			  		<%if (reReply) {%> var fileAddId = 'replyFile' + replyData.ID_REPLY; <%}%>
			  		var strHtml = '';

			  		strHtml += '<li name="reply_'+replyData.ID_REPLY+'">';
		  			if(parseInt(replyDepth, 10) != 0){
		  				strHtml += '<div class="reply">';
			  		}else{
			  			strHtml += '<div class="default">';
			  		}
			  		if(replyData.FG_DEL == 'N'){
				  		strHtml += '	<dl class="writer-info">';
				  		//strHtml += '		<dt><strong><a href="#none" onclick="boardCommon.callManLayer(\''+replyData.REG_USER_ID+'\', event)">'+replyData.REG_USER_NM+'</a></strong></dt>';
				  		strHtml += '		<dt><strong>'+replyData.REG_USER_NM+'</strong></dt>';
				  		strHtml += '		<dd class="date">'+replyData.REG_DATETIME+'</dd>';
				  		<%if (reReply) {%>
				  			strHtml += '		<dd class="re"><span class="ico-re" name="openReReplyForm"><a href="#none">댓글</a></span></dd>';
						<%}%>
				  		strHtml += '	</dl>';
				  		strHtml += '	<div class="cmt-cont">';
				  		strHtml += '		<pre>'+replyData.DS_CONTENT_REPLY+'</pre>';
				  		strHtml += '	</div>';
				  		if(replyData.FILES.length != 0){
				  			for(var k = 0 ; k < replyFileList.rowCount ; k++){
				  				var replyFile = replyFileList.rows[k];
				  				var fileKey = '${paramMap.ID_BOARD}|${paramMap.ID_ARTICLE}|'+replyData.ID_REPLY+'|'+replyData.ID_SUB;
				  				if(fileKey == replyFile.ID_REPLY && replyFile.CONTENT_TYPE.indexOf('image') != -1){
				  					strHtml += '<img src="/boardfile/thumbnail.ub?imageId='+replyFile.ATTACH_ID+'&wSize=106&hSize=74" alt="" />';
				  				}
				  			}

				  			strHtml += '	<div class="file-list"><span class="stxt">첨부파일 :</span><ul>';
				  			var count = 0;
				  			for(var j = 0 ; j < replyFileList.rowCount ; j++){
				  				var replyFile = replyFileList.rows[j];
				  				var fileKey = '${paramMap.ID_BOARD}|${paramMap.ID_ARTICLE}|'+replyData.ID_REPLY+'|'+replyData.ID_SUB;
				  				if(fileKey == replyFile.ID_REPLY){
				  					count++;
				  					var downloadUrl = uxl.getContextURL('/file/download.' + uxl.CONSTANT.URL_EXTENTION + '?fileId=' + replyFile.ATTACH_ID);
				  					strHtml += '	<li><a href="'+downloadUrl+'">'+replyFile.FILE_NM;
				  					if(count != replyData.FILES.split('|').length){
				  						strHtml += '<span class="comma">,</span>';
				  					}
				  					strHtml += '</a></li>';
				  				}
				  			}
					  		strHtml += '	</ul></div>';
				  		}
				  		<%if (reReply) {%>
					  		strHtml += '	<div style="display:none;" name="reReplyLayout">';
					  		strHtml += '		<form id="replyForm'+replyData.ID_REPLY+'" name="replyForm'+replyData.ID_REPLY+'">';
					  		strHtml += '			<div class="reply-area">';
					  		strHtml += '				<textarea class="ub-control textarea" id="DS_CONTENT_REPLY" name="DS_CONTENT_REPLY" metalength="2000"></textarea>';
					  		strHtml += '				<span class="re-write" name="registReReply"><a href="#none">댓글<br />쓰기</a></span>';
					  		strHtml += '			</div>';
					  		strHtml += '			<div class="file-list"><span class="stxt">첨부파일 :</span><ul></ul><a href="#none" id="'+fileAddId+'"><img src="../page/images/board/btn_upload.png" alt="upload" /></a><p class="upload" style="display:none;"><input type="file"></p></div>';
					  		strHtml += '		</form>';
					  		strHtml += '	</div>';
				  		<%}%>
				  		if(replyData.REG_USER_ID == '${user.id}'){
				  			strHtml += '<span class="cmt-btn">';
				  			strHtml += ' 	<a href="#none" class="btn-icon mod" onclick="javascript:setUpdateReplyForm(\''+replyData.ID_REPLY+'\');"><span>수정</span></a>';
				  			strHtml += '	<a href="#none" class="btn-icon del" onclick="javascript:deleteReply(\''+replyData.ID_REPLY+'\');"><span>삭제</span></a>';
				  			strHtml += '</span>';
				  		}

				  		strHtml += '	</div>';
				  		strHtml += '</li>';
				  		$('#replyList').prepend(strHtml);

				  		<%if (reReply) {%> fileReply.action(fileAddId); <%}%>
			  		}else{
				  		strHtml += '		<div class="cmt-cont">';
				  		strHtml += '			<p>삭제된 댓글입니다.</p>';
				  		strHtml += '		</div>';
				  		strHtml += '	</div>';
				  		strHtml += '</li>';
				  		$('#replyList').prepend(strHtml);
			  		}
			  	}
				<%if (reReply) {%>
			  	$('span[name="openReReplyForm"]').click(function(event){
			  		var reReplyForm = $('div[name="reReplyLayout"]', $(this).parent().parent().parent());
			  		if(reReplyForm.css('display') == 'none'){
			  			//열려있는 모든 댓글의 댓글폼 닫기
			  			$('div[name="reReplyLayout"]').css('display','none');
			  			reReplyForm.css('display','');
			  		}else{
			  			reReplyForm.css('display','none');
			  		}
			  	});

			  	$('span[name="registReReply"]').click(function(event){
			  		var targetForm = $(this).parent().parent();
			  		var formId = targetForm.attr('id');
			  		var parentReplyId = formId.substr(9);
			  		fnRegistReReply(formId, parentReplyId);  
			  	});
				<%}%>
			}
		  , async:true
	};
	uxl.callFunction(url, option);
}
/**
 * fnGetFileInfo()
 * @param fileId fileId
 */
function fnGetFileInfo(fileId){
	var fileInfo = null;
	var url = uxl.getContextURL('/file/query.'+ uxl.CONSTANT.URL_EXTENTION);
	var option = {
			data:{fileId:fileId}
		  , success:function(result) {
				fileInfo = result.getDataList(0).rows[0];
			}
		  , async:false
	};
	uxl.callFunction(url, option);
	return fileInfo;
}
 
</script>

<%
	}
%>
