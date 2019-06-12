<%--
#*
 *  파 일 명 :  EXP9998.jsp
 *  설    명 :  목록화면 페이지
 *  작 성 자 : 
 *  작 성 일 : 
 *  버    전 :  1.0
 *  기타사항 :
 *  Copyrights 2011 by ㈜ 유비원. All right reserved.
*# 
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/include/pageCommon.jsp"%>
<style>
.exp {
	margin: 5px 0 10px;
	padding: 3px 10px 7px;
	line-height: 1.6;
	border: 1px dashed #cfcfcf;
}
</style>

<!-- 타이틀 h1 -->
<h1 class="ub-control title">전체화면 타이틀 (대 타이틀)</h1>
<!--// 타이틀 h1 -->
<!-- 타이틀 h2 -->
<h2 class="ub-control title">원뎁스 타이틀 (h2 타이틀)</h2>
<!--// 타이틀 h2 -->
<!-- 타이틀 h3 -->
<h3 class="ub-control title">투뎁스 타이틀 (h3 타이틀)</h3>
<!--// 타이틀 h3 -->

<h1 class="ub-control title">목록 테이블</h1>
<!-- 목록 테이블 -->
<div class="ub-layout button top">
	<span class="ub-control button top icon" id="register"> <a
		href="#none" title="Register"><span class="ico-register"></span>등록</a>
	</span>
</div>
<div class="ub-layout list">
	<table class="ub-control table list">
		<colgroup>
			<col style="width: 10%;" />
			<col style="width: 20%;" />
			<col style="width: 12%;" />
			<col style="width: 12%;" />
			<col />
			<col />
		</colgroup>
		<thead>
			<tr>
				<th rowspan="2" scope="col"><label
					class="ub-control list-header"><nobr>NO</nobr></label></th>
				<th rowspan="2" scope="col"><label
					class="ub-control list-header"><nobr>부품코드</nobr></label></th>
				<th colspan="2" scope="colgroup"><label
					class="ub-control list-header"><nobr>
							센터<br />재고
						</nobr></label></th>
				<th rowspan="2" scope="col"><label
					class="ub-control list-header"><nobr>부품명</nobr></label></th>
			</tr>
			<tr>
				<th class="bl" scope="col"><label
					class="ub-control list-header"><nobr>가용</nobr></label></th>
				<th scope="col"><label class="ub-control list-header"><nobr>수리중</nobr></label></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>4</td>
				<td>ACR854D</td>
				<td>0</td>
				<td>0</td>
				<td class="left">신한생명 프로젝트</td>
			</tr>
			<tr>
				<td>4</td>
				<td><input type="radio" class="ub-control radio" /><label>한글</label></td>
				<td></td>
				<td><input type="text" class="ub-control input-text" /></td>
				<td class="left"></td>
			</tr>
			<tr>
				<td><span class="ico-emergency"></span></td>
				<td><input type="radio" class="ub-control radio" /><label>테스트</label></td>
				<td><input type="checkbox" class="ub-control input-checkbox" /><label>테스트</label></td>
				<td></td>
				<td class="left"></td>
			</tr>
		</tbody>
	</table>
</div>
<!-- //목록 테이블 -->

<!-- 목록 번들 테이블 -->
<h1 class="ub-control title">변형테이블_번들 (목록 테이블 기반/ bundle클래스 추가 / 그룹단위로 테이블이 반복될 경우 사용 / <strong class="txt-color01">추후 업데이트 예정</strong>)</h1>
<table class="ub-control table list bundle">
	<colgroup>
		<col width="2%" />
		<col width="5%" />
		<col width="*" />
		<col width="7%" />
		<col width="7%" />
		<col width="6%" />
		<col width="5%" />
		<col width="5%" />
		<col width="6%" />
		<col width="6%" />
		<col width="8%" />
		<col width="8%" />
		<col width="8%" />
	</colgroup>
	<thead>
		<tr>
			<th scope="col"><label class="ub-control list-header"><nobr>선택</nobr></label>
			</th>
			<th scope="col"><label class="ub-control list-header"><nobr>증권번호</nobr></label>
			</th>
			<th scope="col"><label class="ub-control list-header"><nobr>상품명</nobr></label>
			</th>
			<th scope="col"><label class="ub-control list-header"><nobr>계약일자</nobr></label>
			</th>
			<th scope="col"><label class="ub-control list-header"><nobr>성립일자</nobr></label>
			</th>
			<th scope="col"><label class="ub-control list-header"><nobr>계약자</nobr></label>
			</th>
			<th scope="col"><label class="ub-control list-header"><nobr>피보험자</nobr></label>
			</th>
			<th scope="col"><label class="ub-control list-header"><nobr>월보험료</nobr></label>
			</th>
			<th scope="col"><label class="ub-control list-header"><nobr>최종납입일</nobr></label>
			</th>
			<th scope="col"><label class="ub-control list-header"><nobr>최종납입/납입횟수</nobr></label>
			</th>
			<th scope="col"><label class="ub-control list-header"><nobr>모집지점/모집인</nobr></label>
			</th>
			<th scope="col"><label class="ub-control list-header"><nobr>수금지점/수금인</nobr></label>
			</th>
			<th scope="col"><label class="ub-control list-header"><nobr>이미지</nobr></label>
			</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td rowspan="2"><input type="checkbox"
				class="ub-control input-checkbox" /></td>
			<td>11007807</td>
			<td>나이스건강(개인)</td>
			<td>2001-02-15</td>
			<td>2001-02-15</td>
			<td>허황</td>
			<td>허황</td>
			<td class="text-right">51,800</td>
			<td>2011-01-31</td>
			<td>2011-01/120</td>
			<td>사직/권혁순</td>
			<td>명동/권혁순</td>
			<td></td>
		</tr>
		<tr>
			<td scope="row" class="head01">접수유형</label>
			</td>
			<td colspan="11" class="text-left"><input type="text"
				class="ub-control input-text" style="width: 506px;" /> <select
				class="ub-control select" style="width: 123px;">
					<option></option>
			</select> <select class="ub-control select" style="width: 123px;">
					<option></option>
			</select> <select class="ub-control select" style="width: 133px;">
					<option></option>
			</select> <span class="ub-control button inner icon" name=""><a
					href='#' title="일괄선택">일괄선택</a></span></td>
		</tr>
		<tr>
			<td rowspan="2"><input type="checkbox"
				class="ub-control input-checkbox" /></td>
			<td>11007807</td>
			<td>나이스건강(개인)</td>
			<td>2001-02-15</td>
			<td>2001-02-15</td>
			<td>허황</td>
			<td>허황</td>
			<td class="text-right">51,800</td>
			<td>2011-01-31</td>
			<td>2011-01/120</td>
			<td>사직/권혁순</td>
			<td>명동/권혁순</td>
			<td></td>
		</tr>
		<tr>
			<td scope="row" class="head01">접수유형</label>
			</td>
			<td colspan="11" class="text-left"><input type="text"
				class="ub-control input-text" style="width: 506px;" /> <select
				class="ub-control select" style="width: 123px;">
					<option></option>
			</select> <select class="ub-control select" style="width: 123px;">
					<option></option>
			</select> <select class="ub-control select" style="width: 133px;">
					<option></option>
			</select> <span class="ub-control button inner icon" name=""><a
					href='#' title="일괄선택">일괄선택</a></span></td>
		</tr>
	</tbody>
</table>
<!-- //목록 번들 테이블 -->

<h1 class="ub-control title">검색(상세 검색 영역 포함)</h1>
<!-- 검색 -->
<div class="ub-layout search">
	<span class="search-ltbg"></span> <span class="search-rtbg"></span> <span
		class="search-lbbg"></span> <span class="search-rbbg"></span>
	<form name="searchForm" id="searchForm">
		<!-- 검색영역 기본 -->
		<table class="ub-control table normal ">
			<colgroup>
				<col width="12%">
				<col>
				<col width="12%">
				<col>
			</colgroup>
			<tbody>
				<tr>
					<th scope="row"><label class="ub-control label">등록일자</label></th>
					<td>
						<input type="text" style="text-align: left; width: 73px;" value="2015-02-23" metaformat="date" name="DT_VOC_REG_START" id="DT_VOC_REG_START" class="ub-control input-text calendar "><label class="ub-control label">~</label>
						<input type="text" style="text-align: left; width: 73px;" value="2015-03-02" metaformat="date" name="DT_VOC_REG_END" id="DT_VOC_REG_END" class="ub-control input-text calendar"></td>
					<th scope="row"><label class="ub-control label">진행상태</label></th>
					<td>
						<select style="width: 112px;" class="ub-control select">
							<option value="">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label class="ub-control label">유형</label></th>
					<td>
						<select id="CODE_TP_LIST" name="CODE_TP_LIST" class="ub-control select multiselect" style="width: 120px; display: none;" size="1" datacid="CODE_TP" filteryn="0" multiple="multiple"><option value="ST">Static</option>
							<option value="DN">Dynamic</option>
							<option value="EN">Enum</option>
						</select>
						<button type="button" class="ui-multiselect ui-widget ui-state-default ui-corner-all" aria-haspopup="true" style="width: 156px;">
							<span class="ui-icon ui-icon-triangle-2-n-s"></span><span>선택안됨</span>
						</button>
					</td>
					<th scope="row"><label class="ub-control label">수집채널</label></th>
					<td>
						<select defaultvalue="" datacid="TP_CHNN_SYSTEM" size="1" style="width: 112px;" class="ub-control select " name="TP_CHNN_SYSTEM" id="TP_CHNN_SYSTEM"><option value="">전체</option></select><select defaultvalue="" size="1" style="width: 112px;"
						class="ub-control select " name="TP_CHNN_PATH" id="TP_CHNN_PATH"></select>
					</td>
				</tr>
				<tr>
					<th scope="row"><label class="ub-control label">세부유형</label></th>
					<td colspan="3"><input type="text" style="ime-mode: active; text-align: left; width: 100px;" value="" name="NM_VOC_CAUSE" id="NM_VOC_CAUSE" class="ub-control input-text ">
						<select defaultvalue=""
							size="1" style="width: 112px;" class="ub-control select "
							name="CD_VOC_CAUSE_1" id="CD_VOC_CAUSE_1">
						</select>
							<select defaultvalue="" size="1" style="width: 150px;" class="ub-control select " name="CD_VOC_CAUSE_2" id="CD_VOC_CAUSE_2"></select>
							<select defaultvalue="" size="1" style="width: 150px;" class="ub-control select " name="CD_VOC_CAUSE_3" id="CD_VOC_CAUSE_3"></select>
						</td>
				</tr>
			</tbody>
		</table>
		<!-- //검색영역 기본 -->
		<!-- 검색영역 확장 -->
		<div class="search-advanced close">
			<!-- 확장 닫을땐 close 추가 -->
			<div class="advance">
				<table class="ub-control table normal ">
					<colgroup>
						<col width="12%">
						<col>
						<col width="12%">
						<col>
					</colgroup>
					<tbody>
						<tr id="layout-1_4">
							<th scope="row"><label
								class="ub-control label">고객명</label></th>
							<td><input type="text"
								style="ime-mode: active; text-align: left; width: 100px;"
								value="" name="NM_CUST" id="NM_CUST"
								class="ub-control input-text "></td>
							<th scope="row"><label
								class="ub-control label">고객 연락처</label></th>
							<td><input type="text"
								style="text-align: left; width: 100px;" onkeydown="onlyNumber()"
								value="" name="CUST_ID_PHONE" id="CUST_ID_PHONE"
								class="ub-control input-text "></td>
						</tr>
						<tr>
							<th scope="row"><label
								class="ub-control label">VOC ID</label></th>
							<td><input type="hidden" value=""
								name="ID_CUST" id="ID_CUST"><input type="text"
								style="ime-mode: inactive; text-align: left; width: 100px;"
								value="" name="ID_VOC" id="ID_VOC"
								class="ub-control input-text "></td>
							<th scope="row"></th>
							<td></td>
						</tr>
						<tr>
							<th scope="row"><label
								class="ub-control label">제목</label></th>
							<td><input type="text"
								style="ime-mode: active; text-align: left; width: 300px;"
								value="" name="DS_TITLE" id="DS_TITLE"
								class="ub-control input-text "></td>
							<th scope="row"><label
								class="ub-control label">기타</label></th>
							<td><input type="checkbox" value="Y"
								name="FG_EXCLUSIVE" id="FG_EXCLUSIVE"
								class="ub-control input-checkbox"><label>제외여부</label></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<span class="ub-control button search" id="search"> <a
			href="#none" title="Search">검색</a>
		</span>
		<!-- 검색영역 확장 -->
	</form>
</div>
<!-- //검색 -->

<h2 class="ub-control title">jqgrid 테이블(짝수줄에 even클래스 넣어준다.)</h2>
<!-- jqgrid 테이블 -->
<div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all"
	id="gbox_list" dir="ltr" style="width: auto;">
	<div class="ui-widget-overlay jqgrid-overlay" id="lui_list"></div>
	<div class="loading ui-state-default ui-state-active" id="load_list"
		style="display: none;">조회중...</div>
	<div class="ui-jqgrid-view" role="grid" id="gview_list"
		style="width: auto;">
		<div
			class="ui-jqgrid-titlebar ui-jqgrid-caption ui-widget-header ui-corner-top ui-helper-clearfix"
			style="display: none;">
			<a role="link"
				class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton" title=""
				style="right: 0px;"><span
				class="ui-icon ui-icon-circle-triangle-n"></span></a><span
				class="ui-jqgrid-title"></span>
		</div>
		<div class="ui-state-default ui-jqgrid-hdiv ui-corner-top"
			style="width: auto;">
			<div class="ui-jqgrid-hbox">
				<table class="ui-jqgrid-htable" style="width: 1200px"
					role="presentation" aria-labelledby="gbox_list" cellspacing="0"
					cellpadding="0" border="0">
					<thead>
						<tr class="ui-jqgrid-labels ui-sortable" role="row">
							<th id="list_EMP_NO" role="columnheader"
								class="ui-state-default ui-th-column ui-th-ltr"
								style="width: 50px; display: none;"><span
								class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
								style="cursor: col-resize;">&nbsp;</span>
							<div id="jqgh_list_EMP_NO" class="ui-jqgrid-sortable">
									사번<span class="s-ico" style="display: none"><span
										sort="asc"
										class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span
										sort="desc"
										class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span>
								</div></th>
							<th id="list_USER_ID" role="columnheader"
								class="ui-state-default ui-th-column ui-th-ltr"
								style="width: 50px; display: none;"><span
								class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
								style="cursor: col-resize;">&nbsp;</span>
							<div id="jqgh_list_USER_ID" class="ui-jqgrid-sortable">
									USER_ID<span class="s-ico" style="display: none"><span
										sort="asc"
										class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span
										sort="desc"
										class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span>
								</div></th>
							<th id="list_LOGIN_ID" role="columnheader"
								class="ui-state-default ui-th-column ui-th-ltr"
								style="width: 166px;"><span
								class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
								style="cursor: col-resize;">&nbsp;</span>
							<div id="jqgh_list_LOGIN_ID" class="ui-jqgrid-sortable">
									ID<span class="s-ico" style="display: none"><span
										sort="asc"
										class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span
										sort="desc"
										class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span>
								</div></th>
							<th id="list_USER_NM" role="columnheader"
								class="ui-state-default ui-th-column ui-th-ltr"
								style="width: 166px;"><span
								class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
								style="cursor: col-resize;">&nbsp;</span>
							<div id="jqgh_list_USER_NM" class="ui-jqgrid-sortable">
									이름<span class="s-ico" style="display: none"><span
										sort="asc"
										class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span
										sort="desc"
										class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span>
								</div></th>
							<th id="list_DUTY_CD" role="columnheader"
								class="ui-state-default ui-th-column ui-th-ltr"
								style="width: 166px;"><span
								class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
								style="cursor: col-resize;">&nbsp;</span>
							<div id="jqgh_list_DUTY_CD" class="ui-jqgrid-sortable">
									직책<span class="s-ico" style="display: none"><span
										sort="asc"
										class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span
										sort="desc"
										class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span>
								</div></th>
							<th id="list_DEPT_NM" role="columnheader"
								class="ui-state-default ui-th-column ui-th-ltr"
								style="width: 166px;"><span
								class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
								style="cursor: col-resize;">&nbsp;</span>
							<div id="jqgh_list_DEPT_NM" class="ui-jqgrid-sortable">
									부서<span class="s-ico" style="display: none"><span
										sort="asc"
										class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span
										sort="desc"
										class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span>
								</div></th>
							<th id="list_MOBILE_NO" role="columnheader"
								class="ui-state-default ui-th-column ui-th-ltr"
								style="width: 166px;"><span
								class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
								style="cursor: col-resize;">&nbsp;</span>
							<div id="jqgh_list_MOBILE_NO" class="ui-jqgrid-sortable">
									핸드폰 번호<span class="s-ico" style="display: none"><span
										sort="asc"
										class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span
										sort="desc"
										class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span>
								</div></th>
							<th id="list_EMAIL_DS" role="columnheader"
								class="ui-state-default ui-th-column ui-th-ltr"
								style="width: 166px;"><span
								class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
								style="cursor: col-resize;">&nbsp;</span>
							<div id="jqgh_list_EMAIL_DS" class="ui-jqgrid-sortable">
									이메일<span class="s-ico" style="display: none"><span
										sort="asc"
										class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span
										sort="desc"
										class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span>
								</div></th>
							<th id="list_INCUMBENT_CD" role="columnheader"
								class="ui-state-default ui-th-column ui-th-ltr"
								style="width: 169px;"><span
								class="ui-jqgrid-resize ui-jqgrid-resize-ltr"
								style="cursor: col-resize;">&nbsp;</span>
							<div id="jqgh_list_INCUMBENT_CD" class="ui-jqgrid-sortable">
									재직여부<span class="s-ico" style="display: none"><span
										sort="asc"
										class="ui-grid-ico-sort ui-icon-asc ui-state-disabled ui-icon ui-icon-triangle-1-n ui-sort-ltr"></span><span
										sort="desc"
										class="ui-grid-ico-sort ui-icon-desc ui-state-disabled ui-icon ui-icon-triangle-1-s ui-sort-ltr"></span></span>
								</div></th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<div class="ui-jqgrid-bdiv" style="height: 231px; width: auto;">
			<div style="position: relative; height: 140px;">
				<div style="height: 0px; display: none;"></div>
				<table class="ub-control grid ui-jqgrid-btable" id="list"
					name="list" tabindex="0" cellspacing="0" cellpadding="0" border="0"
					role="presentation" aria-multiselectable="false"
					aria-labelledby="gbox_list" style="width: 1200px;">
					<tbody>
						<tr class="jqgfirstrow" role="row" style="height: auto">
							<td role="gridcell"
								style="height: 0px; width: 50px; display: none;"></td>
							<td role="gridcell"
								style="height: 0px; width: 50px; display: none;"></td>
							<td role="gridcell" style="height: 0px; width: 166px;"></td>
							<td role="gridcell" style="height: 0px; width: 166px;"></td>
							<td role="gridcell" style="height: 0px; width: 166px;"></td>
							<td role="gridcell" style="height: 0px; width: 166px;"></td>
							<td role="gridcell" style="height: 0px; width: 166px;"></td>
							<td role="gridcell" style="height: 0px; width: 166px;"></td>
							<td role="gridcell" style="height: 0px; width: 169px;"></td>
						</tr>
						<tr role="row" id="0" tabindex="-1"
							class="ui-widget-content jqgrow ui-row-ltr">
							<td role="gridcell" style="text-align: center; display: none;"
								title="admin" aria-describedby="list_EMP_NO">admin</td>
							<td role="gridcell" style="text-align: center; display: none;"
								title="admin" aria-describedby="list_USER_ID">admin</td>
							<td role="gridcell" style="text-align: center;" title="admin"
								aria-describedby="list_LOGIN_ID">admin</td>
							<td role="gridcell" style="text-align: center;" title="관리자"
								aria-describedby="list_USER_NM">관리자</td>
							<td role="gridcell" style="text-align: center;" title="회장"
								aria-describedby="list_DUTY_CD">회장</td>
							<td role="gridcell" style="text-align: center;" title="본사아래"
								aria-describedby="list_DEPT_NM">본사아래</td>
							<td role="gridcell" style="text-align: center;" title="123"
								aria-describedby="list_MOBILE_NO">123</td>
							<td role="gridcell" style="text-align: center;" title="123"
								aria-describedby="list_EMAIL_DS">123</td>
							<td role="gridcell" style="text-align: center;" title="재직"
								aria-describedby="list_INCUMBENT_CD">재직</td>
						</tr>
						<tr role="row" id="1" tabindex="-1"
							class="ui-widget-content jqgrow ui-row-ltr even">
							<td role="gridcell" style="text-align: center; display: none;"
								title="01010101" aria-describedby="list_EMP_NO">01010101</td>
							<td role="gridcell" style="text-align: center; display: none;"
								title="000000012" aria-describedby="list_USER_ID">000000012</td>
							<td role="gridcell" style="text-align: center;" title="01010101"
								aria-describedby="list_LOGIN_ID">01010101</td>
							<td role="gridcell" style="text-align: center;" title="테스터"
								aria-describedby="list_USER_NM">테스터</td>
							<td role="gridcell" style="text-align: center;" title="총괄"
								aria-describedby="list_DUTY_CD">총괄</td>
							<td role="gridcell" style="text-align: center;" title="본사2아래"
								aria-describedby="list_DEPT_NM">본사2아래</td>
							<td role="gridcell" style="text-align: center;" title="01"
								aria-describedby="list_MOBILE_NO">01</td>
							<td role="gridcell" style="text-align: center;" title="01"
								aria-describedby="list_EMAIL_DS">01</td>
							<td role="gridcell" style="text-align: center;" title="재직"
								aria-describedby="list_INCUMBENT_CD">재직</td>
						</tr>
						<tr role="row" id="2" tabindex="-1"
							class="ui-widget-content jqgrow ui-row-ltr">
							<td role="gridcell" style="text-align: center; display: none;"
								title="02020202" aria-describedby="list_EMP_NO">02020202</td>
							<td role="gridcell" style="text-align: center; display: none;"
								title="000000013" aria-describedby="list_USER_ID">000000013</td>
							<td role="gridcell" style="text-align: center;" title="02020202"
								aria-describedby="list_LOGIN_ID">02020202</td>
							<td role="gridcell" style="text-align: center;" title="테스터2"
								aria-describedby="list_USER_NM">테스터2</td>
							<td role="gridcell" style="text-align: center;" title="자문"
								aria-describedby="list_DUTY_CD">자문</td>
							<td role="gridcell" style="text-align: center;" title="본사2아래아래"
								aria-describedby="list_DEPT_NM">본사2아래아래</td>
							<td role="gridcell" style="text-align: center;" title="12"
								aria-describedby="list_MOBILE_NO">12</td>
							<td role="gridcell" style="text-align: center;" title="12"
								aria-describedby="list_EMAIL_DS">12</td>
							<td role="gridcell" style="text-align: center;" title="재직"
								aria-describedby="list_INCUMBENT_CD">재직</td>
						</tr>
						<tr role="row" id="3" tabindex="-1"
							class="ui-widget-content jqgrow ui-row-ltr even">
							<td role="gridcell" style="text-align: center; display: none;"
								title="testadmin" aria-describedby="list_EMP_NO">testadmin</td>
							<td role="gridcell" style="text-align: center; display: none;"
								title="000000014" aria-describedby="list_USER_ID">000000014</td>
							<td role="gridcell" style="text-align: center;" title="testadmin"
								aria-describedby="list_LOGIN_ID">testadmin</td>
							<td role="gridcell" style="text-align: center;" title="테스트관리자"
								aria-describedby="list_USER_NM">테스트관리자</td>
							<td role="gridcell" style="text-align: center;" title="부본부장"
								aria-describedby="list_DUTY_CD">부본부장</td>
							<td role="gridcell" style="text-align: center;" title="본사2아래아래"
								aria-describedby="list_DEPT_NM">본사2아래아래</td>
							<td role="gridcell" style="text-align: center;" title="010"
								aria-describedby="list_MOBILE_NO">010</td>
							<td role="gridcell" style="text-align: center;" title="010"
								aria-describedby="list_EMAIL_DS">010</td>
							<td role="gridcell" style="text-align: center;" title="재직"
								aria-describedby="list_INCUMBENT_CD">재직</td>
						</tr>
						<tr role="row" id="4" tabindex="-1"
							class="ui-widget-content jqgrow ui-row-ltr">
							<td role="gridcell" style="text-align: center; display: none;"
								title="01026813956" aria-describedby="list_EMP_NO">01026813956</td>
							<td role="gridcell" style="text-align: center; display: none;"
								title="000000011" aria-describedby="list_USER_ID">000000011</td>
							<td role="gridcell" style="text-align: center;"
								title="01026813956" aria-describedby="list_LOGIN_ID">01026813956</td>
							<td role="gridcell" style="text-align: center;" title="유기태"
								aria-describedby="list_USER_NM">유기태</td>
							<td role="gridcell" style="text-align: center;" title="부회장"
								aria-describedby="list_DUTY_CD">부회장</td>
							<td role="gridcell" style="text-align: center;" title="본사아래"
								aria-describedby="list_DEPT_NM">본사아래</td>
							<td role="gridcell" style="text-align: center;"
								title="01026813956" aria-describedby="list_MOBILE_NO">01026813956</td>
							<td role="gridcell" style="text-align: center;"
								title="rkt3956@ubqone.com" aria-describedby="list_EMAIL_DS">rkt3956@ubqone.com</td>
							<td role="gridcell" style="text-align: center;" title="재직"
								aria-describedby="list_INCUMBENT_CD">재직</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="ui-jqgrid-resize-mark" id="rs_mlist">&nbsp;</div>
</div>
<!--// jqgrid 테이블 -->

<h1 class="ub-control title">검색 예외케이스</h1>
<!-- 검색 -->
<div class="ub-layout search etc01">
	<span class="search-ltbg"></span> <span class="search-rtbg"></span> <span
		class="search-lbbg"></span> <span class="search-rbbg"></span>
	<form name="searchForm" id="searchForm">
		<!-- 검색영역 기본 -->
		<table class="ub-control table normal">
			<tbody>
				<tr id="layout-1_1">
					<td id="layout-1_1_4"><input type="radio"
						class="ub-control radio"><label class="ub-control label">선택1</label>
						<input type="radio" class="ub-control radio"><label
						class="ub-control label">선택2</label> <input type="checkbox"
						class="ub-control input-checkbox"><label
						class="ub-control label">선택3</label></td>
				</tr>
			</tbody>
		</table>
		<!-- //검색영역 기본 -->
	</form>
</div>
<!-- //검색 -->
<div class="exp">화면타입이 list이나, 검색요건이 간단하여 가운데 정렬이 되어져야 할 경우 etc01
	클래스 추가</div>


<h1 class="ub-control title">ui-dialog 예제</h1>
<div class="ui-dialog-example">
	<div class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-draggable ui-resizable ui-dialog-buttons" tabindex="-1" role="dialog" aria-labelledby="ui-id-1" style="outline: 0px; z-index: 1002; /* position: absolute; */ height: auto; width: 300px; /* top: 385px; left: 688px; */ display: block;">
		<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
			<span id="ui-id-1" class="ui-dialog-title">왼쪽 상단 타이틀</span>
			<a href="#" class="ui-dialog-titlebar-close ui-corner-all" role="button">
				<span class="ui-icon ui-icon-closethick">close</span>
			</a>
		</div>
		<!-- 메세지 영역 -->
		<div id="debugDialog" class="ui-dialog-content ui-widget-content" scrolltop="0" scrollleft="0" style="width: auto; min-height: 64px; height: auto;">
			<span style="color: red;" title="error">X</span>&nbsp;&nbsp;사용자 정보가 일치하지 않습니다.<br>확인후 다시 실행해 주십시요.<br>
		</div>
		<div class="ui-resizable-handle ui-resizable-n" style="z-index: 1000;"></div>
		<div class="ui-resizable-handle ui-resizable-e" style="z-index: 1000;"></div>
		<div class="ui-resizable-handle ui-resizable-s" style="z-index: 1000;"></div>
		<div class="ui-resizable-handle ui-resizable-w" style="z-index: 1000;"></div>
		<div class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se ui-icon-grip-diagonal-se" style="z-index: 1000;"></div>
		<div class="ui-resizable-handle ui-resizable-sw" style="z-index: 1000;"></div>
		<div class="ui-resizable-handle ui-resizable-ne" style="z-index: 1000;"></div>
		<div class="ui-resizable-handle ui-resizable-nw" style="z-index: 1000;"></div>
		<!-- 버튼 영역 -->
		<!-- <div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
			<div class="ui-dialog-buttonset">
				
				<button type="button" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" role="button" aria-disabled="false">
					<span class="ui-button-text">Ok</span>
				</button>
			</div>
		</div> -->
	</div>
</div>


<h1 class="ub-control title">jqGrid 넘버링</h1>
<!-- 그리드 영역 -->
<div class="ub-control temp" style="border:2px solid gray;width:100%;height:300px;text-align:center;">
	<h3 style="padding-top:120px;">Grid Control</h3>
</div>
<table class="ub-control grid" id="list_rownumExample" name="list_rownumExample" ></table> 



<script type="text/javascript">
	uxl.onLoad(function() {
				//버튼추가 (메타로 그리기에 애매해서 script로 뺌)
				$('.search-advanced')
						.prepend(
								"<span class='btn'><a href='#' class='open'><span>advanced</span></a></span>");
				$('.search-advanced .btn').click(function() {
					var searchAdvanced = $(this.parentElement);
					var btnImage = $(this.children);
					if (this.parentElement.className.indexOf('close') >= 0) {
						//열기
						searchAdvanced.removeClass('close');
						btnImage.removeClass('close').addClass('open');
					} else {
						//닫기
						searchAdvanced.addClass('close');
						btnImage.removeClass('open').addClass('close');
					}
				});

				//테이블 헤더 고정
				//$('#grid_detail').fixedHeaderListTable({ width: '100%', minWidth: 1200, height: 550, rowHeader: 1 });
				
				
				//그리드 넘버링 예제용 옵션
				var gridOption = {
					colNames:['COL1','COL2','COL3','COL4','COL5','COL6'],
					colModel:
					[
					 	 {name:'COL1',width:20,align:'center'}
					 	,{name:'COL2',width:30,align:'center'}
					 	,{name:'COL3',width:30,align:'center'}
					 	,{name:'COL4',width:30,align:'center'}
					 	,{name:'COL5',width:30,align:'center'}
					 	,{name:'COL6',width:30,align:'center'}
					]
					,height:300
					,autowidth:true
					,rownumbers: true
					,beforeSelectRow: function (rowid, e) {}
					,onSelectRow:function(rowid){}			
					,ondblClickRow: function(rowid){}
					,beforeEditCell : function(rowid, cellname, value, iRow, iCol){}
					,afterEditCell :function(rowid, cellname, value, iRow, iCol){}
			     	,afterSaveCell : function(rowid, cellname, value, iRow, iCol){}
					,loadComplete : function(data)
					{
						var dataArr = new Array(); 		
						
						for(var i = 0 ; i < 10 ; i++)
						{
						    var rowData = {};
							for(var j = 0 ; j < 6 ; j++)
							{
								rowData['COL'+(j+1)] = 'ROW'+(i+1)+'_COL'+(j+1)+'데이터';
							}
							dataArr[i] = rowData;
							$('#list_rownumExample').jqGrid('addRowData', i+1 , rowData);
						}
					}
				}
				uxl.grid('list_rownumExample', gridOption);
				
	});
</script>