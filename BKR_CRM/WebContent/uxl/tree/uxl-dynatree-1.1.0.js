/*! 
 * Copyright (c) 2014 UBONE (http://www.ubqone.com)
 * 
 * File : uxl-dynatree-1.1.0.js
 * Version 1.0.0
 * Release List
 * 
 * 1.1.0 - Ajax POST 전송하도록 변경(2017-10-19)
 */
(function($, uxl) {
		/*
		 * Tree Draw
		 */
		uxl.treeDraw = function(treeOption,keyValue){

			// making jqgrid object
			$('.ub-control.temp').remove();
			var url = uxl.getFunctionUrl(treeOption.screenId,treeOption.functionAlias);
			var treeDivId = uxl.isEmpty(treeOption.treeDivId)?'tree':treeOption.treeDivId;

			try{
				var params = uxl.isEmpty(treeOption.param)?'':'?'+jQuery.param(treeOption.param);
				var dataOption = {
						url: url+params,
						type: 'post',
		              	data: uxl.isEmpty(treeOption.formId)?'':$('#'+treeOption.formId).serialize()
					};
				 
				$('#'+treeDivId).dynatree("option", "initAjax", dataOption);
				$('#'+treeDivId).dynatree("option", "onPostInit", function(isReloading, isError){
																			if(uxl.isNotEmpty(keyValue)){
																				uxl.setActivateNode(keyValue, treeDivId);
																			}
																			
				});
				$('#'+treeDivId).dynatree("getTree").reload();
			}catch(Exception){
				$('#'+treeDivId).dynatree({
						isReloading:true,
						checkbox : treeOption.checkbox||false,
						selectMode : treeOption.selectMode||1,
						clickFolderMode : treeOption.clickFolderMode||3,
						autoCollapse:false,
						minExpandLevel:treeOption.minExpandLevel||2,
						autoFocus: treeOption.autoFocus||false,
						initAjax: dataOption,
						onActivate: function(node) {
							if(uxl.isFunction(treeOption.onActivate)){
								treeOption.onActivate(node);
							}
				      	},
						onDeactivate: function(node) {
							if(uxl.isFunction(treeOption.onDeactivate)){
								treeOption.onDeactivate(node);
							}
						},
						onLazyRead: function(node){
							var lazyUrl = uxl.getFunctionUrl(treeOption.screenId,treeOption.lazyFunctionAlias,'json');
							if(uxl.isNotEmpty(treeOption.lazyKeyInputId)){
								$('#'+treeOption.lazyKeyInputId).val(node.data.key);
							}
							var lazyParam = uxl.isEmpty(treeOption.lazyParam)?'':'?'+jQuery.param(treeOption.lazyParam);
							lazyUrl = lazyUrl+lazyParam;
							node.appendAjax({
								url : lazyUrl,
								type : 'post',
								data : uxl.isEmpty(treeOption.lazyFormId)?'':$('#'+treeOption.lazyFormId).serialize()
							});
						},
						onSelect: function(flag,node) {
							if(uxl.isFunction(treeOption.onSelect)){
								treeOption.onSelect(flag,node);
							}
						},
						dnd : treeOption.dndOption
				});
			}
		};
		
		
		/*
		 * get Tree
		 * */
		uxl.getTree = function(treeDivId){
			var treeDivId = uxl.isEmpty(treeDivId)?'tree':treeDivId;
			return  $("#"+treeDivId).dynatree("getTree");
		};
		
		/**
		 * Activate Node
		 */
		uxl.getActivateNode = function(treeDivId){
			var treeDivId = uxl.isEmpty(treeDivId)?'tree':treeDivId;
			var node = $("#"+treeDivId).dynatree("getActiveNode");
			return node;
		};
		
		/*
		 * get Activate Key
		 * */
		uxl.getActivateKey = function(treeDivId){
			var node = uxl.getActivateNode(treeDivId);
			if(node){
				return node.data.key;
			}
			return "";
		};
		
		uxl.setActivateNode = function(key,treeDivId){
			var tree = uxl.getTree(treeDivId);
			tree.activateKey(key);
		};
		
		uxl.deActivate = function(treeDivId){
			var node = uxl.getActivateNode(treeDivId);
			if(node){
				node.deactivate();
			}
		};
		
		uxl.clearTree = function(treeDivId){
			$('#'+treeDivId).empty();
		};
		
		
		
})(jQuery, uxl); 