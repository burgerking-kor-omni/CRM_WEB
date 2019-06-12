<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"   prefix="c" %>

<html>
<head>
<title>API 테스트</title>
</head>

<body>
<div>
<b>@@회원 로그인</b>
<%-- <form id="loginForm" action="<spring:url value='/testLogin.ub' />" method="post"> --%>
<!-- api local test -->
<form id="form01" action="<spring:url value='http://localhost:8080/api/user/login' />" method="post">
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>로그인구분 : </th>
				<td><input type="text" width=150px id="chk_gubun" name="chk_gubun" value="01"></td>
				<th>회원이메일 : </th>
				<td><input type="text" width=150px id="ds_email" name="ds_email" value="woosukcc@ubqone.com"></td>
			</tr>
			<tr>
				<th>비밀번호 : </th>
				<td><input type="text" width=150px id="passwd" name="passwd" value="Ubone12#"></td>
				<th>app 토큰 : </th>
				<td><input type="password" width=150px id="app_token" name="app_token" value=""></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<input type="submit" value="로그인" >
					<a id="bntLogin" class="textLink" href="<c:url value="http://localhost:8080/api/user/loginKiosk?brcd_member=00001895097" />">
						<input type="button" value="바코드로그인" />
					</a>
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<div>
<b>@@중복체크</b>
<form id="form02" action="<spring:url value='http://localhost:8080/api/user/chkJoin' />" method="post">
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>중복체크항목 : </th>
				<td colspan="3"><input type="text" width=150px id="chk_gubun" name="chk_gubun" value="01"></td>
			</tr>
			<tr>
				<th>중복항목값_01 : </th>
				<td><input type="text" width=150px id="chk_value01" name="chk_value01" value="woosukcc@ubqone.com"></td>
				<th>중복항목값_02 : </th>
				<td><input type="text" width=150px id="chk_value02" name="chk_value02" value="01090670504"></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<input type="submit" value="체크" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<div>
<b>@@휴먼해제</b>
<form id="form02" action="<spring:url value='http://localhost:8080/api/user/releaseDormancy' />" method="post">	
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>회원PK : </th>
				<td colspan="3"><input type="text" width=150px id="id_member" name="id_member" value="1895097"></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<input type="submit" value="해제" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<b>@@회원가입</b>
<div>
<form id="form03" action="<spring:url value='http://localhost:8080/api/user/insertMember' />" method="post">
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>회원명 : </th>
				<td><input type="text" width=150px id="nm_member" name="nm_member" value="01"></td>
				<th>회원이메일 : </th>
				<td><input type="text" width=150px id="ds_email" name="ds_email" value="woosukcc@ubqone.com"></td>
				<th>회원전화번호 : </th>
				<td><input type="text" width=150px id="no_phone" name="no_phone" value="01090670504"></td>
				<th>비밀번호 : </th>
				<td><input type="text" width=150px id="passwd" name="passwd" value="Ubone12#"></td>
			</tr>
			<tr>
				<th>생년월일 : </th>
				<td><input type="text" width=150px id="dt_birth" name="dt_birth" value="19821216"></td>
				<th>성별 : </th>
				<td><input type="text" width=150px id="cd_age_grade" name="cd_age_grade" value="M"></td>
				<th>가입경로 : </th>
				<td><input type="text" width=150px id="cd_join_path" name="cd_join_path" value="04"></td>
				<th>가입사이트 : </th>
				<td><input type="text" width=150px id="cd_join_site" name="cd_join_site" value="01"></td>
			</tr>
			<tr>
				<th>등록IP : </th>
				<td><input type="text" width=150px id="reg_ip" name="reg_ip" value="127.0.0.1"></td>
				<th>인증여부 : </th>
				<td><input type="text" width=150px id="yn_confirm" name="yn_confirm" value="Y"></td>
				<th>회원핀코드 : </th>
				<td><input type="text" width=150px id="cd_pin" name="cd_pin" value="020119624373123"></td>
				<th>실명인증확인값 : </th>
				<td><input type="text" width=150px id="di" name="di" value="MC0GCCqGSIb3DQIJAyEARpqjlGvoEbtboqL30EEkGUVhfkjm9iuZ6BdGiY20q11"></td>
			</tr>
			<tr>
				<th>SMS수신여부 : </th>
				<td><input type="text" width=150px id="yn_sms_recv" name="yn_sms_recv" value="Y"></td>
				<th>EMAIL수신여부 : </th>
				<td><input type="text" width=150px id="yn_email_recv" name="yn_email_recv" value="Y"></td>
				<th>개인정보수집동의여부 : </th>
				<td><input type="text" width=150px id="yn_privacy_agree" name="yn_privacy_agree" value="Y"></td>
				<th>버거킹이용약관동의여부 : </th>
				<td colspan="7"><input type="text" width=150px id="yn_bkr_agree" name="yn_bkr_agree" value="Y"></td>
			</tr>
			<tr>
				<td colspan="8" align="right">
					<input type="submit" value="가입" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<b>@@회원정보수정</b>
<div>
<form id="form04" action="<spring:url value='http://localhost:8080/api/user/updateMember' />" method="post">
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>회원PK : </th>
				<td><input type="text" width=150px id="id_member" name="id_member" value="1895097"></td>
				<th>회원전화번호 : </th>
				<td><input type="text" width=150px id="no_phone" name="no_phone" value="01090670504"></td>
				<th>SMS수신여부 : </th>
				<td><input type="text" width=150px id="yn_sms_recv" name="yn_sms_recv" value="Y"></td>
				<th>EMAIL수신여부 : </th>
				<td><input type="text" width=150px id="yn_email_recv" name="yn_email_recv" value="Y"></td>
			</tr>
			<tr>
				<td colspan="8" align="right">
					<input type="submit" value="수정" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<b>@@비밀번호변경전 체크</b>
<div>
<form id="form05" action="<spring:url value='http://localhost:8080/api/user/chkPw' />" method="post">
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>회원PK : </th>
				<td><input type="text" width=150px id="id_member" name="id_member" value="1895097"></td>
				<th>비밀번호 : </th>
				<td><input type="text" width=150px id="passwd" name="passwd" value="Ubone12#"></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<input type="submit" value="체크" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<b>@@비밀번호변경</b>
<div>
<form id="form05" action="<spring:url value='http://localhost:8080/api/user/updateMemberPw' />" method="post">
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>회원PK : </th>
				<td><input type="text" width=150px id="id_member" name="id_member" value="1895097"></td>
				<th>비밀번호 : </th>
				<td><input type="text" width=150px id="passwd" name="passwd" value="Ubone12#"></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<input type="submit" value="수정" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<b>@@아이디찾기</b>
<div>
<form id="form06" action="<spring:url value='http://localhost:8080/api/user/findId' />" method="post">
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>회원명 : </th>
				<td><input type="text" width=150px id="nm_member" name="nm_member" value="김기영"></td>
				<th>전화번호 : </th>
				<td><input type="text" width=150px id="no_phone" name="no_phone" value="01090670504"></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<input type="submit" value="찾기" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<b>@@비밀번호찾기</b>
<div>
<form id="form06" action="<spring:url value='http://localhost:8080/api/user/resetPw' />" method="post">
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>회원명 : </th>
				<td><input type="text" width=150px id="nm_member" name="nm_member" value="김기영"></td>
				<th>이메일 : </th>
				<td><input type="text" width=150px id="ds_email" name="ds_email" value="woosukcc@ubqone.com"></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<input type="submit" value="찾기" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<b>@@비밀번호 나중변경일 수정</b>
<div>
<form id="form07" action="<spring:url value='http://localhost:8080/api/user/changeLater' />" method="post">
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>회원PK : </th>
				<td><input type="text" width=150px id="id_member" name="id_member" value="1895097"></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="수정" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<b>@@추가 약관 동의</b>
<div>
<form id="form08" action="<spring:url value='http://localhost:8080/api/user/addTermsAgree' />" method="post">
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>회원PK : </th>
				<td><input type="text" width=150px id="id_member" name="id_member" value="1895097"></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="수정" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<b>@@회원 탈퇴</b>
<div>
<form id="form09" action="<spring:url value='http://localhost:8080/api/user/deleteMember' />" method="post">
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>회원PK : </th>
				<td><input type="text" width=150px id="id_member" name="id_member" value="745"></td>
				<th>회원이메일 : </th>
				<td><input type="text" width=150px id="ds_email" name="ds_email" value="01skel10@naver.com"></td>
			</tr>
			<tr>
				<th>탈퇴구분 : </th>
				<td><input type="text" width=150px id="tp_del" name="tp_del" value="01"></td>
				<th>탈퇴사유 : </th>
				<td><input type="text" width=150px id="ds_del" name="ds_del" value="탈퇴엔 이유가 없다."></td>
			</tr>
			<tr>
				<td colspan="2" align="right">
					<input type="submit" value="탈퇴" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<b>@@배송지등록</b>
<div>
<form id="form10" action="<spring:url value='http://localhost:8080/api/address/insertAddress' />" method="post">
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>회원PK : </th>
				<td><input type="text" width=150px id="id_member" name="id_member" value="1895097"></td>
				<th>매장PK : </th>
				<td><input type="text" width=150px id="id_store" name="id_store" value="27"></td>
				<th>매장 소구역 코드 : </th>
				<td><input type="text" width=150px id="branch_idx" name="branch_idx" value="00198C"></td>
				<th>배달 예상시간 : </th>
				<td><input type="text" width=150px id="delivery_time" name="delivery_time" value="45~60"></td>
			</tr>
			<tr>
				<th>야간 매장PK : </th>
				<td><input type="text" width=150px id="night_store_pk" name="night_store_pk" value="1215"></td>
				<th>야간 매장 소구역 코드 : </th>
				<td><input type="text" width=150px id="night_branch_idx" name="night_branch_idx" value="90106G"></td>
				<th>야간 배당 예상시간 : </th>
				<td><input type="text" width=150px id="night_delivery_time" name="night_delivery_time" value="45~60"></td>
				<th>주소제목 : </th>
				<td><input type="text" width=150px id="nm_addr" name="nm_addr" value="회사"></td>
			</tr>
			<tr>
				<th>기본주소여부 : </th>
				<td><input type="text" width=150px id="yn_addr_base" name="yn_addr_base" value="Y"></td>
				<th>우편번호 : </th>
				<td><input type="text" width=150px id="zip_code" name="zip_code" value="06193"></td>
				<th>도로명주소 : </th>
				<td><input type="text" width=150px id="ds_addr_street" name="ds_addr_street" value="서울 강남구 테헤란로64길ns"></td>
				<th>도로명주소상세 : </th>
				<td><input type="text" width=150px id="ds_addr_street_dtl" name="ds_addr_street_dtl" value="1124호"></td>
			</tr>
			<tr>
				<th>지번주소 : </th>
				<td><input type="text" width=150px id="ds_addr" name="ds_addr" value="서울 강남구 대치동 890-4"></td>
				<th>지번주소상세 : </th>
				<td><input type="text" width=150px id="ds_addr_dtl" name="ds_addr_dtl" value="1124호"></td>
				<th>주문시-지번주소시 : </th>
				<td><input type="text" width=150px id="cust_dong_si" name="cust_dong_si" value="서울"></td>
				<th>주문시-지번주소구 : </th>
				<td><input type="text" width=150px id="cust_dong_gu" name="cust_dong_gu" value="강남구"></td>
			</tr>
			<tr>
				<th>주문시-지번주소동 : </th>
				<td><input type="text" width=150px id="cust_dong_dong" name="cust_dong_dong" value="대치동"></td>
				<th>주문시-지번주소번지 : </th>
				<td><input type="text" width=150px id="cust_dong_append" name="cust_dong_append" value="890-49"></td>
				<th>주문시-도로명시 : </th>
				<td><input type="text" width=150px id="cust_gil_si" name="cust_gil_si" value="서울특별시"></td>
				<th>주문시-도로명구 : </th>
				<td><input type="text" width=150px id="cust_gil_gu" name="cust_gil_gu" value="강남구"></td>
			</tr>
			<tr>
				<th>주문시-도로명길 : </th>
				<td><input type="text" width=150px id="cust_gil_gil" name="cust_gil_gil" value="테헤란로64길"></td>
				<th>주문시-도로명건물번호 : </th>
				<td><input type="text" width=150px id="cust_gil_append" name="cust_gil_append" value="9 선릉역대우아이빌"></td>
				<th>주문시-주소추가상세주소 : </th>
				<td><input type="text" width=150px id="cust_gil_dong_desc" name="cust_gil_dong_desc" value="서울특별시 강남구 테헤란로64길 9 선릉역대우아이빌 1124호"></td>
				<th>주문시-회원좌표X : </th>
				<td><input type="text" width=150px id="x_coordinates" name="x_coordinates" value="316341"></td>
			</tr>
			<tr>
				<th>주문시-회원좌표Y : </th>
				<td colspan="7"><input type="text" width=150px id="y_coordinates" name="y_coordinates" value="545123"></td>
			</tr>
			<tr>
				<td colspan="8" align="right">
					<input type="submit" value="등록" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

<b>@@배송지삭제</b>
<div>
<form id="form11" action="<spring:url value='http://localhost:8080/api/address/deleteAddress' />" method="post">	
	<table>
		<colgroup>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
			<col width="200px"/>
		</colgroup>
		<tbody>
			<tr>
				<th>회원PK : </th>
				<td><input type="text" width=150px id="id_member" name="id_member" value="1895097"></td>
				<th>매장PK : </th>
				<td><input type="text" width=150px id="no_address" name="no_address" value="1171307"></td>
			</tr>
			<tr>
				<td colspan="4" align="right">
					<input type="submit" value="삭제" >
				</td>
			</tr>
		</tbody>
	</table>
</form>
</div>

</html>