<%--
#*
 *  파 일 명 :  INF0012.jsp
 *  설    명 :  처리지침 등록
 *  작 성 자 :  이동엽
 *  작 성 일 :  2014-03-19
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.type.ResultStatus"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>


<script type="text/javascript">
uxl.onLoad(function(){
	
	//Combo Ajax 처리
	uxl.bindComboCode('CD_VOC_PATTERN', 'CD_VOC_PATTERN', {parameter : {}, emptyOption:'전체'});
	uxl.bindComboCode('CD_VOC_CAUSE_1', 'CD_VOC_CAUSE_1', {parameter : {}, emptyOption:'전체'});
	uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}});
	uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}});
	
	//내용 에디터
	/*
	uxl.Editor('DS_CONTENT' , {
		height:'250px'   // CSS unit.
	});
	*/
	
	//목록으로 이동
	$('#list').click(function(){
		uxl.returnToList('INF0020');
	});
	
	//저장
	$('#save').click(function(){
		fnSave();
	});
	
	//첨부파일 등록
	uxl.ext.Upload('file');
	
	//자동완성 기능(내용유형)
	uxl.autocomplete('NM_VOC_CAUSE', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'),  {
					data : {}
					, minLength : 2
					, itemExtractor : function(row) { 
													var item = {
																id : row.CODE
																, value : row.CODE_NAME
																, label : row.CODE_NAME
													};
						return item;
					}
	    			, select: function(event, ui) {
									    			var str = ui.item.id;
											    	$('#CD_VOC_CAUSE_1').val(str.substr(0,3));
											    	uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}, unusedMapping:true});
											    	$('#CD_VOC_CAUSE_2').val(str.substr(0,6));
											    	uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}, unusedMapping:true});
											    	$('#CD_VOC_CAUSE_3').val(str).change();
													}
	});
	
});

//등록
function fnSave() {
	
	//$('#DS_CONTENT').val(uxl.Editor.getData("DS_CONTENT"));
	
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
				uxl.moveLocation('INF0020');
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
</script>