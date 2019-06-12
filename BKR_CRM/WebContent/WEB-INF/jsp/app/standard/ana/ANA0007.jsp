<%--
#*
 *  파 일 명 :  ANA0007.jsp
 *  설    명 :  유형-기간별 VOC현황 목록
 *  작 성 자 :  강현준
 *  작 성 일 :  2018-12-20
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

<%
	DataList _dl_CASUE2 = ViewUtil.getResult().getDataList("Code.CD_VOC_CAUSE_2");
	int allcnt = _dl_CASUE2.getRowCount();

	int cnt01 = 0;
	int cnt02 = 0;
	int cnt03 = 0;
	int cnt04 = 0;
	int cnt05 = 0;
	
	for(int i = 0; i < allcnt; i++){
		if("01".equals(_dl_CASUE2.getString(i, "CODE").substring(0, 2))){
			cnt01++;
		}else if("02".equals(_dl_CASUE2.getString(i, "CODE").substring(0, 2))){
			cnt02++;
		}else if("03".equals(_dl_CASUE2.getString(i, "CODE").substring(0, 2))){
			cnt03++;
		}else if("04".equals(_dl_CASUE2.getString(i, "CODE").substring(0, 2))){
			cnt04++;
		}else{
			cnt05++;
		}
	}
%>

<!--  ========================================================================
  This page is generated with the UB-META™ ver4.0 
 
   - PAGE ID : ANA0007R00
   - PAGE TYPE : META
 
  Copyright ⓒ UBONE Co., Ltd. All rights reserved.
 ========================================================================
--> 
<table class="ub-control table stats">
	<colgroup>
		<col width="50px">
		<col width="130px">
		<col width="">
		<col width="">
		<col width="">
		<col width="">
	</colgroup>
	<thead>
		<tr>
			<th scope="col"><strong>구분</strong></th>
			<th scope="col"><strong>유형</strong></th>
			<th scope="col"><strong>전체</strong></th>
		</tr>
	</thead>
	<tbody id="tbody">
	<tr class="bg02">
		<th colspan="2">전체</th>
		<th id="ALLSUM0"></th>
<%
	for(int i=1; i<13; i++){
%>
		<td id="ALLSUM<%=i%>"></td>
<%
	}
%>
	</tr>
	<tr>
		<th rowspan="<%=cnt01+2%>" scope="rowgroup">문의</th>
	</tr>
	<%
		for(int i = 0; i < cnt01; i++){
	%>
	<tr id="<%=_dl_CASUE2.getString(i, "CODE")%>">
		<th><%=_dl_CASUE2.getString(i, "CODE_NAME")%></th>
		<th class="bg02" id="SUM<%=_dl_CASUE2.getString(i, "CODE")%>"></th>
	</tr>
	<%		
		}
	%>
	<tr id="TR01" class="bg02">
		<th>소계</th>
		<th class="bg02" id="SUM01"></th>
	</tr>
	<tr>
		<th rowspan="<%=cnt02+2%>" scope="rowgroup">불만</th>
	</tr>
	<%
		for(int i = cnt01; i < cnt01+cnt02; i++){
	%>
	<tr id="<%=_dl_CASUE2.getString(i, "CODE")%>">
		<th><%=_dl_CASUE2.getString(i, "CODE_NAME")%></th>
		<th class="bg02" id="SUM<%=_dl_CASUE2.getString(i, "CODE")%>"></th>
	</tr>
	<%		
		}
	%>
	<tr id="TR02" class="bg02">
		<th>소계</th>
		<th class="bg02" id="SUM02"></th>
	</tr>
	<tr>
		<th rowspan="<%=cnt03+2%>" scope="rowgroup">제안</th>
	</tr>
	<%
		for(int i = cnt01+cnt02; i < cnt01+cnt02+cnt03; i++){
	%>
	<tr id="<%=_dl_CASUE2.getString(i, "CODE")%>">
		<th><%=_dl_CASUE2.getString(i, "CODE_NAME")%></th>
			<th class="bg02" id="SUM<%=_dl_CASUE2.getString(i, "CODE")%>"></th>
	</tr>
	<%		
		}
	%>
	<tr id="TR03" class="bg02">
		<th>소계</th>
		<th class="bg02" id="SUM03"></th>
	</tr>
	<tr>
		<th rowspan="<%=cnt04+2%>" scope="rowgroup">칭찬</th>
	</tr>
	<%
		for(int i = cnt01+cnt02+cnt03; i < cnt01+cnt02+cnt03+cnt04; i++){
	%>
	<tr id="<%=_dl_CASUE2.getString(i, "CODE")%>">
		<th><%=_dl_CASUE2.getString(i, "CODE_NAME")%></th>
			<th class="bg02" id="SUM<%=_dl_CASUE2.getString(i, "CODE")%>"></th>
	</tr>
	<%		
		}
	%>
	<tr id="TR04" class="bg02">
		<th>소계</th>
		<th id="SUM04"></th>
	</tr>
	<tr>
		<th rowspan="<%=cnt05+2%>" scope="rowgroup">요청</th>
	</tr>
	<%
		for(int i = cnt01+cnt02+cnt03+cnt04; i < allcnt; i++){
	%>
	<tr id="<%=_dl_CASUE2.getString(i, "CODE")%>">
		<th><%=_dl_CASUE2.getString(i, "CODE_NAME")%></th>
			<th class="bg02" id="SUM<%=_dl_CASUE2.getString(i, "CODE")%>"></th>
	</tr>
	<%		
		}
	%>
	<tr id="TR05" class="bg02">
		<th>소계</th>
		<th id="SUM05"></th>
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
	
	var nowYmd = new Date();
// 	nowYmd.addMonths(-1);
	var MM = nowYmd.getMonth()+1;
	$('#DT_START_M').val(MM < 10 ? '0'+MM : MM);
	
	// 2019.06.07  엑셀 다운로드 
	$('#excelBtn').click(function(){
		fnGetExcel();
	});

	fnSearch();
	
});


function fnSearch(){
	
	var chnn_size = $('input[name=CD_BIZ_CHNN]:checked').length;
    
    if(chnn_size < 1){
    	alert('채널을 1개 이상 선택해 주십시오.');
    	return;
    }

	// 연도, 월 헤더 생성
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
	// 기존 헤더 삭제
	$('thead tr th[name="HEADER_Y"]').each(function(){
		$(this).remove();
	});
	for(var i = 0; i < 12; i++){
		// 날짜 헤더 추가
		$('thead tr').append('<th style="width:70px" name="HEADER_Y" scope="col"><strong>'+listDate[i]+'</strong></th>');
	}
	// 연도, 월 헤더 생성 end
	
<%
	// 기존에 있던 내용 td 삭제
	for(int i = 0; i < allcnt; i++){
%>
		$('#<%=_dl_CASUE2.getString(i, "CODE")%> td').remove();
<%
	}
%>
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:{BIZ_CHNN_SIZE : chnn_size}
			, success:function(result){
				var dl = result.getDataList(0);
				for(var i = 0; i < dl.rowCount; i++){
					$('#'+dl.rows[i].CODE).append(
							 '<td>'+uxl.setComma(dl.rows[i].DATA1)+'</td>'
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
							+'<td>'+uxl.setComma(dl.rows[i].DATA12)+'</td>'
					);
				}
				
<%
	for(int i=0; i < allcnt; i++){
%>
				var test = 0;
				$('#<%=_dl_CASUE2.getString(i, "CODE")%> td').each(function(){
					test += $(this).text().split(',').join('')*1;
				});
				$('#SUM<%=_dl_CASUE2.getString(i, "CODE")%>').html( uxl.setComma(test) );
<%
	}
%>
				var allsum = 0;
				for(var i = 1; i < 6;i++){
					var strId = 'SUM0'+i;
					var strSum = 0;
					$('th[id^="'+strId+'0"]').each(function(){
						strSum += $(this).text().split(',').join('')*1;
					});
					allsum += strSum;
					$('#'+strId).html( uxl.setComma(strSum) );
				}
				$('#ALLSUM0').html( uxl.setComma(allsum) );
				
				// 기존 합계 td 삭제
				$('td[id^="sumCol"]').each(function(){
					$(this).remove();
				})
				for(var j = 0; j<12; j++){
					$('tr[id*="TR"]').each(function(index){
						$(this).append('<td id="sumCol'+j+''+index+'">'+j+'/'+index+'</td>');
					});
				}
				
				// 합계 변수
				var colSum = 0;
				
				// 12개월 수 만큼 반복
				for(var eq = 0; eq < 12; eq++){
					// 합계 변수
					colSum = 0;
					allsum = 0;
					
					// cause 01* 개수
					var txtIndex;
					for(var i = 1; i < <%=cnt01+1%>;i++){
						if(i < 10){
							txtIndex = '0'+i;
						}else{
							txtIndex = i;
						}
						colSum += $('#010'+ txtIndex +' td:eq('+eq+')').text().split(',').join('')*1;
					}
					$('#sumCol'+eq+'0').html( uxl.setComma(colSum) );
					allsum += colSum*1;
					
					// cause 02* 개수
					colSum = 0;
					for(var i = 1; i < <%=cnt02+1%>;i++){
						if(i < 10){
							txtIndex = '0'+i;
						}else{
							txtIndex = i;
						}
						colSum += $('#020'+ txtIndex +' td:eq('+eq+')').text().split(',').join('')*1;
					}
					$('#sumCol'+eq+'1').html( uxl.setComma(colSum) );
					allsum += colSum*1;
					
					// cause 03* 개수
					colSum = 0;
					for(var i = 1; i < <%=cnt03+1%>;i++){
						if(i < 10){
							txtIndex = '0'+i;
						}else{
							txtIndex = i;
						}
						colSum += $('#030'+ txtIndex +' td:eq('+eq+')').text().split(',').join('')*1;
					}
					$('#sumCol'+eq+'2').html( uxl.setComma(colSum) );
					allsum += colSum*1;
					
					// cause 04* 개수
					colSum = 0;
					for(var i = 1; i < <%=cnt04+1%>;i++){
						if(i < 10){
							txtIndex = '0'+i;
						}else{
							txtIndex = i;
						}
						colSum += $('#040'+ txtIndex +' td:eq('+eq+')').text().split(',').join('')*1;
					}
					$('#sumCol'+eq+'3').html( uxl.setComma(colSum) );
					allsum += colSum*1;
					
					// cause 05* 개수
					colSum = 0;
					for(var i = 1; i < <%=cnt05+1%>;i++){
						if(i < 10){
							txtIndex = '0'+i;
						}else{
							txtIndex = i;
						}
						colSum += $('#050'+ txtIndex +' td:eq('+eq+')').text().split(',').join('')*1;
					}
					$('#sumCol'+eq+'4').html( uxl.setComma(colSum) );
					allsum += colSum*1;
					// 각 열 전체 합계
					$('#ALLSUM'+(eq+1)).html( uxl.setComma(allsum) );
				}
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