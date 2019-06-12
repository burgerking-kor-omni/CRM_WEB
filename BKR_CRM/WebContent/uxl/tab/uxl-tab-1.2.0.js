(function($, uxl) {
	
	/**
	 * @class 탭 위젯 클래스<br/>
	 * @see uxl-tab-1.2.0.js
	 * @param id tab id
	 * @param options
	 * 
	 * * Release 
	 *  - 1.2.0 : IFrame Memory Leak 현상 대체 처리(IFrame 동적 삭제시 메모리 누수현상 발생.)
	 *            탭삭제시 로드된 페이지 about:blank로 URL전환
	 *               
	 * --------------------------------------------------------------------------------------
	 * 	options 정의
	 * --------------------------------------------------------------------------------------
	 *        속성명       : 초기값  - 설명
	 * 		- showOnAdded  : true
	 *            - true  - Tab 추가시 Show 하기
	 *            - false - Tab 추가시 Show 하지 않음
	 * 		- reloadOnShow : false
	 *            - true  - 탭 선택시 탭 컨트르를 Reload 함.
	 *            - false - 탭 선택시 탭 컨트르를 Reload 하지 않음.
	 *      - iframeScroll : false
	 *            - true  - iframe의 스크롤 표시
	 *            - false - iframe의 스크롤 표시 하지 않음
	 *      - tabPosition  : top   
	 *            - top    - top 으로 탭리스트 표시
	 *            - bottom - bottom 으로 탭리스트 표시
	 *            
	 *      - maxTabs      : 10  - 최대 탭 오픈 갯수를 설정한다.
	 *      - minTabs      : 1   - 최소 탭 오픈 갯수를 설정한다.
	 *      - overMaxTabs  : message
	 *            - message : 최대 탭 갯수 초과시 메세지 표시
	 *            - remove-first : 처음 Tab 삭제
	 *            - remove-last  : 마지막 Tab 삭제
	 *      - height       : tab의 height 초기 설정값 (default : 기본 사이즈로 설정)
	 *      - tabLock      : false
	 *            - true   : Tab에 Locking 기능을 Toggle로 설정/해제 할 수 있다.      
	 *            - false  : Tab에 Locking 기능을 사용하지 않는다.      
	 *      - tabSortable  : false
	 *            - true   : Tab 이동 기능을 사용한다. 
	 *            - false  : Tab 이동 기능을 사용하지 않는다. 
	 */
	uxl.Tabs = function(id, options) {
		var $tab;
		if(uxl.isString(id)) {
			$tab = $('#' + id);
		}
		else {
			$tab = $(id);
		}
		$tab.empty();
		
		if(uxl.isEmpty($tab.attr('id'))) {
			$tab.attr('id', 'lim072');
		}
		
		this.tabId = $tab.attr('id');		
		this.selectedCallbacks = {};
		
		// default options
		options = $.extend({
			showOnAdded:true,
			reloadOnShow:false,
			iframeScroll:false,
			tabPosition:'top',
			maxTabs:10,
			minTabs:1,
			overMaxTabs : 'message',
			height:'300px',
			tabLock:false,
			tabSortable:false
		}, options || {});		

		this.options = options;
		
		var $this = this;
		var selectedCallbacks = this.selectedCallbacks;
		$tab.append('<ul></ul>').tabs({
		    add: function(event, ui) {
				if(options.showOnAdded) {
					$tab.tabs('select', ui.index);
					
					if(options.tabPosition == 'bottom'){
						$this.setBottomTabs();
					}
				}
			},
			show: function(event, ui) {
				$('.ui-tabs-panel', $tab).hide();
				
				var iframeElement = $('iframe', $tab).get(ui.index);
				if(iframeElement) {
					if(uxl.isEmpty(iframeElement.src)) {
						var url = $('input[type=hidden]', $tab).get(ui.index).value;
						iframeElement.src = url;
					}
					else {
						if(options.reloadOnShow) {
							var url = $('input[type=hidden]', $tab).get(ui.index).value;
							iframeElement.src = url;
						}
					}
				}
				$('.ui-tabs-panel', $tab).eq(ui.index).show();
				
				if(uxl.isFunction(selectedCallbacks[ui.panel.id])) {
					selectedCallbacks[ui.panel.id]();
				}
			},
			load : function(event, ui){
			}
	    });
		this.tab = $tab;
		
		// Tab Sortable 설정
		if(this.options.tabSortable){
			var tabList = this.tab.find(".ui-tabs-nav");
			tabList.sortable({
				axis: 'x',
				placeholder: "ui-state-highlight",
				start: function(e, ui) {
					// Sortable 수평 이동시 상하 이동에 대한 쉬프트가 되어야 위치가 변경됨.
					// 좌우 수평에 대한 보정코딩.
		            ui.placeholder.html('&nbsp;'); // unquote this for fix.
		        },
		        stop:function(e, ui) {
		        	// Sortable 처리시 컨텐츠 영역도 탭의 위치와 동일하게 순서를 변경해 주어야 한다. 
		        	var flag = ui.originalPosition.left - ui.offset.left;
		        	
		        	var index = ui.item.index('.ui-state-default', tabList);
		        	var tabId = ui.item.attr('aria-controls');
		        	var panel = $('#'+tabId);
		        	var target = $tab.find('.ui-tabs-panel:nth-child('+(index+1)+')');

		        	// drag-drop의 위치가 동일위치는 제외
		        	if(target.attr('id') != tabId){
		        		if(flag > 0){
		        			target.before(panel);		        		
		        		}else{
		        			target.after(panel);
		        		}
		        	}
		        }
			});	
			tabList.disableSelection();
		}
		
		// Tab Close 버튼 이벤트 바인딩
		$('span.tab-button-close', $tab).live('click', function() {
			if($(this).parent().find('.ui-icon-locked').size() == 0){
				var index = $('li', $tab).index($(this).parent());
				uxl.removeIframe($('iframe',$tab).get(index));

				// 탭버튼 삭제
				$tab.tabs('remove', index);
				
				// 삭제된 컨텐츠는 마지막으로 이동
//				var tabPanel = $('.ui-tabs-panel',$tab).get(index);
//				$('.ui-tabs-panel:last',$tab).after(tabPanel);
//
//				var btnTab = $('.ui-tabs-nav li', $tab).get(index);
//				$('.ui-tabs-nav li:last', $tab).after(btnTab);
			}
			return false;
		});
		
		$('span.tab-button-close', $tab).live('hover', function() {
			if($(this).parent().find('.ui-icon-locked').size() == 0){
				$(this).toggleClass('ui-icon-closethick');
			}
		});

		// Tab Lock 버튼 이벤트 바인딩
		$('span.tab-button-lock', $tab).live('click', function() {
			$(this).toggleClass('ui-icon-unlocked');
			$(this).toggleClass('ui-icon-locked');
			
			if($(this).hasClass('ui-icon-locked')){
				$('span.tab-button-close', $(this).parent()).removeClass('ui-icon-close').addClass('ui-icon-cancel');
			}else{
				$('span.tab-button-close', $(this).parent()).removeClass('ui-icon-cancel').addClass('ui-icon-close');
			}
		});
		
	};
	
	uxl.Tabs.prototype.id_prifix = 'tab_item_';

	uxl.Tabs.prototype.setHeight = function(height){
		this.options.height = height;
		$('iframe', $(this.tab)).css('height', this.options.height);
	};
	
	uxl.Tabs.prototype.resize = function(gap){
		if(uxl.isEmpty(gap)){
			gap = 0;
		}
		
		var offsetTop = 0;
		this.tab.parents().each(function(){
			offsetTop += this.offsetTop;
		});

		var tabsNav = $('.ui-tabs-nav')[0].clientHeight;
		
		var height = $(window).height() - offsetTop - tabsNav + gap;
		this.setHeight(height+'px');
	};
	
	uxl.Tabs.prototype.setBottomTabs = function(){
		$( ".ui-tabs-nav, .ui-tabs-nav > *", this.tab).removeClass( "ui-corner-all ui-corner-top" ).addClass( "ui-corner-bottom" );
		$( ".ui-tabs-nav", this.tab).appendTo( ".tabs-bottom" );
	};
	
	uxl.Tabs.prototype.add = function(id, url, title, canRemove, selectedCallback) {

		
		var countTabs = $('.ui-tabs-nav li', this.tab).size();
		if(uxl.isNotEmpty(this.options.maxTabs)){
			if(countTabs + 1 > this.options.maxTabs){
				if(this.options.overMaxTabs == 'message'){
					alert('더이상 탭을 추가할 수 없습니다.');
					return;
				}
			}
		}
		
		var index = this.getTabIndex(id);
		if(index >= 0) {
			this.selectByIndex(index);
			return;
		}
		
		var cleanId = id;
		id = this.id_prifix + cleanId;
		
		if(uxl.isScreenId(url)) {
			url = uxl.getScreenURL(url);
		}
		
		var iframeScroll = 'no';
		if(uxl.isNotEmpty(this.options.iframeScroll)){
			if(this.options.iframeScroll){
				iframeScroll = 'yes';
			}
		}
		var html = '<div id="'+id+'" class="ub-tab-content"><input type="hidden" value="' + url + '"><iframe frameBorder="0" name="tabFrame_' + id + '" scrolling="'+iframeScroll+'" style="width:100%;margin:0px;padding:0px;border:0px;"></iframe></div>';
		$(this.tab).append(html);

		if(uxl.isNotEmpty(this.options.height)){
			$('iframe', $(this.tab)).css('height', this.options.height);
		}
		
		title = title || id;
		if(title.length > 10) {
			title = title.substr(0, 8) + '..';
		}
		
		canRemove = uxl.isUndefined(canRemove) ? false : canRemove;
		
//		'<li><a href="#{href}"><label>#{label}</label></a><span class="ui-icon ui-icon-close" style="cursor:pointer;">Remove Tab</span></li>'		
		var tabHtml = '<li><a href="#{href}"><label>#{label}</label></a>#{button-locked}#{button-close}</li>';
		if(canRemove) {
			tabHtml = tabHtml.replace(/#{button-close}/g, '<span class="tab-button-close ui-icon ui-icon-close" style="cursor:pointer;">Close</span>');
		}
		
		if(this.options.tabLock){
			tabHtml = tabHtml.replace(/#{button-locked}/g, '<span class="tab-button-lock ui-icon ui-icon-unlocked" style="cursor:pointer;">Locked</span>');
		}
		
		// 설정이 되지 않으면 템픗릿에서 Clear
		tabHtml = tabHtml.replace(/#{button-close}/g, "");
		tabHtml = tabHtml.replace(/#{button-locked}/g, "");
		
		this.tab.tabs({
			tabTemplate: tabHtml 
		});
		
		if(uxl.isFunction(selectedCallback)) {
			this.selectedCallbacks[id] = selectedCallback;
		}
		
		// 신규 탭 생성
		this.tab.tabs('add', "#" + id, title);
		
		if(uxl.isNotEmpty(this.options.maxTabs)){
			if(countTabs + 1 > this.options.maxTabs){
				if(this.options.overMaxTabs == 'remove-first'){
					$('.ui-tabs-nav li:not(:has(.ui-icon-locked)):first .ui-icon-close', this.tab).click();
				}else if(this.options.overMaxTabs == 'remove-last'){
					$('.ui-tabs-nav li:not(:has(.ui-icon-locked)):last', this.tab).prev().find('.ui-icon-close').click();
				}
			}
		}
		
	};

	uxl.Tabs.prototype.getTabIndex = function(id) {
		id = this.id_prifix + id;
		var retValue = -1;
		$('ul:first li a', this.tab).each(function(index) {
			if(id == this.href.substr(this.href.indexOf("#") + 1)) {
				retValue = index;
				return false;
			}
		});
		return retValue;
	};
	
	uxl.Tabs.prototype.removeAll = function() {
		var tab = this.tab;
		$('ul:first li', this.tab).each(function(index) {
			uxl.removeIframe($('iframe',$tab).get(0));
			tab.tabs('remove', 0);
		});
	};
	
	
	uxl.Tabs.prototype.removeTab = function(id) {
		var index = this.getTabIndex(id);
		if(index >= 0) {
			this.removeTabByIndex(index);
		}
	};
	
	uxl.Tabs.prototype.removeTabByIndex = function(index) {
		uxl.removeIframe($('iframe',this.tab).get(index));
		this.tab.tabs('remove', index);
	};
	
	uxl.Tabs.prototype.renameTab = function(id, name) {		
		var index = this.getTabIndex(id);
		if(index >= 0) {
			$('ul:first>li>a>span>label', this.tab).eq(index)
			.text(function() {
				if(name.length > 10) {
					name = name.substr(0, 8) + '..';
				}
				return name;
			});
		}
	};
	
	uxl.Tabs.prototype.select = function(id) {
		this.selectByIndex(this.getTabIndex(id));
	};
	
	uxl.Tabs.prototype.selectByIndex = function(index) {
		this.tab.tabs('select', index);
	};
	
	uxl.Tabs.prototype.reset = function() {
		this.tab.tabs('destroy');
	};

	uxl.Tabs.prototype.getSelectedIndex = function(){
		return this.tab.tabs( "option", "selected" );
	};
	
	
})(jQuery, uxl);