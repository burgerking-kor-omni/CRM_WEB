<%--
#*
 *  파 일 명 :  POP0003.jsp
 *  설    명 :  지번주소 목록(공통) 검색
 *  작 성 자 :  이동엽
 *  작 성 일 :  2013-05-09
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@page import="com.ubone.framework.util.ViewUtil"%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp" %>
<style type="text/css">
	.ub-layout.search .button.search {position:absolute;top:4px;right:30px;}
</style>
<script type="text/javascript">
uxl.onLoad(function(){
	//시도
	uxl.bindComboCode('CD_CITY', 'CD_CITY', {parameter : {}, emptyOption:'선택'});			
	//시군구
	uxl.chainCombo($('#CD_CITY'), $('#CD_GU') , 'CD_GU', {parameter : {}});
	
	var options = {
		//header name
		colNames:['우편번호','구주소/새주소(우편번호) 검색정보', '건물명','관련행정동'] 
		
		//mapping column
		,colModel:[
		          {name:'ID_ZIP' ,width:40, align:'center'},
		          {name:'NM_ADDR_FULL', width:200},
		          {name:'NM_BUILD', width:100},
		          {name:'NM_DONG', width:100}
		         ]
		,autowidth:true
		,height:360
		,onSelectRow: function(rowid){
					var selectedRow = $(this).getRowData(rowid);
					$('#TOTAL_ZIP').val(selectedRow.ID_ZIP);
					$('#TOTAL_ADDR').val(selectedRow.NM_ADDR_FULL);
		}

	};
	
	uxl.grid('list', options);
	$('#cb_list').hide();
	
	//조회 이벤트
	$('#search').click(function(event){
		//fnSearch($("input[name='TP_ADDRESS']:checked").val());
		
		$("#list").jqGrid('addRowData',1,{ID_ZIP:'05718'
			, NM_ADDR_FULL:'서울특별시 송파구 중대로 109 대동빌딩 7층'
			, NM_BUILD:'중대로'
			, NM_DONG:'가락동'});
	});
	
	//확인
	$('#confirm').click(function(event){
// 		var addressData = {
// 				id_zip_jibun			: $('#ID_ZIP_JIBUN').val()					//지번우편번호
// 			,	addr_jibun				: $('#ADDR_JIBUN').val()					//지번앞주소
// 			,   addr2_jibun				: $('#ADDR2_JIBUN').val()					//지번뒷주소
// 			,	id_zip_doro				: $('#ID_ZIP_DORO').val()					//지번우편번호
// 			,	addr_doro				: $('#ADDR_DORO').val()						//지번앞주소
// 			,   addr2_doro				: $('#ADDR2_DORO').val()					//지번뒷주소
// 		};
		var addressData = {
				id_zip_jibun			: '05718'
			,	addr_jibun				: '서울특별시 송파구 중대로 109 대동빌딩 7층'
			,   addr2_jibun				: $('#TOTAL_ADDR2').val()					//지번뒷주소
			,	id_zip_doro				: ''
			,	addr_doro				: ''
			,   addr2_doro				: ''
		};
		
		uxl.pushToParent(addressData);
		self.close();
	});
	
	//닫기
	$('#close').click(function(event){
		uxl.close();
	});
	
	//변환 이벤트
	$('#changeAddress').click(function(event){
		if(uxl.isEmpty($('#TOTAL_ZIP').val()) || uxl.isEmpty($('#TOTAL_ADDR').val()) || uxl.isEmpty($('#TOTAL_ADDR2').val())){
			uxl.showMessage("변환주소를 입력해주세요(나머지주소 포함)");
			return;
		}else{
			fnChange($("input[name='TP_ADDRESS']:checked").val());	
		}
	});
	
	//Enter Key 이벤트
	$('#NM_DONG').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch($("input[name='TP_ADDRESS']:checked").val());
			return false;
		}
	});
	
	//Enter Key 이벤트
	$('#NM_DORO').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch($("input[name='TP_ADDRESS']:checked").val());
			return false;
		}
	});
	
	//Enter Key 이벤트
	$('#CD_BUILD').keydown(function(event) {
		if(event.keyCode == '13') {
			fnSearch($("input[name='TP_ADDRESS']:checked").val());
			return false;
		}
	});
	
	//콜백하지않음 클릭 시
	$('input:radio[name=TP_ADDRESS]').bind('change', function(){
		if($(this).val() == 'R'){
			$('#NM_DONG').val('');
			$('#NM_DONG').attr('disabled', true);
			$('#NM_DONG').attr('class', 'ub-control input-text readonly');
			$('#CD_CITY').attr('disabled', false);
			$('#CD_CITY').attr('class', 'ub-control input-text');
			$('#CD_GU').attr('disabled', false);
			$('#CD_GU').attr('class', 'ub-control input-text');
			$('#NM_DORO').attr('disabled', false);
			$('#NM_DORO').attr('class', 'ub-control input-text');
			$('#CD_BUILD').attr('disabled', false);
			$('#CD_BUILD').attr('class', 'ub-control input-text');
		}else{
			$('#NM_DONG').attr('disabled', false);
			$('#NM_DONG').attr('class', 'ub-control input-text');
			$('#CD_CITY').attr('disabled', true);
			$('#CD_CITY').attr('class', 'ub-control input-text readonly');
			$('#CD_CITY').val('');
			$('#CD_GU').attr('disabled', true);
			$('#CD_GU').attr('class', 'ub-control input-text readonly');
			$('#CD_GU').val('');
			$('#NM_DORO').attr('disabled', true);
			$('#NM_DORO').attr('class', 'ub-control input-text readonly');
			$('#NM_DORO').val('');
			$('#CD_BUILD').attr('disabled', true);
			$('#CD_BUILD').attr('class', 'ub-control input-text readonly');
			$('#CD_BUILD').val('');
		}
	});	
	
});

//조회
function fnSearch(type){
	if(type == 'L'){
		if(uxl.isEmpty($('#NM_DONG').val())){
			uxl.showMessage("읍면동을 입력하세요.");
			return;
		}
	}else{
		if(uxl.isEmpty($('#CD_CITY').val()) || uxl.isEmpty($('#CD_GU').val()) 
				|| uxl.isEmpty($('#NM_DORO').val()) || uxl.isEmpty($('#CD_BUILD').val())){
			uxl.showMessage("시군구,도로명,건물번호를 입력하세요.");
			return;
		}
	}
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'INQUIRY');
	var option = {
			  data:{'TP_ADDRESS' : type}
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

//조회
function fnChange(type){
	
	//필수정보 체크
	var url = uxl.getFunctionUrl(_SCREEN_ID,'USERDEFINED1');
	var option = {
			  data:{'TP_ADDRESS' : type, 'TOTAL_ZIP':$('#TOTAL_ZIP').val(), 'TOTAL_ADDR':$('#TOTAL_ADDR').val(), 'TOTAL_ADDR2':$('#TOTAL_ADDR2').val()}
			/*
			 * 조회한 데이터를 그리드에 추가함.
			 * @param {String} 그리드로 변환할 테이블ID
			 * @param {Result} 조회된 데이터 객체 result
			 * @param {boolean} 데이터 추가시 기존데이터의 clear 여부
			 */
			, success:function(result){
				/*
					DS_REF_SUCCESS: "지번주소정상"
					FG_CHG_SUCCESS: "Y"
					FG_REF_SUCCESS: "Y"
					ID_ZIP_DORO: "08831"
					ID_ZIP_JIBUN: "08831"
					NM_NEXT_ADDR_DORO: "(봉천동)"
					NM_NEXT_ADDR_JIBUN: "1578-15번지"
					NM_PREV_ADDR_DORO: "서울 관악구 청룡11길 12-8"
					NM_PREV_ADDR_JIBUN: "서울 관악구 청룡동"
				*/
				if(result.getDataList(0).rowCount > 0) {
					//지번주소 셋팅
					$('#ID_ZIP_JIBUN').val(result.getDataList(0).rows[0].ID_ZIP_JIBUN);
					$('#ADDR_JIBUN').val(result.getDataList(0).rows[0].NM_PREV_ADDR_JIBUN);
					$('#ADDR2_JIBUN').val(result.getDataList(0).rows[0].NM_NEXT_ADDR_JIBUN);
					//도로명주소 셋팅
					$('#ID_ZIP_DORO').val(result.getDataList(0).rows[0].ID_ZIP_DORO);
					$('#ADDR_DORO').val(result.getDataList(0).rows[0].NM_PREV_ADDR_DORO);
					$('#ADDR2_DORO').val(result.getDataList(0).rows[0].NM_NEXT_ADDR_DORO);
				}
			}
			, async:true
	};
	uxl.callFunction(url , option );		
}

function AddrData(){
	
	parent.Addr('L', $('#TOTAL_ZIP').val(), $('#TOTAL_ADDR').val(), $('#TOTAL_ADDR2').val());
}
</script>
		 