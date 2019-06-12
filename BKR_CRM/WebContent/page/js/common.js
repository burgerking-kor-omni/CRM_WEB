//********************************
//			util
//********************************
var util = {};
/**
 * 엘리먼트 여부를 확인합니다.
 * @param {Object} object 엘리먼트 여부를 확인할 객체
 * @return {Boolean} 엘리먼트 여부
 * @see util-1.0.0.js
 */
util.isElement = function(object) {
	return !!(object && object.nodeType == 1);
};

/**
 * Undefined 여부를 확인합니다.
 * @param {Object} object Undefined 여부를 확인할 객체
 * @return {Boolean} Undefined 여부: return true when object is undefined else false
 * @see util-1.0.0.js
 */
util.isUndefined = function(object) {
	return (typeof object == 'undefined');
};
/**
 * Undefined 여부를 확인합니다.
 * @param {Object} object Undefined 여부를 확인할 객체
 * @return {Boolean} Undefined 여부 : return true when object is defined else false
 * @see util-1.0.0.js
 */
util.isNotUndefined = function(object) {
	return !util.isUndefined(object);
};

/**
 * null 여부를 확인합니다.
 * @param {Object} object null 여부를 확인할 객체
 * @return {Boolean} null 여부: return true when object is undefined or null else false
 * @see util-1.0.0.js
 */
util.isNull = function(object) {
	return (typeof object == 'undefined' || object == null);
};
/**
 * null 여부를 확인합니다.
 * @param {Object} object null 여부를 확인할 객체
 * @return {Boolean} null 여부 : return true when object is defined or not null else false
 * @see util-1.0.0.js
 */
util.isNotNull = function(object) {
	return !util.isNull(object);
};
/**
 * 배열 여부를 확인합니다.
 * @param {Object} object 배열 여부를 확인할 객체
 * @return {Boolean} 배열 여부
 * @see util-1.0.0.js
 */
util.isArray = function(object) {
	return Object.prototype.toString.call(object) == '[object Array]'; 
};
/**
 * String 여부를 확인합니다.
 * @param {Object} object String 여부를 확인할 객체
 * @return {Boolean} String 여부
 * @see util-1.0.0.js
 */
util.isString = function(object){
	 return typeof object == 'string';
};
/**
 * Function 여부를 확인합니다.
 * @param {Object} object Function 여부를 확인할 객체
 * @return {Boolean} Function 여부
 * @see util-1.0.0.js
 */
util.isFunction = function(object) {
	return typeof object == 'function';
};
/**
 * 숫자 여부를 확인합니다.
 * @param {Object} object 숫자 여부를 확인할 객체
 * @return {Boolean} 숫자 여부
 * @see util-1.0.0.js
 */
util.isNumber = function(object) {
	return typeof object == 'number';
};
util.trim = function(str) {
	var nbsp = String.fromCharCode(160);
	str = str.replace(new RegExp(nbsp, 'g'), '');
	return jQuery.trim(str);
};
/**
 * 빈 문자열 여부를 확인합니다.
 * @param {String} str 빈 문자열 여부를 확인할 객체
 * @return {Boolean} 빈 문자열 여부 : return true when object is undefined or null or empty string('')
 * @see util-1.0.0.js
 */
util.isEmpty = function(str) {
	return (util.isNull(str) || str == '');
};
/**
 * 내용이 있는 문자열 여부를 확인합니다.
 * @param {Object} str 내용이 있는 문자열 여부를 확인할 객체
 * @return {Boolean} 내용이 있는 문자열 여부 : return true when is not empty
 * @see util-1.0.0.js
 */
util.isNotEmpty = function(str) {
	return !util.isEmpty(str);
};

/**
 * 공백 문자열 여부를 확인합니다.
 * @param {String} 공백문자열 여부를 확인할 문자열
 * @return {Boolean} 공백 문자열 여부. 공백 문자열일 경우 true 를 반환합니다.
 * @see util-1.0.0.js
 */
util.isBlank = function(str) {
	if(util.isNull(str)) {
		return true;
	}
    return /^\s*$/.test(str);
};
/**
 * 공백 문자열 여부를 확인합니다.
 * @param {String} 공백문자열 여부를 확인할 문자열
 * @return {Boolean} 공백 문자열 여부. 공백 문자열이 아닐 경우 true 를 반환합니다.
 * @see util-1.0.0.js
 */
util.isNotBlank = function(str) {
    return !util.isNotBlank(str);
};
/**
 * 전화번호 마스크
 * @param {String} 전화번호
 * @return {String} 전화번호 
 * @see util-1.0.0.js
 */
util.telMask = function(oldtel) {
	var tel = util.trim(oldtel);
	if(tel == "") return tel;

	//tel = 숫자만 뽑아오는 로직 추가하셔서 사용하시면 될 듯하네요
	//tel = UUtil.removeNumberMask(tel);

	var DDD1 		= new Array("02");
	var DDD2 		= new Array("010","011","017","016","018","019"
													,"031","032","033"
													,"041","042","043","044"
													,"061","062","063","064"
													,"051","052","053","054","055"
													,"060","070","080"
													);
	var DDD3 		= new Array("0505","0130");												
	var DDD4 		= new Array("1588","1577","1544","1566","1644","1688","1599","1666"
													);
	
	var lstrThrNo 	= "";
	var lstrSecNo 	= "";

	if(tel.length < 7) return oldtel;

	lstrThrNo = tel.substring(tel.length -4);
	lstrSecNo = tel.substring(0,tel.length -4);

	//두자리 지역번호
	for(var i=0;i<DDD1.length;i++)
	{
		if(lstrSecNo.substring(0,2) == DDD1[i])
		{
			if(lstrSecNo.substring(2,lstrSecNo.length).length < 3 || lstrSecNo.substring(2,lstrSecNo.length).length > 4)
				return oldtel;
			else
				return DDD1[i] + "-" + lstrSecNo.substring(2,lstrSecNo.length) + "-" + lstrThrNo;
			break;
		}
	}
	
	//세자리 지역번호, 핸드폰
	for(var i=0;i<DDD2.length;i++)
	{
		if(lstrSecNo.substring(0,3) == DDD2[i])
		{
			if(lstrSecNo.substring(3,lstrSecNo.length).length < 3 || lstrSecNo.substring(3,lstrSecNo.length).length > 4)
				return oldtel;
			else			
				return DDD2[i] + "-" + lstrSecNo.substring(3,lstrSecNo.length) + "-" + lstrThrNo;
			break;
		}
	}
	
	//네자리 지역번호, 파워텔
	for(var i=0;i<DDD3.length;i++)
	{
		if(lstrSecNo.substring(0,4) == DDD3[i])
		{
			if(lstrSecNo.substring(4,lstrSecNo.length).length < 3 || lstrSecNo.substring(4,lstrSecNo.length).length > 4)
				return oldtel;
			else					
				return DDD3[i] + "-" + lstrSecNo.substring(4,lstrSecNo.length) + "-" + lstrThrNo;
			break;
		}
	}
	
	//대표번호
	if(lstrSecNo.length == 4)
	{
		for(var i=0;i<DDD4.length;i++)
		{
			if(lstrSecNo == DDD4[i])
			{				
				return DDD4[i] + "-" + lstrThrNo;
				break;
			}
		}
	}
	
	//지역번호 없는 전화번호 자동 지역번호 부여
	if(lstrSecNo.length == 3 || lstrSecNo.length == 4)
	{
		return "031" + "-" + lstrSecNo + "-" + lstrThrNo;
	}
	
	return oldtel;
};

DateUtil = {};

DateUtil.getDayInterval = function(date1,date2)
{
    var source1 = this.toDateObject(date1);
    var source2 = this.toDateObject(date2);
    var day   	= 1000 * 3600 * 24; //24시간

    // +면 date2가 크고, -면 date1이 큼
    return parseInt((source2 - source1) / day, 10);
};

/**
 * Time 스트링을 자바스크립트 Date 객체로 변환
*
* @param	date	Time 형식의 String
*/
DateUtil.toDateObject = function (date)
{
   var dateValue = date.replace(new RegExp('\-', 'g'), '');
   var year  = dateValue.substr(0,4);
   var month = dateValue.substr(4,2) - 1; // 1월=0,12월=11
   var day   = dateValue.substr(6,2);

   return new Date(year,month,day);
};
/**
 * Combo 분단위 셋팅
 */
DateUtil.setDateMm = function(data) {
	var chkData1 = [1,2,3,4];
	var chkData2 = [6,7,8,9];
	
	if(data == 0){
		return '0';
	}
	if(data == 5){
		return '5';
	}
	
	for(var i=0; i<chkData1.length; i++){
		if(data == chkData1[i]){
			return '0';
		}
	}
	for(var j=0; j<chkData2.length; j++){
		if(data == chkData2[j]){
			return '5';
		}
	}
};

/**
 *  This function allow entering just the specified expression to a textbox or textarea control.
 *
 * @param expression 	Allowed characters
 *                   	a..z => ONLY LETTERS
 *                  	0..9 => ONLY NUMBERS
 *                  	other symbols...
 * @return none
 *
 * [example] use the onKeyPress event to make this function work:
 *           //Allows only from A to Z
 *           onKeyPress="allowOnly('a..z');"
 *
 *           //Allows only from 0 to 9
 *           onKeyPress="allowOnly('0..9');"
 *
 *           //Allows only A,B,C,1,2 and 3
 *           onKeyPress="allowOnly('abc123');"
 *
 *           //Allows only A TO Z,@,#,$ and %
 *           onKeyPress="allowOnly('a..z|@#$%');"
 *
 *           //Allows only A,B,C,0 TO 9,.,,,+ and -
 *           onKeyPress="allowOnly('ABC|0..9|.,+-');"
 *
 * [remarks] Use the pipe "|" symbol to separate a..z from 0..9 and symbols
 */
function allowOnly(expression)
{
	expression = expression.toLowerCase();
	expression = expression.replace( "a..z", "abcdefghijklmnopqrstuvwxyz");
	expression = expression.replace( "0..9", "0123456789");
	expression = expression.replace( "1..9", "123456789");
	expression = expression.replace( "|", "");

	var ch = String.fromCharCode(window.event.keyCode);
	ch = ch.toLowerCase();
	expression = expression.toLowerCase();
	var a = expression.indexOf(ch);
	if (a == -1) window.event.keyCode = 0;
}

function fitTextareaSize (obj) {
	if (obj) {
		var strRows = obj.clientHeight;  // textarea height
		var strRows2 = obj.scrollHeight; // contents height

		if(strRows < strRows2) {
		   obj.style.height = 4 + strRows2;
		}		
		
		if(obj.readOnly == true || obj.readOnly == 1) {
			if(strRows2 < 19) {
				obj.style.height = 15;
			}
			obj.style.border = '0';
			obj.style.overflow = 'hidden';
		}
	}
}

