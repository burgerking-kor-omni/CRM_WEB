<%--
#*
 *  파 일 명 :  EXP5005.jsp
 *  설    명 :  DIV TAB 상세화면 샘플
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
tab.onLoad('EXP5005', function(tabId, $thisTab, screenId){
	
	uxl.ext.Upload('file3');

	//수정
	$('#btnUpdate', $thisTab).click(function(){
		
		//필수정보 체크
		var url = uxl.getFunctionUrl(screenId,'MODIFY');
		var option = {
				  data:{}
				, validator:function(data,targetForm){
						var returnVal = false;
						//필수항목체크
						if(uxl.checkRequiredFields(targetForm)){
							if($('#DT_START').val()>$('#DT_END').val()){
								uxl.showMessage(uxl.getMessage('message.common.validation.date', "공지기간 마지막일","공지기간 시작일"));
							}else{
								returnVal = true;
							}				
						}
						
						return returnVal;
					}
				/*
				 * 조회한 데이터를 그리드에 추가함.
				 * @param {String} 그리드로 변환할 테이블ID
				 * @param {Result} 조회된 데이터 객체 result
				 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
				 */
				, success:function(result){
				}
				, async:true
				, message : {
					 confirm : uxl.getMessage('@message.common.update.confirm'),
					 success : uxl.getMessage('@message.common.update.success'),
					 fail 	 : uxl.getMessage('@message.common.update.fail')
				  }
				
		};
		uxl.callSubmitFunction($('#detailForm', $thisTab), url , option );		
	});
	
	//삭제
	$('#btnDelete', $thisTab).click(function(){
		//필수정보 체크
		var url = uxl.getFunctionUrl(screenId,'REMOVE');
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
				/*
				 * 조회한 데이터를 그리드에 추가함.
				 * @param {String} 그리드로 변환할 테이블ID
				 * @param {Result} 조회된 데이터 객체 result
				 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
				 */
				, success:function(result){
				}
				, async:true
				, message : {
					 confirm : uxl.getMessage('@message.common.delete.confirm'),
					 success : uxl.getMessage('@message.common.delete.success'),
					 fail : uxl.getMessage('@message.common.delete.fail')
				  }
				
		};
		uxl.callSubmitFunction($('#detailForm', $thisTab), url , option );		});
	
	//다음글
	$('#btnNext', $thisTab).click(function(){
		//필수정보 체크
		
		var url = uxl.getFunctionUrl(screenId,'USERDEFINED1');
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
					var data = result.getDataList("NoticeManageInquiry.getNoticeNextDetail");
					if(data.rowCount > 0){
						uxl.moveLocation(uxl.getScreenURL(screenId)+ '?ID_NOTICE='+data.rows[0].ID_NOTICE);	
					}else{
						alert('다음글이 존재하지 않습니다.');
					}
					
					
				}
		};
		uxl.callSubmitFunction($('#detailForm', $thisTab), url , option );	
	});
	
	//이전글
	$('#btnPrev', $thisTab).click(function(){
		//필수정보 체크
		var url = uxl.getFunctionUrl(screenId,'USERDEFINED2');
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
					var data = result.getDataList("NoticeManageInquiry.getNoticePrevDetail");
					if(data.rowCount > 0){
						uxl.moveLocation(uxl.getScreenURL(screenId)+ '?ID_NOTICE='+data.rows[0].ID_NOTICE);
					}else{
						alert('이전글이 존재하지 않습니다.');					
					}
					
				}
		};
		uxl.callSubmitFunction($('#detailForm', $thisTab), url , option );	
	});
});
</script>	