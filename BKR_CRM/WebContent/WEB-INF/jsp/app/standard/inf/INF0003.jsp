<%--
#*
 *  파 일 명 :  INF0003.jsp
 *  설    명 :  공지사항 등록
 *  작 성 자 :  이슬기
 *  작 성 일 :  2015-08-03
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2015 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>

<script type="text/javascript">
uxl.onLoad(function(){
	
	//첨부파일 등록
	uxl.ext.Upload('file');
	
	$('#DS_NOTICE').attr('maxlength',1000);
	
	//목록으로 이동
	$('#list').click(function(){
		uxl.moveLocation('INF0001');
	});
	
	//저장
	$('#save').click(function(){		
		fnSave();
	});
	
	//팝업여부 체크박스 여부
	$('#FG_POPUP').click(function() {
		var ischecked = $('#FG_POPUP').attr('checked');
		if(ischecked){
			//checked일 경우
			uxl.openWindow('registDate', uxl.getScreenURL('INF0030'), { width:'550px' ,height:'280px' }, callBackDate);
			}
	});
	
	$('#FG_OPEN').click(function(){
		if($(this).prop("checked")){
			$('#DT_START, #DT_END').attr('metaessential',1);
			$('label[for="DT_START,DT_END"]').append('<span class="required">*</span>');
		}else{
			$('#DT_START, #DT_END').attr('metaessential',0);
			$('label[for="DT_START,DT_END"] span').remove();
		}		
	});
	
	$('input, textarea').dblclick(function(){
		$(this).val('')
	});

});//end of onLoad

//등록
function fnSave() {
	
	var dtStart = new Date($('#DT_START').val());
	var dtEnd = new Date($('#DT_END').val());
	var fgOpenPortal = 'N';
	if(dtStart > dtEnd){
		alert('공지기간이 유효하지 않습니다.');
		return;
	}
	
	if($('#FG_OPEN').prop('checked')){
		fgOpenPortal = 'Y';
	}
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			data:{
				FG_OPEN_PORTAL : fgOpenPortal
			}
		  , validator:function(data,targetForm){
			  var returnVal = false;
			  //필수항목체크
			  if(uxl.checkRequiredFields(targetForm)){
				  returnVal = true;
			  }
			  return returnVal;
		  }
		  , success:function(result){
			  uxl.returnToList('INF0001');
		  }
		  , async:true
		  , message : {
			  confirm : uxl.getMessage('@message.common.confirm','등록'),
			  success : uxl.getMessage('@message.common.success','등록'),
			  fail : uxl.getMessage('@message.common.fail','등록')
		  }
	};
	uxl.callSubmitFunction('registForm' , url , option );
}

//팝업 기간 설정 콜백
function callBackDate(date){
	$('#DT_START_POPUP').val(date.startDate);				
	$('#DT_END_POPUP').val(date.endDate);		  	
}



</script>	

