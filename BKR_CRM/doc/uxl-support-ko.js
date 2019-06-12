/** 
 * @fileoverview UBONE X-Library  
 *
 * @author (주)유비원 제품지원파트
 * @version 1.0 
 */

/**
 * @namespace UBONE X-Library
*/
function uxl(){}

/** 
 * uxl의 버전
 * @type String
*/
uxl.version = "1.0.0";


//********************************
//			Constant 
//********************************


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


//********************************
//CORE 
//********************************

/**
 * 페이지에 이미지등을 제외한 모든 엘리먼트가 로딩된 다음 처리할 초기화 함수를 지정한다.
 * @param {Function} 초기화시 호출될 함수
 * @return 없음
 */
uxl.onLoad = function(fn){};


/**
 * 페이지에 이미지등을 제외한 모든 엘리먼트가 로딩된 다음 처리할 초기화 함수를 지정한다.
 * @param {Function} 초기화시 호출될 함수
 * @return 없음
 */
uxl.onLoadSecondary = function(fn){};



/**
 * 페이지 공통 초기화 작업 완료후 실행될 함수를 지정한다.
 * @param {Function} 초기화시 호출될 함수
 * @return 없음
 */
uxl.onLoadComplete = function(fn){};



/**
 * 초기화 함수 호출
 * @return 없음
 */
uxl.callLoad = function(){};



/**
 * 초기화 함수 호출
 * @return 없음
 */
uxl.callLoadSecondary = function(){};


/**
 * 초기화 완료 함수 호출
 * @return 없음
 */
uxl.callLoadComplete = function(){};


/**
 * 페이지의 언어를 변경하는 함수
 */
uxl.changeLocale = function(lang){};


/**
 * 웹 컨텍스트 경로를 포함한 URL로 만들어줍니다.
 * @param {String} 상대경로
 * @return {String} 웹 컨텍스트 경로를 포함한 URL
 */
uxl.getContextURL = function (url) {};


/**
 * 페이지 새로고침 함수
 * @param {document} document
 * @param {String} URL
 * @param {boolean} 상태 표시 여부
 */
uxl.reload = function(doc, isStatusBar){};


/**
 * 현재 활성화 되어 있는 화면을 닫는다.
 */
uxl.close = function() {};


/**
 * URL에 Layout 파라미터 정보를 추가하는 함수
 * 
 * 현 페이지의 파라미터에서 call_layout 이 존재할 경우 다음페이지
 * 전환시에도 동일한 Layout으로 전환하기 위한 셋팅 처리
 * 2012-05-17 kang0252
 */
uxl.setLayoutParameter = function(url){};


/**
 * 페이지 이동 함수
 * @param {String} URL
 * @param {document} document
 * @param {boolean} 상태 표시 여부
 */
uxl.moveLocation = function(url, doc, isStatusBar){};


/**
 * URL에서 HostString을 추출하는 함수
 * 예) http://localhost:8080/screen/SCO0001.ub?p1=test&p2=test2
 *    --> return value => http://localhost:8080/screen/SCO0001.ub
 * @param {String} URL
 */
uxl.getUrlHostString = function(url){};


/**
 * URL에서 QueryString을 추출하는 함수
 * 예) http://localhost:8080/screen/SCO0001.ub?p1=test&p2=test2
 *    --> return value => p1=test&p2=test2
 * @param {String} URL
 */
uxl.getUrlQueryString = function(url){};



/**
 * 목록으로 복귀 함수(이전 검색결과를 유지한 목록으로 복귀)
 * @param {String} URL
 * @param {document} document
 * @param {boolean} 상태 표시 여부
 */
uxl.returnToList = function(url, doc, isStatusBar){};


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
uxl.openWindow = function(target, url, option, listner){};


/**
 * 부모창으로 데이터를 전송한다.
 * 팝업 오픈시 등록된 리스너 이벤트를 실행하여 부모창으로 데이타 전송. 
 * @param {data} 부모창으로 전송할 데이타 객체
 */
uxl.pushToParent = function(data){};



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
uxl.openModalWindow = function(target, url, option, listner){};


/**
 * 화면 호출 URL을 만들어줍니다.
 * @param {String} 요청할 화면 ID
 * @param {String} 요청할 화면의 레이아웃
 * @return {String} 화면을 호출하기 위한 URL
 */
uxl.getScreenURL = function(id, layout){};

/**
 * 화면 ID 여부 조사
 * @param {String} 조사 대상 문자열
 * @return {Boolean} true 화면ID 패턴일 경우
 */
uxl.isScreenId = function(path){};


/**
 * 화면 요청 URL 여부 조사
 * @param {String} 조사 URL
 * @return {Boolean} true 서비스 요청 URL 패턴일 경우
 */
uxl.isScreenRequestPath = function(path){};


/**
 * URL로 부터 화면 ID 추출
 * @param {String} URL
 * @return {String} 화면 ID
 */
uxl.getScreenIdFromPath = function(path) {};



/**
 * 서비스 호출 URL을 만들어 줍니다.
 * @param {String} 요청할 서비스 ID
 * @param {String} 호출 확장자
 * @return {String} 서비스를 호출하기 위한 URL
 */
uxl.getServiceURL = function(id, urlExtention){};


/**
 * 서비스 ID 여부 조사
 * @param {String} 조사 대상 문자열
 * @return {Boolean} true 서비스 ID 패턴일 경우
 */
uxl.isServiceId = function(path){};

/**
 * Function URL호출
 * */
uxl.getFunctionUrl = function(screenId, functionAlias, urlExtention){};



/**
 * Function ID 여부 조사
 * @param {String} 조사 대상 문자열
 * @return {Boolean} true Function ID 패턴일 경우
 */
uxl.isFunctionId = function(path){};


/**
 * Function ID 여부 조사
 * @param {String} 조사 대상 문자열
 * @return {Boolean} true Function ID 패턴일 경우
 */
uxl.isFunctionAlias = function(path){};


/**
 * 서비스 요청 URL 여부 조사
 * @param {String} 조사 URL
 * @return {Boolean} true 서비스 요청 URL 패턴일 경우
 */
uxl.isServiceRequestPath = function(path){};

/**
 * Function 요청 URL 여부 조사
 * @param {String} 조사 URL
 * @return {Boolean} true 서비스 요청 URL 패턴일 경우
 */
uxl.isFunctionRequestPath = function(path) {};

/**
 * 코드 요청 URL 여부 조사
 * @param {String} 조사 대상 문자열
 * @return {Boolean} true 서비스 ID 패턴일 경우
 */
uxl.isCodeRequestPath = function(path){};


/**
 * 코드 서비스 호출 URL을 만들어 줍니다.
 * @param {String} 요청할 코드 카테고리 ID
 * @param {String} 호출 확장자
 * @return {String} 코드 서비스를 호출하기 위한 URL
 */
uxl.getCodeURL = function(codeCategoryId, urlExtention){};


/**
 * 메세지 서비스 호출 URL을 만들어 줍니다.
 * @param {String} 요청할 메세지 key
 * @param {String} 호출 확장자
 * @return {String} 메세지 서비스를 호출하기 위한 URL
 */
uxl.getMessageURL = function(messageKey, urlExtention){};


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
uxl.addQueryToUrl = function(url, key, value){};


/**
 * 서비스 실행 결과 객체
 * @param {Object} JSON Object Result
 */
uxl.Result = function(data){};

/**
 * dataList 객체를 가져옵니다.<br/>
 * @param {String || integer} dataListId 가져올 DataList 객체의 ID 혹은 순번
 * @return DataList 객체
 */
uxl.Result.getDataList = function(dataListId){};

/**
 * 상세 정보[DataList 의 첫번째 row]를 가져옵니다.<br/>
 * @param {String || integer} dataListId 가져올 DataList 객체의 ID 혹은 순번
 * @return 상세 정보
 */
uxl.Result.getDetail = function(dataListId){};


/*
 * 2012.07.13 추가 조은혜
 */
uxl.Result.getRowCount = function(dataListId){};



/**
 * 지정한 컬럼의 row를 String 배열로 리턴한다.
 * @param dataListId DataList Id
 * @param columnName ColumnName
 * 예제)
 *    result.getColsData('DATA_LIST_ID', 'COL1')                = [10, 20, 30, .... 90]
 */
uxl.Result.getColData = function(dataListId, columnName){};


/**
 * 여러개 컬럼의 row를 String 배열로 리턴한다.
 * @param dataListId DataList Id
 * @param columnNames ColumnNames
 * 예제) 
 *    result.getColsData('DATA_LIST_ID', 'COL1')                = [[10], [20], [30], .... [90]]
 *    result.getColsData('DATA_LIST_ID', 'COL1', 'COL2')        = [[10,11], [20, 21] ... [90,91]] 
 */
uxl.Result.getMultiColData = function(dataListId){};


/**
 * serviceMessage 객체를 가져옵니다.<br/>
 * @return serviceMessage 객체
 */
uxl.Result.getServiceMessage = function(){};


/**
 * message 문자열을 가져옵니다.<br/>
 * @return message 문자열
 */
uxl.Result.getMessage = function(){};


/**
 * service id 문자열을 가져옵니다.<br/>
 * @return message 문자열
 */
uxl.Result.getServiceId = function(){};

/**
 * service error id 문자열을 가져옵니다.<br/>
 * @return message 문자열
 */
uxl.Result.getServiceErrorId = function(){};

/**
 * error type(예외클래스명) 문자열을 가져옵니다.<br/>
 * @return message 문자열
 */
uxl.Result.getErrorType = function(){};


/**
 * 결과 키 배열을 가져옵니다.<br/>
 * @return 결과 키 배열
 */
uxl.Result.getResultKey = function(){};

/**
 * 결과 건수를 가져옵니다.<br/>
 * @return 결과 건수
 */
uxl.Result.getResultCount = function(){};

/**
 * 성공 여부를 가져옵니다.<br/>
 * @return 성공여부
 */
uxl.Result.isSuccess = function(){};


//********************************
//		Form 
//********************************

/**
 * 폼을 생성한다.
 * @param {Document} doc 폼이 생성될 도큐먼트 객체
 * @param {String} name 폼 이름
 * @return {Form} 폼 엘리먼트
 */
uxl.createForm = function (doc, name){};

/**
 * Hidden 타입의 Input 엘리먼트를 추가합니다.
 * @param {Form} form 폼 객체
 * @param {String} name Input 엘리먼트 이름
 * @param {String} value Input 엘리먼트 값
 * @param {Boolean} isMultiLine 멀리라인 모드
 * @return 없음
 */
uxl.addHidden = function (form, name, value, isMultiLine){};



uxl.addValidation = function(key, fn){};


uxl.removeValidation = function(key){};

/**
 * 기본 입력 검증.<br/>
 *  - 필수 항목, 자리수 등의 기본 입력값을 검증한다.
 * @param {Form|Form Input Element|String} form 필수항목 체크를 할 폼 객체 또는 폼 객체의 이름을 지정합니다.
 * @return {Boolean} true when exist not allowed input
 * @see uxl-form-1.1.0.js
 */
uxl.validateBasicInput = function(target){};


/**
 * 필수항목을 체크합니다.<br/>
 * @param {Form|Form Input Element|String} form 필수항목 체크를 할 폼 객체 또는 폼 객체의 이름을 지정합니다.
 * @return {Boolean} 입력되지 않은 필수 항목이 있는 경우 false 를 반환합니다.
 * @see uxl-form-1.1.0.js
 */
uxl.checkRequiredFields = function(target){};

/**
 * 필수항목 에러 처리 함수 생성
 * @param {Form input element || String} error element or jquery selector statement
 * @return {Function} 
 * @see uxl-form-1.1.0.js
 */
uxl.getRequireErrorFunction = function(targetElement) {};


/**
 * 필수항목 에러 처리 함수 생성
 * @param {Form input element || String} error element or jquery selector statement
 * @return {Function} 
 * @see uxl-form-1.1.0.js
 */
uxl.getInvalidValueErrorFunction = function(targetElement) {};



/**
 * 잘못된 값 에러 처리 함수 생성
 * @param {Form input element || String} error element or jquery selector statement
 * @return {Function} 
 * @see uxl-form-1.1.0.js
 */
uxl.getNotAllowedValueErrorFunction = function(targetElement){};

/**
 * 폼 submit
 * @param {String|Form element} form name or form element
 * @param {String} screenId or target url
 * @param {String} submit target(default:_self)
 * @param {Function} 전송하기 전에 호출 할 함수. 해당 함수가 false 를 반환할 경우 취소
 * @param {boolean} 상태 표시 여부
 * @return 없음
 */
uxl.submit = function(targetForm, url, target, beforeSubmit, isStatusBar){};


/**
 * code-text 타입 관련 컨트롤 내용지우기
 * @param {String} 컨트롤명
 * @return 없음
 */	
uxl.ClearValue = function(cid){};


/**
 * UXL Page 객체
 *  - 화면의 Function 관리
 */
uxl.Page = {};


/**
 * 기능 사용 가능 여부
 * @param {String} Function ID or Function Alias
 * @return 사용 가능 여부
 */
uxl.Page.canDoit = function(functionId){};

/**
 * 사용자의 기능에 대한 권한레벨
 * @param {String} Function ID or Function Alias
 * @return 권한 레벨
 */
uxl.Page.getAuth = function(functionId){};

/**
 * 기능과 target을 연동하여 권한이 없을 경우의 처리를 실행
 * @param {String} Function ID or Function Alias
 * @param {String || element || jquery array} 기능관 연동된 target
 * @param {String || function} (hide|disable) 권한없을 경우 실행될 처리
 * @return 권한 레벨
 */
uxl.Page.syncTargetWithAuth = function(functionId, target, action){};


/**
 * Page Util
 */
uxl.Page.Util = {};

/**
 * Screen Function 객체 가져오기
 * @param {String} Function ID or Function Alias
 * @return {Object} Screen Function Object
 */
uxl.Page.Util.findScreenFunction = function(functionId) {};



/**
 * 서비스 호출에 앞서 호출될 Validator 함수 생성
 * @param {Function} 서비스 호출 전 앞단에서 실행될 검증 함수
 *                   해당 함수가 false 를 반환 할 경우 서비스 호출 취소
 *                   함수의 첫번째 매개변수로 서버로 전송될 data 객체가 전달된다
 * @param {String} confirm 메세지 or 메세지 리소스 키(리소스 키 사용시 키값앞에 '@' 접두어 필수)
 * @return {Function} 서비스 호출 검증 함수
 */
uxl.Page.Util.makeServiceValidateHandler = function(validator, confirmMessage){};



/**
 * Service 호출 완료 후 실행될 콜백 함수 생성
 * @param {Function || String} 서비스 정상 완료 후 실행될 콜백 함수 or 이동 할 화면 ID(or URL)
 *                             함수일 경우 함수의 첫번째 매개변수로 서비스 결과 객체(url.Result)가 전달된다
 * @param {Function} 서비스 실패 후 실행될 콜백 함수
 *                   응답이 에러 상황에 호출되는 콜백이 아니라 서비스 완료 후
 *                   서비스 결과 객체(url.Result)의 성공여부가 false 일 경우에 호출된다
 *                   함수의 첫번째 매개변수로 서비스 결과 객체(url.Result)가 전달된다
 * @param {String} 성공시 메세지 or 성공시 메세지 리소스 키(리소스 키 사용시 키값앞에 '@' 접두어 필수)
 * @param {String} 실패시 메세지 or 실패시 메세지 리소스 키(리소스 키 사용시 키값앞에 '@' 접두어 필수)
 * @return {Function} Service 호출 완료 콜백 함수
 */
uxl.Page.Util.makeServiceSuccessHandler = function(success, fail, successMessage, failMessage){};


/**
 * Ajax fucntion 호출
 * @param {String} ajax function call URL
 * @param {Object} 서비스 호출 시 서버로 전송할 data
 * @param {Function} 서비스 호출 전 앞단에서 실행될 검증 함수
 *                   해당 함수가 false 를 반환 할 경우 서비스 호출 취소
 *                   함수의 첫번째 매개변수로 서버로 전송될 data 객체가 전달된다
 * @param {Function} 서비스 호출 완료 후 실행될 콜백 함수
 *                   함수의 첫번째 매개변수로 서비스 결과 객체(url.Result)가 전달된다
 * @param {boolean} 비동기여부. true 일 경우 비동기 호출(생략가능, default : false)
 * @return {boolean} 서비스 호출 실행 여부
 * @return {boolean} 서비스 실행 준비 함수
 */
uxl.callFunction = function(url, option){};

/**
 * Ajax Submit 서비스 호출
 * @param {String || Form Element} 전송 폼 이름 or 전송 폼 객체
 * @param {String} ajax service call URL or Service ID
 * @param {Object} 서비스 호출 시 서버로 전송할 data
 * @param {Function} 서비스 호출 전 앞단에서 실행될 검증 함수
 *                   해당 함수가 false 를 반환 할 경우 서비스 호출 취소
 *                   함수의 첫번째 매개변수로 서버로 전송될 data 객체가 전달된다
 * @param {Function} 서비스 호출 완료 후 실행될 콜백 함수
 *                   함수의 첫번째 매개변수로 서비스 결과 객체(url.Result)가 전달된다
 * @param {boolean} 비동기여부. true 일 경우 비동기 호출(생략가능, default : false)
 * @return {boolean} 서비스 호출 실행 여부
 * @return {boolean} 서비스 실행 준비 함수
 */
uxl.callSubmitFunction = function(targetForm, url, option) {};

uxl.removeLodingDiv = function(){};

uxl.showLodingDiv = function(){};

/**
 * Ajax 화면 load
 * @param {String || Element} laoding target element id or element
 * @param {String} load contents URL or Screen ID
 * @param {Object} 호출 시 서버로 전송할 data
 * @param {Function} 로딩 완료 실행 될 콜백 함수
 * @return 없음
 */
uxl.load = function(target, url, data, completeHandler){};


/**
 * alert 창으로 메세시 대체
 * -- ActiveX 및 기타 디자인 문제로 인한 기본 메세지로 전환
 */
uxl.showMessage = function(message, fn, title){};

/**
* window.alert 대용, 사용자에게 메세지를 출력한다.
* @param {String} 사용자에게 출력할 메세지
* @return 없음
*/
uxl.showMessage1 = function(message, fn, title){};


/**
* 상태바를 보여줍니다.
* @return 없음
*/
uxl.showStatusBar = function (target){};



/**
* 상태바를 숨깁니다.
* @return 없음
*/
uxl.hideStatusBar = function (){};


/**
 * 메세지 키 여부 조사
 * @param {String} 조사 대상 문자열
 * @return {Boolean} true 메세지 키 패턴일 경우
 */
uxl.isMessageKey = function(message){};


/**
 * 메세지 가져오기
 * @param {String} 가져올 메세지 키
 * @return 없음
 */
uxl.getMessage = function(messageKey){};


uxl.showDebug = function(message, title){};

uxl.debug = function(message){};

uxl.error = function(message){};

uxl.time = function(message, since){};

uxl.time.done = function(){};

/**
 * Called to disable F1, F3, and F5.
 */
uxl.disableShortcuts = function(flag){};

/**
 * search form 의 input 항목의 엔터 입력 설정
 * @return 없음
 */
uxl.setupFormInput = function(target){};



/**
 * 버튼 UI 생성
 * @return 없음
 */
uxl.displayButton = function(target){};


/**
 * 필수 항목 표시
 * @return 없음
 */
uxl.displayRequired = function(target){};



/**
 * readOnly 항목 표시
 * @return 없음
 */
uxl.displayReadOnly = function(target){};



/**
 * selector 에 포함되어있는 input, textarea, select 엘리먼트를 모두 readOnly로 변경한다.
 * @return 없음
 */
uxl.setReadOnly = function(target){};


/**
 * input format
 * @return 없음
 */
uxl.setInputFormat = function(){};

/**
 * 달력 버튼 설정
 * @return 없음
 */
uxl.setCalandarButton = function(){};


/**
 * 연계 콤보 박스 - 부모코드 필터링
 * @param {String} 콤보박스 ID
 * @param {String} 연결 콤보박스 ID
 * @param {String} 코드 카테고리 ID or service request path. 별도 지정이 없을 경우 연결 콤보박스 ID를 코드 카테고리 ID 간주.
 * @param options
 * 		parameter - 추가 파라미터 설정
 * 		emptyOption - Empty Option 생성여부 및 초기값
 *  	unusedMapping - 맵핑제외 여부 (true / false) 
 *  		- default : false
 * @return 없음
 */
uxl.chainCombo = function(comboId, nextComboId, codeCategoryId, options){};

/**
 * 연계 콤보 박스 - 그룹코드 필터링
 * @param {String} 콤보박스 ID
 * @param {String} 연결 콤보박스 ID
 * @param {String} 코드 카테고리 ID or service request path. 별도 지정이 없을 경우 연결 콤보박스 ID를 코드 카테고리 ID 간주.
 * @param options
 * 		parameter - 추가 파라미터 설정
 * 		emptyOption - Empty Option 생성여부 및 초기값
 *  	unusedMapping - 맵핑제외 여부 (true / false) 
 *  		- default : false
 * @return 없음
 */
uxl.chainComboByGroupFilter = function(comboId, nextComboId, codeCategoryId, options){};



uxl._bindChainCombo = function(combo, nextCombo, codeCategoryId, options){};

/**
 * 코드 서비스 ajax 호출을 통해 콤보박스의 옵션 내용을 가져온다.
 * @param {String || select element} 콤보박스 ID
 * @param {String} 코드 카테고리 ID or service request path(ex:/service/SVCTST0001.ub)
 * @param options
 * 		parameter - 추가 파라미터 설정
 * 		emptyOption - Empty Option 생성여부 및 초기값
 *  	unusedMapping - 맵핑제외 여부 (true / false) 
 *  		- default : false
 * @return 없음
 */
uxl.bindComboCode = function(comboId, codeCategoryId, options){};


/**
 * 목록 마우스 오버 효과
 * @param {String} 기능 부여 대상 셀렉트 구문
 * @return 없음
 */
uxl.bindListHover = function(listSelector){};


/**
 * 목록 마우스 오버 효과 - cursor 기능 제외
 * @param {String} 기능 부여 대상 셀렉트 구문
 * @return 없음
 */
uxl.bindListHoverHighlight = function(listSelector){};


/**
 * INNER 목록 마우스 오버 효과
 * @param {String} 기능 부여 대상 셀렉트 구문
 * @return 없음
 */
uxl.bindListInnerHover = function(listSelector){};


/**
 * INNER 목록 마우스 오버 효과
 * label 에 대하여 id 값이 있으면 커서를 pointer 로 변경
 * 그렇지 않을 경우엔 일반 default cursor
 * @param {String} 기능 부여 대상 셀렉트 구문
 * @return 없음
 */
uxl.bindListInnerPartHover = function(listSelector){};

/**
 * 목록 Cell Merge 기능 적용
 * @param {String} 목록 레이아웃 id
 * @return 없음
 */
uxl.cellMerge = function(layoutId){};

/**
 * 목록 정렬기능 적용
 * @param {String} 목록 레이아웃 id
 * @param {String} 정렬 표현식 ex) '0:COLMUN_NAME1,1:COLMUN_NAME2,2:COLMUN_NAME2'
 * @param {String} 검색 form name(생략할 경우 uxl.CONSTANT.FORM.SEARCH 상수값 사용)
 * @return 없음
 */
uxl.orderTable = function(layoutId, exp, formName){};


/**
 * 특정 객체의 Blink 효과
 */
uxl.blink = function(src){};


/**
 * 서브 타이틀 링크 설정 및 폴더 폴딩 기능
 * createBookLink : true (default)
 *                  false - BookLink 생성하지 않음
 */
uxl.setSubTitleHolder = function(createBookLink){};

/**
 * MutiSelect Width 조정 함수
 */
uxl.setMultiSelectWidth = function(obj){};

/**
 * MutiSelect Combobox UI 생성
 */
uxl.setMultiSelect = function(){};

/**
 * enter key
 * @return 없음
 */
uxl.handleEnter = function (id){};

/**
 * 자동완성기능
 * @param {String || input element} 자동완성기능 적용 대상 input id or input element
 * @param {String} 자동완성 기능과 연결될 서비스 ID
 * @param {Object} 옵션 객체, jquery ui autocomplete option 참조
 *            option.dataListId : 사용할 dataList id 설정(별도 설정이 없을 경우 첫번째 dataList 사용)
 *            option.itemExtractor : dataList로부터 자동완성 목록에 사용할 핸들러(별도 설정이 없을 경우 LABEL(목록 view), VALUE(선택시 입력값) 칼럼을 사용하는 기본 추출기 사용)
 *            ex)  {dataListId:'Screen.getList', itemExtractor:function(row) {return {value:row.SCREEN_ID,label:row.SCREEN_NAME}}}
 * @return 없음
 */
uxl.autocomplete = function(element, url, option){};

/**
 * jquery 확장 : 콤보박스의 항목들을 모두 지운다.
 */
$.fn.emptySelect = function(emptyOption){};

/**
 * jquery 확장 : 주어진 배열 데이타로 콤보박스 항목을 생성한다.
 */
$.fn.loadSelect = function(optionDataArray, emptyOption , defaultValue){};



/**
 * jquery 확장 : 주어진 text, value 값을 갖는 option 을 콤보박스에 추가한다.
 */
$.fn.addOption = function(text, value){};


$.fn.displayRequired = function(){};

/**
 * jquery 확장 : 필수 항목 속성 추가
 */
$.fn.setRequired = function(flag){};


/**
 * 엘리먼트 여부를 확인합니다.
 * @param {Object} object 엘리먼트 여부를 확인할 객체
 * @return {Boolean} 엘리먼트 여부
 * @see uxl-util-1.0.0.js
 */
uxl.isElement = function(object){};


/**
 * Undefined 여부를 확인합니다.
 * @param {Object} object Undefined 여부를 확인할 객체
 * @return {Boolean} Undefined 여부: return true when object is undefined else false
 * @see uxl-util-1.0.0.js
 */
uxl.isUndefined = function(object){};

/**
 * Undefined 여부를 확인합니다.
 * @param {Object} object Undefined 여부를 확인할 객체
 * @return {Boolean} Undefined 여부 : return true when object is defined else false
 * @see uxl-util-1.0.0.js
 */
uxl.isNotUndefined = function(object){};

/**
 * null 여부를 확인합니다.
 * @param {Object} object null 여부를 확인할 객체
 * @return {Boolean} null 여부: return true when object is undefined or null else false
 * @see uxl-util-1.0.0.js
 */
uxl.isNull = function(object) {};


/**
 * null 여부를 확인합니다.
 * @param {Object} object null 여부를 확인할 객체
 * @return {Boolean} null 여부 : return true when object is defined or not null else false
 * @see uxl-util-1.0.0.js
 */
uxl.isNotNull = function(object){};

/**
 * 배열 여부를 확인합니다.
 * @param {Object} object 배열 여부를 확인할 객체
 * @return {Boolean} 배열 여부
 * @see uxl-util-1.0.0.js
 */
uxl.isArray = function(object) {};

/**
 * String 여부를 확인합니다.
 * @param {Object} object String 여부를 확인할 객체
 * @return {Boolean} String 여부
 * @see uxl-util-1.0.0.js
 */
uxl.isString = function(object){};


/**
 * Function 여부를 확인합니다.
 * @param {Object} object Function 여부를 확인할 객체
 * @return {Boolean} Function 여부
 * @see uxl-util-1.0.0.js
 */
uxl.isFunction = function(object) {};


/**
 * 숫자 여부를 확인합니다.
 * @param {Object} object 숫자 여부를 확인할 객체
 * @return {Boolean} 숫자 여부
 * @see uxl-util-1.0.0.js
 */
uxl.isNumber = function(object){};


/**
 * 문자열에서 공백(NBSP문자포함)을 제거합니다.
 * @param {String} str 공백을 제거할 문자열
 * @return {String} 공백이 제거된 문자열
 * @see uxl-util-1.0.0.js
 */
uxl.trim = function(str){};

/**
 * 빈 문자열 여부를 확인합니다.
 * @param {String} str 빈 문자열 여부를 확인할 객체
 * @return {Boolean} 빈 문자열 여부 : return true when object is undefined or null or empty string('')
 * @see uxl-util-1.0.0.js
 */
uxl.isEmpty = function(str){};


/**
 * 내용이 있는 문자열 여부를 확인합니다.
 * @param {Object} str 내용이 있는 문자열 여부를 확인할 객체
 * @return {Boolean} 내용이 있는 문자열 여부 : return true when is not empty
 * @see uxl-util-1.0.0.js
 */
uxl.isNotEmpty = function(str){};


/**
 * 공백 문자열 여부를 확인합니다.
 * @param {String} 공백문자열 여부를 확인할 문자열
 * @return {Boolean} 공백 문자열 여부. 공백 문자열일 경우 true 를 반환합니다.
 * @see uxl-util-1.0.0.js
 */
uxl.isBlank = function(str){};


/**
 * 공백 문자열 여부를 확인합니다.
 * @param {String} 공백문자열 여부를 확인할 문자열
 * @return {Boolean} 공백 문자열 여부. 공백 문자열이 아닐 경우 true 를 반환합니다.
 * @see uxl-util-1.0.0.js
 */
uxl.isNotBlank = function(str){};

/**
 * 문자열에 포함된 {0}, {1}, {2}와 같은 인수를 배열값으로 변환합니다.<br/>
 * 인수 번호의 시작은 0번입니다.<br/>
 * @param {String} str 인수가 포함된 문자열
 * @param {Array} values 배열값
 * @return {String} 배열값으로 치환된 문자열
 * @see uxl-util-1.0.0.js
 */
uxl.replaceValues = function (str, values){};

/**
 * XML 노드를 문자열로 변환합니다.
 * @param {Node} xmlNode 문자열로 변환할 XML 노드
 * @return {String} XML 노드 문자열
 * @see uxl-util-1.0.0.js
 */
uxl.xml2Str = function (xmlNode){};

/**
 * HTML 태그를 문자열로 변환합니다.
 * @param {TAG} tag 문자열로 변환할 HTML 태그
 * @return {String} HTML 태그 문자열
 * @see uxl-util-1.0.0.js
 */
uxl.tag2Str = function(tag){};

/**
 * 개행문자를 BR 태그로 변환한다.
 * @param {String} 개행문자를 포함한 문자열
 * @return {String} BR태그로 변환된 문자열
 * @see uxl-util-1.0.0.js
 */
uxl.newline2Br = function(str){};

/**
 * JSON 객체를 문자열로 변환한다.
 * @param {JSON} object 문자열로 변환할 JSON 객체
 * @return {String} JSON 객체 문자열
 * @see uxl-util-1.0.0.js
 */
uxl.json2Str =  function(object){};


/**
 * JSON 객체 문자열로 부터 json 객체로 변환하여 반환
 * @param {String} JSON 객체 문자열
 * @return {JSON} object 문자열로 변환할 JSON 객체
 * @see uxl-util-1.0.0.js
 */
uxl.str2Json = function(str){};

/**
 * JSON 객체 문자열로 부터 json 객체로 변환하여 반환
 * @param {String} JSON 객체 문자열
 * @param {String} target json 객체
 * @return {JSON} object 문자열로 변환할 JSON 객체
 * @see uxl-util-1.0.0.js
 */
uxl.str2JsonObject = function(str, target){};

uxl.null2Str = function(object){};

uxl.getCharByteSize = function (ch){};

uxl.getByteLen = function (str){};

/**
* 이메일 유효성체크
* @param {String} 메일값
* @return {Boolean} 정상 이메일 여부
* @see uxl-util-1.0.0.js
*/
uxl.isEmail = function (str){};

uxl.isDate = function (str){};


/**
 * 1,000 단위마다 콤마찍기
 */
uxl.setComma = function (str){};







