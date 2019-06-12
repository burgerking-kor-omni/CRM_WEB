/** 
 * @fileoverview UBONE X-Library  
 *
 * @author (��)����� ��ǰ������Ʈ
 * @version 1.0 
 */

/**
 * @namespace UBONE X-Library
*/
function uxl(){}

/** 
 * uxl�� ����
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
 * �������� �̹������� ������ ��� ������Ʈ�� �ε��� ���� ó���� �ʱ�ȭ �Լ��� �����Ѵ�.
 * @param {Function} �ʱ�ȭ�� ȣ��� �Լ�
 * @return ����
 */
uxl.onLoad = function(fn){};


/**
 * �������� �̹������� ������ ��� ������Ʈ�� �ε��� ���� ó���� �ʱ�ȭ �Լ��� �����Ѵ�.
 * @param {Function} �ʱ�ȭ�� ȣ��� �Լ�
 * @return ����
 */
uxl.onLoadSecondary = function(fn){};



/**
 * ������ ���� �ʱ�ȭ �۾� �Ϸ��� ����� �Լ��� �����Ѵ�.
 * @param {Function} �ʱ�ȭ�� ȣ��� �Լ�
 * @return ����
 */
uxl.onLoadComplete = function(fn){};



/**
 * �ʱ�ȭ �Լ� ȣ��
 * @return ����
 */
uxl.callLoad = function(){};



/**
 * �ʱ�ȭ �Լ� ȣ��
 * @return ����
 */
uxl.callLoadSecondary = function(){};


/**
 * �ʱ�ȭ �Ϸ� �Լ� ȣ��
 * @return ����
 */
uxl.callLoadComplete = function(){};


/**
 * �������� �� �����ϴ� �Լ�
 */
uxl.changeLocale = function(lang){};


/**
 * �� ���ؽ�Ʈ ��θ� ������ URL�� ������ݴϴ�.
 * @param {String} �����
 * @return {String} �� ���ؽ�Ʈ ��θ� ������ URL
 */
uxl.getContextURL = function (url) {};


/**
 * ������ ���ΰ�ħ �Լ�
 * @param {document} document
 * @param {String} URL
 * @param {boolean} ���� ǥ�� ����
 */
uxl.reload = function(doc, isStatusBar){};


/**
 * ���� Ȱ��ȭ �Ǿ� �ִ� ȭ���� �ݴ´�.
 */
uxl.close = function() {};


/**
 * URL�� Layout �Ķ���� ������ �߰��ϴ� �Լ�
 * 
 * �� �������� �Ķ���Ϳ��� call_layout �� ������ ��� ����������
 * ��ȯ�ÿ��� ������ Layout���� ��ȯ�ϱ� ���� ���� ó��
 * 2012-05-17 kang0252
 */
uxl.setLayoutParameter = function(url){};


/**
 * ������ �̵� �Լ�
 * @param {String} URL
 * @param {document} document
 * @param {boolean} ���� ǥ�� ����
 */
uxl.moveLocation = function(url, doc, isStatusBar){};


/**
 * URL���� HostString�� �����ϴ� �Լ�
 * ��) http://localhost:8080/screen/SCO0001.ub?p1=test&p2=test2
 *    --> return value => http://localhost:8080/screen/SCO0001.ub
 * @param {String} URL
 */
uxl.getUrlHostString = function(url){};


/**
 * URL���� QueryString�� �����ϴ� �Լ�
 * ��) http://localhost:8080/screen/SCO0001.ub?p1=test&p2=test2
 *    --> return value => p1=test&p2=test2
 * @param {String} URL
 */
uxl.getUrlQueryString = function(url){};



/**
 * ������� ���� �Լ�(���� �˻������ ������ ������� ����)
 * @param {String} URL
 * @param {document} document
 * @param {boolean} ���� ǥ�� ����
 */
uxl.returnToList = function(url, doc, isStatusBar){};


/**
 * �˾� �Լ�
 * @param {String} target
 * @param {String} URL or screen id
 * @param {json} Options
 *            location, menubar, resizable, resizable, scrollbars, status, titlebar �� [yes,no]�� ����
 *            height, width, top, left �� [�ȼ��� ����]
 *            ex)  {resizable:yes,width:300,height:400}   
 * @param {Function} �˾�â���� ���� ����Ÿ ���۽� ����� �Լ�, �˾�â���� ���޹��� data�� �Լ� ���ڷ� �޴´�.
 * 
 */
uxl.openWindow = function(target, url, option, listner){};


/**
 * �θ�â���� �����͸� �����Ѵ�.
 * �˾� ���½� ��ϵ� ������ �̺�Ʈ�� �����Ͽ� �θ�â���� ����Ÿ ����. 
 * @param {data} �θ�â���� ������ ����Ÿ ��ü
 */
uxl.pushToParent = function(data){};



/**
 * ��� �˾� �Լ�
 * @param {String} target
 * @param {String} URL or screen id
 * @param {json} Options
 *            center, resizable, scroll, status �� [yes,no]�� ����
 *            dialogHeight, dialogWidth, dialogtop, dialogleft �� [�ȼ��� ����]
 *            ex)  {center:'yes',resizable: 'no',dialogHeight:400,dialogWidth:600}   
 * @param {Function} �˾�â���� ���� ����Ÿ ���۽� ����� �Լ�, �˾�â���� ���޹��� data�� �Լ� ���ڷ� �޴´�.
 * 
 */
uxl.openModalWindow = function(target, url, option, listner){};


/**
 * ȭ�� ȣ�� URL�� ������ݴϴ�.
 * @param {String} ��û�� ȭ�� ID
 * @param {String} ��û�� ȭ���� ���̾ƿ�
 * @return {String} ȭ���� ȣ���ϱ� ���� URL
 */
uxl.getScreenURL = function(id, layout){};

/**
 * ȭ�� ID ���� ����
 * @param {String} ���� ��� ���ڿ�
 * @return {Boolean} true ȭ��ID ������ ���
 */
uxl.isScreenId = function(path){};


/**
 * ȭ�� ��û URL ���� ����
 * @param {String} ���� URL
 * @return {Boolean} true ���� ��û URL ������ ���
 */
uxl.isScreenRequestPath = function(path){};


/**
 * URL�� ���� ȭ�� ID ����
 * @param {String} URL
 * @return {String} ȭ�� ID
 */
uxl.getScreenIdFromPath = function(path) {};



/**
 * ���� ȣ�� URL�� ����� �ݴϴ�.
 * @param {String} ��û�� ���� ID
 * @param {String} ȣ�� Ȯ����
 * @return {String} ���񽺸� ȣ���ϱ� ���� URL
 */
uxl.getServiceURL = function(id, urlExtention){};


/**
 * ���� ID ���� ����
 * @param {String} ���� ��� ���ڿ�
 * @return {Boolean} true ���� ID ������ ���
 */
uxl.isServiceId = function(path){};

/**
 * Function URLȣ��
 * */
uxl.getFunctionUrl = function(screenId, functionAlias, urlExtention){};



/**
 * Function ID ���� ����
 * @param {String} ���� ��� ���ڿ�
 * @return {Boolean} true Function ID ������ ���
 */
uxl.isFunctionId = function(path){};


/**
 * Function ID ���� ����
 * @param {String} ���� ��� ���ڿ�
 * @return {Boolean} true Function ID ������ ���
 */
uxl.isFunctionAlias = function(path){};


/**
 * ���� ��û URL ���� ����
 * @param {String} ���� URL
 * @return {Boolean} true ���� ��û URL ������ ���
 */
uxl.isServiceRequestPath = function(path){};

/**
 * Function ��û URL ���� ����
 * @param {String} ���� URL
 * @return {Boolean} true ���� ��û URL ������ ���
 */
uxl.isFunctionRequestPath = function(path) {};

/**
 * �ڵ� ��û URL ���� ����
 * @param {String} ���� ��� ���ڿ�
 * @return {Boolean} true ���� ID ������ ���
 */
uxl.isCodeRequestPath = function(path){};


/**
 * �ڵ� ���� ȣ�� URL�� ����� �ݴϴ�.
 * @param {String} ��û�� �ڵ� ī�װ� ID
 * @param {String} ȣ�� Ȯ����
 * @return {String} �ڵ� ���񽺸� ȣ���ϱ� ���� URL
 */
uxl.getCodeURL = function(codeCategoryId, urlExtention){};


/**
 * �޼��� ���� ȣ�� URL�� ����� �ݴϴ�.
 * @param {String} ��û�� �޼��� key
 * @param {String} ȣ�� Ȯ����
 * @return {String} �޼��� ���񽺸� ȣ���ϱ� ���� URL
 */
uxl.getMessageURL = function(messageKey, urlExtention){};


/**
 * URL�� �Ķ���͸� �߰��մϴ�.<br/>
 * <br/>
 * http://localhost/root/customer.jsp?key=value�� ���� �������� �߰��մϴ�.<br/>
 * <br/>
 * @param {String} url URL
 * @param {String} key �Ķ���� Ű �̸�
 * @param {String} value �Ķ���� ��
 * @type String
 * @return �Ķ���� Ű�� ���� �߰��� URL
 */
uxl.addQueryToUrl = function(url, key, value){};


/**
 * ���� ���� ��� ��ü
 * @param {Object} JSON Object Result
 */
uxl.Result = function(data){};

/**
 * dataList ��ü�� �����ɴϴ�.<br/>
 * @param {String || integer} dataListId ������ DataList ��ü�� ID Ȥ�� ����
 * @return DataList ��ü
 */
uxl.Result.getDataList = function(dataListId){};

/**
 * �� ����[DataList �� ù��° row]�� �����ɴϴ�.<br/>
 * @param {String || integer} dataListId ������ DataList ��ü�� ID Ȥ�� ����
 * @return �� ����
 */
uxl.Result.getDetail = function(dataListId){};


/*
 * 2012.07.13 �߰� ������
 */
uxl.Result.getRowCount = function(dataListId){};



/**
 * ������ �÷��� row�� String �迭�� �����Ѵ�.
 * @param dataListId DataList Id
 * @param columnName ColumnName
 * ����)
 *    result.getColsData('DATA_LIST_ID', 'COL1')                = [10, 20, 30, .... 90]
 */
uxl.Result.getColData = function(dataListId, columnName){};


/**
 * ������ �÷��� row�� String �迭�� �����Ѵ�.
 * @param dataListId DataList Id
 * @param columnNames ColumnNames
 * ����) 
 *    result.getColsData('DATA_LIST_ID', 'COL1')                = [[10], [20], [30], .... [90]]
 *    result.getColsData('DATA_LIST_ID', 'COL1', 'COL2')        = [[10,11], [20, 21] ... [90,91]] 
 */
uxl.Result.getMultiColData = function(dataListId){};


/**
 * serviceMessage ��ü�� �����ɴϴ�.<br/>
 * @return serviceMessage ��ü
 */
uxl.Result.getServiceMessage = function(){};


/**
 * message ���ڿ��� �����ɴϴ�.<br/>
 * @return message ���ڿ�
 */
uxl.Result.getMessage = function(){};


/**
 * service id ���ڿ��� �����ɴϴ�.<br/>
 * @return message ���ڿ�
 */
uxl.Result.getServiceId = function(){};

/**
 * service error id ���ڿ��� �����ɴϴ�.<br/>
 * @return message ���ڿ�
 */
uxl.Result.getServiceErrorId = function(){};

/**
 * error type(����Ŭ������) ���ڿ��� �����ɴϴ�.<br/>
 * @return message ���ڿ�
 */
uxl.Result.getErrorType = function(){};


/**
 * ��� Ű �迭�� �����ɴϴ�.<br/>
 * @return ��� Ű �迭
 */
uxl.Result.getResultKey = function(){};

/**
 * ��� �Ǽ��� �����ɴϴ�.<br/>
 * @return ��� �Ǽ�
 */
uxl.Result.getResultCount = function(){};

/**
 * ���� ���θ� �����ɴϴ�.<br/>
 * @return ��������
 */
uxl.Result.isSuccess = function(){};


//********************************
//		Form 
//********************************

/**
 * ���� �����Ѵ�.
 * @param {Document} doc ���� ������ ��ť��Ʈ ��ü
 * @param {String} name �� �̸�
 * @return {Form} �� ������Ʈ
 */
uxl.createForm = function (doc, name){};

/**
 * Hidden Ÿ���� Input ������Ʈ�� �߰��մϴ�.
 * @param {Form} form �� ��ü
 * @param {String} name Input ������Ʈ �̸�
 * @param {String} value Input ������Ʈ ��
 * @param {Boolean} isMultiLine �ָ����� ���
 * @return ����
 */
uxl.addHidden = function (form, name, value, isMultiLine){};



uxl.addValidation = function(key, fn){};


uxl.removeValidation = function(key){};

/**
 * �⺻ �Է� ����.<br/>
 *  - �ʼ� �׸�, �ڸ��� ���� �⺻ �Է°��� �����Ѵ�.
 * @param {Form|Form Input Element|String} form �ʼ��׸� üũ�� �� �� ��ü �Ǵ� �� ��ü�� �̸��� �����մϴ�.
 * @return {Boolean} true when exist not allowed input
 * @see uxl-form-1.1.0.js
 */
uxl.validateBasicInput = function(target){};


/**
 * �ʼ��׸��� üũ�մϴ�.<br/>
 * @param {Form|Form Input Element|String} form �ʼ��׸� üũ�� �� �� ��ü �Ǵ� �� ��ü�� �̸��� �����մϴ�.
 * @return {Boolean} �Էµ��� ���� �ʼ� �׸��� �ִ� ��� false �� ��ȯ�մϴ�.
 * @see uxl-form-1.1.0.js
 */
uxl.checkRequiredFields = function(target){};

/**
 * �ʼ��׸� ���� ó�� �Լ� ����
 * @param {Form input element || String} error element or jquery selector statement
 * @return {Function} 
 * @see uxl-form-1.1.0.js
 */
uxl.getRequireErrorFunction = function(targetElement) {};


/**
 * �ʼ��׸� ���� ó�� �Լ� ����
 * @param {Form input element || String} error element or jquery selector statement
 * @return {Function} 
 * @see uxl-form-1.1.0.js
 */
uxl.getInvalidValueErrorFunction = function(targetElement) {};



/**
 * �߸��� �� ���� ó�� �Լ� ����
 * @param {Form input element || String} error element or jquery selector statement
 * @return {Function} 
 * @see uxl-form-1.1.0.js
 */
uxl.getNotAllowedValueErrorFunction = function(targetElement){};

/**
 * �� submit
 * @param {String|Form element} form name or form element
 * @param {String} screenId or target url
 * @param {String} submit target(default:_self)
 * @param {Function} �����ϱ� ���� ȣ�� �� �Լ�. �ش� �Լ��� false �� ��ȯ�� ��� ���
 * @param {boolean} ���� ǥ�� ����
 * @return ����
 */
uxl.submit = function(targetForm, url, target, beforeSubmit, isStatusBar){};


/**
 * code-text Ÿ�� ���� ��Ʈ�� ���������
 * @param {String} ��Ʈ�Ѹ�
 * @return ����
 */	
uxl.ClearValue = function(cid){};


/**
 * UXL Page ��ü
 *  - ȭ���� Function ����
 */
uxl.Page = {};


/**
 * ��� ��� ���� ����
 * @param {String} Function ID or Function Alias
 * @return ��� ���� ����
 */
uxl.Page.canDoit = function(functionId){};

/**
 * ������� ��ɿ� ���� ���ѷ���
 * @param {String} Function ID or Function Alias
 * @return ���� ����
 */
uxl.Page.getAuth = function(functionId){};

/**
 * ��ɰ� target�� �����Ͽ� ������ ���� ����� ó���� ����
 * @param {String} Function ID or Function Alias
 * @param {String || element || jquery array} ��ɰ� ������ target
 * @param {String || function} (hide|disable) ���Ѿ��� ��� ����� ó��
 * @return ���� ����
 */
uxl.Page.syncTargetWithAuth = function(functionId, target, action){};


/**
 * Page Util
 */
uxl.Page.Util = {};

/**
 * Screen Function ��ü ��������
 * @param {String} Function ID or Function Alias
 * @return {Object} Screen Function Object
 */
uxl.Page.Util.findScreenFunction = function(functionId) {};



/**
 * ���� ȣ�⿡ �ռ� ȣ��� Validator �Լ� ����
 * @param {Function} ���� ȣ�� �� �մܿ��� ����� ���� �Լ�
 *                   �ش� �Լ��� false �� ��ȯ �� ��� ���� ȣ�� ���
 *                   �Լ��� ù��° �Ű������� ������ ���۵� data ��ü�� ���޵ȴ�
 * @param {String} confirm �޼��� or �޼��� ���ҽ� Ű(���ҽ� Ű ���� Ű���տ� '@' ���ξ� �ʼ�)
 * @return {Function} ���� ȣ�� ���� �Լ�
 */
uxl.Page.Util.makeServiceValidateHandler = function(validator, confirmMessage){};



/**
 * Service ȣ�� �Ϸ� �� ����� �ݹ� �Լ� ����
 * @param {Function || String} ���� ���� �Ϸ� �� ����� �ݹ� �Լ� or �̵� �� ȭ�� ID(or URL)
 *                             �Լ��� ��� �Լ��� ù��° �Ű������� ���� ��� ��ü(url.Result)�� ���޵ȴ�
 * @param {Function} ���� ���� �� ����� �ݹ� �Լ�
 *                   ������ ���� ��Ȳ�� ȣ��Ǵ� �ݹ��� �ƴ϶� ���� �Ϸ� ��
 *                   ���� ��� ��ü(url.Result)�� �������ΰ� false �� ��쿡 ȣ��ȴ�
 *                   �Լ��� ù��° �Ű������� ���� ��� ��ü(url.Result)�� ���޵ȴ�
 * @param {String} ������ �޼��� or ������ �޼��� ���ҽ� Ű(���ҽ� Ű ���� Ű���տ� '@' ���ξ� �ʼ�)
 * @param {String} ���н� �޼��� or ���н� �޼��� ���ҽ� Ű(���ҽ� Ű ���� Ű���տ� '@' ���ξ� �ʼ�)
 * @return {Function} Service ȣ�� �Ϸ� �ݹ� �Լ�
 */
uxl.Page.Util.makeServiceSuccessHandler = function(success, fail, successMessage, failMessage){};


/**
 * Ajax fucntion ȣ��
 * @param {String} ajax function call URL
 * @param {Object} ���� ȣ�� �� ������ ������ data
 * @param {Function} ���� ȣ�� �� �մܿ��� ����� ���� �Լ�
 *                   �ش� �Լ��� false �� ��ȯ �� ��� ���� ȣ�� ���
 *                   �Լ��� ù��° �Ű������� ������ ���۵� data ��ü�� ���޵ȴ�
 * @param {Function} ���� ȣ�� �Ϸ� �� ����� �ݹ� �Լ�
 *                   �Լ��� ù��° �Ű������� ���� ��� ��ü(url.Result)�� ���޵ȴ�
 * @param {boolean} �񵿱⿩��. true �� ��� �񵿱� ȣ��(��������, default : false)
 * @return {boolean} ���� ȣ�� ���� ����
 * @return {boolean} ���� ���� �غ� �Լ�
 */
uxl.callFunction = function(url, option){};

/**
 * Ajax Submit ���� ȣ��
 * @param {String || Form Element} ���� �� �̸� or ���� �� ��ü
 * @param {String} ajax service call URL or Service ID
 * @param {Object} ���� ȣ�� �� ������ ������ data
 * @param {Function} ���� ȣ�� �� �մܿ��� ����� ���� �Լ�
 *                   �ش� �Լ��� false �� ��ȯ �� ��� ���� ȣ�� ���
 *                   �Լ��� ù��° �Ű������� ������ ���۵� data ��ü�� ���޵ȴ�
 * @param {Function} ���� ȣ�� �Ϸ� �� ����� �ݹ� �Լ�
 *                   �Լ��� ù��° �Ű������� ���� ��� ��ü(url.Result)�� ���޵ȴ�
 * @param {boolean} �񵿱⿩��. true �� ��� �񵿱� ȣ��(��������, default : false)
 * @return {boolean} ���� ȣ�� ���� ����
 * @return {boolean} ���� ���� �غ� �Լ�
 */
uxl.callSubmitFunction = function(targetForm, url, option) {};

uxl.removeLodingDiv = function(){};

uxl.showLodingDiv = function(){};

/**
 * Ajax ȭ�� load
 * @param {String || Element} laoding target element id or element
 * @param {String} load contents URL or Screen ID
 * @param {Object} ȣ�� �� ������ ������ data
 * @param {Function} �ε� �Ϸ� ���� �� �ݹ� �Լ�
 * @return ����
 */
uxl.load = function(target, url, data, completeHandler){};


/**
 * alert â���� �޼��� ��ü
 * -- ActiveX �� ��Ÿ ������ ������ ���� �⺻ �޼����� ��ȯ
 */
uxl.showMessage = function(message, fn, title){};

/**
* window.alert ���, ����ڿ��� �޼����� ����Ѵ�.
* @param {String} ����ڿ��� ����� �޼���
* @return ����
*/
uxl.showMessage1 = function(message, fn, title){};


/**
* ���¹ٸ� �����ݴϴ�.
* @return ����
*/
uxl.showStatusBar = function (target){};



/**
* ���¹ٸ� ����ϴ�.
* @return ����
*/
uxl.hideStatusBar = function (){};


/**
 * �޼��� Ű ���� ����
 * @param {String} ���� ��� ���ڿ�
 * @return {Boolean} true �޼��� Ű ������ ���
 */
uxl.isMessageKey = function(message){};


/**
 * �޼��� ��������
 * @param {String} ������ �޼��� Ű
 * @return ����
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
 * search form �� input �׸��� ���� �Է� ����
 * @return ����
 */
uxl.setupFormInput = function(target){};



/**
 * ��ư UI ����
 * @return ����
 */
uxl.displayButton = function(target){};


/**
 * �ʼ� �׸� ǥ��
 * @return ����
 */
uxl.displayRequired = function(target){};



/**
 * readOnly �׸� ǥ��
 * @return ����
 */
uxl.displayReadOnly = function(target){};



/**
 * selector �� ���ԵǾ��ִ� input, textarea, select ������Ʈ�� ��� readOnly�� �����Ѵ�.
 * @return ����
 */
uxl.setReadOnly = function(target){};


/**
 * input format
 * @return ����
 */
uxl.setInputFormat = function(){};

/**
 * �޷� ��ư ����
 * @return ����
 */
uxl.setCalandarButton = function(){};


/**
 * ���� �޺� �ڽ� - �θ��ڵ� ���͸�
 * @param {String} �޺��ڽ� ID
 * @param {String} ���� �޺��ڽ� ID
 * @param {String} �ڵ� ī�װ� ID or service request path. ���� ������ ���� ��� ���� �޺��ڽ� ID�� �ڵ� ī�װ� ID ����.
 * @param options
 * 		parameter - �߰� �Ķ���� ����
 * 		emptyOption - Empty Option �������� �� �ʱⰪ
 *  	unusedMapping - �������� ���� (true / false) 
 *  		- default : false
 * @return ����
 */
uxl.chainCombo = function(comboId, nextComboId, codeCategoryId, options){};

/**
 * ���� �޺� �ڽ� - �׷��ڵ� ���͸�
 * @param {String} �޺��ڽ� ID
 * @param {String} ���� �޺��ڽ� ID
 * @param {String} �ڵ� ī�װ� ID or service request path. ���� ������ ���� ��� ���� �޺��ڽ� ID�� �ڵ� ī�װ� ID ����.
 * @param options
 * 		parameter - �߰� �Ķ���� ����
 * 		emptyOption - Empty Option �������� �� �ʱⰪ
 *  	unusedMapping - �������� ���� (true / false) 
 *  		- default : false
 * @return ����
 */
uxl.chainComboByGroupFilter = function(comboId, nextComboId, codeCategoryId, options){};



uxl._bindChainCombo = function(combo, nextCombo, codeCategoryId, options){};

/**
 * �ڵ� ���� ajax ȣ���� ���� �޺��ڽ��� �ɼ� ������ �����´�.
 * @param {String || select element} �޺��ڽ� ID
 * @param {String} �ڵ� ī�װ� ID or service request path(ex:/service/SVCTST0001.ub)
 * @param options
 * 		parameter - �߰� �Ķ���� ����
 * 		emptyOption - Empty Option �������� �� �ʱⰪ
 *  	unusedMapping - �������� ���� (true / false) 
 *  		- default : false
 * @return ����
 */
uxl.bindComboCode = function(comboId, codeCategoryId, options){};


/**
 * ��� ���콺 ���� ȿ��
 * @param {String} ��� �ο� ��� ����Ʈ ����
 * @return ����
 */
uxl.bindListHover = function(listSelector){};


/**
 * ��� ���콺 ���� ȿ�� - cursor ��� ����
 * @param {String} ��� �ο� ��� ����Ʈ ����
 * @return ����
 */
uxl.bindListHoverHighlight = function(listSelector){};


/**
 * INNER ��� ���콺 ���� ȿ��
 * @param {String} ��� �ο� ��� ����Ʈ ����
 * @return ����
 */
uxl.bindListInnerHover = function(listSelector){};


/**
 * INNER ��� ���콺 ���� ȿ��
 * label �� ���Ͽ� id ���� ������ Ŀ���� pointer �� ����
 * �׷��� ���� ��쿣 �Ϲ� default cursor
 * @param {String} ��� �ο� ��� ����Ʈ ����
 * @return ����
 */
uxl.bindListInnerPartHover = function(listSelector){};

/**
 * ��� Cell Merge ��� ����
 * @param {String} ��� ���̾ƿ� id
 * @return ����
 */
uxl.cellMerge = function(layoutId){};

/**
 * ��� ���ı�� ����
 * @param {String} ��� ���̾ƿ� id
 * @param {String} ���� ǥ���� ex) '0:COLMUN_NAME1,1:COLMUN_NAME2,2:COLMUN_NAME2'
 * @param {String} �˻� form name(������ ��� uxl.CONSTANT.FORM.SEARCH ����� ���)
 * @return ����
 */
uxl.orderTable = function(layoutId, exp, formName){};


/**
 * Ư�� ��ü�� Blink ȿ��
 */
uxl.blink = function(src){};


/**
 * ���� Ÿ��Ʋ ��ũ ���� �� ���� ���� ���
 * createBookLink : true (default)
 *                  false - BookLink �������� ����
 */
uxl.setSubTitleHolder = function(createBookLink){};

/**
 * MutiSelect Width ���� �Լ�
 */
uxl.setMultiSelectWidth = function(obj){};

/**
 * MutiSelect Combobox UI ����
 */
uxl.setMultiSelect = function(){};

/**
 * enter key
 * @return ����
 */
uxl.handleEnter = function (id){};

/**
 * �ڵ��ϼ����
 * @param {String || input element} �ڵ��ϼ���� ���� ��� input id or input element
 * @param {String} �ڵ��ϼ� ��ɰ� ����� ���� ID
 * @param {Object} �ɼ� ��ü, jquery ui autocomplete option ����
 *            option.dataListId : ����� dataList id ����(���� ������ ���� ��� ù��° dataList ���)
 *            option.itemExtractor : dataList�κ��� �ڵ��ϼ� ��Ͽ� ����� �ڵ鷯(���� ������ ���� ��� LABEL(��� view), VALUE(���ý� �Է°�) Į���� ����ϴ� �⺻ ����� ���)
 *            ex)  {dataListId:'Screen.getList', itemExtractor:function(row) {return {value:row.SCREEN_ID,label:row.SCREEN_NAME}}}
 * @return ����
 */
uxl.autocomplete = function(element, url, option){};

/**
 * jquery Ȯ�� : �޺��ڽ��� �׸���� ��� �����.
 */
$.fn.emptySelect = function(emptyOption){};

/**
 * jquery Ȯ�� : �־��� �迭 ����Ÿ�� �޺��ڽ� �׸��� �����Ѵ�.
 */
$.fn.loadSelect = function(optionDataArray, emptyOption , defaultValue){};



/**
 * jquery Ȯ�� : �־��� text, value ���� ���� option �� �޺��ڽ��� �߰��Ѵ�.
 */
$.fn.addOption = function(text, value){};


$.fn.displayRequired = function(){};

/**
 * jquery Ȯ�� : �ʼ� �׸� �Ӽ� �߰�
 */
$.fn.setRequired = function(flag){};


/**
 * ������Ʈ ���θ� Ȯ���մϴ�.
 * @param {Object} object ������Ʈ ���θ� Ȯ���� ��ü
 * @return {Boolean} ������Ʈ ����
 * @see uxl-util-1.0.0.js
 */
uxl.isElement = function(object){};


/**
 * Undefined ���θ� Ȯ���մϴ�.
 * @param {Object} object Undefined ���θ� Ȯ���� ��ü
 * @return {Boolean} Undefined ����: return true when object is undefined else false
 * @see uxl-util-1.0.0.js
 */
uxl.isUndefined = function(object){};

/**
 * Undefined ���θ� Ȯ���մϴ�.
 * @param {Object} object Undefined ���θ� Ȯ���� ��ü
 * @return {Boolean} Undefined ���� : return true when object is defined else false
 * @see uxl-util-1.0.0.js
 */
uxl.isNotUndefined = function(object){};

/**
 * null ���θ� Ȯ���մϴ�.
 * @param {Object} object null ���θ� Ȯ���� ��ü
 * @return {Boolean} null ����: return true when object is undefined or null else false
 * @see uxl-util-1.0.0.js
 */
uxl.isNull = function(object) {};


/**
 * null ���θ� Ȯ���մϴ�.
 * @param {Object} object null ���θ� Ȯ���� ��ü
 * @return {Boolean} null ���� : return true when object is defined or not null else false
 * @see uxl-util-1.0.0.js
 */
uxl.isNotNull = function(object){};

/**
 * �迭 ���θ� Ȯ���մϴ�.
 * @param {Object} object �迭 ���θ� Ȯ���� ��ü
 * @return {Boolean} �迭 ����
 * @see uxl-util-1.0.0.js
 */
uxl.isArray = function(object) {};

/**
 * String ���θ� Ȯ���մϴ�.
 * @param {Object} object String ���θ� Ȯ���� ��ü
 * @return {Boolean} String ����
 * @see uxl-util-1.0.0.js
 */
uxl.isString = function(object){};


/**
 * Function ���θ� Ȯ���մϴ�.
 * @param {Object} object Function ���θ� Ȯ���� ��ü
 * @return {Boolean} Function ����
 * @see uxl-util-1.0.0.js
 */
uxl.isFunction = function(object) {};


/**
 * ���� ���θ� Ȯ���մϴ�.
 * @param {Object} object ���� ���θ� Ȯ���� ��ü
 * @return {Boolean} ���� ����
 * @see uxl-util-1.0.0.js
 */
uxl.isNumber = function(object){};


/**
 * ���ڿ����� ����(NBSP��������)�� �����մϴ�.
 * @param {String} str ������ ������ ���ڿ�
 * @return {String} ������ ���ŵ� ���ڿ�
 * @see uxl-util-1.0.0.js
 */
uxl.trim = function(str){};

/**
 * �� ���ڿ� ���θ� Ȯ���մϴ�.
 * @param {String} str �� ���ڿ� ���θ� Ȯ���� ��ü
 * @return {Boolean} �� ���ڿ� ���� : return true when object is undefined or null or empty string('')
 * @see uxl-util-1.0.0.js
 */
uxl.isEmpty = function(str){};


/**
 * ������ �ִ� ���ڿ� ���θ� Ȯ���մϴ�.
 * @param {Object} str ������ �ִ� ���ڿ� ���θ� Ȯ���� ��ü
 * @return {Boolean} ������ �ִ� ���ڿ� ���� : return true when is not empty
 * @see uxl-util-1.0.0.js
 */
uxl.isNotEmpty = function(str){};


/**
 * ���� ���ڿ� ���θ� Ȯ���մϴ�.
 * @param {String} ���鹮�ڿ� ���θ� Ȯ���� ���ڿ�
 * @return {Boolean} ���� ���ڿ� ����. ���� ���ڿ��� ��� true �� ��ȯ�մϴ�.
 * @see uxl-util-1.0.0.js
 */
uxl.isBlank = function(str){};


/**
 * ���� ���ڿ� ���θ� Ȯ���մϴ�.
 * @param {String} ���鹮�ڿ� ���θ� Ȯ���� ���ڿ�
 * @return {Boolean} ���� ���ڿ� ����. ���� ���ڿ��� �ƴ� ��� true �� ��ȯ�մϴ�.
 * @see uxl-util-1.0.0.js
 */
uxl.isNotBlank = function(str){};

/**
 * ���ڿ��� ���Ե� {0}, {1}, {2}�� ���� �μ��� �迭������ ��ȯ�մϴ�.<br/>
 * �μ� ��ȣ�� ������ 0���Դϴ�.<br/>
 * @param {String} str �μ��� ���Ե� ���ڿ�
 * @param {Array} values �迭��
 * @return {String} �迭������ ġȯ�� ���ڿ�
 * @see uxl-util-1.0.0.js
 */
uxl.replaceValues = function (str, values){};

/**
 * XML ��带 ���ڿ��� ��ȯ�մϴ�.
 * @param {Node} xmlNode ���ڿ��� ��ȯ�� XML ���
 * @return {String} XML ��� ���ڿ�
 * @see uxl-util-1.0.0.js
 */
uxl.xml2Str = function (xmlNode){};

/**
 * HTML �±׸� ���ڿ��� ��ȯ�մϴ�.
 * @param {TAG} tag ���ڿ��� ��ȯ�� HTML �±�
 * @return {String} HTML �±� ���ڿ�
 * @see uxl-util-1.0.0.js
 */
uxl.tag2Str = function(tag){};

/**
 * ���๮�ڸ� BR �±׷� ��ȯ�Ѵ�.
 * @param {String} ���๮�ڸ� ������ ���ڿ�
 * @return {String} BR�±׷� ��ȯ�� ���ڿ�
 * @see uxl-util-1.0.0.js
 */
uxl.newline2Br = function(str){};

/**
 * JSON ��ü�� ���ڿ��� ��ȯ�Ѵ�.
 * @param {JSON} object ���ڿ��� ��ȯ�� JSON ��ü
 * @return {String} JSON ��ü ���ڿ�
 * @see uxl-util-1.0.0.js
 */
uxl.json2Str =  function(object){};


/**
 * JSON ��ü ���ڿ��� ���� json ��ü�� ��ȯ�Ͽ� ��ȯ
 * @param {String} JSON ��ü ���ڿ�
 * @return {JSON} object ���ڿ��� ��ȯ�� JSON ��ü
 * @see uxl-util-1.0.0.js
 */
uxl.str2Json = function(str){};

/**
 * JSON ��ü ���ڿ��� ���� json ��ü�� ��ȯ�Ͽ� ��ȯ
 * @param {String} JSON ��ü ���ڿ�
 * @param {String} target json ��ü
 * @return {JSON} object ���ڿ��� ��ȯ�� JSON ��ü
 * @see uxl-util-1.0.0.js
 */
uxl.str2JsonObject = function(str, target){};

uxl.null2Str = function(object){};

uxl.getCharByteSize = function (ch){};

uxl.getByteLen = function (str){};

/**
* �̸��� ��ȿ��üũ
* @param {String} ���ϰ�
* @return {Boolean} ���� �̸��� ����
* @see uxl-util-1.0.0.js
*/
uxl.isEmail = function (str){};

uxl.isDate = function (str){};


/**
 * 1,000 �������� �޸����
 */
uxl.setComma = function (str){};







