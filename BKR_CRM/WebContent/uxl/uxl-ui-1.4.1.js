/*! 
 * Copyright (c) 2014 UBONE (http://www.ubqone.com)
 * 
 * File : uxl-ui-1.4.1.js
 * Version 1.4.1
 * 
 * Release List
 * 1.4.1 - 2017-11-20
 *   - 엑셀 Export success handler 함수 uxl.excelDaolog 추가 
 * 1.4.0 - 2017-04-12
 *   - DivTab 기능 추가로 인한 UI 로드 함수 수정 (target 지정이 되어 있지 않은 선택 함수 보정)
 *   - setBorwserInfo : 퍼블리싱을 위한 브라우져 기능
 * 1.3.0 - 2016-09-23
 *   - 메세지 디버그 모드 추가 (다국어 리소스 등록 팝업 추가)
 *   - Search Advanced 검색조건 복원시 펼침/접힘 추가
 * 1.2.0 - 2016-08-28
 *   - 마스크 모듈 변경 (meio.mask --> jquery.mask)
 *   - Input box의 블럭선택후 키입력하면 한문자만 반복적으로 입력되는 버그 발생으로 모듈 교체
 * 1.1.0 - 2014-07-10
 *   - 초기 개발
 */
var stopResize;
var resetResize;

;(function($, uxl) {

	/**
	 * 초기 문서 로딩시 실행되는 공통 함수
	 */
	$(document).ready(function() {
		// 퍼블리싱을 위한 브라우져 정보를 추가하는 함수
		uxl.setBrowserInfo();
		uxl.time('document ready');
		
		// 문서준비 핸들러에 등록한 이벤트 실행
		uxl.callLoad();
		uxl.time('callLoad');

		// 문서준비 핸들러에 등록한 Secondary 이벤트 실행
		uxl.callLoadSecondary();
		uxl.time('callLoadSecondary');

		// 공통 UI 초기화
		uxl.initCommonUI(document);		

		// 초기화 완료 함수 호출
		uxl.callLoadComplete();

		// 특정 함수키 비활성 처리(F1, F3, F5, BackSpace)
		uxl.disableShortcuts(true);
		
		uxl.time('callLoadComplete');
		uxl.time.done();
	});
	
	/**
	 * 공통 UI 초기화 함수
	 * @target 적용대상 null이면 document 대상으로 처리함.
	 * 부분 동적 컨텐트 로드시 target을 로딩 div로 정의후 직접실행시켜서 UI를 일치 시킨다.
	 */
	uxl.initCommonUI = function(target){
		// 웹 접근성 관련 보정 처리
		uxl.setWebAccessibility(target);

		// form 의 input 항목의 엔터 입력 설정
		uxl.setupFormInput(target);

		// 버튼 UI 생성
		//uxl.displayButton(target);

		// required field display
		uxl.displayRequired(target);

		// read only field display
		uxl.displayReadOnly(target);

		// input mask
		uxl.setInputFormat(target);

		// 달력 버튼 설정
		uxl.setCalandarButton(target);

		// 서브 타이틀 접기 기능
		uxl.setSubTitleHolder(target);

		// MultiSelect 설정
		uxl.setMultiSelect(target);
		
		// 검색확장영역 버튼 생성 및 기능활성
		uxl.setSearchAdvancedButton(target);
		
		// APMD 링크 관련 기능 (옵션)
		uxl.setLinkAPMD(target);
	};	
	
	/**
	 * Called to disable F1, F3, and F5.
	 */
	uxl.disableShortcuts = function(flag){
		var maskKey = 'F1, F3, F5, Alt+Left, Alt+Right';

		$.Shortcuts.add({type:'down', mask:maskKey
			, handler:function(){
				return false;
			}
		});
		$.Shortcuts.add({type:'hold', mask:maskKey
			, handler:function(){
				return false;
			}
		});
		
		if(flag){
			$.Shortcuts.start();
		}
	};
	
	/**
	 * search form 의 input 항목의 엔터 입력 설정
	 * @return 없음
	 */
	uxl.setupFormInput = function(target) {
		target = target || document;

		$('textarea[autosize=1],textarea[autosize=yes]', target).each(function(index, em) {
			$(em).height(30);
			if(uxl.isNotEmpty(em.value)) {
				$(em).height(em.scrollHeight - 2);
			}
		}).keydown(function(event) {
			if(event.which == '13') {
				if(uxl.isFunction(stopResize)) {
					$('body').attr('scroll', 'auto');
					//$('body').css('overflow-X', 'hidden').attr('scroll', 'auto');
					stopResize();
				}
				$(this).height(0);
				$(this).height(this.scrollHeight + 12);
				if(uxl.isFunction(resetResize)) {
					setTimeout(function() {
						resetResize();
					}, 500);
				}
			}
		});

		// 목록화면에서 Enter 입력시 자동조회
		$('.ub-page.list .ub-layout.search :input:not(:button)', target).keypress(function(event) {
			if (event.which == '13') {
				event.preventDefault();

				if(uxl.isNotEmpty($(this).val())) {
					$('#' + uxl.CONSTANT.BUTTON.SEARCH, target).click();
				}
				else {
					var $searchInputs = $('.ub-page.list .ub-layout.search :input:not(:button)', target).filter(':visible').filter(':enabled');

					var index = $searchInputs.index(this);
					$searchInputs.eq(index + 1).focus();
				}

			}
		}).first().focus();

		// Enter key 입력시 다음 활성 컨트롤로 이동
		$('.ub-page.detail :input:not(:button):not(textarea)', target).keypress(function(event) {
			if (event.which == '13') {
				event.preventDefault();

				var $detailInputs = $('.ub-page.detail :input:not(:button):not(textarea)', target).filter(':visible').filter(':enabled');

				var index = $detailInputs.index(this);
				$detailInputs.eq(index + 1).focus();
			}
		});
	};

	/**
	 * 버튼 UI 생성
	 * @return 없음
	 */
	uxl.displayButton = function(target) {
		target = target || document;
		$('button', target).each(function() {
			var option = {};
			var image_type = '';
			var $this = $(this);
			image_type = $this.attr('image_type');
			if(uxl.isNotEmpty(image_type)) {
				option['icons'] = {
					primary: image_type
				};
				if($this.val() == '{false}' || $this.html() == '{false}') {
					option['text'] = false;
				}
			}
			$(this).button(option);
		});

		$('.ui-button', target).click(function(event) {
			event.preventDefault();
		});
	};

	/**
	 * 필수 항목 표시
	 * @return 없음
	 */
	uxl.displayRequired = function(target) {
		target = target || document;
		$('label', target).displayRequired();
	};

	/**
	 * readOnly 항목 표시
	 * @return 없음
	 */
	uxl.displayReadOnly = function(target) {
		target = target || document;

		$('*[readonly], *[disabled]', target).addClass('readonly');

		/*$('.readonly').focus(function() {
			$(this).blur();
		});*/

		$('select[disabled]', target).each(function() {
			if(uxl.isNotEmpty(this.id)){
				if($('input#' + this.id).size() == 0) {
					$(this)
					.before('<input type="hidden" name="' + this.id + '" id="' + this.id + '" value="' + this.value + '"/>')
					.removeClass('required')
					.attr({
						disabled: true,
						metaessential: 0
					});
				}
			}
		});
	};

	/**
	 * selector 에 포함되어있는 input, textarea, select 엘리먼트를 모두 readOnly로 변경한다.
	 * @return 없음
	 */
	uxl.setReadOnly = function(target) {
		target = target || document;

		$('input, textarea, select, button', target).attr('disabled', 'disabled');
		uxl.displayReadOnly(target);
	};

	/**
	 * input format
	 * @return 없음
	 */
	uxl.setInputFormat = function(target) {
		target = target || document;
		
		// metaformat 속성이 존재하는 Input Tag의 마스킹 처리
		$('input[metaformat]', target).each(function(){
			uxl.setInputMask(this, $(this).attr('metaformat'));
		});

		$('input[metaformat=date]', target).change(function() {
			var val = $(this).val();
			if(uxl.isDate(val)) {
				$(this).val(Date.parse(val).toString('yyyy-MM-dd'));
			}
			else {
				$(this).val('');
			}
		});
	};
	
	/**
	 * 달력 버튼 설정
	 * @return 없음
	 */
	uxl.setCalandarButton = function(target) {
		target = target || document;
		
		$('.ub-control.input-text.calendar', target).each(function(){
			if(!this.readOnly){
				$(this).datepicker({
				      changeMonth: true,
				      changeYear: true,
				      //최소 날짜 추가(김범수)
				      minDate: new Date(1000, 1, 1)
				});	
			}
		});
	};

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
	uxl.chainCombo = function(comboId, nextComboId, codeCategoryId, options) {
		var combo = uxl.isString(comboId) ? $('#' + comboId) : $(comboId);
		var nextCombo = uxl.isString(nextComboId) ? $('#' + nextComboId) : $(nextComboId);
		codeCategoryId = codeCategoryId || nextCombo.attr('id');

		var defaultOption = {
				  parameter : {}
				, emptyOption : true
				, unusedMapping : false
			};

		options = $.extend(defaultOption, options);
		
		uxl._bindChainCombo(combo, nextCombo, codeCategoryId, options);
	};

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
	uxl.chainComboByGroupFilter = function(comboId, nextComboId, codeCategoryId, options) {
		var combo = uxl.isString(comboId) ? $('#' + comboId) : $(comboId);
		var nextCombo = uxl.isString(nextComboId) ? $('#' + nextComboId) : $(nextComboId);
		codeCategoryId = codeCategoryId || nextCombo.attr('id');

		var defaultOption = {
				  parameter : {}
				, emptyOption : true
				, unusedMapping : false
			};
		
		options = $.extend(defaultOption, options);
		
		$.extend(options.parameter, {GROUP : combo.val()});
		uxl._bindChainCombo(combo, nextCombo, codeCategoryId, options);
	};

	uxl._bindChainCombo = function(combo, nextCombo, codeCategoryId, options) {
		var _event_name = 'change.' + nextCombo.attr('id');
		combo.bind(_event_name, function(event) {
			if(combo.val() == '') {
				nextCombo.emptySelect(options.emptyOption);
			}
			else {
				if(event.target.type == 'select-one'){
					var tmp = {};
					tmp [uxl.CONSTANT.CODE.PARENT] = event.target.value;
					$.extend(options.parameter, tmp);
					
					uxl.bindComboCode(nextCombo, codeCategoryId, options);
				}else{
					var checkItems = $(event.target).find(':checked');
					var parentValues = [];
					parentValues.push('_');
					for(var i=0; i<checkItems.size(); i++){
						parentValues.push(checkItems[i].value);
					}
					
					var tmp = {};
					tmp [uxl.CONSTANT.CODE.PARENT] = parentValues;
					$.extend(options.parameter, tmp);
					
					uxl.bindComboCode(nextCombo, codeCategoryId, options);
				}
			}
			nextCombo.change();
		}).trigger(_event_name);
	};

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
	uxl.bindComboCode = function(comboId, codeCategoryId, options) {
		var combo = uxl.isString(comboId) ? $('#' + comboId) : $(comboId);
		codeCategoryId = codeCategoryId || combo.attr('id');
		var codeServiceUrl = codeCategoryId;
		if(!uxl.isServiceRequestPath(codeCategoryId)) {
			if(!uxl.isCodeRequestPath(codeCategoryId)) {
				codeServiceUrl = uxl.getCodeURL(codeCategoryId, 'json');
			}
		}
		
		var defaultOption = {
			  parameter : {}
			, emptyOption : true
			, unusedMapping : false
		};
		
		options = $.extend(defaultOption, options);
		$.extend(options.parameter, {'UNUSED_MAPPING' :	options.unusedMapping});
		
		var ajaxOption = {
			url : codeServiceUrl,
			data : options.parameter,
			dataType : 'json',
			success : function(data) {
				var result = new uxl.Result(data);
				if(result.isSuccess()) {
					var dataList = result.getDataList(uxl.CONSTANT.CODE.PREFIX + codeCategoryId) || result.getDataList(0);
					if(dataList['rowCount'] == 0) {
						combo.emptySelect(options.emptyOption);
					}
					else {
						var rows = dataList['rows'];
						combo.loadSelect(rows, options.emptyOption , combo.attr('defaultvalue'));
						if(uxl.isEmpty(combo.attr('defaultvalue'))) {
							combo.attr('selectedIndex', 0);
						}
						else {
							combo.val(combo.attr('defaultvalue'));
						}
						combo.attr('defaultvalue', '');
						
						try{
							/* IE8-disable 또는 읽기 전용일 경우 focus 오류 발생*/
							combo.focus();
						}catch(e){}
					}
				}
				else {
					combo.emptySelect(options.emptyOption);
				}
			},
			async : false
		};
		$.ajax(ajaxOption);
	};

	/**
	 * 목록 마우스 오버 효과
	 * @param {String} 기능 부여 대상 셀렉트 구문
	 * @return 없음
	 */
	uxl.bindListHover = function(listSelector) {
		listSelector = listSelector || uxl.CONSTANT.LIST_ITEM_SELECTOR;
		$(listSelector)
		.each(function(index) {
			var _1stLabel = $('label[onclick]:first', this).get(0);
			if(_1stLabel) {
				if(uxl.isFunction(_1stLabel.onclick)) {
					var fn = _1stLabel.onclick;
					$(this).click(function() {
						fn();
					});
					_1stLabel.onclick = function() {
					};
				}
			}
		})
		.hover(function() {
			$(this).parent().addClass('ui-state-highlight');
		}, function() {
			$(this).parent().removeClass('ui-state-highlight');
		});
	};
	
	/**
	 * 목록 마우스 오버 효과 - cursor 기능 제외
	 * @param {String} 기능 부여 대상 셀렉트 구문
	 * @return 없음
	 */
	uxl.bindListHoverHighlight = function(listSelector) {
		listSelector = listSelector || uxl.CONSTANT.LIST_ITEM_SELECTOR;
		$(listSelector)
		.each(function(index) {
			var _1stLabel = $('label[onclick]:first', this).get(0);
			if(_1stLabel) {
				if(uxl.isFunction(_1stLabel.onclick)) {
					var fn = _1stLabel.onclick;
					$(this).click(function() {
						fn();
					});
					_1stLabel.onclick = function() {
					};
				}
			}
		})
		.hover(function() {
			$(this).parent().addClass('ui-state-highlight');
			$(this).css('cursor', 'default');
		}, function() {
			$(this).parent().removeClass('ui-state-highlight');
		});
	};

	/**
	 * INNER 목록 마우스 오버 효과
	 * @param {String} 기능 부여 대상 셀렉트 구문
	 * @return 없음
	 */
	uxl.bindListInnerHover = function(listSelector) {
		listSelector = listSelector || uxl.CONSTANT.LIST_INNER_ITEM_SELECTOR;
		$(listSelector)
		.each(function(index) {
			var _1stLabel = $('label[onclick]:first', this).get(0);
			if(_1stLabel) {
				if(uxl.isFunction(_1stLabel.onclick)) {
					var fn = _1stLabel.onclick;
					$(this).click(function() {
						fn();
					});
					_1stLabel.onclick = function() {
					};
				}
			}
		})
		.hover(function() {
			$(this).parent().addClass('ui-state-highlight');
		}, function() {
			$(this).parent().removeClass('ui-state-highlight');
		});
	};
	
	/**
	 * INNER 목록 마우스 오버 효과
	 * label 에 대하여 id 값이 있으면 커서를 pointer 로 변경
	 * 그렇지 않을 경우엔 일반 default cursor
	 * @param {String} 기능 부여 대상 셀렉트 구문
	 * @return 없음
	 */
	uxl.bindListInnerPartHover = function(listSelector) {
		listSelector = listSelector || uxl.CONSTANT.LIST_INNER_ITEM_SELECTOR;
		$(listSelector)
		.each(function(index) {
			var _1stLabel = $('label[onclick]:first', this).get(0);
			if(_1stLabel) {
				//if($('label', this).attr('id')) {
				if(uxl.isFunction(_1stLabel.onclick)) {
					var fn = _1stLabel.onclick;
					$(this).click(function() {
						fn();
					});
					_1stLabel.onclick = function() {
					};
				}
			}
		})
		.hover(function() {
			$(this).parent().addClass('ui-state-highlight');
						
			if($('label', this).attr('id') == undefined || $('label', this).attr('id') == "") {
				$(this).css('cursor', 'default');
			}
		}, function() {
			$(this).parent().removeClass();
		});
	};

	/**
	 * 목록 Cell Merge 기능 적용
	 * @param {String} 목록 레이아웃 id
	 * @return 없음
	 */
	uxl.cellMerge = function(layoutId){
		var currRow  = $('#'+layoutId+' tr:last');
		var mergeList = $('td[cellType=M]', currRow);

		for(var i=0; i<mergeList.size(); i++){

			var cellId   = $(mergeList.get(i)).attr('id');
			var currCol  = "";
			var html     = "";
			var grpCnt   = 1;

			do{
				currCol = $('td[id='+cellId+"]", currRow);
				html    = $(currCol).html();

				var prevCol =  $('td[id='+cellId+"]", currRow.prev());
				if( html == prevCol.html()){
					if( html != "" && prevCol.html() != ""){
						currCol.remove();
						grpCnt++;
					}
				}else{
					html = prevCol.html();
					currCol.attr("rowspan", grpCnt);
					grpCnt = 1;
				}
				currRow = currRow.prev();
			}while(currRow.size() != 0);

			currRow  = $('#'+layoutId+' tr:last');
		}
	};

	/**
	 * 목록 정렬기능 적용
	 * @param {String} 목록 레이아웃 id
	 * @param {String} 정렬 표현식 ex) '0:COLMUN_NAME1,1:COLMUN_NAME2,2:COLMUN_NAME2'
	 * @param {String} 검색 form name(생략할 경우 uxl.CONSTANT.FORM.SEARCH 상수값 사용)
	 * @return 없음
	 */
	uxl.orderTable = function(layoutId, exp, formName) {
		var asc = $('<span style="height:12px !important;" class="ui-icon ui-icon-triangle-1-n"/>');
		var desc = $('<span style="height:12px !important;" class="ui-icon ui-icon-triangle-1-s"/>');

		var items = exp.split(',');
		var orderbleHeader = $('#' + layoutId + ' label.List_header,' + '#' + layoutId + ' th').filter(function(index) {
			var check = false;
			var label = $(this);
			jQuery.each(items, function(n, value) {
				var sort = uxl.trim(value).split(':');
				if(sort[0] == index) {
					check = true;
					label.attr('ORDER_COLUMN', sort[1]);
					label.attr('title', 'sort by ' + label.text() + '');

					if(orderColumn == sort[1]) {
						if(orderAsc == 'ASC') {
							label.append(asc);
							label.attr('ORDER_ASC', 'DESC');
						}
						else {
							label.append(desc);
							label.attr('ORDER_ASC', 'ASC');
						}
					}
					else {
						label.append('<span style="height:12px !important;" class="ui-icon ui-icon-triangle-2-n-s"/>');
						label.attr('ORDER_ASC', 'ASC');
					}
					return false;
				}
			});
			return check;
		})
		.css('cursor', 'pointer')
		.hover(function() {
			if(this.tagName == 'TH') {
				$(this).toggleClass('ui-state-active');
			}
			else {
				$(this).parent().toggleClass('ui-state-active');
			}
		})
		.click(function(event) {
    		formName = formName || uxl.CONSTANT.FORM.SEARCH;
			var eventDoc = event.target.ownerDocument;
			var searchForm = eventDoc.forms[formName];
			if(searchForm == null) {
				searchForm = uxl.createForm(eventDoc, formName);
			}

			uxl.addHidden(searchForm, 'ORDER_COLUMN', $(this).attr('ORDER_COLUMN'));
			uxl.addHidden(searchForm, 'ORDER_ASC', $(this).attr('ORDER_ASC'));

			uxl.submit(searchForm, location.href.replace(uxl.CONSTANT.KEY.RECOVERY, 'dummy'));
		});
	};

	/**
	 * 특정 객체의 Blink 효과
	 */
	uxl.blink = function(src){
		var time = 250;
		$(src).animate({opacity:0, color:"red"},time,"linear", function(){ 
			$(this).animate({opacity:1},time, function(){
//				$(this).animate({opacity:0},time,"linear", function(){ 
//					$(this).animate({opacity:1},time, function(){
						$(this).animate({opacity:0},time,"linear", function(){ 
							$(this).animate({opacity:1, color:"black"},time); 
						});
//					}); 
//				});
			}); 
		});
	};
	
	/**
	 * 서브 타이틀 링크 설정 및 폴더 폴딩 기능
	 */
	uxl.setSubTitleHolder = function(target){
		target = target || document;
		
//		var isMakeBookLink = true;
//		var bookLink = null;
//		var linkList = $('.ub-control.title[hfold=1]');
//		
//		if(!uxl.isNull(createBookLink)){
//			isMakeBookLink = createBookLink;
//		}
		
		/* Book-Link */
//		if(linkList.size() > 0 && isMakeBookLink){
//
//			// booklink 가 있는지 체크 없으면, 헤터 밑에 생성
//			if($('.booklink').size() == 0){
//				var htmlBookLink = '<div class="booklink"></div>';
//				
//				if($('.inner-contents-wrap').size() > 0){
//					// tab 화면인경우
//					$('.inner-contents-wrap').children().first().before(htmlBookLink);
//				}else if($('#pop_wrap').size() > 0){
//					// Popup 화면인 경우
//					$('#pop_wrap #contents').children().first().before(htmlBookLink);
//				}else{
//					// 일반 화면인 경우
//					if($('#contents h3').size() == 0){
//						$('body').children().first().before(htmlBookLink);
//					}else{
//						var node = $('#contents h3').next();
//						if(node.attr('class') == "page_button"){
//							node.after(htmlBookLink);
//						}else{
//							$('#contents h3').after(htmlBookLink);
//						}
//					}
//				}
//			}
//			
//			bookLink = $('.booklink');
//			bookLink.empty();
//			bookLink.append("<ul/>");	
//		}
//
//		linkList.each(function(){
//			// 제목 추출
//			var clone = $(this).clone();
//			clone.children().remove();
//			var title   = clone.text();
//
//			var forName = $(this).attr("for");
//			if(bookLink != null){
//				var linkId  = "link_"+forName;
//				$(this).before('<a id="'+linkId+'"/>');
//				bookLink.find('ul').append('<li><a href="#'+linkId+'">'+title+'</a></li>');
//				bookLink.find('a[href=#'+linkId+']').bind("click", function(){
//					// blink animation
//					uxl.blink($('h4[for="'+forName+'"]'));
//				});
//			}
//			
//			$(this).addClass("nahq-booklink-item");
//		});
		
		var folderList = $('.ub-control.title[hfold=1]', target);
		folderList.removeClass('hfold').addClass('hfold');
		folderList.each(function(){
			
			// 제목 추출
			var clone = $(this).clone();
			clone.children().remove();
			var title   = clone.text();

			// 하위 노드 이벤트 전달 제거
			var clone = $(this).clone();
			clone.children().unbind('click').bind('click', function(event){
				event.stopPropagation();
			});

			$(this).empty();
			$(this).append('<span class="ico-fold on" />');
			$(this).append(title);
		    $(this).append(clone.children());
			
			var forNames = $(this).attr("for").split(',');
			var forObjects = [];
			var checkFor = true;

			for(var i=0; i<forNames.length; i++){
			    if($('#'+uxl.trim(forNames[i]), target).size() == 0){
			    	checkFor = false;
			    	break;
			    }else{
			    	forObjects[forObjects.length] = $('#'+uxl.trim(forNames[i]), target)[0];
			    }
			}
			
			if(!checkFor){
		    	$(this).css("color", "red");
		    	$(this).click(function(){
		    		alert('Does not found id. ['+forName[i]+']\nYou must bind [for] attribute.');
		    		return;
		    	});
		    }
		    
	    	if($(this).attr('initClose') == '1'){
	    		$(forObjects).hide();
    			$(this).find(".ico-fold").removeClass("on");
	    		
	    		$(this).toggle(function(){
	    			$(this).find(".ico-fold").addClass("on");
	    			$(forObjects).show('slow', function(){
	    				// Tab 일경우 리사이즈 조정
	    				try{ resize(); }catch(e){};
	    			});
	    		}, function(){
	    			$(this).find(".ico-fold").removeClass("on");
	    			$(forObjects).hide('slow', function(){
	    				// Tab 일경우 리사이즈 조정
	    				try{ resize(); }catch(e){};
	    			});
	    		});
	    	}else{
	    		$(forObjects).show();
	    		
	    		$(this).toggle(function(){
	    			$(this).find(".ico-fold").removeClass("on");
	    			$(forObjects).slideUp('slow', function(){
	    				// Tab 일경우 리사이즈 조정
	    				try{ resize(); }catch(e){};
	    			});
	    		}, function(){
	    			$(this).find(".ico-fold").addClass("on");
	    			$(forObjects).slideDown('slow', function(){
	    				// Tab 일경우 리사이즈 조정
	    				try{ resize(); }catch(e){};
	    			});
	    		});
	    	};
		});
	};

	/**
	 * MutiSelect Width 조정 함수
	 */
	uxl.setMultiSelectWidth = function(obj){
		var width = $(obj).css('width').replace('px');
		var minWidth = $(obj).multiselect('option').minWidth;
		if(width > minWidth){
			$(obj).next().css('width', $(obj).css('width'));
		}
	};
	
	/**
	 * MutiSelect Combobox UI 생성
	 */
	uxl.setMultiSelect = function(target){
		target = target || document;
		
		$('.ub-control.select.multiselect', target).each(function(){
			$(this).attr('multiple', true);
			if($(this).attr('filterYn') == '1' || $(this).attr('filterYn') == 'Y' || $(this).attr('filterYn') == 'y'){
				$(this).multiselect({
					create : function(event, ui){
						uxl.setMultiSelectWidth(this);
					},
				    refresh : function(event, ui){
						uxl.setMultiSelectWidth(this);
				    }
				}).multiselectfilter();
			}else{
				$(this).multiselect({
					create : function(event, ui){
						uxl.setMultiSelectWidth(this);
					},
					refresh : function(event, ui){
						uxl.setMultiSelectWidth(this);
					}
				});
			}
			$(this).multiselect('uncheckAll');
		});
	};
	
	/**
	 * enter key
	 * @return 없음
	 */
	uxl.handleEnter = function (id) {
		var keyCode = event.keyCode ? event.keyCode : event.which ? event.which : event.charCode;
		if (keyCode == 13) {
			$('#'+id).click();
		}
	};

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
	uxl.autocomplete = function(element, url, option) {
		element = uxl.isString(element) ? '#' + element : element;

		var key = '';
		option = $.extend({
			minLength : 2,
			dataListId : 0,
			itemExtractor : function(row) {
				return {
					value : row.VALUE,
					label : row.LABEL
				};
			},
			filter : function(row) {
				return true;
			},
			focus: function(event, ui) {
				return false;
			},
			open: function(event, ui) {
			},
			select: function(event, ui) {
			}
		}, option || {});

		option = $.extend({
			source: function(request, response) {
				if(uxl.isFunction(option.data)) {
					option.data = option.data();
				}
				option.data = option.data || {};

				key = request.term;
				option.data[$(element).attr('id')] = key;
				
				uxl.callFunction(url , {  data:option.data
									    , loading:false
									    , success:function(result) {var dataList = result.getDataList(option.dataListId) || {};
																	response($.map(dataList.rows || {}, function(row) {
																		if(option.filter(row) !== true) {
																			return null;
																		}
																		else {
																			var item = option.itemExtractor(row);
																			item.label = item.label
																				.replace(/\>/g, '&gt;')
																				.replace(/\</g, '&lt;')
																				.replace(
																					new RegExp(
																						'(?![^&;]+;)(?!<[^<>]*)(' +
																						$.ui.autocomplete.escapeRegex(request.term) +
																						')(?![^<>]*>)(?![^&;]+;)', 'gi'
																					), '<strong style="color: #f76d1a;">$1</strong>');
																			return item;
																		}
																	}));
																   }
									   , async:true
							    });
			}
		}, option);

		var open = option.open;
		option.open = function(event, ui) {
			open(event, ui);
		};

		var el = $(element).autocomplete(option);

		el.data('autocomplete')._renderItem = function(ul, item) {
			return $('<li></li>')
				.data('item.autocomplete', item )
				.append('<a><label style="white-space: nowrap;">' + item.label + '</label></a>')
				.appendTo(ul);
		};
	};

	$.datepicker.regional['ko'] = {
		closeText: '닫기',
		prevText: '이전달',
		nextText: '다음달',
		currentText: '오늘',
		yearSuffix: '년&nbsp;&nbsp;',
		monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
		dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
		dayNamesShort: ['일','월','화','수','목','금','토'],
		dayNamesMin: ['<span class="sun">일</span>','월','화','수','목','금','<span class="sat">토</span>'],
		weekHeader: 'Wk',
		dateFormat: 'yy-mm-dd',
		firstDay: 0,
		isRTL: false,
		showMonthAfterYear: true,
		showOn: 'button',
		buttonImage: _CONTEXT_ROOT + '/page/images/common/calendar.gif',
		buttonImageOnly: true,
		buttonText: 'Calandar',
		changeMonth: true,
		changeYear: true
	};
	$.datepicker.regional['en'] = {
			closeText: 'close',
			prevText: 'Prev.Month',
			nextText: 'Next.Month',
			currentText: 'Today',
			yearSuffix: '',
			monthNames: ['January','February','March','April','May','June','July','August','September','October','November','December'],
			monthNamesShort: ['JAN','FEB','MAR','APR','MAY','JUN','JUL','AUG','SEP','OCT','NOV','DEC'],
			dayNames: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'],
			dayNamesShort: ['SUN','MON','TUE','WED','THU','FRI','SAT'],
			dayNamesMin: ['<span class="sun">S</span>','M','T','W','T','F','<span class="sat">S</span>'],
			weekHeader: 'Wk',
			dateFormat: 'yy-mm-dd',
			firstDay: 0,
			isRTL: false,
			showMonthAfterYear: true,
			showOn: 'button',
			buttonImage: _CONTEXT_ROOT + '/page/images/common/calendar.gif',
			buttonImageOnly: true,
			buttonText: 'Calandar',
			changeMonth: true,
			changeYear: true
		};

	$.datepicker.setDefaults($.datepicker.regional['en']);

	/**
	 * jquery 확장 : 콤보박스의 항목들을 모두 지운다.
	 */
	$.fn.emptySelect = function(emptyOption) {
		return this.each(function() {
			if(this.tagName == 'SELECT') {
				this.options.length = 0;
				
				if(this.type == 'select-multiple'){
					try{
						$(this).multiselect('refresh');
					}catch(e){}
					
				}else if(this.type == 'select-one'){
					if(emptyOption === 'none'){
						
					}else if(uxl.isUndefined(emptyOption) || emptyOption === true) {
						var $option = $('<option></option>', {
							value: '',
							text: uxl.getMessage('label.common.notselected')
						});
						$(this).append($option);
						
					}
					else if(uxl.isString(emptyOption)) {
						var $option = $('<option></option>', {
							value: '',
							text: uxl.isMessageKey(emptyOption) ? uxl.getMessage(emptyOption) : emptyOption
						});
						$(this).append($option);
					}
				}
			}
		});
	};

	/**
	 * jquery 확장 : 주어진 배열 데이타로 콤보박스 항목을 생성한다.
	 */
	$.fn.loadSelect = function(optionDataArray, emptyOption , defaultValue) {
		return this.emptySelect(emptyOption).each(function() {
			if(optionDataArray == null || typeof(optionDataArray)=='undefined'){
				return ;
			}
			if(this.tagName == 'SELECT') {
				var selectElement = this;
				$.each(optionDataArray, function(index, optionData) {

					var CODE_NAME = optionData[uxl.CONSTANT.CODE.NAME];

					// JSON 객체중 숫자 값일경우는 Number Type으로 들어오므로 type을 체크하여 처리
					if(typeof CODE_NAME == 'string'){
						if(CODE_NAME.indexOf('RSC:') > -1){
							CODE_NAME = uxl.getMessage(CODE_NAME.substring(4));
						}
					}

					var option = new Option(CODE_NAME, ''+optionData[uxl.CONSTANT.CODE.CODE]);
					if(optionData[uxl.CONSTANT.CODE.CODE] == defaultValue){
					        setTimeout(function(){
							option.selected = true;
						},100);
					}

					if($.browser.msie) {
						selectElement.add(option);
					}
					else {
						selectElement.add(option, null);
					}


				});
				
				if(this.type == 'select-multiple'){
					try{
						$(this).multiselect('refresh');
					}catch(e){}
				}
			}
		});
	};

	/**
	 * jquery 확장 : 주어진 text, value 값을 갖는 option 을 콤보박스에 추가한다.
	 */
	$.fn.addOption = function(text, value) {
		return this.each(function() {
			if(this.tagName == 'SELECT') {
				var $option = $('<option></option>', {
					value: value,
					text: text
				});
				$(this).append($option);
			}
		});
	};

	/**
	 * jquery 확장 : 필수 항목 View 설정
	 */
	/*
	$.fn.displayRequired = function() {
		return this.each(function() {
			var el = $(this);
			$('.ui-icon-check', el).remove();
			if(uxl.isNotEmpty(el.attr('for'))) {
				var targets = el.attr('for').split(',');
				for(var i=0; i<targets.length; i++) {
					var targetId = '#' + targets[i];
					if(el.hasClass('required') || $(targetId).hasClass('required') || $(targetId).attr('metaessential') == '1') {
						if($('.ui-icon-check', el).size() == 0) {
							$('<span class="ui-icon ui-icon-check" style="margin-bottom:-3px;"/>').appendTo(this);
						}
					}
				}
			}
		});
	};
	*/
	$.fn.displayRequired = function() {
		return this.each(function() {
			var el = $(this);
			if(uxl.isNotEmpty(el.attr('for'))) {
				var targets = el.attr('for').split(',');
				for(var i=0; i<targets.length; i++) {
					var targetId = '#' + targets[i];
					if(el.hasClass('required') || $(targetId).hasClass('required') || $(targetId).attr('metaessential') == '1') {
						if($('span.required' , $(this)).size() ==0){
							$('<span class="required">*</span>').appendTo(this);	
						}	  
					}
				}
			}
		});
	};
	

	/**
	 * jquery 확장 : 필수 항목 속성 추가
	 */
	$.fn.setRequired = function(flag) {
		return this.each(function() {
			var $el = $(this);
			//$el.toggleClass('required', flag);
			if(flag) {
				$el.attr('metaessential', '1');
			}
			else {
				$el.attr('metaessential', '0');
			}

			if($('label[for=' + this.id + ']').children().size() == 0){
            	$('label[for=' + this.id + ']').displayRequired();	
            }else{
            	$('label[for=' + this.id + '] > span').remove();
            }
		});
	};

	/**
	 * jquery 확장 : 사용자/부서 입력 컨트롤
	 */
	/*$.extend({
		finder: {
			empoyee: {
				description: '사원',
				icon: 'ui-icon-person',
				id_column: 'USER_ID',
				nm_column: 'USER_NM',

				// 검색 조회 서비스 ID
				autocompleteServiceId: 'SVCBCO0001',
				// 상세 조회 서비스 ID
				detailServiceId: 'SVCBCO0002',
				// 상세 조회 화면 ID
				detailViewId: 'BCO0014',
				detailViewWidth: 580,
				// 검색 팝업 화면 ID
				searchViewId: 'BCO0012',
				searchViewWidth:840,
				searchViewHeight:500,

				// default autocomplete result item extractor
				itemExtractor: function(row) {
	    			return {
	    				label: row.USER_NM + '(' + row.USER_ID + ')',
	    				value: row.USER_NM,
	    				id: row.USER_ID
	    			};
	    		},

				// default employee display
    			display: function(row) {
	    			return row.USER_NM + '(' + row.USER_ID + ')';
    			}
			},
			department: {
				description: '부서',
				icon: 'ui-icon-flag',
				id_column: 'DEPT_ID',
				nm_column: 'DEPT_NM',

				// 검색 조회 서비스 ID
				autocompleteServiceId: 'SVCBCO0005',
				// 상세 조회 서비스 ID
				detailServiceId: 'SVCBCO0006',
				// 상세 조회 화면 ID
				detailViewId: 'BCO0015',
				detailViewWidth: 562,
				// 검색 팝업 화면 ID
				searchViewId: 'BCO0016',
				searchViewWidth: 520,
				searchViewHeight: 500,

				// default autocomplete result item extractor
				itemExtractor: function(row) {
	    			return {
	    				label: row.DEPT_NM_FULL,
	    				value: row.DEPT_NM,
	    				id: row.DEPT_ID
	    			};
	    		},

				// default department display
    			display: function(row) {
    				return row.DEPT_NM;
    				//return (uxl.isNotEmpty(row.DEPT_NM_UP) ? row.DEPT_NM_UP + ' > ' : '') + row.DEPT_NM;
    			}
			},

			// default settings for the plugin
			_options: {
    			searchWidth: 120,
    			selectAny: true,
    			department: null,
    			departmentObjectId: null,
    			pixDepartment:false,
				filter: function(row) {
					return true;
	    		},
    			selected: function(detail) {
    			},
    			removed: function(id) {
    			}
			},

			_containerPrefix: 'FINDER_CONTAINER_',
			_search_input_id: 'FINDER_NM',
			_search_button_id: 'FINDER_BUTTON',
			_list_id: 'FINDER_LIST',

			_getBase: function(type) {
				type = type || 'employee';
				type = type.toLowerCase();
				if(type == 'employee' || type == 'user' || type == 'emp' || type == 'u' || type == 'e') {
					return this.empoyee;
				}
				else {
					return this.department;
				}
			},

			init: function(el, options) {
				var thisObject = this;
				options = $.extend({}, this._options, options || {});
				if(el.size() > 0) {
					options.searchWidth = el.css("width").replace('px', '') - 15;
				}

				return el.each(function() {
					var data = {
						'control_id': this.id,
						'control_base': $(this).attr('metadatatype'),
						'control_type': this.tagName,
						'control_required': $(this).attr('metaessential') == '1',
						'control_readonly': this.disabled || this.readOnly,
						'control_width': $(this).innerWidth(),
						'control_length': this.size
					};
					var $container = $('<div></div>', {
						id: thisObject._containerPrefix + this.id,
						'class': 'finder_container'
					})
					.data(data);

					var control_base = thisObject._getBase($(this).attr('metadatatype'));

					var $searchInput = thisObject._makeSearchInput(this.id, this.tagName, control_base, options);
					var $findbutton= thisObject._makeFindButton(this.id, this.tagName, control_base, options);
					var $list = thisObject._makeList(this.id, this.tagName, control_base, options, data.control_width);

					$(this).after($container);
					$container.append($searchInput);
					$container.append($findbutton);
					$container.append($list);

					thisObject._setAutocomplete($searchInput, this.id, this.tagName, control_base, options);

					// 초기 데이타 설정
					if(this.tagName == 'INPUT') {
						if(uxl.isNotEmpty(this.value)) {
							thisObject.addItem(this.id, this.value, null, options.remvoed, options.selected);
						}
					}
					else {
						var selectObject = this;
						$('option', this).each(function() {
							if(uxl.isNotEmpty(this.value)) {
								thisObject.addItem(selectObject.id, this.value, null, options.remvoed, options.selected);
							}
						});
					}

					// 필수여부 설정
					thisObject.setRequired(this.id, $(this).attr('metaessential') == '1');

					// 수정가능 여부 설정
					if(this.disabled || this.readOnly) {
						if(data.control_readonly) {
							$list.sortable('disabled');
						}
						thisObject._toggleInput($container, false);
					}

					$(this).remove();
				});
			},
			_makeSearchInput: function(control_id, type, base, options) {
				return $searchInput = $('<input/>', {
					id: this._search_input_id,
					name: this._search_input_id,
					style: 'width:' + options.searchWidth + 'px; !important; color:#9C9C9C; ime-mode:active;',
					value: base.description + '검색',
					focus: function() {
						this.value = '';
					}
				}).keypress(function(event) {
					if (event.which == '13') {
						event.preventDefault();
					}
				});
			},
			_setAutocomplete: function($searchInput, control_id, type, base, options) {
				var thisObject = this;
				var department = options.department;
				var selected = options.selected;
				var removed = options.removed;
				var dataFunction = function() {
					var data = {};
					if(uxl.isNotNull(options.departmentObjectId)) {
						var val = $('#' + options.departmentObjectId).val();
						if(uxl.isNotEmpty(val)) {
							department = val;
						}
					}
					if(uxl.isNotEmpty(department)) {
						data.DEPT_ID = department;
					}
					return data;
				};
				var option = {
					filter: options.filter,
					itemExtractor: base.itemExtractor,
		    		select: function(event, ui) {
						thisObject.addItem(control_id, ui.item.id, selected, removed);
						$searchInput.val('');
						return false;
		    		}
				};
				uxl.autocomplete($searchInput, base.autocompleteServiceId, dataFunction, option);
			},
			_makeFindButton: function(control_id, type, base, options) {
				var thisObject = this;
				var selectAny = options.selectAny;
				var department = options.department;
				var departmentObjectId = options.departmentObjectId;
				var pixDepartment = options.pixDepartment;
				var selected = options.selected;
				var removed = options.removed;

				return $('<label style="padding-top:2px; border: none; backgroud: none;" id="' + this._search_button_id + '"><span class="ui-icon ui-icon-search" style="margin-bottom:-2px; cursor:pointer;" title="찾기"></span></label>')
				.click(function() {
					var url = uxl.getScreenURL(base.searchViewId);
					if(type == 'INPUT') {
						url = uxl.addQueryToUrl(url, 'only_one', 'true');
					}
					else {
						url = uxl.addQueryToUrl(url, 'only_one', 'false');
					}
					if(selectAny == false) {
						url = uxl.addQueryToUrl(url, 'sel_any', 'F');
					}
					else {
						url = uxl.addQueryToUrl(url, 'sel_any', 'T');
					}
					if(pixDepartment == false) {
						url = uxl.addQueryToUrl(url, 'pix_Department', 'false');
					}
					else {
						url = uxl.addQueryToUrl(url, 'pix_Department', 'true');
					}

					if(uxl.isNotNull(departmentObjectId)) {
						var val = $('#' + departmentObjectId).val();
						if(uxl.isNotEmpty(val)) {
							department = val;
						}
					}
					if(uxl.isNotEmpty(department)) {
						url = uxl.addQueryToUrl(url, 'DEPT_ID', department);
					}

					var option = {
						width: base.searchViewWidth,
						height: base.searchViewHeight
					};
					var handler = function(data) {
						if(data != null && data != -1 && data != 0) {
							if(uxl.isString(data)) {
								thisObject.addItem(control_id, data, selected, removed);
							}
							else {
								if(type == 'INPUT') {
									thisObject.addItem(control_id, data[0], selected, removed);
								}
								else {
									$.each(data, function() {
										return thisObject.addItem(control_id, this, selected, removed);
									});
								}
							}
						}
					};

					uxl.openWindow(base.searchViewId, url, option, handler);
				})
				.hover(function(event) {
					$(this).toggleClass('ui-state-hover');
					return false;
				});
			},
			_makeList: function(id, type, base, options, width) {
				var $list = $('<ul id="' + this._list_id + '" class="sortable ui-widget-content ui-priority-secondary" style="width:' + width + 'px; margin-left: 3px"></ul>');
				if(type == 'INPUT') {
					$list
					.css('padding', '0px')
					.hide();
				}
				else {
					$list
					.css('min-height', '22px')
					.css('padding', '3px')
					.sortable({
						placeholder: 'ui-state-highlight',
						containment: 'parent'
					});
				}
				return $list;
			},

			// 선택항목 list 에 항목 추가
			addItem: function(control_id, id, selected, removed) {
				var thisObject = this;
				var $container = $('#' + this._containerPrefix + control_id);
				var $list = $('#' + this._list_id, $container).show();
				var control_base = this._getBase($container.data('control_base'));
				var thisSelected = selected;
				var thisRemoved = removed;
				if(this._addValidation($container, $list, id) === false) {
					return false;
				}

				var $item = $('<li></li>', {
					id: 'item_' + id,
					text: id,
					style: "padding: 1px 0px 1px 5px;"
				});

				$list.append($item);

				var data = {};
				data[control_base.id_column] = id;

				uxl.ajaxQuery(control_base.detailServiceId, data, function(result) {
					var detail = result.getDetail();
					var $label = thisObject._makeLabel(detail, control_base);
					var $del = thisObject._makeRemoveButton(control_id, detail, control_base, thisRemoved);
					var $hidden = $('<input/>', {
						'type': 'hidden',
						id: $container.data('control_id'),
						name: $container.data('control_id'),
						value: id
					});

					$item.empty()
					.append($label)
					.append($hidden);

					if($container.data('control_type') == 'INPUT') {
						var $change = thisObject._makeChangeButton($container);
						$item.append($change);

						if($container.data('control_readonly')) {
							$change.hide();
						}
					}

					$item.append($del);
					if($container.data('control_readonly')) {
						$del.hide();
					}

					$('#' + thisObject._search_input_id, $container).removeClass('ui-state-error');
					if(uxl.isFunction(thisSelected)) {
						thisSelected(detail);
					}
				});

				try {resize();}
				catch(e) {}

			},
			// list로부터 항목 삭제
			removeItem: function(control_id, id, removed) {
				var $container = $('#' + this._containerPrefix + control_id);
				var $list = $('#' + this._list_id, $container);

				if($container.data('control_type') == 'INPUT') {
					$list.hide();
					this._toggleInput($container, true);
				}

				if(uxl.isEmpty(id)) {
					$('li', $list).each(function() {
						if(uxl.isFunction(removed)) {
							removed($('input', this).val());
						}
						$(this).remove();
					});
				}
				else {
					$('input[value=' + id + ']', $list).each(function() {
						if(uxl.isFunction(removed)) {
							removed(id);
						}
						$(this).parent().remove();
					});
				}
			},
			_addValidation: function($container, $list, id) {
				if($container.data('control_type') == 'INPUT') {
					$('li', $list).remove();
					this._toggleInput($container, false);
				}
				else {
					if($container.data('control_length') != 0) {
						if($('li', $list).size() >= $container.data('control_length')) {
							uxl.showMessage('@message.common.validation.nomore');
							return false;
						}
					}
				}

				if($('input[value=' + id + ']', $list).size() > 0) {
					uxl.showMessage('@message.common.validation.duplicated');
					return false;
				}
				return true;
			},
			_makeLabel: function(detail, control_base) {
				return $('<label></label>', {
					text: control_base.display(detail),
					title: 'click to open [' + detail[control_base.nm_column] + '] detail view',
					'class' :  'ui-width-content',
					mouseover: function() {
						$(this).parent().addClass('ui-state-highlight').css('border', '0px');
						return false;
					},
					mouseout: function() {
						$(this).parent().removeClass('ui-state-highlight');
						return false;
					},
					click: function(e) {
			    		if($('#detailViewer_' + detail[control_base.id_column]).size() == 0) {
			    			$('<div id="detailViewer_' + detail[control_base.id_column] + '"></div>').appendTo('body');
			    		}

			    		var fixLeft = function(left) {
			    			if(left + control_base.detailViewWidth > $(window).width()) {
			    				return $(window).width() - control_base.detailViewWidth < 0 ? 0 : $(window).width() - control_base.detailViewWidth - 12;
			    			}
			    			else {
			    				return left;
			    			}
			    		};

						var data = {};
						data[control_base.id_column] = detail[control_base.id_column];
						$('#detailViewer_' + detail[control_base.id_column]).dialog({
							width: control_base.detailViewWidth,
							title : control_base.description + ' 상세',
							position : [fixLeft(e.clientX), e.clientY + 12],
							open: function(event, ui) {
			    				uxl.load(this, control_base.detailViewId, data);
							},
							close: function(event, ui) {
								$(this).remove();
							}
						});
					}
				})
				.append('<span class="ui-icon ' + control_base.icon + '" style="margin-bottom:-2px; margin-right:4px; cursor:pointer;"/>');
			},
			_makeRemoveButton: function(control_id, detail, control_base, removed) {
				var thisObject = this;
				var thisRemoved = removed;
				return $('<label class="edit_mode" style="padding-top:2px"><span title="click to remove [' + detail[control_base.nm_column] + ']" class="ui-icon ui-icon-close" style="margin-bottom:-2px; cursor:pointer;"/></label>')
				.click(function() {
					thisObject.removeItem(control_id, detail[control_base.id_column], thisRemoved);

				})
				.hover(function(event) {
					$(this).toggleClass('ui-state-hover');
					return false;
				})
				.mouseout(function() {
					return false;
				});
			},
			_makeChangeButton: function($container) {
				var thisObject = this;
				return $('<label class="edit_mode" style="padding-top:2px"><span title="toggle user search" class="ui-icon ui-icon-locked" style="margin-bottom:-2px; cursor:pointer;"/></label>')
				.toggle(function() {
					$('span', this).toggleClass('ui-icon-unlocked');
					thisObject._toggleInput($container, true);
				}, function() {
					$('span', this).toggleClass('ui-icon-unlocked');
					thisObject._toggleInput($container, false);
				})
				.hover(function(event) {
					$(this).toggleClass('ui-state-hover');
					return false;
				})
				.mouseout(function() {
					return false;
				});
			},


			setDisabled: function(id) {
				var $container = $('#' + this._containerPrefix + id);
				$container.data('control_readonly', true);

				this._toggleInput($container, false);

				$('#' + this._list_id, $container).sortable('disable');
				$('li>label.edit_mode', $container).hide();
			},

			setEnabled: function(id) {
				var $container = $('#' + this._containerPrefix + id);
				$container.data('control_readonly', false);

				if($container.data('control_type') == 'INPUT') {
					if($('li', $container).size() == 0) {
						this._toggleInput($container, true);
					}
				}
				else {
					this._toggleInput($container, true);
				}

				$('#' + this._list_id, $container).sortable('enable');
				$('li>label.edit_mode', $container).show();
			},

			setRequired: function(id, flag) {
				var $container = $('#' + this._containerPrefix + id);
				$container.data('control_required', flag);
				if(flag == true) {
					$('label[for=' + id + ']').addClass('required').displayRequired();
					uxl.addValidation(id, function() {
						if($('li', $container).size() == 0) {
							var message = uxl.getMessage('message.common.validation.noselect', $('label[for=' + id + ']').text());
							if(window.top && window.top.uxl) {
								window.top.uxl.showMessage(message, uxl.getRequireErrorFunction($('input:first', $container)));
							}
							else {
								uxl.showMessage(message, uxl.getRequireErrorFunction($('input:first', $container)));
							}
							return false;
						}
						return true;
					});
				}
				else {
					$('label[for=' + id + ']').removeClass('required').displayRequired();
					uxl.removeValidation(id);
				}
			},

			isEmpty: function(id) {
				var $container = $('#' + this._containerPrefix + id);
				return $('li', $container).size() == 0;
			},

			checkEmpty: function(id) {
				var $container = $('#' + this._containerPrefix + id);
				if(this.isEmpty(id)) {
					var message = uxl.getMessage('message.common.validation.noselect', uxl.trim($('label[for*=' + id + ']').text()));
					if(window.top && window.top.uxl) {
						window.top.uxl.showMessage(message, uxl.getRequireErrorFunction($('input:first', $container)));
					}
					else {
						uxl.showMessage(message, uxl.getRequireErrorFunction($('input:first', $container)));
					}
					return true;
				}
				return false;
			},

			_toggleInput: function($container, flag) {
				var $input = $('#' + this._search_input_id, $container);
				var $button = $('#' + this._search_button_id, $container);
				if(flag === true) {
					$input.show();
					$button.show();
				}
				else {
					$input.hide();
					$button.hide();
				}
			}
		}
	});*/

	$.fn.finder = function(options) {
		return $.finder.init(this, options);
	};

	/**
	 * APMD 정보 연결 버튼 생성
	 */
	uxl.setLinkAPMD = function(target){
		target = target || document;
		var screenId = _SCREEN_ID;

		// Target이 TabContents이면
		if($(target).hasClass('ub-tab-content')){
			screenId = $('.ub-page.div-tab', target).attr('data-screen-id');
		}
		
		var ignoreScreenCategory = ['APM', 'UBD', 'UBS'];
		var passFlag = true;
		for(var i = 0 ; i < ignoreScreenCategory.length ; i++){
			if(screenId.indexOf(ignoreScreenCategory[i]) >= 0){
				passFlag = false;
				break;
			}
		}
		if(_SERVER_MODE == 'local'){
			// APMD 링크 버튼 표시
			var html = '<section class="ub-frame toolbar"><div class="ub-layout apmd-panel">';
			if(passFlag){
				html += '<a class="apmd-link" title="Link APMD">APMD</a>&nbsp;';
			}
			
			if(_USE_MULTI_LANG){
				html += '<a class="message-debug" title="Message Debug">Msg.Debug</a>';
				for(var i=0; i<_USE_LANG_LIST.length; i++){			
					html += '&nbsp;<a class="lang-list" title="Change to ['+_USE_LANG_LIST[i]+'] mode" code="'+_USE_LANG_LIST[i]+'">['+_USE_LANG_LIST[i]+']</a>';
				}
			}
			html += '</div></section>';
			
			var newLinker = $(html);
			if(target == document){
				$('body').append(newLinker);
			}else{
				$(target).append(newLinker);
			}
			
			$('.ub-layout.apmd-panel a.apmd-link', newLinker).click(function(){
				var param = "?SCREEN_ID=" + screenId + "&call_layout=Popup";
				uxl.openWindow('apmdScreenLinkPop', uxl.getScreenURL('APM0002') + param, {scrollbars:'yes', width:1280, height:800});
			});
			
			// 메세지Debug 버튼 표시
			$('.ub-layout.apmd-panel a.message-debug', newLinker).click(function(){
				uxl.messageDebugMode();
			});
			
			// 다국어 모드변경
			$('.ub-layout.apmd-panel a.lang-list', newLinker).click(function(){
				uxl.changeLocale($(this).attr('code'));
			});
		}
	};
	
	/**
	 * 메세지 디버그 모드를 변경하는 함수
	 */
	uxl.messageDebugMode = function(){
		$.ajax({
			url: '/messageDebug.ub',
			success: function(result){
				uxl.reload(document, true);
			}
		});
	};	
	
	/**
	 * 검색 확장영역 버튼 생성 및 버튼이벤트 바인딩 
	 */
	uxl.setSearchAdvancedButton = function(target){
		target = target || document;

		var lytSearchAdvanced = $('.ub-layout.search-advanced', target);
		if(lytSearchAdvanced.length == 0){
			return;
		}
		
		//버튼 추가 및 이벤트 바인딩
		lytSearchAdvanced.prepend("<span class='btn'><a href='#' class='open'><span>advanced</span></a></span>");
		lytSearchAdvanced.append("<input type=hidden name='SEARCH_ADVANCED_FLAG' value='"+_SEARCH_ADVANCED_FLAG+"'>");
		
		$('span.btn', lytSearchAdvanced).click(function(){
			$(this.parentElement).toggleClass('close');
			$(this.children).toggleClass('open close');
			$('input[name="SEARCH_ADVANCED_FLAG"]', lytSearchAdvanced).val(!lytSearchAdvanced.hasClass('close'));
		});
		
		if("true"==_SEARCH_ADVANCED_FLAG){
			$('span.btn', lytSearchAdvanced).click();
		}
	};

	/**
	 * Input 태그의 마스크를 처리하는 함수
	 * @param item     - object
	 * @param maskType - mask 유형 (number, date, ... )
	 */
	uxl.setInputMask = function(item, maskType){
		if(maskType == "number"){//숫자
			$(item).css('text-align', 'right');
			$(item).mask('#,##0', {reverse: true});
		}
		else if(maskType == "date"){//날짜
			$(item).mask('0000-00-00');
		}
		else if(maskType == "postno"){//우편번호(구,신 모두 적용)
			// 마스크 셋팅
			var masks = ['00000#', '000-000'];
			
			// 마스크 초기화
			var maskInit = ($(item).val().replace('-','').length > 5) ? masks[1] : masks[0];
			
			// 마스크 옵션
			var options =  {onKeyPress: function(cep, e, field, options){
				  							cep = cep.replace('-','');
				  							mask = (cep.length > 5) ? masks[1] : masks[0];
				  							$(item).mask(mask, options);
										}
							};	
			
			// 마스크 적용
			$(item).mask(maskInit, options);
		}
		else if(maskType == "cellPhone"){//핸드폰
			//마스크 셋팅
			var masks = ['000-000-0000#', '000-0000-0000'];
			
			// 마스크 초기화
			var	maskInit = ($(item).val().length > 12) ? masks[1] : masks[0];
			
			// 마스크 옵션
			var options =  { onKeyPress: function(cep, e, field, options){
				  							var mask = (cep.length > 12) ? masks[1] : masks[0];
				  							$(item).mask(mask, options);
										}
							};
			//마스크 적용
			$(item).mask(maskInit, options);
		}
		else if(maskType == "resident1"){//주민등록번호 앞 6자리
			$(item).mask('000000');
		}
		else if(maskType == "resident2"){//주민등록번호 뒤 7자리
			$(item).mask('0000000');
		}
		else if(maskType == "resident"){//주민등록번호 전체
			$(item).mask('000000-0000000');
		}
		else if(maskType == "business1"){//사업자번호 앞 3자리
			$(item).mask('000');
		}
		else if(maskType == "business2"){//사업자번호 중간 2자리
			$(item).mask('00');
		}
		else if(maskType == "business3"){//사업자번호 뒤 5자리
			$(item).mask('00000');
		}
		else if(maskType == "business"){//사업자번호 전체
			$(item).mask('000-00-00000');
		}				
	};

	/**
	 * 웹 접근성 관련 함수 추가
	 */	
	uxl.setWebAccessibility = function(target){
		target = target || document;

		$('html', target).attr('lang', _CURR_LANG_CD);							// html의 기본언어 설정
		$('iframe', target).attr('title', document.title);						// iframe의 Title지정 - 현재문서의 타이틀로 설정
		
		$('th', $('.ub-control.table.normal', target)).attr('scope', 'col');	// 일반 테이블의 TH Scope은 col
		$('.ub-control.table.normal', target).each(function(index){
			// Caption이 없을 경우에 생성함.
			if($('caption', $(this)).size() == 0){
				$(this).prepend('<caption>'+_SCREEN_NAME+'-Normal-'+index+'</caption>');
			}
			$(this).attr('summary', _SCREEN_NAME+'-Normal Summary-'+index);
		});
	};
	
	/**
	 * 퍼블리싱을 위한 현재 브라우져의 정보를 추가로 설정하는 함수
	 */
	uxl.setBrowserInfo = function(){
		$(window).resize(function(){
			if(uxl.isMobile()){
				$('body').addClass("mobile");
			}else{
				$('body').removeClass("mobile");
			}
		}).resize();
	};
	
	/**
	 * 모바일 접속여부
	 */
	uxl.isMobile = function(){
		return /mobile/i.test(navigator.userAgent.toLowerCase());
	};
	
	/**
	 * Excel 다운로드 다이얼로그 함수
	 */
	uxl.excelDaolog = function (result){
			var filelink = result.getResultKey();
			if ($('#exportViewer').size() == 0) {
				$('<div id="exportViewer"></div>').appendTo('body');
			}
			$('#exportViewer').dialog({
				width: 460,
				title : 'Download Result',
				open: function(event, ui) {
					var tag = '';
					if(filelink == null) {
						tag = tag + '<span>다운로드할 데이터가 존재하지 않습니다.</span>';
					}
					else {
						tag = tag + '<span>아래의 다운로드 link를 클릭하시면 파일을 다운로드 받을 수 있습니다.</span>';
						tag = tag + '<br/><br/><ul>';
						for(var i=0; i<filelink.length; i++) {
							var url = uxl.getContextURL('/excel/list.ub');
							url = uxl.addQueryToUrl(url, 'encFile', filelink[i]);
							tag = tag + '<li ><a href="' + url + '" target="_self" style="color:#B54444"> 다운로드 파일 '+ (i + 1) +' </a></li>';
						}
						tag = tag + '</ul>';
					}
					
					$(this).html(tag);
				},
				close: function(event, ui) {
					$(this).remove();
				}
			});
	}
})(jQuery, uxl);