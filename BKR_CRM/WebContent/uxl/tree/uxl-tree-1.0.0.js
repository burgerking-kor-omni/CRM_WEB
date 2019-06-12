
(function($, uxl) {
	
	/**
	 * simple tree
	 * @param {String || input element} 트리 생성 대상 div id or div element
	 * @param {String} tree 정보를 가져올 서비스 ID
	 * @param {Object} 서비스 호출시 추가적으로 전송할 파라미터 ex) {code : '1'}
	 * @param {Object} 옵션 객체, jquery simple tree option 참조 
	 *            option.dataListId : 사용할 dataList id 설정(별도 설정이 없을 경우 첫번째 dataList 사용)
	 *            option.nodeExtractor : dataList로부터 트리 생성에 사용할 노드 추출기
	 * @return 없음
	 */
	uxl.simpleTree = function(target, serviceId, data, option) {
		target = uxl.isString(target) ? '#' + target : target;
		
		var treeServiceId = serviceId;
		var option = $.extend({
			autoclose: false,
			animate: false,
			drag: false,
			docToFolderConvert: true,
			rootName: 'root',
			nodeExtractor: function(row) {
				return {
					level: row.LVL,
					isFolder: row.IS_FOLDER,
					isAjax: row.IS_AJAX,
					url: row.URL || '',
					parent: row.PARENT,
					id: row.ID,
					type: row.TYPE,
					status : row.STATUS,
					name: row.NAME
				};
			},
			nodeTagGenerator: function(node) {
				var title = "";
				if(node.status=="S"){
					title = "<font color='gray'>" + node.name + "</font>";
				}else{
					title = node.name;
				}
				
				var $li = $('<li></li>', {
					id: node.id || '',
					title: node.name || '',
					tp: node.type || '',
					level: node.level || '',
					isFolder: node.isFolder || ''
				}).append("<SPAN>" + title + "</SPAN>").data('node', node);				
				
				if(node.isFolder) {
					var ul = $('<ul></ul>');
					if(node.isAjax) {
						var url = uxl.isEmpty(node.url) ? treeServiceId : node.url;
						url = uxl.isScreenId(url) ? uxl.getScreenURL(url) : url;
						url = uxl.isServiceId(url) ? uxl.getServiceURL(url) : url;
						url = uxl.getContextURL(url);
						url = uxl.addQueryToUrl(url, uxl.CONSTANT.KEY.PRIMARY, node.id);
						
						if(uxl.isServiceRequestPath(url)) {
							ul.addClass('ajax').append('<li>{service:' + url + '}</li>');
						}
						else {
							ul.addClass('ajax').append('<li>{url:' + url + '}</li>');
						}
					}
					$li.append(ul);
				}
				return $li;
			},
			dataListId: 0,
			load:false
		}, option || {});
		
		var $tree =  $(target).append('<ul><li id="root" class="root"><span>' + option.rootName + '</span><ul/></li></ul>');
		
		var $loading = $('<img style="margin:4px;">').attr('src', uxl.getContextURL('/page/images/common/loading_spot.gif'));
		$tree = $($tree).append($loading);
		
		data = data || {};
		
		uxl.ajaxQuery(serviceId, data, function(result) {			
			var datalist = result.getDataList(option.dataListId) || {};
			$.each(datalist.rows || [], function(index, row) {
				var node = option.nodeExtractor(row);
				var parent = $('#root>ul', $tree);
				if(node.level != 1) {
					parent = $('#' + node.parent + '>ul', parent);
				}
				parent.append(option.nodeTagGenerator(node));
			});
			
			try {
				$tree = $('ul:first', $tree).simpleTree(option);
			}
			catch(error) {
				uxl.error(error.message);
			}
			
			$loading.remove();
			
			if(typeof option.load == 'function')
			{
				option.load($tree);
			}
		});
		
		this.tree = $tree;
		
	};
	uxl.simpleTree.prototype.get = function() {
		return this.tree;
	};
	uxl.simpleTree.prototype.clear = function() {
		this.tree.empty();
	};
	uxl.simpleTree.prototype.expandAll = function() {
		var list = $('li.folder-close, li.folder-close-last', this.tree);
		list.effect('clip', function() {
			$('img:first', this).click();
			$(this).show();
		});
		return list.size()>0?true:false;
	};

	uxl.simpleTree.prototype.expandAllForOnLoad = function() {
		// Tree에 해당노드가 표시될때까지 타이머로 체크
		if(tree.expandAll() == false){
			var count   = 0;
		 	var timerId = setInterval(function(){

		 		// 정상 표출시 타이머 종료
				if(tree.expandAll()){
		 			clearInterval( timerId );
		 		};

		 		// 타이머가 10회이상 구동시 비정상적인 상황이라 판단하여 자동 타이머 종료
		 		if(count > 10){
		 			clearInterval( timerId );
		 		}
		 		
		 		count++;
		 	}, 100);
		 };
		
	};
	uxl.simpleTree.prototype.closeAll = function() {
		$('li.folder-open, li.folder-open-last', this.tree).each(function() {
			$('img:first', this).click();
			$(this).show();
		});
	};
	uxl.simpleTree.prototype.selectNode = function(nodeId) {
		$('li#' + nodeId, this.tree).each(function() {
			$('span:first', this).click();
			$(this).show();
		});
	};
	uxl.simpleTree.prototype.unfocusNode = function() {
		$('.active', this.tree).removeClass("active");
	};
	
	uxl.simpleTree.prototype.focusNode = function(nodeId) {
		tree.unfocusNode();
		
		var list = $('li:has(li#' + nodeId+').folder-close, li:has(li#' + nodeId+').folder-close-last', this.tree);
		if(list.size() > 0){
			list.each(function() {
				$('img:first', this).click();
				$(this).show();
			});
		}

		$('li#' + nodeId, this.tree).each(function() {
			$('span:first', this).addClass("active");
			$(this).show();
		});
	};
	uxl.simpleTree.prototype.expand = function(nodeId) {		
		var list = $('li:has(li#' + nodeId+').folder-close, li:has(li#' + nodeId+').folder-close-last', this.tree)
		.add('li#' + nodeId+'.folder-close, li#' + nodeId+'.folder-close-last', this.tree)
		.add('li#' + nodeId+'.doc', this.tree);
		
		if(list.size() > 0) {
			list.each(function() {
				$('img:first', this).click();
				$(this).show();
			});
			tree.selectNode(nodeId);
		}
		return list.size() > 0 ? true : false;
	};
	
	uxl.simpleTree.prototype.expandForOnLoad = function(nodeId) {
		// Tree에 해당노드가 표시될때까지 타이머로 체크
		if(tree.expand(nodeId) == false) {
			var count   = 0;
		 	var timerId = setInterval(function() {
		 		// 정상 표출시 타이머 종료
		 		if(tree.expand(nodeId)) {
		 			clearInterval( timerId );
		 		};

		 		// 타이머가 10회이상 구동시 비정상적인 상황이라 판단하여 자동 타이머 종료
		 		if(count > 10) {
		 			clearInterval( timerId );
		 		}
		 		
		 		count++;
		 	}, 100);
		 }
	};


	
	uxl.simpleTree.prototype.remove = function(nodeId) {
		$('li#' + nodeId, this.tree).each(function() {
			$(this).prev().remove();
			$(this).remove();
		});
	};
	uxl.simpleTree.prototype.rename = function(nodeId, name) {
		$('li#' + nodeId, this.tree).each(function() {
			$('span:first', this).html(name);
			$(this).attr('title', name).show();
		});
	};
})(jQuery, uxl);