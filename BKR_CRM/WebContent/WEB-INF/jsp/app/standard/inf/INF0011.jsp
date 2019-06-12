<%--
#*
 *  파 일 명 :  INF0011.jsp
 *  설    명 :  베스트/워스트 등록
 *  작 성 자 :  이슬기
 *  작 성 일 :  2015-03-16
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
	
	
<script type="text/javascript">

uxl.onLoad(function(){
	
	
	//사례유형
	uxl.bindComboCode('TP_CASE', 'TP_CASE', {parameter : {}, emptyOption:'전체'});
	
	//접수채널
	uxl.bindComboCode('TP_CHNN_SYSTEM', 'TP_CHNN_SYSTEM', {parameter : {}, emptyOption:'전체'});
	uxl.chainCombo($('#TP_CHNN_SYSTEM'), $('#TP_CHNN_PATH') , 'TP_CHNN_PATH', {parameter : {}});
	
	//유형
	uxl.bindComboCode('CD_VOC_PATTERN_1', 'CD_VOC_PATTERN_1', {parameter : {}, emptyOption:'전체'});
	uxl.chainCombo($('#CD_VOC_PATTERN_1'), $('#CD_VOC_PATTERN_2') , 'CD_VOC_PATTERN_2', {parameter : {}});
	
	//세부유형
	uxl.bindComboCode('CD_VOC_CAUSE_1', 'CD_VOC_CAUSE_1', {parameter : {}, emptyOption:'전체'});
	uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}});
	uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}});

 	$('#CD_VOC_PATTERN_1').attr('disabled',true);
 	$('#CD_VOC_PATTERN_2').attr('disabled',true);
	$('#TP_CASE').attr('disabled',true);
	$('#TP_CHNN_SYSTEM').attr('disabled',true);
	$('#TP_CHNN_PATH').attr('disabled',true);
	$('#CD_VOC_CAUSE_1').attr('disabled',true);
	$('#CD_VOC_CAUSE_2').attr('disabled',true);
	$('#CD_VOC_CAUSE_3').attr('disabled',true);  
	
	//목록버튼 클릭
	$('#list').click(function(){
		uxl.moveLocation('INF0010');
	});
	
	//등록버튼 클릭
	$('#save').click(function(){		
		fnSave();
	});
	
	//검색버튼 클릭
	$('#searchID').click(function(){
		//vocId 등록 팝업
		uxl.openWindow('Popup', uxl.getScreenURL('INF0014'), { width:'1048px', height:'600px' }, fnPushToOpener);
	});
	
   	
});//end of onload


//등록
function fnSave() {
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			  data:{}
			, validator:function(data,targetForm){
				var returnVal = false;
				//필수항목체크
				if(uxl.checkRequiredFields(targetForm)){
					returnVal = true;
				}
					return returnVal;
			}
			, success:function(result){
				uxl.moveLocation('INF0010');
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

//베스트 상담 VOC 선택 후 callback
function fnPushToOpener(vocData) {	
	
	$('select[id=TP_CHNN_SYSTEM]').attr('disabled',false);
	$('select[id=TP_CHNN_PATH]').attr('disabled',false);
	$('select[id=TP_CASE]').attr('disabled',false);
	$('select[id=CD_VOC_PATTERN_1]').attr('disabled',false);
	$('select[id=CD_VOC_PATTERN_2]').attr('disabled',false);
	$('select[id=CD_VOC_CAUSE_1]').attr('disabled',false);
	$('select[id=CD_VOC_CAUSE_2]').attr('disabled',false);
	$('select[id=CD_VOC_CAUSE_3]').attr('disabled',false);
	
	$('#VOC_NO').val(vocData.noVoc);	//VOC_NO(ID_VOC + ID_SUB_VOC)
	$('#DS_TITLE').val(vocData.dsTitle);    //제목
	
	//접수채널+경로
	$('select[id=TP_CHNN_SYSTEM]').val(vocData.tpChnnS).change();
	 uxl.chainCombo($('select[id=TP_CHNN_SYSTEM]'), $('select[id=TP_CHNN_PATH]') , 'TP_CHNN_PATH', {parameter : {}, unusedMapping:true});
	 $('select[id=TP_CHNN_PATH]').val(vocData.tpChnnP).change();
	
	$('select[id=TP_CASE]').each(function(){
		$(this).val(vocData.tpCase);
	}); //사례유형
	
	$('input[id=TP_CASE]').each(function(){
		$(this).val(vocData.tpCase);
	}); //사례유형
	
	//voc유형 2단 처리
	
	$('select[id=CD_VOC_PATTERN_1]').val(vocData.vocPattern_1).change();
	uxl.chainCombo($('select[id=CD_VOC_PATTERN_1]'), $('select[id=CD_VOC_PATTERN_2]') , 'CD_VOC_PATTERN_2', {parameter : {}, unusedMapping:true});
	$('select[id=CD_VOC_PATTERN_2]').val(vocData.vocPattern_2).change();
	
	$('#ID_VOC').val(vocData.idVoc); //id_voc
	$('#ID_SUB_VOC').val(vocData.idSubVoc);
	$('#DS_CONT').val(vocData.dsCont);//voc내용
	$('#DS_REPLY').val(vocData.dsReply); //회신내용
	$('#DS_ACT').val(vocData.dsAct); //처리내용

	 var Cause = vocData.vocCause;
	 $('#CD_VOC_CAUSE').val(Cause); //세부유형코드(HIDDEN값)
	 
	//세부유형 3단 처리
	 $('select[id=CD_VOC_CAUSE_1]').val(Cause.substr(0,3)).change();
	 uxl.chainCombo($('select[id=CD_VOC_CAUSE_1]'), $('select[id=CD_VOC_CAUSE_2]') , 'CD_VOC_CAUSE_2', {parameter : {}, unusedMapping:true});
	 $('select[id=CD_VOC_CAUSE_2]').val(Cause.substr(0,6)).change();
	 uxl.chainCombo($('select[id=CD_VOC_CAUSE_2]'), $('select[id=CD_VOC_CAUSE_3]') , 'CD_VOC_CAUSE_3', {parameter : {}, unusedMapping:true});
	 $('select[id=CD_VOC_CAUSE_3]').val(Cause.substr(0,9)).change();
	
	 
	 $('select[id=TP_CHNN_SYSTEM]').attr('disabled',true);
	 $('select[id=TP_CHNN_PATH]').attr('disabled',true);
	 $('select[id=TP_CASE]').attr('disabled',true);
	 $('select[id=CD_VOC_PATTERN_1]').attr('disabled',true);
	 $('select[id=CD_VOC_PATTERN_2]').attr('disabled',true);
	 $('select[id=CD_VOC_CAUSE_1]').attr('disabled',true);
	 $('select[id=CD_VOC_CAUSE_2]').attr('disabled',true);
	 $('select[id=CD_VOC_CAUSE_3]').attr('disabled',true);

}



</script>	

