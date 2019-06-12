/*! 
 * Copyright (c) 2014 UBONE (http://www.ubqone.com)
 * 
 * File : uxl-message-1.2.0.js
 * Version 1.1.1
 * Release List
 * 
 * 1.2.0 - 2016-09-13
 *   - 다국어 Debug 모드 추가 (ub-framework-1.6.0 이상버전에서 지원됨)
 *     
 * 1.1.1 - 2015-05-08
 *   - Cookie에 메세지를 저장하지 않게 수정 (Http 요청시 Header 사이즈의 제한으로 구성된 환경에서는 문제가 발생됨)
 *   - 보안상의 이유로 또한 Cookie를 이용하지 않기 위함. 
 */
(function($, uxl) {

	/**
	 * alert 창으로 메세시 대체
	 * -- ActiveX 및 기타 디자인 문제로 인한 기본 메세지로 전환
	 */
	uxl.showMessage = function(message, fn, title) {
		if(uxl.isMessageKey(message)) {
			message = uxl.getMessage(message);
		}
		
		alert(message);

		if(uxl.isFunction(fn)) {
			try {
				fn();
			} catch (e) {
				uxl.error(e.message, e);
			}
		}
	};
	
	/**
	* window.alert 대용, 사용자에게 메세지를 출력한다.
	* @param {String} 사용자에게 출력할 메세지
	* @return 없음
	*/
	uxl.showMessage1 = function(message, fn, title) {
		message = message || '';
		
		if ($('#dialog').size() == 0) {
			$('<div id="dialog"></div>').appendTo('body');
			$('#dialog').dialog({
				modal : true,
				autoOpen : false,
				resizable : false,
				draggable : false,
				title : title || uxl.getMessage('label.common.notice'),
				bgiframe : true,
				width : 360,
				heght : 200,
				buttons : {
					OK : function() {
						$(this).dialog('close');
					}
				}
			});
		}
		var keydownHandler = function(event) {
			if(event.keyCode == '13' || event.keyCode == '32') {
				$('#dialog').dialog('close');
				return false;
			}
		};
		$('body').bind('keydown', keydownHandler);
		
		var closeHandler = function() {
			if(uxl.isFunction(fn)) {
				try {
					fn();
				} catch (e) {
					uxl.error(e.message, e);
				}
			}
			$('#dialog').unbind('dialogclose');
			$('body').unbind('keydown', keydownHandler);
		};
		$('#dialog').bind('dialogclose', closeHandler);
		
		if(uxl.isMessageKey(message)) {
			message = uxl.getMessage(message);
		}
		message = '<span class="ui-widget">' + message.replace(/\n/g, '<br/>') + '</span>';
		$('#dialog').html(message).dialog('open');
	};
	
	/**
	* 상태바를 보여줍니다.
	* @return 없음
	*/
	uxl.showStatusBar = function (target) {
		uxl.showLoadingDiv();
	};
	
	/**
	* 상태바를 숨깁니다.
	* @return 없음
	*/
	uxl.hideStatusBar = function () {
		uxl.removeLoadingDiv();
	};
	
	/**
	 * 메세지 키 여부 조사
	 * @param {String} 조사 대상 문자열
	 * @return {Boolean} true 메세지 키 패턴일 경우
	 */
	uxl.isMessageKey = function(message) {
		if(uxl.isBlank(message)) {
			return false;
		}
		return /^@message/.test(message) || /^@label/.test(message);
	};
	
	uxl.messages = {};

	/**
	 * 메세지 가져오기
	 * @param {String} 가져올 메세지 키
	 * @return 없음
	 */
	uxl.getMessage = function(messageKey) {
		if(uxl.isMessageKey(messageKey)) {
			messageKey = messageKey.replace('@', '');
		}
		var message = null;
		if(uxl.isUndefined(uxl.messages[messageKey])) {

// v1.1.1 - 보안상의 이유로 주석처리
//			message = $.cookie('cookie_message:' + messageKey);
			
			if(uxl.isEmpty(message)) {
				var option = {
					url : uxl.getMessageURL(messageKey, 'json'),
					dataType : 'json',
					success : function(data) {
						var result = new uxl.Result(data);
						if(result.isSuccess()) {
							message = result.getMessage();
							if(message != null) {

// v1.1.1 - 보안상의 이유로 주석처리
//								$.cookie('cookie_message:' + messageKey, message, {
//									expires: 1
//								});
								
								uxl.messages[messageKey] = message;
							}
						}
					},
					async : false
				};
				$.ajax(option);
			}
			else {
				uxl.messages[messageKey] = message;
			}
		}
		else {
			message = uxl.messages[messageKey];
		}
		
		if(message == null) {
			uxl.debug('Unable to find the corresponding message[key=' + messageKey + '].');
		}
		else {
			try{
				var reg = new RegExp("{[0-9]}","g");
				var keys = message.match(reg);
				if(uxl.isArray(keys)) {
					for (var i=0; i<keys.length; i++) {
						if(!uxl.isUndefined(arguments[i+1])) {
							message = message.replace(keys[i], arguments[i+1]);
						}
					}
				}
			}catch(e){
				// 2012 처럼 숫자로만 된 데이터의 치환시 스크립트 내부 오류 발생으로 인한 try 처리
			}
		}
		return message;
	};
	
	uxl.showDebug = function(message, title) {
		if ($('#debugDialog').size() == 0) {
			$('<div id="debugDialog" title="'+title+'"></div>').appendTo('body');
			$('#debugDialog').dialog({
				modal: true,
			    buttons: {
			        Ok: function() {
			        	$( this ).dialog( "close" );
			        }
			    }
			});
		}
		$('#debugDialog').append(message);
		$('#debugMini').css({
			'top'  				: "0px",
			'left' 				: "0px",
			'width'				: "12px",
			'height'			: "12px",
			'position' 			: 'absolute',
			'z-index' 			: "999",
			'border'  			: '1px solid gray',
			'background-color' 	: '#fff',
			'display'		 	: 'none',
			'cursor' 			: 'hand'
		});
		$('#debugMini').show();
		$('#debugMini').click(function(){
			//$(this).hide();
			$('#debugDialog').dialog('open');
		}); 
	};
	uxl.debug = function(message) {
		message = (message || '') + '';
		message = message.replace(/\n/g, '<br/>') + '<br/>';
		uxl.showDebug('<span style="color: red;" title="debug">!</span>&nbsp;&nbsp;' + message, "Debug");
		
	};
	uxl.error = function(message) {
		if(message && message.message) {
			message = message.message;
		}
		else {
			message = (message || '') + '';
		}
		message = message.replace(/\n/g, '<br/>') + '<br/>';
		uxl.showDebug('<span style="color: red;" title="error">X</span>&nbsp;&nbsp;' + message, "오류 메세지");
		
		return false;
	};
	
	var timelog = [], first, last;
	uxl.time = function(message, since) {
		var now = +new Date;
		var seconds = (now - (since || last)) / 1000;
		timelog.push(seconds.toFixed(3) + ': ' + message + '<br/>');
		return last = +new Date;
	};
	
	uxl.time.done = function() {
		uxl.time('total', first);
		//uxl.debug('script profiling <br/>' + timelog.join(''));
	};
	
	first = last = + new Date;

	/**
	 * 다국어 관련 Debug Mode 기능
	 */
	$(document).ready(function(){
		// 리소스 컨트롤의 등록팝업 연동
		$('.label-resource').click(function(event){
			var code = $(this).attr('code');
			var text = $(this).text();
			if(uxl.isEmpty(code)){
				alert('선택된 객체의 리소스코드가 정의되어 있지 않습니다.\n관련 기능은 해당 기능의 관리페이지에서 확인하세요.');
				return false;
			}
			var screenId = $(this).hasClass('nodata')?'APM0040':'APM0041';
			var url = uxl.getScreenURL(screenId);
			url = uxl.addQueryToUrl(url, 'RES_ID', code);
			url = uxl.addQueryToUrl(url, 'TEXT', escape(text));
			uxl.openWindow('msgDebug', url, {
				width : 540,
				height : 300
			});
			return false;
		});
		
		// 다국어 입력 컬럼 생성
		var $column = $('.ub-control.message-column');
		var resNameId = $column.attr('id')+'_RES_ID';
		var columnResId = uxl.isNotNull($column.attr('resId'))?$column.attr('resId'):"";
		
		$column.attr('readonly', true).attr('title', '다국어대상컬럼');
		var $hidden = $('<input type=hidden id="'+resNameId+'" name="'+resNameId+'" value="'+columnResId+'" />'); 
		$column.after($hidden);
		$column.after('<label class="message-column-label">다</label>');
		$column.click(function(){
	         var $this = $(this);
	         var tableNm  = uxl.isNotNull($this.attr('table'))?$this.attr('table'):"";
	         var columnNm = uxl.isNotNull($this.attr('column'))?$this.attr('column'):"";

			 var $resId = $('#'+$this.attr('id')+'_RES_ID')
	         var resId = $resId.val();
	         
	         var screenId = uxl.isEmpty(resId)?'APM0040':'APM0041';
			 var url = uxl.getScreenURL(screenId);
	         url = uxl.addQueryToUrl(url, 'TYPE', 'T');
	         url = uxl.addQueryToUrl(url, 'RES_ID', resId);
	         url = uxl.addQueryToUrl(url, 'TABLE_NM', tableNm);
	         url = uxl.addQueryToUrl(url, 'COLUMN_NM', columnNm);
	         url = uxl.addQueryToUrl(url, 'TEXT', escape($column.val()));
	         
	         uxl.openWindow('msgDebug',  url,  {width:540, height:300}, function(returnData) {
	            $this.val(returnData.RES_NM);
	            $resId.val(returnData.RES_ID);
	         });
	         return false;
		});
		$hidden.change(function(){
			$column.removeClass('nodata');
			if(uxl.isEmpty($(this).val())){
				$column.addClass('nodata');
			} 
		});
	});
	
})(jQuery, uxl);