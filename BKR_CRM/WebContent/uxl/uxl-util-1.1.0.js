;(function($, uxl) {
	
	//********************************
	//			Object
	//********************************
	/**
	 * 엘리먼트 여부를 확인합니다.
	 * @param {Object} object 엘리먼트 여부를 확인할 객체
	 * @return {Boolean} 엘리먼트 여부
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isElement = function(object) {
		return !!(object && object.nodeType == 1);
	};
	
	/**
	 * Undefined 여부를 확인합니다.
	 * @param {Object} object Undefined 여부를 확인할 객체
	 * @return {Boolean} Undefined 여부: return true when object is undefined else false
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isUndefined = function(object) {
		return (typeof object == 'undefined');
	};
	/**
	 * Undefined 여부를 확인합니다.
	 * @param {Object} object Undefined 여부를 확인할 객체
	 * @return {Boolean} Undefined 여부 : return true when object is defined else false
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isNotUndefined = function(object) {
		return !uxl.isUndefined(object);
	};
	
	/**
	 * null 여부를 확인합니다.
	 * @param {Object} object null 여부를 확인할 객체
	 * @return {Boolean} null 여부: return true when object is undefined or null else false
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isNull = function(object) {
		return (typeof object == 'undefined' || object == null);
	};
	/**
	 * null 여부를 확인합니다.
	 * @param {Object} object null 여부를 확인할 객체
	 * @return {Boolean} null 여부 : return true when object is defined or not null else false
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isNotNull = function(object) {
		return !uxl.isNull(object);
	};
	
	
	/**
	 * 배열 여부를 확인합니다.
	 * @param {Object} object 배열 여부를 확인할 객체
	 * @return {Boolean} 배열 여부
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isArray = function(object) {
		return Object.prototype.toString.call(object) == '[object Array]'; 
	};
	
	/**
	 * String 여부를 확인합니다.
	 * @param {Object} object String 여부를 확인할 객체
	 * @return {Boolean} String 여부
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isString = function(object){
		 return typeof object == 'string';
	};
	
	/**
	 * Function 여부를 확인합니다.
	 * @param {Object} object Function 여부를 확인할 객체
	 * @return {Boolean} Function 여부
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isFunction = function(object) {
		return typeof object == 'function';
	};
	
	/**
	 * 숫자 여부를 확인합니다.
	 * @param {Object} object 숫자 여부를 확인할 객체
	 * @return {Boolean} 숫자 여부
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isNumber = function(object) {
		return typeof object == 'number';
	};
	
	
	//********************************
	//			String
	//********************************
	/**
	 * 문자열에서 공백(NBSP문자포함)을 제거합니다.
	 * @param {String} str 공백을 제거할 문자열
	 * @return {String} 공백이 제거된 문자열
	 * @see uxl-util-1.0.0.js
	 */
	uxl.trim = function(str) {
		var nbsp = String.fromCharCode(160);
		str = str.replace(new RegExp(nbsp, 'g'), '');
		return jQuery.trim(str);
	};
	
	/**
	 * 빈 문자열 여부를 확인합니다.
	 * @param {String} str 빈 문자열 여부를 확인할 객체
	 * @return {Boolean} 빈 문자열 여부 : return true when object is undefined or null or empty string('')
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isEmpty = function(str) {
		return (uxl.isNull(str) || str == '');
	};
	/**
	 * 내용이 있는 문자열 여부를 확인합니다.
	 * @param {Object} str 내용이 있는 문자열 여부를 확인할 객체
	 * @return {Boolean} 내용이 있는 문자열 여부 : return true when is not empty
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isNotEmpty = function(str) {
		return !uxl.isEmpty(str);
	};
	
	/**
	 * 공백 문자열 여부를 확인합니다.
	 * @param {String} 공백문자열 여부를 확인할 문자열
	 * @return {Boolean} 공백 문자열 여부. 공백 문자열일 경우 true 를 반환합니다.
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isBlank = function(str) {
		if(uxl.isNull(str)) {
			return true;
		}
	    return /^\s*$/.test(str);
	};
	/**
	 * 공백 문자열 여부를 확인합니다.
	 * @param {String} 공백문자열 여부를 확인할 문자열
	 * @return {Boolean} 공백 문자열 여부. 공백 문자열이 아닐 경우 true 를 반환합니다.
	 * @see uxl-util-1.0.0.js
	 */
	uxl.isNotBlank = function(str) {
	    return !uxl.isNotBlank(str);
	};
	
	/**
	 * 문자열에 포함된 {0}, {1}, {2}와 같은 인수를 배열값으로 변환합니다.<br/>
	 * 인수 번호의 시작은 0번입니다.<br/>
	 * @param {String} str 인수가 포함된 문자열
	 * @param {Array} values 배열값
	 * @return {String} 배열값으로 치환된 문자열
	 * @see uxl-util-1.0.0.js
	 */
	uxl.replaceValues = function (str, values) {
		if(!uxl.isArray(values)) {
			values = [values];
		}
		var reg = new RegExp('\\{[0-9]*\\}', 'g');
		var keys = str.match(reg);
		if(keys != null) {
			for (i=0; i<keys.length; i++) {
				matchKey = keys[i].replace(/{/g,"\\{").replace(/}/g,"\\}");
				var idx = parseInt(keys[i].replace(/{/g,"").replace(/}/g,""), 10);
				if(typeof values[idx]!="undefined") {
					str = str.replace(RegExp(matchKey,"g"),values[idx]);
				}
			}
		}
		return str;
	};
	
	
	//********************************
	//			Covert
	//********************************
	/**
	 * XML 노드를 문자열로 변환합니다.
	 * @param {Node} xmlNode 문자열로 변환할 XML 노드
	 * @return {String} XML 노드 문자열
	 * @see uxl-util-1.0.0.js
	 */
	uxl.xml2Str = function (xmlNode) {
		try {
			return (new XMLSerializer()).serializeToString(xmlNode);
		}
		catch (e) {
			try {
				return xmlNode.xml;
			}
			catch (e) {
				uxl.showAlert('Xmlserializer not supported');
			}
		}
		return null;
	};
	
	/**
	 * HTML 태그를 문자열로 변환합니다.
	 * @param {TAG} tag 문자열로 변환할 HTML 태그
	 * @return {String} HTML 태그 문자열
	 * @see uxl-util-1.0.0.js
	 */
	uxl.tag2Str = function(tag){
		return uxl.isString(tag) ? tag.replace(/>/g, '&gt;').replace(/</g, '&lt;') : tag;
	};
	
	/**
	 * 개행문자를 BR 태그로 변환한다.
	 * @param {String} 개행문자를 포함한 문자열
	 * @return {String} BR태그로 변환된 문자열
	 * @see uxl-util-1.0.0.js
	 */
	uxl.newline2Br = function(str){
		return uxl.isString(str) ? str.replace(/\n/g, '</br>') : str;
	};
	
	/**
	 * JSON 객체를 문자열로 변환한다.
	 * @param {JSON} object 문자열로 변환할 JSON 객체
	 * @return {String} JSON 객체 문자열
	 * @see uxl-util-1.0.0.js
	 */
	uxl.json2Str =  function(object) {
		var retorno = '{';
		for( var i in object ) {
			if( object[i].constructor == Object )
				retorno += '\'' + i + '\':' + uxl.json2Str(object[i]) + ',';
			else if(object[i].constructor == Array) {
				retorno += '\'' + i + '\':\'' + uxl.json2Str(object[i]) + '\'';
			}
			else {
				if(uxl.isString(object[i])) {
					retorno += '\'' + i + '\':\'' + object[i] + '\',';
				}
				else {
					retorno += '\'' + i + '\':' + object[i] + ',';
				}
			}
		}
		
		retorno = retorno.substr(0, (retorno.length - 1));
		retorno += '}'; 
		return retorno; 
	}; 
	
	/**
	 * JSON 객체 문자열로 부터 json 객체로 변환하여 반환
	 * @param {String} JSON 객체 문자열
	 * @return {JSON} object 문자열로 변환할 JSON 객체
	 * @see uxl-util-1.0.0.js
	 */
	uxl.str2Json = function(str) {
		try {
			eval('var json = ' + str + ';');
			return json;
		}
		catch(e) {
			return false;
		}
	}; 
	
	/**
	 * JSON 객체 문자열로 부터 json 객체로 변환하여 반환
	 * @param {String} JSON 객체 문자열
	 * @param {String} target json 객체
	 * @return {JSON} object 문자열로 변환할 JSON 객체
	 * @see uxl-util-1.0.0.js
	 */
	uxl.str2JsonObject = function(str, target) {
		try {
			target = eval('(' + str + ')');
			return target;
		}
		catch(e) {
			return false;
		}
	}; 
	
	uxl.null2Str = function(object) {
		if(object == null || typeof object == 'undefined') {
			return '';
		}
		return object;
	};
	
	
	//********************************
	//			etc
	//********************************
	uxl.getCharByteSize = function (ch) {
	    if (ch == null || ch.length == 0) {
	      return 0;
	    }
	    var charCode = ch.charCodeAt(0);
	    if (charCode <= 0x00007F) {
	      return 1;
	    }
	    return 2;
	};
	
	uxl.getByteLen = function (str) {
	    if (str == null || str.length == 0) {
	      return 0;
	    }
	    var size = 0;
	    for (var i = 0; i < str.length; i++) {
	      size += uxl.getCharByteSize(str.charAt(i));
	    }
	    return size;
	};
	
	/**
	* 이메일 유효성체크
	* @param {String} 메일값
	* @return {Boolean} 정상 이메일 여부
	* @see uxl-util-1.0.0.js
	*/
	uxl.isEmail = function (str) {
		return str.search(/^\s*[\w\~\-\.]+\@[\w\~\-]+(\.[\w\~\-]+)+\s*$/g)>=0;
	};
	
	uxl.isDate = function (str) {
		return Date.parse(str) != null;
	};
	
	/**
	 * 1,000 단위마다 콤마찍기
	 */
	uxl.setComma = function (str) {
		str = str.toString();
	    var pattern = /(-?\d+)(\d{3})/;
	    while (pattern.test(str))
	    	str = str.replace(pattern, "$1,$2");
	    return str;
	};

})(jQuery, uxl);