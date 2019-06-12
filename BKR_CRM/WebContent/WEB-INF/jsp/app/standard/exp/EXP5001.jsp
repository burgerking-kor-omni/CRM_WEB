<%--
#*
 *  파 일 명 :  EXP5001.jsp
 *  설    명 :  DIV TAB 등록화면 샘플
 *  작 성 자 :  강영운
 *  작 성 일 :  2017-04-10
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
	
<script type="text/javascript">
/**
 * 탭ID에 해당하는 로딩 한수를 등록하는 함수 선언
 *
 * tabId : 현재탭 id
 * thisTab : 현재탭 객체
 * screenId : 현재 탭에 표시되는 화면ID
 */
tab.onLoad('EXP5001', function(tabId, $thisTab, screenId){

	uxl.ext.Upload('file1');
	
	//저장
	$('#btnSave', $thisTab).click(function(){		
		//필수정보 체크
		var url = uxl.getFunctionUrl(screenId,'REGIST');
		var option = {
				  data:{}
				, validator:function(data,targetForm){
						var returnVal = false;
						//필수항목체크
						if(uxl.checkRequiredFields(targetForm)){
							if($('#DT_START', $thisTab).val()>$('#DT_END', $thisTab).val()){
								uxl.showMessage(uxl.getMessage('message.common.validation.date', "공지기간 마지막일","공지기간 시작일"));
							}else{
								returnVal = true;
							}
						}
						return returnVal;
				}
				, success:function(result){
					// 적절한 처리 
				}
				, message : {
					 confirm : uxl.getMessage('@message.common.confirm','등록'),
					 success : uxl.getMessage('@message.common.success','등록'),
					 fail : uxl.getMessage('@message.common.fail','등록')
				}
		};
		uxl.callSubmitFunction($('#registForm', $thisTab), url , option );
	});
	
});
</script>	

