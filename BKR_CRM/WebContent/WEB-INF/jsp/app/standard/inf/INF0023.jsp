<%--
#*
 *  파 일 명 :  INF0023.jsp
 *  설    명 :  사전예보 등록
 *  작 성 자 :  이슬기
 *  작 성 일 :  2015-03-24
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,org.w3c.dom.*" %>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
	
	
<script type="text/javascript">
uxl.onLoad(function(){
	
	//첨부파일 업로드
	uxl.ext.pdfUpload('file');
	
	//경고메시지 숨기기
	$('#msg').hide();
	
	//목록으로 이동
	$('#list').click(function(){
		uxl.moveLocation('INF0021');
	});
	
	//저장
	$('#save').click(function(){
		checkDate();
		//fnSave();
	});
	
	//년
	$('#DS_YYYY').change(function(){
		yymmRegCheck();
	});
	
	//월
	$('#DS_DT_MM').change(function(){
		yymmRegCheck();
	});

	//첨부파일 필수조건 표시
	$('#layout-1_5_9').append("<span class='required'>*</span>");
	
});

//년/월 콤보박스 변환시 등록여부 체크
function yymmRegCheck(){
	if($('#DS_YYYY').val()!= null && $('#DS_DT_MM').val() != null){
		regCheck();
	}
}

function regCheck(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
			  data:{}
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				var rowCount = result.getDataList(0).rowCount;
				if(rowCount>0){
					$('#msg').css('color','red').show();
				}else{
					$('#msg').hide();
				}
			}
			, async:true
	};
	uxl.callSubmitFunction('registForm' , url , option );		
}

//(등록시)년월 등록 여부 조회
function checkDate(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
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
				var rowCount = result.getDataList(0).rowCount;
				if(rowCount==0){
					fnSave();
				}else{
					uxl.showMessage("이미 등록된 (년/월)입니다.");
				}
			}
			, async:true
	};
	uxl.callSubmitFunction('registForm' , url , option );		
}

//저장
function fnSave() {
	
	//첨부파일 필수처리
	var attrCount = 0;
	$('div',$('#uploadedFiles_file')).each(function() {
		if('block' == $(this).css('display')){
			attrCount++;
		}
	});
	if(0 == attrCount){
		uxl.showMessage('[첨부파일*] 은(는) 필수 항목입니다.');
		return;
	}
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
				uxl.moveLocation('INF0021');
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