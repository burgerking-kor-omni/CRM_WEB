<%--
#*
 *  파 일 명 :  INF0025.jsp
 *  설    명 :  정독캠페인 상세
 *  작 성 자 :  이슬기
 *  작 성 일 :  2015-03-24
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ include file="/WEB-INF/jsp/include/pageTagLibs.jsp"%>

<%
	User user = UserUtil.getLoginUser();
	String apMaxRole = user.getMaxRole();
	String hasRole = "N";
	// VOC 총괄관리자, 시스템 관리자일 경우 버튼권한
// 	if( apMaxRole.equals(VocConstantHolder.ROLE_VOC_ADMIN) || apMaxRole.equals(VocConstantHolder.ROLE_ID_ADMIN))
	{
		hasRole = "Y";
	}
	
	DataList dataList = ViewUtil.getResult().getDataList("ForecastInquiry.getPeruseCampaignDetail");
	String filePath = dataList.getString(0, "ATTACH_PATH");
%>

<script type="text/javascript">

uxl.onLoad(function(){
	//파일명
	var attachPath = '<%=filePath%>';
	//권한
	var hasRole = "<%=hasRole%>";
	
	//관리자일 경우
	if("Y" == hasRole){
		//첨부파일 수정 가능
		uxl.ext.pdfUpload('file');
	}else{
		//첨부파일 열람만 가능
		uxl.ext.pdfUpload('file',{readOnly : true});
		//조회이력 숨김
		$('#layout-1_7').hide();
		$('#update').hide();
		$('#delete').hide();
		$('#DS_TITLE').attr('readonly',true);
		$('#DT_START').attr('class', 'ub-control input-text calendar hasDatepicker readonly');
		$('#DT_END').attr('class', 'ub-control input-text calendar hasDatepicker readonly');
		$('#DS_CONTENT').attr('readonly',true);
	}
	
	
	/*#########공통 이벤트 ##########*/
	
	//첨부파일 자동 팝업
	if(uxl.isNotEmpty(attachPath)){
		var url = uxl.getContextURL(attachPath);
		var fgPopup = window.open(url, 'pdfPopUp', 'width=960, height=800, scrollbars=no, resizable=no, titlebar=no, status=no, location=no, menubar=no');
		if(fgPopup == null){
			 window.close();
			uxl.showMessage("차단된 팝업창을 허용해 주세요");
		}else{
			var acrobat = CheckAdobeVersion();
			if(uxl.isNull(acrobat)){
				window.close();
				uxl.showMessage("Acrobat Reader를 설치 해야 합니다.");
			}
		} 
	};
	
	//조회이력저장
	fnSave();
	
	//목록으로 이동
	$('#list').click(function(){
		uxl.returnToList('INF0024');
	});
	
	//수정
	$('#update').click(function(){
		fnUpdate();
	});
	
	//삭제
	$('#delete').click(function(){ 
		fnDelete();
	});
	
	//조회이력 버튼 클릭
	$('#inquiryRecord').click(function(){
		uxl.openWindow('deptSearch', uxl.getScreenURL('POP0103')+'?ID_CAMPAIGN='+$('#ID_CAMPAIGN').val(), { width:'960px' ,height:'450px',scrollbars:'yes'});
		
	});
	
});//End of onLoad


//등록
function fnSave() {
	
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REGIST');
	var option = {
			  data:{}
			, success:function(result){
			}
			, async:true
	};
	
	uxl.callSubmitFunction('detailForm' , url , option );
}

//수정
function fnUpdate(){
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'MODIFY');
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
				uxl.reload();
			}
			, async:true
			, message : {
				 confirm : uxl.getMessage('@message.common.update.confirm'),
				 success : uxl.getMessage('@message.common.update.success'),
				 fail : uxl.getMessage('@message.common.update.fail')
			  }
			
	};
	uxl.callSubmitFunction('detailForm' , url , option );		
}

//삭제
function fnDelete(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'REMOVE');
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
				uxl.returnToList('INF0024');
			}
			, async:true
			, message : {
				 confirm : uxl.getMessage('@message.common.delete.confirm'),
				 success : uxl.getMessage('@message.common.delete.success'),
				 fail : uxl.getMessage('@message.common.delete.fail')
			  }
			
	};
	uxl.callSubmitFunction('detailForm' , url , option );		
}

//acrobat reader 설치여부 체크
function CheckAdobeVersion() {
    var isInstalled = false;
    var version = null;
    if (window.ActiveXObject) {
        var control = null;
        try {
            // AcroPDF.PDF is used by version 7 and later
            control = new ActiveXObject('AcroPDF.PDF');
        } catch (e) {
            // Do nothing
        }
        if (!control) {
            try {
                // PDF.PdfCtrl is used by version 6 and earlier
                control = new ActiveXObject('PDF.PdfCtrl');
            } catch (e) {
                return;
            }
        }
        if (control) {
            isInstalled = true;
            version = control.GetVersions().split(',');
            version = version[0].split('=');
            version = parseFloat(version[1]);
            return version;
        }
    } else {
        // Changes added in here
        var plugins = navigator.plugins;

        for(var i = 0; i < plugins.length; i++){
            if (plugins[i].name === "Adobe Acrobat"){
                version = plugins[i].version;

                if(!version) {
                    version = plugins[i].description.split('"')[1];
                }

                return parseFloat(version);
            }
        }    
    }
}

</script>	