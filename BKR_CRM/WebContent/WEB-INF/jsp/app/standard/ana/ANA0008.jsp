<%--
#*
 *  파 일 명 :  ANA0008.jsp
 *  설    명 :  매장별-기간별 VOC현황 목록
 *  작 성 자 :  강현준
 *  작 성 일 :  2019-01-05
 *  버    전 :  1.0
 *  기타사항 :  
 *  수정이력 :  
 *  Copyrights 2013 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.MessageUtils"%>
<%@page import="com.ubone.framework.util.CodeUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ubone.framework.util.ViewUtil"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<%@ page import="com.ubone.framework.data.DataList"%>
<%@ page import="com.ubone.framework.data.Parameter"%>
<%@ page import="com.ubone.framework.ConstantHolder"%>
<%@ page import="com.ubone.framework.ConfigHolder"%>
<%@ page import="java.util.Map"%>
<%@ page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="com.ubone.ubmeta.page.util.JspUtils"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>

<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : ANA0007R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<table class="ub-control table stats">
	<colgroup>
		<col width="100px">
		<col width="">
		<col width="">
		<col width="">
		<col width="">
		<col width="">
	</colgroup>
	<thead>
		<tr>
			<th scope="col"><strong>매장</strong></th>
			<th scope="col"><strong>전체</strong></th>
		</tr>
	</thead>
	<tbody id="tbody">
	<tr class="bg02">
	<th>전체</th>
	<th id="ALLSUM0"></th>
<%
	for(int i=1; i<13; i++){
%>
		<td id="ALLSUM<%=i%>"></td>
<%
	}
%>
	</tr>
	</tbody>
</table>

<br /><br /><br /><br />
<script type="text/javascript">
uxl.onLoad(function(){
	
	// code bind
	uxl.bindComboCode('DT_START_Y', 'CD_YEAR', {emptyOption:false});
	uxl.bindComboCode('DT_START_M', 'CD_MONTH', {emptyOption:false});
	uxl.bindComboCode('CD_AGE', 'CD_AGE', {emptyOption:'전체'});
	uxl.bindComboCode('CD_GENDER', 'CD_GENDER', {emptyOption:'전체'});
	uxl.bindComboCode('CD_GRADE', 'CD_GRADE', {emptyOption:'전체'});
	uxl.bindComboCode('CD_STORE', 'CD_STORE', {emptyOption:'전체'});
	$('#CD_STORE option[value="99"]').remove();
	$('#FG_MEMBER').append('<option value="">전체</option><option value="Y">회원</option><option value="N">비회원</option>');
	$('#YN_FLAG').append('<option value="">전체</option><option value="1">Y</option><option value="0">N</option>');

	//Enter Key 이벤트
	$('form').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch();
		}
	});
	
	// 2019.06.07  엑셀 다운로드 
	$('#excelBtn').click(function(){
		fnGetExcel();
	});
	
	var nowYmd = new Date();
// 	nowYmd.addMonths(-1);
	var MM = nowYmd.getMonth()+1;
	$('#DT_START_M').val(MM < 10 ? '0'+MM : MM);

	fnSearch();
	
});

//전체 XML 생성
function fnSearch(){
	
	var chnn_size = $('input[name=CD_BIZ_CHNN]:checked').length;
    
    if(chnn_size < 1){
    	alert('채널을 1개 이상 선택해 주십시오.');
    	return;
    }

	var listDate = [];
	var startDate = new Date($('#DT_START_Y').val()+"-"+$('#DT_START_M').val()+'-01');
	var endDate = new Date($('#DT_START_Y').val()+"-"+$('#DT_START_M').val()+'-01');
	var dateMove = new Date($('#DT_START_Y').val()+"-"+$('#DT_START_M').val()+'-01');
	startDate.setMonth(-12);
	var strDate = "";
    for(var i = 0; i < 12; i++) {
    	strDate = dateMove.getFullYear()+'년 ';
        strDate += (dateMove.getMonth()+1) < 10? '0'+(dateMove.getMonth()+1) : (dateMove.getMonth()+1);
        strDate += '월';
        listDate.push(strDate);
        dateMove.setMonth(dateMove.getMonth()-1);
    }
	
	$('thead tr th[name="HEADER_Y"]').each(function(){
		$(this).remove();
	});
	for(var i = 0; i < 12; i++){
		// 기존 날짜 헤더 삭제
		$('thead tr').append('<th style="width:70px" name="HEADER_Y" scope="col"><strong>'+listDate[i]+'</strong></th>');
	}
	
	 $('#tbody tr[name="dataTR"]').each(function(){
		 $(this).remove();
	});
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:{BIZ_CHNN_SIZE : chnn_size}
			, success:function(result){
				var dl = result.getDataList(0);
				var allSum = 0;
				var rowSum = 0;
				var colSum = [11];
				for(var i = 0; i < 12; i++ ){
					colSum[i] = 0;
				}
				for(var i = 0; i < dl.rowCount; i++){
					
					// 행별 합계
					rowSum = 0;
					rowSum += dl.rows[i].DATA1*1;
					rowSum += dl.rows[i].DATA2*1;
					rowSum += dl.rows[i].DATA3*1;
					rowSum += dl.rows[i].DATA4*1;
					rowSum += dl.rows[i].DATA5*1;
					rowSum += dl.rows[i].DATA6*1;
					rowSum += dl.rows[i].DATA7*1;
					rowSum += dl.rows[i].DATA8*1;
					rowSum += dl.rows[i].DATA9*1;
					rowSum += dl.rows[i].DATA10*1;
					rowSum += dl.rows[i].DATA11*1;
					rowSum += dl.rows[i].DATA12*1;
					
					// 각 열별 합계 더하기
					colSum[0] += dl.rows[i].DATA1 *1;  
					colSum[1] += dl.rows[i].DATA2 *1;  
					colSum[2] += dl.rows[i].DATA3 *1;  
					colSum[3] += dl.rows[i].DATA4 *1;  
					colSum[4] += dl.rows[i].DATA5 *1;  
					colSum[5] += dl.rows[i].DATA6 *1;  
					colSum[6] += dl.rows[i].DATA7 *1;  
					colSum[7] += dl.rows[i].DATA8 *1;  
					colSum[8] += dl.rows[i].DATA9 *1;  
					colSum[9] += dl.rows[i].DATA10 *1; 
					colSum[10] += dl.rows[i].DATA11 *1;
					colSum[11] += dl.rows[i].DATA12 *1;
					
					// 전체 합계
					allSum += rowSum*1;
					
					$('#tbody').append(
							 '<tr name="dataTR"><th>'+dl.rows[i].STOR_NM+'</th>'
							+'<th class="bg02">'+uxl.setComma(rowSum)+'</th>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA1)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA2)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA3)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA4)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA5)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA6)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA7)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA8)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA9)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA10)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA11)+'</td>'
							+'<td>'+uxl.setComma(dl.rows[i].DATA12)+'</td></tr>'
					);
				}
				
				// 각 열별 합계
				for(var i = 1; i < 13; i++){
					$('#ALLSUM'+i).html(uxl.setComma(colSum[i-1]));
				}
				$('#ALLSUM0').html(uxl.setComma(allSum));
				
			}
			, async:true
	};
	uxl.callSubmitFunction('searchForm' , url , option );
}

//엑셀파일 추출하기 
function fnGetExcel() {
	
	var chnn_size = $('input[name=CD_BIZ_CHNN]:checked').length;
    
    if(chnn_size < 1){
    	alert('채널을 1개 이상 선택해 주십시오.');
    	return;
    }
	
	var data = {BIZ_CHNN_SIZE : chnn_size};
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID, 'EXPORT');
	var option = {
		data : data
		,success : function(result) {
			fnSearchExcel(result);
		},
		async : true
	};
	uxl.callSubmitFunction('searchForm', url, option);
}

function fnSearchExcel(result) {
	var filelink = result.getResultKey();
	if ($('#exportListViewer').size() == 0) {
		$('<div id="exportListViewer"></div>').appendTo('body');
	}
	$('#exportListViewer')
			.dialog(
					{
						width : 460,
						title : 'Download Result',
						open : function(event, ui) {
							var tag = '';
							if (filelink == null) {
								tag = tag
										+ '<span>다운로드할 데이터가 존재하지 않습니다.</span>';
							} else {
								tag = tag
										+ '<span>아래의 다운로드 link를 클릭하시면 파일을 다운로드 받을 수 있습니다.</span>';
								tag = tag + '<br/><br/><ul>';
								for (var i = 0; i < filelink.length; i++) {
// 									var url = uxl.getContextURL('/file/view.do');
// 									url = uxl.addQueryToUrl(url,'filePath', filelink[i]);
									var url = uxl.getContextURL('/file/bkrDown.' + uxl.CONSTANT.URL_EXTENTION + '?fileId=' + filelink);
									tag = tag + '<li ><a href="' + url + '" target="_self" style="color:#B54444" onclick=fnClose()> 다운로드 파일 '+ (i + 1) + ' </a></li>';
								}
								tag = tag + '</ul>';
							}
							$(this).html(tag);
						},
						close : function(event, ui) {
							$(this).remove();
						}
					})
			.style('css','border-bottom: 1px solid;');
}

function fnClose(){
	$('#exportListViewer').remove();
}

</script>