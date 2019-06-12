/**
 * Event Bus - JavaScript File
 * 
 * Description : 이벤트 버스를 이용한 하위 오브젝트 관리 모듈
 */

var EventBus = function(options){
	
	this.listeners = new Array();
	
	var defaultOptions = {
		events : {
			onLoad : function(){}
		}
	};
	
	this.options = $.extend(defaultOptions, options);
	
	/**
	 * 이벤트 리스너를 추가하는 함수
	 * @param options
	 */
	EventBus.prototype.addListener = function(listnerOptions){
		var defaultOptions = {};
		listnerOptions = $.extend(defaultOptions, listnerOptions);
		
		if(uxl.isNull(listnerOptions.id)){
			alert('EventBus의 ID가 정의되지 않았습니다.');
			return null;
		}
		
		this.listeners.push(listnerOptions);
		this.listeners[listnerOptions.id] = listnerOptions;
		
		this.debugLog();
		return listnerOptions;
	};
	
	/**
	 * 등록된 리스너를 삭제하는 함수
	 * @param id window id
	 */
	EventBus.prototype.removeListener = function(id) {
		var thisListener = this.findListener(id);
		
		if(this.listeners.indexOf(thisListener) > -1){
			delete this.listeners[thisListener.id];
			this.listeners.splice(this.listeners.indexOf(thisListener), 1);
		}
		
		this.debugLog();
	};

	/**
	 * 특정이벤트 리스너 조회하는 함수
	 * @param id 리스너id
	 * @returns Listener 인스턴스
	 */
	EventBus.prototype.findListener = function(id) {
		for(var i=0; i<this.listeners.length; i++){
			if(this.listeners[i].id == id){
				return this.listeners[i]; 
			}
		}
		return null;
	};
	
	/**
	 * 디버그 로그 함수
	 */
	EventBus.prototype.debugLog = function(){
		if(console){
			console.debug('listeners count : '+this.listeners.length);
			for(var i=0; i<this.listeners.length; i++){
				console.debug(this.listeners[i]);
			};
		}
	};
	
	/**
	 * 특정이벤트를 발생하는 함수
	 * @param eventName 발생이벤트명
	 */
	EventBus.prototype.triggerEvent = function(eventName, args){
		
		if(uxl.isNull(this.options.events[eventName]) || !uxl.isFunction(this.options.events[eventName])){
			alert(eventName+'는 정의되지 않은 이벤트 입니다.');
			return;
		}
		
		// 1.Global Event 선행 실행
//		this.options.events[eventName].call(this);
		this.options.events[eventName].apply(this, args);
		
		// 2.Listener Event 실행
		for(var i=0; i<this.listeners.length; i++){
			if(uxl.isNotNull(this.listeners[i][eventName]) && uxl.isFunction(this.listeners[i][eventName])){
//				this.listeners[i][eventName].call(this);
				this.listeners[i][eventName].apply(this, args);
			}
		}		
	};
};
