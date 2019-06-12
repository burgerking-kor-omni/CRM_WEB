<%--
#*
 *  파 일 명 : INF0014.jsp
 *  설    명 : 베스트&워스트 등록 팝업
 *  작 성 자 : 이슬기
 *  작 성 일 :  2015-08-03
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<%@ page import="com.ubone.framework.engine.domain.User"%>
<%@ page import="com.ubone.framework.util.UserUtil"%>
<%
	User user = UserUtil.getLoginUser();
	String hasRole = "N";
	
	//권한 컨트롤
// 	if(user.hasRole(VocConstantHolder.ROLE_ID_ADMIN)){
		//1.시스템관리자
		hasRole = "S";
// 	}else if(user.hasRole(VocConstantHolder.ROLE_VOC_ADMIN)){
// 		//2.고객의소리(voc)관리자
// 		hasRole = "V";
// 	}else if(user.hasRole(VocConstantHolder.ROLE_CC_ADMIN)){
// 		//3.민원관리자
// 		hasRole = "C";
// 	}
%>
<script type="text/javascript">
uxl.onLoad(function(){
	
	//분류유형
	uxl.bindComboCode('CD_VOC_PATTERN_1', 'CD_VOC_PATTERN_1', {parameter : {}, emptyOption:'전체'});
	uxl.chainCombo($('#CD_VOC_PATTERN_1'), $('#CD_VOC_PATTERN_2') , 'CD_VOC_PATTERN_2', {parameter : {}});
	uxl.chainCombo($('#CD_VOC_PATTERN_1'), $('#CD_VOC_CAUSE_1') , 'CD_VOC_CAUSE_1', {parameter : {}});   
	uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}});
	uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}}); 
	
	//접수경로
 	uxl.bindComboCode('TP_CHNN_SYSTEM', 'TP_CHNN_SYSTEM', {parameter : {}, emptyOption:'전체'});
	uxl.chainCombo($('#TP_CHNN_SYSTEM'), $('#TP_CHNN_PATH') , 'TP_CHNN_PATH', {parameter : {}});
	
	var hasRole = "<%=hasRole%>";
	//권한별 등록 컨트롤
	if(hasRole == "V"){     
		//1.고객의소리(voc)관리자 -> voc 등록가능
		$('select[id=CD_VOC_PATTERN_1]').val('01').change();
		$('#CD_VOC_PATTERN_1').attr('disabled',true);
	}else if(hasRole == "C"){
		//2.민원관리자 -> 민원 등록가능
		$('select[id=CD_VOC_PATTERN_1]').val('02').change();
		$('#CD_VOC_PATTERN_1').attr('disabled',true);
	}
	
	/*
		그리드 옵션
		colNames : 그리드 Header 정보,
		colModel : 그리드 Contents 의 바인딩 정보
	*/
	var options = {
		//header name
		colNames:['VOC NO','ID_SUB_VOC','VOC ID','유형(코드)','유형','유형(코드)','접수채널','접수경로','VOC제목','분류유형','분류유형코드','완료일시','사례유형','VOC내용','회신내용','처리내용'] 
		
		//mapping column
		,colModel:[
				   {name:'ID_VOC' ,width:0 ,hidden:true}
				  ,{name:'ID_SUB_VOC' ,width:0 ,hidden:true}
				  ,{name:'VOC_NO' ,width:27 ,align:'left'}											//VOC ID 
		          ,{name:'CD_VOC_PATTERN_1' ,width:0 ,hidden:true} 									//VOC유형1(코드)
		          ,{name:'NM_VOC_PATTERN' ,width:10 ,align:'center'}									//VOC유형1
		          ,{name:'CD_VOC_PATTERN_2' ,width:0 ,hidden:true} 									//VOC유형2(코드)
		          ,{name:'TP_CHNN_SYSTEM' ,width:15 ,align:'center',hidden:true}					//접수채널코드
		          //,{name:'NM_CHNN_SYSTEM' ,width:15 ,align:'center'}								//접수채널명
		          ,{name:'TP_CHNN_PATH' ,width:15 ,align:'center',hidden:true}
		         // ,{name:'NM_CHNN_PATH' ,width:15 ,hidden:true}									//접수채널
		          ,{name:'DS_TITLE' ,width:40} 														//제목
		          ,{name:'NM_VOC_CAUSE' ,width:30, align:'left'} 									//분류유형
		          ,{name:'CD_VOC_CAUSE' ,width:0, align:'left' ,hidden:true}						//분류유형(코드)
		          ,{name:'DT_VOC_END',width:22 ,align:'center'} 									//완료일시
		          ,{name:'TP_CASE' ,width:0 ,hidden:true} 											//사례유형
		          ,{name:'DS_CONT' ,width:0 ,hidden:true}											//VOC내용
		          ,{name:'DS_REPLY' ,width:0 ,hidden:true}											//회신내용
		          ,{name:'DS_ACT' ,width:0 ,hidden:true}											//처리내용
		      ]
		,autowidth:true
		,height:260
		,multiselect:true
		,onSelectRow:function(rowid, status, e){
		    if($('#jqg_list_'+rowid).is(":checked")){
    			$(this).resetSelection();
		    	$(this).setSelection(rowid, false);
			}
		}
		,onSelectAll: function(aRowids,status) { 
				jQuery("#list").jqGrid('resetSelection');
			}
		,ondblClickRow: function(rowid){
					//상세 호출
					var selectedRow = $(this).getRowData(rowid);
					uxl.openWindow('popVocDetail', uxl.getScreenURL('POP0023') + '?ID_VOC='+ selectedRow.ID_VOC+ '&ID_SUB_VOC='+selectedRow.ID_SUB_VOC
													, { width:1024,height:700 ,scrollbars:'yes' });
		}
	};
	uxl.grid('list', options);
	fnSearch();
	
	/*######### Button events ##########*/
	//조회 이벤트
	$('#search').click(function(event){
		fnSearch();
	});
	
	
	//엔터키 검색 전체 적용
	$('#searchForm').keydown(function(event){
		if(event.keyCode == '13'){
			fnSearch();
			return false;
		}
	});
	
	//더블 클릭시 리셋
	$('#DT_VOC_REG_START').dblclick(function(){ $(this).val(''); });
	$('#DT_VOC_REG_END').dblclick(function(){ $(this).val(''); });
	$('#DS_TITLE').dblclick(function(){ $(this).val(''); });
	$('#CD_VOC_CAUSE').dblclick(function(){
		$(this).val(''); 
		uxl.bindComboCode('CD_VOC_CAUSE_1', 'CD_VOC_CAUSE_1', {parameter : {}, emptyOption:'전체'});
		uxl.chainCombo($('#CD_VOC_CAUSE_1'), $('#CD_VOC_CAUSE_2') , 'CD_VOC_CAUSE_2', {parameter : {}});
		uxl.chainCombo($('#CD_VOC_CAUSE_2'), $('#CD_VOC_CAUSE_3') , 'CD_VOC_CAUSE_3', {parameter : {}});
	});
	
	
	//워스트 버튼 클릭 시
	$('#worst').click(function(event){
		 var rowid = $('#list').jqGrid('getGridParam','selarrrow');
		 //선택 안했을 경우
		 if(rowid.length==null || rowid.length=='0'){
			 uxl.showMessage("체크 박스를 선택한 후 확인 버튼을 눌러 주세요");
	 			return;
	 	  }
		 selectedRow = $('#list').jqGrid('getRowData',rowid);
		 var tpCase = "W";
		 fnPushToOpener(selectedRow, tpCase);
	});
	
	//베스트 버튼 클릭 시
	$('#best').click(function(event){
		 var rowid = $('#list').jqGrid('getGridParam','selarrrow');
		 //선택 안했을 경우
		 if(rowid.length==null || rowid.length=='0'){	
	 			uxl.showMessage("체크 박스를 선택한 후 확인 버튼을 눌러 주세요");
	 			return;
	 	  }
		 selectedRow = $('#list').jqGrid('getRowData',rowid);
		 var tpCase = "B";
		 fnPushToOpener(selectedRow, tpCase);
	});
	
	
	
	//자동완성 기능(내용유형)
	uxl.autocomplete('NM_VOC_CAUSE', uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1'),  {
					data : {CD_VOC_PATTERN_1: function(){
						return $('#CD_VOC_PATTERN_1').val();
					}}
					, minLength : 2
					, itemExtractor : function(row) { 
													var item = {
																      id : row.CODE
																, value: row.CODE_NAME
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
	
});//end of onload


/*########### functions ###########*/

function fnPushToOpener(selectedRow, tpCase){
	var userData = {
		 idVoc		 : selectedRow.ID_VOC	//voc id		
		,idSubVoc	 : selectedRow.ID_SUB_VOC  //sub voc id
		,noVoc       : selectedRow.VOC_NO  //voc no(vocid+vocsubid)
		,tpCase      : tpCase  //사례유형
		,dsTitle     : selectedRow.DS_TITLE //제목
		,vocPattern_2  : selectedRow.CD_VOC_PATTERN_2 //voc유형2
		,vocPattern_1  : selectedRow.CD_VOC_PATTERN_1 //voc유형1
		,vocCause    : selectedRow.CD_VOC_CAUSE //세부유형
		,dtVocEnd    : selectedRow.DT_VOC_END  //완료일
		,tpChnnS     : selectedRow.TP_CHNN_SYSTEM  //접수채널
		,tpChnnP     : selectedRow.TP_CHNN_PATH  //접수경로
		,dsCont      : selectedRow.DS_CONT  //voc내용
		,dsReply     : selectedRow.DS_REPLAY //회신내용
		,dsAct       : selectedRow.DS_ACT   //처리내용
	};
	uxl.pushToParent(userData);
	self.close();
}

/*
 * 조회한 데이터를 그리드에 추가함.
 * @param {String} 그리드로 변환할 테이블ID
 * @param {Result} 조회된 데이터 객체 result
 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
 */
function fnSearch(){
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:uxl.grid.getParam('list')
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
				uxl.grid.appendData('list' ,result , true );
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );		
}
</script>
