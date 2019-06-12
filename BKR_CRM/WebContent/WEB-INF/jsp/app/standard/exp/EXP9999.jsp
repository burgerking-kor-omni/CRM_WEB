<%--
#*
 *  파 일 명 :  EXP9999.jsp
 *  설    명 :  상세화면 페이지
 *  작 성 자 :  
 *  작 성 일 :  
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	h1 strong {padding-left:10px; font-size:13px; color:#666;}
	.exp {margin:5px 0 10px; padding:3px 10px 7px; line-height:1.6; border:1px dashed #cfcfcf;}
	
</style>
<div style="margin:;">

<div>
	<input type="radio" class="radio" /> 라디오버튼
	<input type="checkbox" class="input-checkbox" /> 체크박스
</div>

<div class="ub-layout button top">
	<span class="ub-control button top icon" id="register">
	    <a href="#none" title="Register"><span class="ico-register"></span>등록</a>
	</span>
	<span class="ub-control button top icon" id="list">
	    <a href="#none" title="list"><span class="ico-list"></span>목록</a>
	</span>
	<span class="ub-control button top icon" id="find">
	    <a href="#none" title="find"><span class="ico-find"></span>찾기</a>
	</span>
	<span class="ub-control button top icon" id="print">
	    <a href="#none" title="print"><span class="ico-print"></span>인쇄</a>
	</span>
	<span class="ub-control button top icon" id="">
	    <a href="#none" title=""><span class=""></span>기본</a>
	</span>
</div>

<!-- 버튼 테스트 -->
<div style="display:none">
	<h1 class="ub-control title">버튼 테스트</h1>
	<span class="ub-control button inner">
		<button type="submit"><span>서브밋 버튼</span></button>
	</span>
	<span class="ub-control button inner">
		<button type="submit"><label>서브밋 버튼</label></button>
	</span>
	
	<span class="ub-control button inner">
		<button type="button"><span class="ico-reg"></span>버튼</button>
	</span>
	
	<span class="ub-control button inner">
		<a href="#">span -a 테스트</a>
	</span>
</div>
<!-- //버튼 테스트 -->

<h1 class="ub-control title">일반 테이블/기본테이블 (일반 테이블 사용)</h1>
<table class="ub-control table normal ">
	<colgroup>
	<col width="12%">
	<col width="38%">
	<col width="12%">
	<col width="38%">
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label class="ub-control label">접수일시<span class="required">*</span></label></th>
			<td><input type="text" class="ub-control input-text calendar  readonly" id="DT_VOC_RECV" name="DT_VOC_RECV" value="2015-03-20 11:29" readonly="" style="text-align:left;width:100px;"></td>
			<th scope="row">
			<label class="ub-control label"><strong class="txt-color01">수집채널<br /></strong></label>
			</th>
			<td class="text-right">
				<a href="#none" class="link-color02">0</a>
			</td>
		</tr>
		<tr>
			<th scope="row" class="bg03"><label class="ub-control label">th class : bg03</label></th>
			<td><input class="ub-control input-checkbox readonly" type="checkbox" id="FG_REPLY_PHONE" name="FG_REPLY_PHONE" value="Y" disabled="disabled"><label>전화</label><input class="ub-control input-checkbox readonly" type="checkbox" id="FG_REPLY_SMS" name="FG_REPLY_SMS" value="Y" disabled="disabled"><label>SMS</label></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th scope="row"><label class="ub-control label">등록일시</label></th>
			<td><input type="text" class="ub-control input-text readonly" id="DT_VOC_REG" name="DT_VOC_REG" value="2015-03-20 11:29" readonly="" style="text-align:left;width:100px;"></td>
			<th scope="row"><label class="ub-control label">등록자</label></th>
			<td><input type="text" class="ub-control input-text readonly" value="본사" readonly="" style="text-align:left;width:100px;"><input type="text" class="ub-control input-text readonly" value="김희연" readonly="" style="text-align:left;width:100px;"></td>
		</tr>
		<tr>
			<th><label class="ub-control label" scope="row">등록일시</label></th>
			<th class="sub-th label-none" scope="row"><label class="ub-control label">th 클래스 : sub-th(왼쪽 보더 역할) label-none(블릿 삭제)</label></th>
			<td colspan="2"><input type="text" class="ub-control input-text readonly" value="본사" readonly="" style="text-align:left;width:100px;"><input type="text" class="ub-control input-text readonly" value="김희연" readonly="" style="text-align:left;width:100px;"></td>
		</tr>
		<tr>
			<th scope="row"><label class="ub-control label">등록일시</label></th>
			<th class="sub-th"><label class="ub-control label">th 클래스 : sub-th(왼쪽 보더 역할)</label></th>
			<td colspan="2"><input type="text" class="ub-control input-text readonly" value="본사" readonly="" style="text-align:left;width:100px;"><input type="text" class="ub-control input-text readonly" value="김희연" readonly="" style="text-align:left;width:100px;"></td>
		</tr>
		<tr>
			<th scope="row">
				<label class="ub-control label">등록일시</label><br />
				<span class="ub-control button inner icon" id="custClean">    <a href="#none" title="초기화"><span></span>초기화</a></span>
			</th>
			<td colspan="3"><input type="text" class="ub-control input-text readonly" value="본사" readonly="" style="text-align:left;width:100px;"><input type="text" class="ub-control input-text readonly" value="김희연" readonly="" style="text-align:left;width:100px;"></td>
		</tr>
	</tbody>
</table>
<div class="exp">
	분홍색 bg - th에  bg03 클래스<br />
	왼쪽에 보더 있으면 sub-th 클래스,
	th에 들어가는 블릿 삭제  label-none 클래스
</div>

<h1 class="ub-control title">일반 테이블 - 데이터형 (일반 테이블 사용 / data클래스 추가)</h1>
<table class="ub-control table normal data">
	<colgroup>
	<col width="120px">
	<col width="300px">
	<col width="120px">
	<col width="300px">
	<col width="120px">
	<col width="*">
	</colgroup>
	<tbody>
		<tr>
			<th scope="row">
				<label class="ub-control label">VOC번호</label>
			</th>
			<td>20161006-0017</td>
			<th scope="row">
				<label class="ub-control label">상태</label>
			</th>
			<td>결재중</td>
			<th scope="row">
				<label class="ub-control label">처리예정일</label>
			</th>
			<td>2016-10-26</td>
		</tr>
		<tr>
			<th scope="row">
				<label class="ub-control label">등록일</label>
			</th>
			<td>2016-10-26</td>
			<th scope="row">
				<label class="ub-control label">등록부서</label>
			</th>
			<td>소비자보호팀</td>
			<th scope="row">
				<label class="ub-control label">등록자</label>
			</th>
			<td>관리자</td>
		</tr>
	</tbody>
</table>


<h1 class="ub-control title">td안에 테이블 (변형테이블, 테이블 안 테이블 / td안에 기본 레이아웃 + in-td 클래스  삽입)</h1>

<table class="ub-control table normal tbl-fix">
	<colgroup>
		<col width="120px" />
		<col />
	</colgroup>
	<tbody>
		<tr>
			<th scope="row"><label class="ub-control label">접수일시</label></th>
			<td>
				<!-- 테이블 td > 컨텐트  -->
				<div class="ub-layout in-td">
					<h3 class="ub-control title">td안에 기본 레이아웃 , 클래스는  in-td 삽입</h3>
					<!-- 목록테이블 -->
					<table class="ub-control table list">
						<colgroup>
							<col style="width:10%;" />
							<col style="width:20%;" />
							<col style="width:12%;" />
							<col style="width:12%;" />
							<col style="width:%;" />
							<col />
						</colgroup>
						<thead>
							<tr>
								<th rowspan="2" scope="col"><label class="ub-control list-header"><nobr>NO</nobr></label></th>
								<th rowspan="2" scope="col"><label class="ub-control list-header"><nobr>부품코드</nobr></label></th>
								<th  scope="colgroup" colspan="2"><label class="ub-control list-header"><nobr>센터<br />재고</nobr></label></th>
								<th rowspan="2" scope="col"><label class="ub-control list-header"><nobr>부품명</label></nobr></th>
							</tr>
							<tr>
								<th class="bl" scope="col"><label class="ub-control list-header"><nobr>가용</nobr></label></th>
								<th scope="col"><label class="ub-control list-header"><nobr>수리중</nobr></label></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td><label class="ub-control list-content">4</label></td>
								<td><label class="ub-control list-content">ACR854D</label></td>
								<td><label class="ub-control list-content">0</label></td>
								<td><label class="ub-control list-content">0</label></td>
								<td class="text-left"><label class="ub-control list-content">Spring, Plate (BL)COP</label></td>
							</tr>
						</tbody>
					</table>
					<!-- //목록테이블 -->
					<!-- 그리드테이블 -->
					<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" id="gbox_list" dir="ltr" style="width: auto;">
						<div class="ui-widget-overlay jqgrid-overlay" id="lui_list"></div><div class="loading ui-state-default ui-state-active" id="load_list" style="display: none;">조회중...</div><div class="ui-jqgrid-view" role="grid" id="gview_list" style="width: auto;"><div class="ui-jqgrid-titlebar ui-jqgrid-caption ui-widget-header ui-corner-top ui-helper-clearfix" style="display: none;"><a role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton" title="" style="right: 0px;"><span class="ui-icon ui-icon-circle-triangle-n"></span></a><span class="ui-jqgrid-title"></span></div><div class="ui-state-default ui-jqgrid-hdiv ui-corner-top" style="width: auto;"><div class="ui-jqgrid-hbox"><table class="ui-jqgrid-htable" style="width:1200px" role="presentation" aria-labelledby="gbox_list" cellspacing="0" cellpadding="0" border="0"><thead><tr class="ui-jqgrid-labels ui-sortable" role="row"><th id="list_EMP_NO" role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 50px; display: none;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div id="jqgh_list_EMP_NO" class="ui-jqgrid-sortable">사번<span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div></th><th id="list_USER_ID" role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 50px; display: none;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div id="jqgh_list_USER_ID" class="ui-jqgrid-sortable">USER_ID<span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div></th><th id="list_LOGIN_ID" role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 166px;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div id="jqgh_list_LOGIN_ID" class="ui-jqgrid-sortable">ID<span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div></th><th id="list_USER_NM" role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 166px;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div id="jqgh_list_USER_NM" class="ui-jqgrid-sortable">이름<span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div></th><th id="list_DUTY_CD" role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 166px;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div id="jqgh_list_DUTY_CD" class="ui-jqgrid-sortable">직책<span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div></th><th id="list_DEPT_NM" role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 166px;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div id="jqgh_list_DEPT_NM" class="ui-jqgrid-sortable">부서<span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div></th><th id="list_MOBILE_NO" role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 166px;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div id="jqgh_list_MOBILE_NO" class="ui-jqgrid-sortable">핸드폰 번호<span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div></th><th id="list_EMAIL_DS" role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 166px;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div id="jqgh_list_EMAIL_DS" class="ui-jqgrid-sortable">이메일<span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div></th><th id="list_INCUMBENT_CD" role="columnheader" class="ui-state-default ui-th-column ui-th-ltr" style="width: 169px;"><span class="ui-jqgrid-resize ui-jqgrid-resize-ltr" style="cursor: col-resize;">&nbsp;</span><div id="jqgh_list_INCUMBENT_CD" class="ui-jqgrid-sortable">재직여부<span class="s-ico" style="display:none"><span sort="asc" class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span sort="desc" class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span></div></th></tr></thead></table></div></div><div class="ui-jqgrid-bdiv" style="height: 231px; width: auto;"><div style="position: relative; height: 140px;"><div style="height: 0px; display: none;"></div><table class="ub-control grid ui-jqgrid-btable" id="list" name="list" tabindex="0" cellspacing="0" cellpadding="0" border="0" role="presentation" aria-multiselectable="false" aria-labelledby="gbox_list" style="width: 1200px;"><tbody><tr class="jqgfirstrow" role="row" style="height:auto"><td role="gridcell" style="height:0px;width:50px;display:none;"></td><td role="gridcell" style="height:0px;width:50px;display:none;"></td><td role="gridcell" style="height:0px;width:166px;"></td><td role="gridcell" style="height:0px;width:166px;"></td><td role="gridcell" style="height:0px;width:166px;"></td><td role="gridcell" style="height:0px;width:166px;"></td><td role="gridcell" style="height:0px;width:166px;"></td><td role="gridcell" style="height:0px;width:166px;"></td><td role="gridcell" style="height:0px;width:169px;"></td></tr><tr role="row" id="0" tabindex="-1" class="ui-widget-content jqgrow ui-row-ltr"><td role="gridcell" style="text-align:center;display:none;" title="admin" aria-describedby="list_EMP_NO">admin</td><td role="gridcell" style="text-align:center;display:none;" title="admin" aria-describedby="list_USER_ID">admin</td><td role="gridcell" style="text-align:center;" title="admin" aria-describedby="list_LOGIN_ID">admin</td><td role="gridcell" style="text-align:center;" title="관리자" aria-describedby="list_USER_NM">관리자</td><td role="gridcell" style="text-align:center;" title="회장" aria-describedby="list_DUTY_CD">회장</td><td role="gridcell" style="text-align:center;" title="본사아래" aria-describedby="list_DEPT_NM">본사아래</td><td role="gridcell" style="text-align:center;" title="123" aria-describedby="list_MOBILE_NO">123</td><td role="gridcell" style="text-align:center;" title="123" aria-describedby="list_EMAIL_DS">123</td><td role="gridcell" style="text-align:center;" title="재직" aria-describedby="list_INCUMBENT_CD">재직</td></tr><tr role="row" id="1" tabindex="-1" class="ui-widget-content jqgrow ui-row-ltr even"><td role="gridcell" style="text-align:center;display:none;" title="01010101" aria-describedby="list_EMP_NO">01010101</td><td role="gridcell" style="text-align:center;display:none;" title="000000012" aria-describedby="list_USER_ID">000000012</td><td role="gridcell" style="text-align:center;" title="01010101" aria-describedby="list_LOGIN_ID">01010101</td><td role="gridcell" style="text-align:center;" title="테스터" aria-describedby="list_USER_NM">테스터</td><td role="gridcell" style="text-align:center;" title="총괄" aria-describedby="list_DUTY_CD">총괄</td><td role="gridcell" style="text-align:center;" title="본사2아래" aria-describedby="list_DEPT_NM">본사2아래</td><td role="gridcell" style="text-align:center;" title="01" aria-describedby="list_MOBILE_NO">01</td><td role="gridcell" style="text-align:center;" title="01" aria-describedby="list_EMAIL_DS">01</td><td role="gridcell" style="text-align:center;" title="재직" aria-describedby="list_INCUMBENT_CD">재직</td></tr><tr role="row" id="2" tabindex="-1" class="ui-widget-content jqgrow ui-row-ltr"><td role="gridcell" style="text-align:center;display:none;" title="02020202" aria-describedby="list_EMP_NO">02020202</td><td role="gridcell" style="text-align:center;display:none;" title="000000013" aria-describedby="list_USER_ID">000000013</td><td role="gridcell" style="text-align:center;" title="02020202" aria-describedby="list_LOGIN_ID">02020202</td><td role="gridcell" style="text-align:center;" title="테스터2" aria-describedby="list_USER_NM">테스터2</td><td role="gridcell" style="text-align:center;" title="자문" aria-describedby="list_DUTY_CD">자문</td><td role="gridcell" style="text-align:center;" title="본사2아래아래" aria-describedby="list_DEPT_NM">본사2아래아래</td><td role="gridcell" style="text-align:center;" title="12" aria-describedby="list_MOBILE_NO">12</td><td role="gridcell" style="text-align:center;" title="12" aria-describedby="list_EMAIL_DS">12</td><td role="gridcell" style="text-align:center;" title="재직" aria-describedby="list_INCUMBENT_CD">재직</td></tr><tr role="row" id="3" tabindex="-1" class="ui-widget-content jqgrow ui-row-ltr even"><td role="gridcell" style="text-align:center;display:none;" title="testadmin" aria-describedby="list_EMP_NO">testadmin</td><td role="gridcell" style="text-align:center;display:none;" title="000000014" aria-describedby="list_USER_ID">000000014</td><td role="gridcell" style="text-align:center;" title="testadmin" aria-describedby="list_LOGIN_ID">testadmin</td><td role="gridcell" style="text-align:center;" title="테스트관리자" aria-describedby="list_USER_NM">테스트관리자</td><td role="gridcell" style="text-align:center;" title="부본부장" aria-describedby="list_DUTY_CD">부본부장</td><td role="gridcell" style="text-align:center;" title="본사2아래아래" aria-describedby="list_DEPT_NM">본사2아래아래</td><td role="gridcell" style="text-align:center;" title="010" aria-describedby="list_MOBILE_NO">010</td><td role="gridcell" style="text-align:center;" title="010" aria-describedby="list_EMAIL_DS">010</td><td role="gridcell" style="text-align:center;" title="재직" aria-describedby="list_INCUMBENT_CD">재직</td></tr><tr role="row" id="4" tabindex="-1" class="ui-widget-content jqgrow ui-row-ltr"><td role="gridcell" style="text-align:center;display:none;" title="01026813956" aria-describedby="list_EMP_NO">01026813956</td><td role="gridcell" style="text-align:center;display:none;" title="000000011" aria-describedby="list_USER_ID">000000011</td><td role="gridcell" style="text-align:center;" title="01026813956" aria-describedby="list_LOGIN_ID">01026813956</td><td role="gridcell" style="text-align:center;" title="유기태" aria-describedby="list_USER_NM">유기태</td><td role="gridcell" style="text-align:center;" title="부회장" aria-describedby="list_DUTY_CD">부회장</td><td role="gridcell" style="text-align:center;" title="본사아래" aria-describedby="list_DEPT_NM">본사아래</td><td role="gridcell" style="text-align:center;" title="01026813956" aria-describedby="list_MOBILE_NO">01026813956</td><td role="gridcell" style="text-align:center;" title="rkt3956@ubqone.com" aria-describedby="list_EMAIL_DS">rkt3956@ubqone.com</td><td role="gridcell" style="text-align:center;" title="재직" aria-describedby="list_INCUMBENT_CD">재직</td></tr></tbody></table></div></div></div><div class="ui-jqgrid-resize-mark" id="rs_mlist">&nbsp;</div>
					</div>
					<!-- //그리드테이블 -->		
				</div>
				<!-- //테이블 td > 컨텐트  -->
			</td>
		</tr>
		<tr>
			<th scope="row"><label class="ub-control label">접수일시</label></th>
			<td>
				<!-- 테이블 td > 컨텐트  -->
				<div class="ub-layout in-td">
					<table class="ub-control table normal ">
						<colgroup>
							<col width="120px;" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row"><label class="ub-control label">접수일시</label></th>
								<td><label class="ub-control label">내용</label></td>
							</tr>
						</tbody>
					</table>					
				</div>
				<!-- //테이블 td > 컨텐트  -->
			</td>
		</tr>
	</tbody>
</table>
<div class="ub-layout button bottom">
	<div class="ub-layout floatBox">
		<div class="ub-layout leftBox">
			<span class="ub-control button bottom left icon" title="왼쪽 버튼">
			    <a href="#none" title="btn"><span></span>왼쪽 버튼</a>
			</span>
		</div>
		<div class="ub-layout rightBox">
			<span class="ub-control button bottom icon" id="btnUpdate" title="수정">
			    <a href="#none" title="Save"><span class="ico-save"></span>수정</a>
			</span>
			<span class="ub-control button bottom icon" id="btnDelete" title="삭제">
			    <a href="#none" title="Delete"><span class="ico-delete"></span>삭제</a>
			</span>
		</div>
	</div>
</div>

<h1 class="ub-control title">변형테이블_멀티 (일반 테이블 기반 / multi클래스 추가 / th가 상단과 왼쪽에 함께 들어가는 경우 사용 / <strong class="txt-color01">추후 업데이트 예정</strong>)</h1>
<table class="ub-control table normal multi">
	<colgroup>
		<col width="10%" />
		<col width="%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
	</colgroup>
	<thead>
		<tr>
			<th colspan="4" scope="colgroup" class="text-center"><label class="ub-control list-header"><nobr>심사Ⅰ</nobr></label></th>
			<th scope="row" class="label-none"><label class="ub-control list-header"><nobr>처리결과Ⅰ</nobr></label></th>
			<td></td>
			<th scope="row" class="label-none"><label class="ub-control list-header"><nobr>심사Ⅰ</nobr></label></th>
			<td></td>
		</tr>
	</thead>
	<tbody>
		<tr>
			<th scope="col" class="label-none"><label class="ub-control label">구분 label-none</label></th>
			<th scope="col" class="text-center label-none"><label class="ub-control label">처리일자 label-none</label></th>
			<th scope="col" class="text-center label-none"><label class="ub-control label">처리기관 label-none</label></th>
			<th scope="col" class="text-center label-none"><label class="ub-control label">사원명 label-none</label></th>
			<td colspan="4" rowspan="4">
				<textarea class="ub-control textarea" style="width:95%; height:90px;"></textarea>
			</td>
		</tr>
		<tr>
			<th scope="row"><label class="ub-control label">수신</label></th>
			<td class="text-left"><label class="ub-control list-content">기본 왼쪽 정렬, text-left도 왼쪽 정렬</label></td>
			<td class="text-center"><label class="ub-control list-content">가운데 정렬</label></td>
			<td class="text-right"><label class="ub-control list-content">오른쪽 정렬</label></td>
		</tr>
		<tr>
			<th scope="row" class="label-none"><label class="ub-control list-header"><nobr>심사</nobr></label></th>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<th scope="row" class="text-center label-none"><label class="ub-control list-header"><nobr>결재</nobr></label></th>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</tbody>
</table>		
</div>


<div style="margin:0 20px; display:none;">
	<h1 class="ub-control title">일반 목록 테이블</h1>
	<table class="ub-control table list">
	
	<colgroup>
	<col width="12%">
	<col>
	<col>
	<col>
	</colgroup>
	<thead>
	<tr>
		<th rowspan="2" scope="col"><label class="ub-control label">즉시처리여부</label></th>
		<th scope="col"></th>
		<th colspan="2" scope="col"><label class="ub-control label">즉시<br>처리여부</label></th>
	</tr>
	<tr>
		<th scope="col"><label class="ub-control label">즉시처리여부</label></th>
		<thscope="col"></th>
		<th scope="col"></th>
	</tr>
	</thead>
	<tbody>
		<tr>
			<td rowspan="2">즉시처리여부</td>
			<td>즉시처리여부</td>
			<td>즉시처리여부</td>
			<td>즉시처리여부</td>
		</tr>
		<tr>
			<td>즉시처리여부</td>
			<td>즉시처리여부</td>
			<td>즉시처리여부</td>
		</tr>
	</tbody>
	</table>
</div>

<h1 class="ub-control title">서브탭(아이콘 추가)</h1>
<div class="ub-control tab ui-tabs ui-widget ui-widget-content ui-corner-all" name="tabs" id="tabs">
	<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all" role="tablist">
		<li class="ui-state-default ui-corner-top ui-tabs-active ui-state-active" aria-controls="tab_item_COM0000" role="tab" tabindex="0" aria-labelledby="ui-id-1" aria-selected="true">
			<a href="#tab_item_COM0000" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-1">
				<label>처리이력</label><span class="ico-new"></span>
			</a>
		</li>
		<li class="ui-state-default ui-corner-top" aria-controls="tab_item_COM0002" role="tab" tabindex="-1" aria-labelledby="ui-id-2" aria-selected="false">
			<a href="#tab_item_COM0002" class="ui-tabs-anchor" role="presentation" tabindex="-1" id="ui-id-2"><label>통보이력</label></a>
		</li>
	</ul>
</div>

<br /><br />

<h1 class="ub-control title">타이틀 케이스</h1>
<h2 class="ub-control title">h2 타이틀 기본형</h2>
<h2 class="ub-control title">타이틀
	<span class="ub-control button inner icon" id="btnAddParameter">
   		<a href="#none" title="추가"><span></span>추가</a>
	</span>
	<div class="ub-layout button inner" style="text-align:right;">
		<span class="ub-control button inner" id="btnAddParameter">
	   		<a href="#none" title="추가"><span></span>추가</a>
		</span>
	</div>
</h2>
<h2 class="ub-control title hfold">타이틀 + 버튼 조합일때 gap01 클래스 추가(타이틀 , 버튼 사이에 약간의 간격 필요)</h2>
<div class="ub-layout button inner gap01" style="text-align:right;">
	<span class="ub-control button inner icon">
	    <a href="#none" title="버튼"><span></span>버튼</a>
	</span>
</div> 



<h2 class="ub-control title">타이틀
	<label class="ub-control label">
		<span class="caution-txt">고객등급</span>
	</label>
	<div class="ub-layout button inner" style="text-align:right;">
		<label class="ub-control label"><strong class="label-txt">담당자</strong></label>
		<select class="ub-control select" style="width:100px;">
			<option></option>
		</select>
	</div>
</h2>

<h2 class="ub-control title hfold">타이틀
	<div class="ub-layout button inner" style="text-align:right;">
		<label class="ub-control label"><strong class="label-txt"><strong class="line">단체계약은 콜센터상담이력 제외</strong>, <strong class="txt-color02">관련화면(BAK0909)</strong>으로 조회가능</strong></label>		
		<span class="ub-control button inner icon" id="btnAddParameter">
    		<a href="#none" title="추가"><span></span>추가</a>
		</span>
	</div>
	<span class="ico-fold on"></span>
</h2>

<h2 class="ub-control title hfold">
	<div class="ub-layout button inner" style="text-align:right;">
		<span class="ub-control button inner">
		    <a href="#none" title="고객정보수정">고객정보수정</a>
		</span>
	</div>
	<span class="ico-fold on"></span>타이틀
</h2>

<h3 class="ub-control title">
	<div class="ub-layout button inner" style="text-align:right;">
		<span class="ub-control button inner">
		    <a href="#none" title="고객정보수정">고객정보수정</a>
		</span>
	</div>
	타이틀
</h3>

<h1 class="ub-control title">통계  테이블<strong>colgroup > col 단위는 px 사용한다.</strong></h1>
<div class="ub-layout floatBox sub-desc">
	<div class="leftBox">
		<label class="ub-control label">
			<strong class="label-txt">접수건수 : 총 <strong class="txt-color02">267</strong> 건</strong>
		</label>
		<label class="ub-control label">
			<strong class="label-txt">미처리건 : 총 <strong class="txt-color02">0</strong> 건</strong>
		</label>
	</div>
	<div class="rightBox text-right" style="width:50%;">
		<label class="ub-control label">
			<strong class="label-txt">제재확정결좌 : 최근순 설계사평가확정결과조회 (상세조회는 제재확정결과 클릭)</strong>
		</label>
		<label class="ub-control label">
			<strong class="label-txt">제재확정결좌</strong>
		</label>
	</div>
</div>

<div class="ub-layout button inner">
	<div class="floatBox">
		<div class="leftBox">	
			<span class="ub-control button inner">
			    <a href="#none" title="고객정보수정"><span></span>고객정보수정</a>
			</span>
		</div>
		<div class="rightBox text-right" style="width:50%;">
				<span class="ub-control button inner icon excel">
				    <a title="엑셀" href="#none"><span class="ico-excel"></span>엑셀</a>
				</span>
				<span class="ub-control button inner">
				    <a href="#none" title="고객정보수정"><span></span>고객정보수정</a>
				</span>
		</div>
	</div>
</div>

<div class="stats_wrap">
    <table class="ub-control table stats">
        <colgroup>
            <col width="">
            <col width="">
            <col width="">
            <col width="">
            <col width="">
            <col width="">
        </colgroup>
        <thead>
            <tr>
                <th scope="col"><strong>상담유형1</strong></th>
                <th scope="col"><strong>상담유형2</strong></th>
                <th scope="col"><strong>상담유형3</strong></th>
                <th scope="col"><strong>합계</strong></th>
                <th scope="col"><strong>불만</strong></th>
                <th scope="col"><strong>칭찬</strong></th>
            </tr>
        </thead>
        <tbody>
            <tr class="bg01">
                <th colspan="3"  scope="row"><strong>합계 bg01</strong></th>
                <td>85%</td>
                <td>1,209</td>
                <td>1,209</td>
            </tr>
            <tr>
                <th rowspan="3"   scope="rowgroup">품질</th>
                <th class="bg02" colspan="2"   scope="row"><strong>소계 (클래스 - bg02)</strong></th>
                <td class="bg01">62% (클래스 - bg01)</td>
                <td class="bg02">206 (클래스 - bg02)</td>
                <td class="bg02">206 (클래스 - bg01)</td>
            </tr>
            <tr>
                <th rowspan="2"  scope="rowgroup">외관</th>
                <th class="bg02"  scope="row"><strong>소계 bg02</strong></th>
                <td class="bg01">54%</td>
                <td class="bg02">102</td>
                <td class="bg02">206</td>
            </tr>
            <tr>
                <th  scope="row">녹발생</th>
                <td class="bg01">100%</td>
                <td>64</td>
                <td>206</td>
            </tr>
        </tbody>
    </table>
</div>

<div class="stats_wrap"> 
	<table class="ub-control table stats">
		<colgroup>
			<col width="200px">
			<col width="300px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
			<col width="120px">
		</colgroup>
		<thead>
			<tr>
				<th rowspan="2"  scope="col"><strong>유형</strong></th>
				<th rowspan="2"  scope="col"><strong>직전<br />8분기<br />평균</strong></th>
				<th rowspan="2"  scope="col"><strong>직전<br />4분기<br />평균</strong></th>
				<th rowspan="2"  scope="col"><strong>직전<br />2분기<br />평균</strong></th>
				<th rowspan="2"  scope="col"><strong>직전<br />평균</strong></th>
				<th rowspan="2"  scope="col"><strong>당분기</strong></th>
				<th colspan="3"  scope="colgroup"><strong>2013년</strong></th>
				<th colspan="4"  scope="colgroup"><strong>2014년</strong></th>
				<th  scope="col"><strong>2015년</strong></th>
				<th rowspan="2"  scope="col"><strong>합계</strong></th>
				<th rowspan="2"  scope="col"><strong>비중</strong></th>
			</tr>
			<tr>
				<th class="bl"  scope="col"><strong>2분기</strong></th>
				<th  scope="col"><strong>분기</strong></th>
				<th  scope="col"><strong>4분기</strong></th>
				<th  scope="col"><strong>1분기</strong></th>
				<th  scope="col"><strong>2분기</strong></th>
				<th  scope="col"><strong>3분기</strong></th>
				<th  scope="col"><strong>4분기</strong></th>
				<th  scope="col"><strong>1분기</strong></th>				
			</tr>
		</thead>
		<tfoot>
			<tr>
				<th class="bg01"   scope="row"><strong>합계</strong></th>
				<td class="bg01">1,800</td>
				<td class="bg01">1,800</td>
				<td class="bg01">1,800</td>
				<td class="bg01">1,800</td>
				<td class="bg01">1,800</td>
				<td class="bg01">1,800</td>
				<td class="bg01">1,800</td>
				<td class="bg01">1,800</td>
				<td class="bg01">1,800</td>
				<td class="bg01">1,800</td>
				<td class="bg01">1,800</td>
				<td class="bg01">1,800</td>
				<td class="bg01">1,800</td>
				<td class="bg01">3,600</td>
				<td class="bg01">100.0%</td>
			</tr>
		</tfoot>
		<tbody>
			<tr>
				<th  scope="row"><strong><a href="#">보험가입</a></strong></th>
				<td><a href="#">300</a> / a태그 클래스없음</td>
				<td>4.110,300</td>
				<td>300</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>50</td>
				<td>100</td>
				<td><a href="#" class="link-color01">100</a></td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td class="bg02">600</td>
				<td class="bg01">16.7%</td>
			</tr>
			<tr>
				<th class="bg04"  scope="row"><strong>계약유지 - 클래스 bg04</strong></th>
				<td><a href="#" class="link-color01">300</a> / a태그 클래스 :  link-color01</td>
				<td>300</td>
				<td>300</td>
				<td><a href="#" class="link-color02">100</a></td>
				<td>100</td>
				<td>100</td>
				<td></td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td class="bg02">600</td>
				<td class="bg01">16.7%</td>
			</tr>
			<tr>
				<th class="bg05"  scope="row"><strong>재지급 - 클래스 bg05</strong></th>
				<td><a href="#" class="link-color02">300</a> / a태그 클래스 :  link-color02</td>
				<td>300</td>
				<td>300</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>50</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td class="bg02">600</td>
				<td class="bg01">16.7%</td>
			</tr>
			<tr>
				<th class="bg06"  scope="row"><strong>보험금 - 클래스 bg06</strong></th>
				<td>300</td>
				<td>300</td>
				<td>300</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>50</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td class="bg02">600</td>
				<td class="bg01">16.7%</td>
			</tr>
			<tr>
				<th class="bg7"  scope="row"><strong>서비스 및 기타</strong></th>
				<td>300</td>
				<td>300</td>
				<td>300</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>50</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td class="bg02">600</td>
				<td class="bg01">16.7%</td>
			</tr>
			<tr>
				<th  scope="row"><strong>금융사고</strong></th>
				<td>300</td>
				<td>300</td>
				<td>300</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>50</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td class="bg02">600</td>
				<td class="bg01">16.7%</td>
			</tr>
			<tr>
				<th  scope="row"><strong>칭찬건의</strong></th>
				<td>300</td>
				<td>300</td>
				<td>300</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>50</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td class="bg02">600</td>
				<td class="bg01">16.7%</td>
			</tr>
			<tr>
				<th  scope="row"><strong>칭찬건의</strong></th>
				<td>300</td>
				<td>300</td>
				<td>300</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>50</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td>100</td>
				<td class="bg02">600</td>
				<td class="bg01">16.7%</td>
			</tr>
		</tbody>
	</table>
</div>

<!-- 페이징 -->	
<div class="ub-layout pagging">
	<div class="ub-control pagging" for="list" formid="searchForm" function="fnSearch">
		<span class="total-count">전체:843</span>
		<a title="first" href="#none" class="ub-control button imgBtn img-pagging-first" param=""></a><a title="prev" href="#none" class="ub-control button imgBtn img-pagging-prev" param="10"></a><em param="11" class="num">11</em> <a param="12" class="num">12</a> <a param="13" class="num">13</a> <a param="14" class="num">14</a> <a param="15" class="num">15</a> <a param="16" class="num">16</a> <a param="17" class="num">17</a> <a param="18" class="num">18</a> <a param="19" class="num">19</a> <a param="20" class="num">20</a> <a title="next" href="#none" class="ub-control button imgBtn img-pagging-next" param="21"></a><a title="last" href="#none" class="ub-control button imgBtn img-pagging-last" param="85"></a>
		<div class="select-pagging"><label for="listPaging">Rows/Page&nbsp;</label><select id="listPaging" class="page-rows" title="Rows/Page"><option value="10">10</option><option value="20">20</option><option value="50">50</option></select></div>
	</div>
</div>

<div class="floatBox caution">
	<div class="leftBox" style="width:50%;">
		<div class="caution-txt">
			<ul>
				<li><strong class="txt-color02">1. ERMS 10회이상 접수자 => 접수이력의 해당 횟수 숫자만 붉은색 굵은체</strong></li>
				<li><strong class="txt-color02">2. 민원 3회이상 접수자 => 접수이력의 해당 횟수 숫자만 붉은색 굵은체</strong></li>
				<li><strong class="txt-color02">3. 유형 [불만] => 붉은색 굵은체 (해당 유형값만 해당)</strong></li>
				<li><strong class="txt-color02">4. 유의고객등록자 => 행전체가 붉은 글씨</strong></li>
			</ul>
		</div>
	</div>
	<div class="rightBox" style="width:50%;">
		<div class="caution-txt">
			<ul>
				<li><strong class="txt-color02">[소요시간] </strong>: 접수일시에서 답변일시를 계산하여 시간으로 표현 (실제일수기준)</li>
				<li><strong class="txt-color02">[처리기일] </strong>: 소요시간을 계산하여 일수로 환산하여 소수점 첫째자리까지 표현 (실제일수기준)</li>
			</ul>
		</div>
	</div>
</div>

<div class="ub-layout floatBox">
	<div class="rightBox">
		<label class="ub-control label">
			<span class="caution-txt">고객등급</span>
		</label>
	</div>
</div>
<h1 class="ub-control title">상세화면 상태바(<strong class="txt-color01">추후 업데이트 예정</strong>)</h1>
<!-- 상세화면 상태바 -->
<div class="ub-layout state-bar">
	<!-- <ul>
		<li>
			<strong class="tit-state">VOC 번호 : </strong>
			<strong class="cont-state">A160101584</strong>
		</li>
		<li>
			<strong class="tit-state">처리상태 :</strong>
			<strong class="cont-state">접수중</strong>		
		</li>
	</ul> -->
	<table class="ub-control table normal ">
		<colgroup>
			<col width="" />
			<col width="" />
			<col width="" />
			<col width="" />
		</colgroup>
		<tbody>
			<tr>
				<th scope="row">
					<label class="ub-control label">VOC 번호 : </label>
				</th>
				<td>
					<label class="ub-control label">A160101584</label>
				</td>
				<th scope="row">
					<label class="ub-control label">처리상태 : </label>
				</th>
				<td>
					<label class="ub-control label">접수중</label>
				</td>
			</tr>
		</tbody>
	</table>
</div>
<!-- //상세화면 상태바 -->

<!-- <h1 class="ub-control title">도움말 아이콘 추가</h1> -->
<!-- <div name="vocInfo" id="vocInfo" class="ub-layout details" style="display: block;"><table class="ub-control table normal "> -->
<!-- <colgroup> -->
<!-- <col width="20%"> -->
<!-- <col> -->
<!-- </colgroup> -->
<!-- <tbody> -->
<!-- <tr id="layout-1_1"> -->
<!-- <th id="layout-1_1_1"> -->
<!-- 	<label class="ub-control label">선행업무 표시여부</label> -->
<!-- 	<div class="layer-wrap01" id="layer-1"> -->
<!-- 		<span class="ico-advice"></span> -->
<!-- 		<div class="ub-layout layer01" style="width:255px; top:-23px; left:30px;"> -->
<!-- 			<p> -->
<!-- 				본 후처리가 진행되기 전에 반드시 순서에 따라<br />사전 처리완료 되어야 하는 후처리가 있는 경우 <br />선행업무를 선택합니다. -->
<!-- 			</p> -->
<!-- 			<span class="tail"></span> -->
<!-- 		</div> -->
<!-- 	</div> -->
<!-- </th> -->
<!-- <td id="layout-1_1_2"> -->
<!-- 	<input type="text" disabled="" style="text-align:left;width:100px;" value="2015-03-17" name="DT_VOC_RECV" id="DT_VOC_RECV" class="ub-control input-text  readonly"> -->
<!-- 	<input type="text" class="ub-control input-text readonly input-data" value="내용" /> -->
<!-- </td> -->
<!-- </tr> -->
<!-- </tbody> -->
<!-- </table> -->
 
<!-- </div> -->

<!-- 파일첨부 -->
<h1 class="ub-control title">파일첨부</h1>
<div class="ub-layout file-up">
    <input type="text" class="ub-control input-text" id="fileName" style="width:200px;" />	
	<span id="fileUp" class="ub-control button inner icon">
		<a title="파일업로드" href="#none"><span></span>파일업로드</a>
		<input type="file" class="ub-control file" onchange="document.getElementById('fileName').value=this.value" />
	</span>
</div>
<!-- 파일첨부 -->

<!-- 엑셀다운 -->
<h1 class="ub-control title">엑셀 버튼</h1>
<div class="ub-layout button inner">
	<span id="excelBtn" class="ub-control button inner icon excel">
	    <a title="엑셀" href="#none"><span class="ico-excel"></span>엑셀</a>
	</span>
</div>
<div class="exp">span > a > span에 ico-excel 클래스</div>
<select multiple class="ub-control select select-multi" style="width: 250px; height:200px;"  size="1" >
	<option value="ST">Static</option>
	<option value="DN">Dynamic</option>
	<option value="EN">Enum</option>
</select>
<!-- //엑셀다운 -->

<br /><br />

<ul>
	<li class="txt-color01">포인트컬러 클래스명 : <strong>txt-color01</strong></li>
	<li class="txt-color02">포인트컬러 클래스명 :<strong> txt-color02</strong></li>
	<li><a href="#" class="link-color01">링크 컬러 클래스명 : <strong>link-color01</strong></a></li>
	<li><a href="#" class="link-color02">링크 컬러 클래스명 : <strong>link-color02</strong></a></li>
</ul>

<br /><br />

<table class="ub-control table list" style="width:750px">
	<colgroup>
		<col width="250px">
		<col width="250px">
		<col width="250px">
	</colgroup>
	<tbody>
		<tr>
			<td class="text-left">텍스트 왼쪽 정렬 : <strong style="vertical-align:baseline;">text-left</strong></td>
			<td class="text-center">텍스트 가운데 정렬 : <strong style="vertical-align:baseline;">text-center</strong></td>
			<td class="text-right">텍스트 오른쪽 정렬 : <strong style="vertical-align:baseline;">text-right</strong></td>
		</tr>
	</tbody>
</table>


<!-- <div class="ub-layout floatBox"> -->
<!--   	<div class="ub-layout leftBox"> -->
<!--   		<h2 class="ub-control title">코드 상세 정보</h2> -->
<!--   	</div> -->
<!-- 	<div class="ub-layout rightBox"> -->
<!--     	<div class="ub-layout button inner" style="text-align:right;"> -->
<!--     		<span class="ub-control button inner icon" id="insertBtn"> -->
<!--    				 <a href="#none" title="Add"> -->
<!--    			 		<span class="ico-add"></span>코드추가 -->
<!--    			 	</a> -->
<!--    			 </span> -->
<!-- 		</div> -->
<!--   </div> -->
<!-- </div> -->

<!-- <h2 class="ub-control title"> -->
<!-- 	일반 목록 테이블 -->
<!-- 	<div style="text-align:right;" class="ub-layout button inner"> -->
<!-- 		<span id="insertBtn" class="ub-control button inner icon"> -->
<!-- 	    	<a title="Add" href="#none"><span class="ico-add"></span>코드추가</a> -->
<!-- 		</span> -->
<!-- 	</div> -->
<!-- </h2> -->
</div>