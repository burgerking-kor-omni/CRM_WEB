/** 
 * @fileoverview UBONE X-Library  
 *
 * @author (주)유비원 제품지원파트
 * @version 1.2.2
 * 
 *  1.2.2 : uxl.openWindow 의 width / height의 값이 px 단위까지 같이 입력시 팝업이 화면의 가운데 정열이 안되던 버그수정
 *  1.2.1 : iFrame Memory Leak 관련 메소드 추가 (uxl.removeIframe)
 */

/**
 * @namespace UBONE X-Library
*/
var uxl = {};

/** 
 * uxl 의 버전
 * @type String
*/
uxl.version = '1.2.2';

uxl.CONSTANT = {};
uxl.CONSTANT.URL_EXTENTION = 'ub';
uxl.CONSTANT.CONTEXT_ROOT = _CONTEXT_ROOT;
uxl.CONSTANT.SERVER_MODE = _SERVER_MODE;
uxl.CONSTANT.LIST_ITEM_SELECTOR = '.section_list tbody td.value';
uxl.CONSTANT.LIST_INNER_ITEM_SELECTOR = '.section_list_inner tbody td.value';

uxl.CONSTANT.KEY = {};
uxl.CONSTANT.KEY.PRIMARY = _KEY_PRIMARY;
uxl.CONSTANT.KEY.RECOVERY = _KEY_RECOVERY;

uxl.CONSTANT.PATH = {};
uxl.CONSTANT.PATH.SCREEN = _REQUEST_PATH_SCREEN;
uxl.CONSTANT.PATH.FUNCTION = _REQUEST_PATH_FUNCTION;
uxl.CONSTANT.PATH.SERVICE = _REQUEST_PATH_SERVICE;
uxl.CONSTANT.PATH.CODE = _REQUEST_PATH_CODE;
uxl.CONSTANT.PATH.MESSAGE = _REQUEST_PATH_MESSAGE;

uxl.CONSTANT.CODE = {};
uxl.CONSTANT.CODE.PREFIX = _CODE_PREFIX;
uxl.CONSTANT.CODE.PARENT = _CODE_COLUMN_PARENT;
uxl.CONSTANT.CODE.CODE = _CODE_COLUMN_CODE;
uxl.CONSTANT.CODE.NAME = _CODE_COLUMN_NAME;

uxl.CONSTANT.RECOVERYCOMMAND = {};
uxl.CONSTANT.RECOVERYCOMMAND.SAVE = _SEARCH_RECOVERY_COMMAND_SAVE;
uxl.CONSTANT.RECOVERYCOMMAND.RECOVERY = _SEARCH_RECOVERY_COMMAND_RECOVERY;
uxl.CONSTANT.RECOVERYCOMMAND.CLEAR = _SEARCH_RECOVERY_COMMAND_CLEAR;

uxl.CONSTANT.CALL_LAYOUT = _CALL_LAYOUT;

uxl.CONSTANT.FORM = {};
uxl.CONSTANT.FORM.SEARCH = _FORM_SEARCH;
uxl.CONSTANT.FORM.DETAIL = _FORM_DETAIL;

uxl.CONSTANT.BUTTON = {};
uxl.CONSTANT.BUTTON.SEARCH = _BUTTON_SEARCH;
uxl.CONSTANT.BUTTON.NEW = _BUTTON_NEW;
uxl.CONSTANT.BUTTON.LIST = _BUTTON_LIST;
uxl.CONSTANT.BUTTON.INSERT = _BUTTON_INSERT;
uxl.CONSTANT.BUTTON.UPDATE = _BUTTON_UPDATE;
uxl.CONSTANT.BUTTON.DELETE = _BUTTON_DELETE;
uxl.CONSTANT.BUTTON.REQUEST = _BUTTON_REQUEST;
uxl.CONSTANT.BUTTON.CONFIRM = _BUTTON_CONFIRM;
uxl.CONSTANT.BUTTON.COMPLETE = _BUTTON_COMPLETE;
uxl.CONSTANT.BUTTON.CANCEL = _BUTTON_CANCEL;
uxl.CONSTANT.BUTTON.IMPORT = _BUTTON_IMPORT;
uxl.CONSTANT.BUTTON.EXPORT = _BUTTON_EXPORT;

uxl.CONSTANT.SECURITY = {};
uxl.CONSTANT.SECURITY.TOKEN = _SECURITY_KEY_TOKEN;
uxl.CONSTANT.SECURITY.ENABLED = _SECURITY_SERVICE_ENABLED;


(function($) {

	uxl.readyList = [];
	
	uxl.readySecondaryList = [];

	uxl.readyCompleteList = [];
	
	/**
	 * 페이지에 이미지등을 제외한 모든 엘리먼트가 로딩된 다음 처리할 초기화 함수를 지정한다.
	 * @param {Function} 초기화시 호출될 함수
	 * @return 없음
	 */
	uxl.onLoad = function(fn) {
		if(jQuery.isReady) {
			$(fn);
		}
		else {
			uxl.readyList.push(fn);
		}
	};
	
	/**
	 * 페이지에 이미지등을 제외한 모든 엘리먼트가 로딩된 다음 처리할 초기화 함수를 지정한다.
	 * @param {Function} 초기화시 호출될 함수
	 * @return 없음
	 */
	uxl.onLoadSecondary = function(fn) {
		if(jQuery.isReady) {
			$(fn);
		}
		else {
			uxl.readySecondaryList.push(fn);
		}
	};
	
	/**
	 * 페이지 공통 초기화 작업 완료후 실행될 함수를 지정한다.
	 * @param {Function} 초기화시 호출될 함수
	 * @return 없음
	 */
	uxl.onLoadComplete = function(fn) {
		if(jQuery.isReady) {
			$(fn);
		}
		else {
			uxl.readyCompleteList.push(fn);
		}
	};
	
	/**
	 * 초기화 함수 호출
	 * @return 없음
	 */
	uxl.callLoad = function() {
		$.each(uxl.readyList, function(index, item) {
			try {
				this.call(document, jQuery);
			}
			catch(e) {
				uxl.error('error occured in documnet ready function[uxl.onLoad];\n' + e.message, e);
				throw e;		
			}
		});
	};
	
	/**
	 * 초기화 함수 호출
	 * @return 없음
	 */
	uxl.callLoadSecondary = function() {
		$.each(uxl.readySecondaryList, function(index, item) {
			try {
				this.call(document, jQuery);
			}
			catch(e) {
				uxl.error('error occured in documnet ready secondary function[uxl.onLoadSecondary];\n' + e.message, e);
			}
		});
	};
	
	/**
	 * 초기화 완료 함수 호출
	 * @return 없음
	 */
	uxl.callLoadComplete = function() {
		$.each(uxl.readyCompleteList, function(index, item) {
			try {
				this.call(document, jQuery);
			}
			catch(e) {
				uxl.error('error occured in documnet ready complete function[uxl.onLoadComplete];\n' + e.message, e);
			}
		});
	};
	
	/**
	 * 페이지의 언어를 변경하는 함수
	 */
	uxl.changeLocale = function(lang){
		$.ajax({
			url: uxl.getScreenURL() + "?app_lang="+lang,
			success: function(result){
				uxl.reload(document, true);
			}
		});
	};	
	
	/**
	 * 웹 컨텍스트 경로를 포함한 URL로 만들어줍니다.
	 * @param {String} 상대경로
	 * @return {String} 웹 컨텍스트 경로를 포함한 URL
	 */
	uxl.getContextURL = function (url) {
		if(uxl.isEmpty(uxl.CONSTANT.CONTEXT_ROOT)) {
			return url;
		}
		
		var re = '\\' + uxl.CONSTANT.CONTEXT_ROOT;
		var m1 = url.match(re);
		var m2 = url.match('http:');
		
		if((m1 == null || m1.index != 0) && (m2 == null || m2.index != 0)) {
			return uxl.CONSTANT.CONTEXT_ROOT + url;
		}
		return url;
	};
	
	/**
	 * 페이지 새로고침 함수
	 * @param {document} document
	 * @param {String} URL
	 * @param {boolean} 상태 표시 여부
	 */
	uxl.reload = function(doc, isStatusBar) {
		doc = doc || document;
		isStatusBar = uxl.isUndefined(isStatusBar) ? true : isStatusBar;
		
		if(isStatusBar) {
			uxl.showStatusBar(doc);
		}
		doc.location.reload();
	};
	
	/**
	 * 현재 활성화 되어 있는 화면을 닫는다.
	 */
	uxl.close = function() {
		window.close();
	};
	
	/**
	 * URL에 Layout 파라미터 정보를 추가하는 함수
	 * 
	 * 현 페이지의 파라미터에서 call_layout 이 존재할 경우 다음페이지
	 * 전환시에도 동일한 Layout으로 전환하기 위한 셋팅 처리
	 * 2012-05-17 kang0252
	 */
	uxl.setLayoutParameter = function(url){
		if(!uxl.isEmpty(_CALL_LAYOUT_PARAM)){
			if(url.indexOf(_CALL_LAYOUT) == -1){
				url = uxl.addQueryToUrl(url, uxl.CONSTANT.CALL_LAYOUT, _CALL_LAYOUT_PARAM);
			}
		}
		return url;
	};
	
	/**
	 * 페이지 이동 함수
	 * @param {String} URL
	 * @param {document} document
	 * @param {boolean} 상태 표시 여부
	 */
	uxl.moveLocation = function(url, doc, isStatusBar) {		
		url = uxl.isScreenId(url) ? uxl.getScreenURL(url) : url;		
		doc = doc || document;
		if($('body', doc).size() == 0){
			doc = doc.document;
			if($('body', doc).size() == 0){
				//빠르게 마구 누를 때 아래 주석된 alert 메세지가 호출 되는 경우가 발생합니다.(김태완)
				//alert('uxl.moveLocation의 doc 파라미터가 document or Window 인스턴스가 아닙니다.\호출 코딩을 확인해주세요.');
				return;
			}
		}
		
		isStatusBar = uxl.isUndefined(isStatusBar) ? true : isStatusBar;
		if(isStatusBar) {			
			uxl.showStatusBar(doc);
		}

		url = uxl.setLayoutParameter(url);
		doc.location.href = url;
	};
	
	/**
	 * URL에서 HostString을 추출하는 함수
	 * 예) http://localhost:8080/screen/SCO0001.ub?p1=test&p2=test2
	 *    --> return value => http://localhost:8080/screen/SCO0001.ub
	 * @param {String} URL
	 */
	uxl.getUrlHostString = function(url){
		if(url.indexOf("?") > -1){
			return url.substr(0, url.indexOf("?"));
		}else{
			return url;
		}
	};

	/**
	 * URL에서 QueryString을 추출하는 함수
	 * 예) http://localhost:8080/screen/SCO0001.ub?p1=test&p2=test2
	 *    --> return value => p1=test&p2=test2
	 * @param {String} URL
	 */
	uxl.getUrlQueryString = function(url){
		if(url.indexOf("?") > -1){
			return url.substr(url.indexOf("?")+1);
		}
		return "";
	};
	
	/**
	 * 목록으로 복귀 함수(이전 검색결과를 유지한 목록으로 복귀)
	 *  - 현재 Window의 Name을 복구 키값을 리턴한다.
	 * @param {String} URL
	 * @param {document} document
	 * @param {boolean} 상태 표시 여부
	 */
	uxl.returnToList = function(url, doc, isStatusBar) {		
		url = uxl.isScreenId(url) ? uxl.getScreenURL(url) : url;
		url = uxl.addQueryToUrl(url, uxl.CONSTANT.KEY.RECOVERY, uxl.CONSTANT.RECOVERYCOMMAND.RECOVERY);		
		url = uxl.addQueryToUrl(url, "_window_name", window.name);		
		uxl.moveLocation(url, doc, isStatusBar);
	};
	
	uxl.popupRegistry = [];
	/**
	 * 팝업 함수
	 * @param {String} target
	 * @param {String} URL or screen id
	 * @param {json} Options
	 *            location, menubar, resizable, resizable, scrollbars, status, titlebar 는 [yes,no]로 설정
	 *            height, width, top, left 는 [픽셀로 설정]
	 *            ex)  {resizable:yes,width:300,height:400}   
	 * @param {Function} 팝업창으로 부터 데이타 전송시 실행될 함수, 팝업창으로 전달받은 data를 함수 인자로 받는다.
	 * 
	 */
	uxl.openWindow = function(target, url, option, listner) {
		target = (target || 'Popup').replace(".", "");			
		if(option.resizable == 'yes') {
			url = uxl.addQueryToUrl(url , 'popup_resizable', 'yes');
		}
		
		if(uxl.popupRegistry[target] == null 
				|| uxl.popupRegistry[target].win == null
				|| uxl.popupRegistry[target].win.closed) {
			url = uxl.isScreenId(url) ? uxl.getScreenURL(url) : url;
			
			option = $.extend({
				top: -1, left: -1,
				location: 'no', menubar: 'no', resizable: 'no', scrollbars: 'no', status: 'no', titlebar: 'no',
				height: 400, width: 600
			}, option || {});
			
			if(option.top < 0) {
				// fixed bugs : 1.2.2 : Set position center of screen height. 
				if(uxl.isString(option.height)){
					option.height = option.height.replace('px', '');
					option.height = parseInt(option.height, 10);
				}
				option.top = (screen.availHeight / 2 - option.height / 2);
			}
			if(option.left < 0) {
				// fixed bugs : 1.2.2 : Set position center of screen width.
				if(uxl.isString(option.width)){
//					option.height = option.height.replace('px', '');
					option.height = parseInt(option.width, 10);
				}
				option.left = (screen.availWidth / 2 - option.width / 2);
			}
			
			var param = '';
			for(op in option) {
				param += op + '=' +  option[op] + ',';
			}
			
			var pop = window.open(url, target, param);
			return uxl.popupRegistry[target] = {
				win: pop,
				listner: listner || $.noop
			};
		}
		else {
			
			uxl.moveLocation(url, uxl.popupRegistry[target].win, false);
			uxl.popupRegistry[target].win.focus();
			return uxl.popupRegistry[target];
		}
		
	};

	/**
	 * 부모창으로 데이터를 전송한다.
	 * 팝업 오픈시 등록된 리스너 이벤트를 실행하여 부모창으로 데이타 전송. 
	 * @param {data} 부모창으로 전송할 데이타 객체
	 */
	uxl.pushToParent = function(data) {
		var registry = null;
		try {
			if(self.opener && self.opener.uxl && self.opener.uxl.popupRegistry) {
				registry = self.opener.uxl.popupRegistry;
			}
			else {
				return;
			}
		}
		catch (e) {
			return;
		}
		
		for(var name in registry) {
			if(name == self.name) {
				registry[name].listner(data);
			}
		}
	};
	
	/**
	 * 모달 팝업 함수
	 * @param {String} target
	 * @param {String} URL or screen id
	 * @param {json} Options
	 *            center, resizable, scroll, status 는 [yes,no]로 설정
	 *            dialogHeight, dialogWidth, dialogtop, dialogleft 는 [픽셀로 설정]
	 *            ex)  {center:'yes',resizable: 'no',dialogHeight:400,dialogWidth:600}   
	 * @param {Function} 팝업창으로 부터 데이타 전송시 실행될 함수, 팝업창으로 전달받은 data를 함수 인자로 받는다.
	 * 
	 */
	uxl.openModalWindow = function(target, url, option, listner) {
		target = (target || 'Popup').replace(".", "");
			url = uxl.isScreenId(url) ? uxl.getScreenURL(url) : url;
			option = $.extend({
				dialogWidth:'600px',
				dialogHeight:'400px', 
				center:'yes',
				resizable: 'yes', 
				scroll: 'no', 
				status: 'no'
			}, option || {});
			
			var param = '';
			for(op in option) {
				param += op + '=' +  option[op] + ';';
			}
			var returnValue = window.showModalDialog(url, target, param);
			if(listner) listner(returnValue);
			
	};
	
	
	/**
	 * 화면 호출 URL을 만들어줍니다.
	 * @param {String} 요청할 화면 ID
	 * @param {String} 요청할 화면의 레이아웃
	 * @return {String} 화면을 호출하기 위한 URL
	 */
	uxl.getScreenURL = function(id, layout) {
		if(uxl.isBlank(id)) {
			id = _SCREEN_ID;
		}
		
		var url = uxl.getContextURL('/' + uxl.CONSTANT.PATH.SCREEN + '/' + id + '.' + uxl.CONSTANT.URL_EXTENTION);
		if(uxl.isEmpty(layout)) {
			return url;
		}else{
			return uxl.addQueryToUrl(url, uxl.CONSTANT.CALL_LAYOUT, layout);
		}
	};
	
	/**
	 * 화면 ID 여부 조사
	 * @param {String} 조사 대상 문자열
	 * @return {Boolean} true 화면ID 패턴일 경우
	 */
	uxl.isScreenId = function(path) {
		if(uxl.isBlank(path)) {
			return false;
		}
		
		return /^[A-Z]{3}[0-9]{4}/.test(path);
	};
	
	/**
	 * 화면 요청 URL 여부 조사
	 * @param {String} 조사 URL
	 * @return {Boolean} true 서비스 요청 URL 패턴일 경우
	 */
	uxl.isScreenRequestPath = function(path) {
		if(uxl.isBlank(path)) {
			return false;
		}
		
		var screenPath = uxl.getContextURL('/' + uxl.CONSTANT.PATH.SCREEN + '/');
		return path.match(screenPath);
	};
	
	/**
	 * URL로 부터 화면 ID 추출
	 * @param {String} URL
	 * @return {String} 화면 ID
	 */
	uxl.getScreenIdFromPath = function(path) {
		var matched = path.match(/[A-Z]{3}[0-9]{4}/);
		if(matched) {
			return matched[0];
		}
		return null;
	};
	
	/**
	 * 서비스 호출 URL을 만들어 줍니다.
	 * @param {String} 요청할 서비스 ID
	 * @param {String} 호출 확장자
	 * @return {String} 서비스를 호출하기 위한 URL
	 */
	uxl.getServiceURL = function(id, urlExtention) {
		if(uxl.isBlank(id)) {
			uxl.error('[id] argument is null (uxl.getServiceURL)');
		}
		
		urlExtention = urlExtention || uxl.CONSTANT.URL_EXTENTION;
		return uxl.getContextURL('/' + uxl.CONSTANT.PATH.SERVICE + '/' + id + '.' + urlExtention);
	};
	
	/**
	 * 서비스 ID 여부 조사
	 * @param {String} 조사 대상 문자열
	 * @return {Boolean} true 서비스 ID 패턴일 경우
	 */
	uxl.isServiceId = function(path) {
		if(uxl.isBlank(path)) {
			return false;
		}
		
		return /^SVC[A-Z]{3}[0-9]{4}/.test(path);
	};
	
	/**
	 * Function URL호출
	 * */
	uxl.getFunctionUrl = function(screenId, functionAlias, urlExtention){
		if(uxl.isBlank(screenId)) {
			uxl.error('[screenId] argument is null (uxl.getFunctionUrl)');
		}
		if(uxl.isBlank(functionAlias)) {
			uxl.error('[function Alias] argument is null (uxl.getFunctionUrl)');
		}
		urlExtention = urlExtention || uxl.CONSTANT.URL_EXTENTION;
		var url = uxl.getContextURL('/' + uxl.CONSTANT.PATH.FUNCTION + '/'+screenId+'/'+functionAlias+'.' + urlExtention);
		return url;
	};
	
	/**
	 * Function ID 여부 조사
	 * @param {String} 조사 대상 문자열
	 * @return {Boolean} true Function ID 패턴일 경우
	 */
	uxl.isFunctionId = function(path) {
		if(uxl.isBlank(path)) {
			return false;
		}
		
		return /^FNC[A-Z]{3}[0-9]{4}/.test(path);
	};
	
	/**
	 * Function ID 여부 조사
	 * @param {String} 조사 대상 문자열
	 * @return {Boolean} true Function ID 패턴일 경우
	 */
	uxl.isFunctionAlias = function(path) {
		if(uxl.isServiceId(path)) {
			return false;
		}
		if(uxl.isFunctionId(path)) {
			return false;
		}

		return /^[A-Z_0-9]{1, 9}/.test(path);
	};
	
	/**
	 * 서비스 요청 URL 여부 조사
	 * @param {String} 조사 URL
	 * @return {Boolean} true 서비스 요청 URL 패턴일 경우
	 */
	uxl.isServiceRequestPath = function(path) {
		if(uxl.isBlank(path)) {
			return false;
		}
		var servicePath = uxl.getContextURL('/' + uxl.CONSTANT.PATH.SERVICE + '/');

		return path.match(servicePath);
	};
	
	/**
	 * Function 요청 URL 여부 조사
	 * @param {String} 조사 URL
	 * @return {Boolean} true 서비스 요청 URL 패턴일 경우
	 */
	uxl.isFunctionRequestPath = function(path) {
		if(uxl.isBlank(path)) {
			return false;
		}
		var functionPath = uxl.getContextURL('/' + uxl.CONSTANT.PATH.FUNCTION + '/');
		
		return path.match(functionPath);
	};
	
	/**
	 * 코드 요청 URL 여부 조사
	 * @param {String} 조사 대상 문자열
	 * @return {Boolean} true 서비스 ID 패턴일 경우
	 */
	uxl.isCodeRequestPath = function(path) {
		if(uxl.isBlank(path)) {
			return false;
		}

		var codePath = uxl.getContextURL('/' + uxl.CONSTANT.PATH.CODE + '/');
		return path.match(codePath);
	};
	
	/**
	 * 코드 서비스 호출 URL을 만들어 줍니다.
	 * @param {String} 요청할 코드 카테고리 ID
	 * @param {String} 호출 확장자
	 * @return {String} 코드 서비스를 호출하기 위한 URL
	 */
	uxl.getCodeURL = function(codeCategoryId, urlExtention) {
		if(uxl.isBlank(codeCategoryId)) {
			uxl.error('[codeCategoryId] argument is null (uxl.getCodeURL)');
		}
		
		urlExtention = urlExtention || uxl.CONSTANT.URL_EXTENTION;
		return uxl.getContextURL('/' + uxl.CONSTANT.PATH.CODE + '/' + codeCategoryId + '.' + urlExtention);
	};
	
	/**
	 * 메세지 서비스 호출 URL을 만들어 줍니다.
	 * @param {String} 요청할 메세지 key
	 * @param {String} 호출 확장자
	 * @return {String} 메세지 서비스를 호출하기 위한 URL
	 */
	uxl.getMessageURL = function(messageKey, urlExtention) {
		if(uxl.isBlank(messageKey)) {
			uxl.error('[messageKey] argument is null (uxl.getMessageURL)');
		}
		
		urlExtention = urlExtention || uxl.CONSTANT.URL_EXTENTION;
		var url = uxl.getContextURL('/' + uxl.CONSTANT.PATH.MESSAGE + '.' + urlExtention);
		return uxl.addQueryToUrl(url, 'messageKey', messageKey);
	};
	
	/**
	 * URL에 파라미터를 추가합니다.<br/>
	 * <br/>
	 * http://localhost/root/customer.jsp?key=value와 같은 형식으로 추가합니다.<br/>
	 * <br/>
	 * @param {String} url URL
	 * @param {String} key 파라미터 키 이름
	 * @param {String} value 파라미터 값
	 * @type String
	 * @return 파라미터 키와 값이 추가된 URL
	 */
	uxl.addQueryToUrl = function(url, key, value) {
		if(url.indexOf('?') > 0) {
			url = url + '&' + encodeURIComponent(key) + '=' + encodeURIComponent(value);
		} else {
			url = url + '?' + encodeURIComponent(key) + '=' + encodeURIComponent(value);
		}
		return url;
	};
	
	/**
	 * 서비스 실행 결과 객체
	 * @param {Object} JSON Object Result
	 */
	uxl.Result = function(data) {
		var serviceMessage = null;
		if(uxl.isNull(data['result'])) {
			uxl.debug('result is undefined or null.');
		}
		else {
			var result = data['result'];
			if(uxl.isUndefined(result['serviceMessage']) || result['serviceMessage'] == null) {
				uxl.debug('result.serviceMessage is undefined or null.');
			}
			else {
				serviceMessage = result['serviceMessage'];
			}
		}
		
		this.dump = function() {
			return uxl.json2Str(result);
		};
		
		/**
		 * dataList 객체를 가져옵니다.<br/>
		 * @param {String || integer} dataListId 가져올 DataList 객체의 ID 혹은 순번
		 * @return DataList 객체
		 */
		this.getDataList = function(dataListId) {
			dataListId = dataListId || 0;
			
			if(uxl.isNull(result['dataList'])) {
				uxl.debug('result.dataList is undefined or null.');
				return null;
			}
			else {
				var dataList = null;
				if(uxl.isString(dataListId)) {
					$.each(result['dataList'], function(index, item) {
						if(item['@id'] == dataListId) {
							dataList = item;
							return false;
						}
					});
				}
				else {
					dataList = result['dataList'][dataListId];
				}
				return dataList;
			}
		};
		
		/**
		 * 상세 정보[DataList 의 첫번째 row]를 가져옵니다.<br/>
		 * @param {String || integer} dataListId 가져올 DataList 객체의 ID 혹은 순번
		 * @return 상세 정보
		 */
		this.getDetail = function(dataListId) {
			var dataList = this.getDataList(dataListId);
			if(uxl.isNull(dataList.rows)) {
				uxl.debug('dataList is empty.');
				return null;
			}
			return dataList.rows[0];
		};
		
		/*
		 * 2012.07.13 추가 조은혜
		 */
		this.getRowCount = function(dataListId) {
			dataListId = dataListId || 0;
			
			if(uxl.isNull(result['dataList'])) {
				uxl.debug('result.dataList is undefined or null.');
				return null;
			}
			else {
				var rowCount = 0;
				$.each(result['dataList'], function(index, item) {
					rowCount = item['rowCount'];
				});
				
				return rowCount;
			}
		};
		
		/**
		 * 지정한 컬럼의 row를 String 배열로 리턴한다.
		 * @param dataListId DataList Id
		 * @param columnName ColumnName
		 * 예제)
		 *    result.getColsData('DATA_LIST_ID', 'COL1')                = [10, 20, 30, .... 90]
		 */
		this.getColData = function(dataListId, columnName){
			var rtnValue = [];
			var dataList = this.getDataList(dataListId);
			if(uxl.isNotNull(dataList.rows)){
				for(var i=0; i<dataList.rows.length; i++){
					rtnValue.push(dataList.rows[i][columnName]);
				}
			}
			return rtnValue;
		};
		
		/**
		 * 여러개 컬럼의 row를 String 배열로 리턴한다.
		 * @param dataListId DataList Id
		 * @param columnNames ColumnNames
		 * 예제) 
		 *    result.getColsData('DATA_LIST_ID', 'COL1')                = [[10], [20], [30], .... [90]]
		 *    result.getColsData('DATA_LIST_ID', 'COL1', 'COL2')        = [[10,11], [20, 21] ... [90,91]] 
		 */
		this.getMultiColData = function(dataListId){
			var rtnValue = [];
			var columnNames = arguments;
			var dataList = this.getDataList(dataListId);
			if(uxl.isNotNull(dataList.rows)){
				for(var i=0; i<dataList.rows.length; i++){
				    var pushData = [];
				    for(var j=1; j<columnNames.length; j++){
				        pushData[pushData.length] = dataList.rows[i][columnNames[j]];
				    }
					rtnValue.push(pushData);
				}
			}
			return rtnValue;
		};		
		
		/**
		 * serviceMessage 객체를 가져옵니다.<br/>
		 * @return serviceMessage 객체
		 */
		this.getServiceMessage = function() {
			return serviceMessage;
		};
		
		/**
		 * message 문자열을 가져옵니다.<br/>
		 * @return message 문자열
		 */
		this.getMessage = function() {
			if(serviceMessage == null ||
					uxl.isNull(serviceMessage['message'])) {
				return null;
			}
			return serviceMessage['message'];
		};
		
		/**
		 * service id 문자열을 가져옵니다.<br/>
		 * @return message 문자열
		 */
		this.getServiceId = function() {
			if(serviceMessage == null ||
					uxl.isNull(serviceMessage['serviceId'])) {
				return null;
			}
			return serviceMessage['serviceId'];
		};
		
		/**
		 * service error id 문자열을 가져옵니다.<br/>
		 * @return message 문자열
		 */
		this.getServiceErrorId = function() {
			if(serviceMessage == null ||
					uxl.isNull(serviceMessage['serviceErrorId'])) {
				return 0;
			}
			return serviceMessage['serviceErrorId'];
		};
		
		/**
		 * error type(예외클래스명) 문자열을 가져옵니다.<br/>
		 * @return message 문자열
		 */
		this.getErrorType = function() {
			if(serviceMessage == null ||
					uxl.isNull(serviceMessage['errorType'])) {
				return null;
			}
			return serviceMessage['errorType'];
		};
		
		/**
		 * 결과 키 배열을 가져옵니다.<br/>
		 * @return 결과 키 배열
		 */
		this.getResultKey = function() {
			if(serviceMessage == null
					|| uxl.isNull(serviceMessage['resultKey'])) {
				return null;
			}
			if(uxl.isString(serviceMessage['resultKey'])) {
				return [serviceMessage['resultKey']];
			}
			return serviceMessage['resultKey'];
		};
		
		/**
		 * 결과 건수를 가져옵니다.<br/>
		 * @return 결과 건수
		 */
		this.getResultCount = function() {
			if(serviceMessage == null
					|| uxl.isNull(serviceMessage['resultCount'])) {
				return -1;
			}
			return serviceMessage['resultCount'];
		};
		
		/**
		 * 성공 여부를 가져옵니다.<br/>
		 * @return 성공여부
		 */
		this.isSuccess = function() {
			if(serviceMessage == null
					|| uxl.isNull(serviceMessage['resultStatus'])) {
				return false;
			}
			return serviceMessage['resultStatus'] == 'Success';
		};
	};

	/**
	 * IFrame을 동적으로 삭제시(코딩으로) IE/Cherome 등 메모리 누수(Memory Leak)현상 발생함.
	 * 코딩으로 삭제할 경우 uxl.removeIframe을 사용하여 삭제하면 메모리 누수현상이 해결됨.
	 * 1.2.0 
	 */
	uxl.removeIframe = function(iframe){
		var $iframe = $(iframe);
		
		try{
			// Upload 객체 초기화 함수
			$iframe[0].contentWindow.uxl.ext.UploadDestroyAll();		
		}catch(e){};
		
		$iframe[0].src = "about:blank";
		$iframe[0].contentWindow.document.innerHTML = '';
		$iframe.remove();		
	};
	
})(jQuery);