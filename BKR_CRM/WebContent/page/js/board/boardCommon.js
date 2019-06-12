var boardCommon = {};

boardCommon.moveList = function(param){
	uxl.returnToList(uxl.getScreenURL(_BOARD_LIST_PAGE) + param);
};

boardCommon.moveArticle = function(param){
	uxl.moveLocation(uxl.getScreenURL(_BOARD_DETAIL_PAGE) + param);
};

boardCommon.moveArticleRegister = function(param){
	uxl.moveLocation(uxl.getScreenURL(_BOARD_REGIST_PAGE)+param);
};

boardCommon.moveArticleUpdate = function(param){
	uxl.moveLocation(uxl.getScreenURL(_BOARD_MODIFY_PAGE)+param);
};

boardCommon.moveAnswerRegister = function(param){
	uxl.moveLocation(uxl.getScreenURL(_BOARD_ANSWER_REGIST_PAGE)+param);
};

boardCommon.moveAnswerUpdate = function(param){
	uxl.moveLocation(uxl.getScreenURL(_BOARD_ANSWER_MODIFY_PAGE)+param);
};

//미사용
boardCommon.callManLayer = function(userId, event){
	return true;
	if(uxl.isEmpty(userId)){
		uxl.error("UserId is Undefined..");
		return;
	}
	
	$('.man-layer', $(document.body)).remove();
	
	var url = uxl.getFunctionUrl('UBD0000', 'MANLAYER');
	var option = {
			data:{USER_ID:userId}
		  , success:function(result) {
			  	var dataSet = result.getDataList('userInfo').rows[0];
//			  	var fileInfo = result.getDataList(1);
//			  	var userImageUrl = '../page/images/board/@no-profile.jpg';   
//			  	if(fileInfo.rowCount != 0){
//			  		var fileId = result.getDataList(1).rows[0].id;
//			  		userImageUrl = uxl.getContextURL('/boardfile/thumbnail.' + uxl.CONSTANT.URL_EXTENTION + '?imageId='+fileId+'&wSize=78&hSize=89');
//			  	}
			  	var userImageUrl = _IMAGE_SERVER_URL + '/portal/profile/' + dataSet.USER_ID + '.jpg';
			  	
			  	var manLayerHtml = '';
				manLayerHtml += '<div class="man-layer">';
				manLayerHtml += '	<div class="man-header-wrap">';
				manLayerHtml += '		<div class="man-header">';
				manLayerHtml += '			<span class="close" onclick="boardCommon.removeManLayer();"><a href="#none"><span>닫기</span></a></span>';
				manLayerHtml += '		</div>';
				manLayerHtml += '	</div>';
				manLayerHtml += '	<div class="man-body">';
				manLayerHtml += '		<div class="man-info">';
				manLayerHtml += '			<img src="'+userImageUrl+'" class="pic" alt="" onError="this.src=\'../page/images/board/@no-profile.jpg\'"/>';
				manLayerHtml += '			<div class="info">';
				manLayerHtml += '				<strong class="name">'+dataSet.NM_USER+'</strong>';
				manLayerHtml += '				<ul>';
				manLayerHtml += '					<li><span class="item">회사</span> : '+dataSet.NM_COMPANY+'</li>';
				manLayerHtml += '					<li><span class="item">부서</span> : '+dataSet.NM_DEPT+'</li>';
				manLayerHtml += '					<li><span class="item">직급</span> : '+dataSet.NM_TITLE+'</li>';
				manLayerHtml += '					<li><span class="item">전화번호</span> : '+dataSet.NO_MOBILE+'</li>';
				manLayerHtml += '					<li><span class="item">이메일</span> : '+dataSet.DS_EMAIL+'</li>';
				manLayerHtml += '				</ul>';
				manLayerHtml += '			</div>';
				manLayerHtml += '		</div>';
				manLayerHtml += '	</div>';
				manLayerHtml += '</div>';

				$(document.body).append(manLayerHtml);
				
				var $layer = $('div.man-layer', $(document.body));
//				var xx = event.srcElement.offsetLeft;
//				var yy = event.srcElement.offsetTop + 44;
				var xx = event.pageX;
				var yy = event.pageY + 20;
				
				if(xx + 280 > 1200){
					var minusSize = (xx + 280) - 1200;
					xx = xx - minusSize;
				}
				
				$layer.css('top' , yy+"px");
				$layer.css('left', xx+"px");
				$layer.draggable();
				$layer.show();
			}
		  , async:true
	};
	uxl.callFunction(url, option);	
};

boardCommon.removeManLayer = function(){
	$('.man-layer', $(document.body)).remove();
};

boardCommon.setPaging = function(listId, result){
	if(uxl.isNull(listId)){
		uxl.error("listId is Undefined.");
		return;
	}
	
	var totalCount = result.getServiceMessage().totalCount;  //총 건수
	var pageNum    = result.getServiceMessage().pageNum;     //현재 페이지
	var pageSize   = result.getServiceMessage().pageSize;    //한페이지 Row수
	
	// 한 블럭의 페이지 수
    var pageCntPerBlock = 10;
    // 그리드 데이터 전체의 페이지 수
    var totalPage = Math.ceil(totalCount/pageSize);//113/10 11.3 totalPage 12
    // 전체 페이지 수를 한화면에 보여줄 페이지로 나눈다.
    var totalPageList = Math.ceil(totalPage/pageCntPerBlock); // 12/10 = 1.2  2
    // 페이지 리스트가 몇번째 리스트인지
    var pageList=Math.ceil(pageNum/pageCntPerBlock);  // 1 1 2 1 3 1 100 10 101 

    // 페이지 리스트가 1보다 작으면 1로 초기화
    if(pageList<1) pageList=1;
    // 페이지 리스트가 총 페이지 리스트보다 커지면 총 페이지 리스트로 설정
    if(pageList>totalPageList) pageList = totalPageList;
    // 시작 페이지
    var startPageList=((pageList-1)*pageCntPerBlock)+1;
    // 끝 페이지
    var endPageList=startPageList+pageCntPerBlock-1;
   
    // 시작 페이지와 끝페이지가 1보다 작으면 1로 설정
    // 끝 페이지가 마지막 페이지보다 클 경우 마지막 페이지값으로 설정
    if(startPageList<1) startPageList=1;
    if(endPageList>totalPage) endPageList=totalPage;
    if(endPageList<1) endPageList=1;
   
    // 페이징 DIV에 넣어줄 태그 생성변수
    var pageInner="";
   
    // 페이지 리스트가 1이나 데이터가 없을 경우 (링크 빼고 흐린 이미지로 변경)
    if(pageList<2){
    }
    // 이전 페이지 리스트가 있을 경우 (링크넣고 뚜렷한 이미지로 변경)
    if(pageList>1){
       
        pageInner+="<a title=\"first\" href=\"#none\" class=\"ub-control button imgBtn img-pagging-first\"  param=\"\"></a>";
        pageInner+="<a title=\"prev\" href=\"#none\" class=\"ub-control button imgBtn img-pagging-prev\"  param="+(startPageList-1)+"></a>";
       
    }
    // 페이지 숫자를 찍으며 태그생성 (현재페이지는 강조태그)
    for(var i=startPageList; i<=endPageList; i++){
        if(i==pageNum){
            pageInner = pageInner +"<em param="+(i)+" class='num' >"+(i)+"</em> ";
        }else{
            pageInner = pageInner +"<a param="+(i)+" class='num' >"+(i)+"</a> ";
            
        }
       
    }

    // 다음 페이지 리스트가 있을 경우
    if(totalPageList>pageList){
       
        pageInner+="<a title=\"next\" href=\"#none\" class=\"ub-control button imgBtn img-pagging-next\"  param="+(i)+"></a>"; 
        pageInner+="<a title=\"last\" href=\"#none\" class=\"ub-control button imgBtn img-pagging-last\" param="+(totalPage)+"></a>";
    }
    // 현재 페이지리스트가 마지막 페이지 리스트일 경우
    if(totalPageList==pageList){
    }  
    // 페이징할 DIV태그에 우선 내용을 비우고 페이징 태그삽입
    $(".ub-control.pagging[for='"+listId+"']").empty().append("<span class='total-count'>전체:"+uxl.setComma(totalCount)+"</span>").append(pageInner);

    //페이징 이벤트 바인딩
	$('.ub-control.pagging a[param]').click(function(event) {
		
		var formName   = $(this).parent().attr('formId');
		var searchForm = $('#'+formName);
		var vfunction = $(this).parent().attr('function');

		if(uxl.isNull(formName)){
			alert('formName 속성이 지정되지 않았습니다. 확인후 다시 실행해 주십시요.');
			return;
		}

		if(uxl.isNull(vfunction)){
			alert('function 속성이 지정되지 않았습니다. 확인후 다시 실행해 주십시요.');
			return;
		}
		
		if(searchForm != null) {
			var params = $(this).attr('param');
			
			if($('#'+_KEY_PAGE_NUMBER, $(searchForm)).size() == 0){
				uxl.addHidden(searchForm, _KEY_PAGE_NUMBER, parseInt(params, 10));
			}else{
				$('#'+_KEY_PAGE_NUMBER, $(searchForm)).val(parseInt(params, 10));
			}
			if($('#'+_KEY_PAGE_BLOCK, $(searchForm)).size() == 0){
				uxl.addHidden(searchForm, _KEY_PAGE_BLOCK, parseInt(params/10, 10));
			}else{
				$('#'+_KEY_PAGE_BLOCK, $(searchForm)).val(parseInt(params/10, 10));
			}
			_BOARD_RECOVERY_PAGENUM = parseInt(params, 10);
			
			//조회
			if(vfunction != null){
				eval(vfunction+'('+params+')');
			}
		}	
	});
    
};

boardCommon.recoveryParameter = function(pageNumber){

	var $paging = $('.ub-control.pagging');
	var searchFunction = $paging.attr('function');
	var searchFormId   = $paging.attr('formId');
	var searchForm     = $('#'+ searchFormId);
	
	if(uxl.isNotEmpty(searchFunction)){
		if($('#'+_KEY_PAGE_NUMBER, $(searchForm)).size() == 0){
			uxl.addHidden(searchForm, _KEY_PAGE_NUMBER, pageNumber);
		}else{
			$('#'+_KEY_PAGE_NUMBER, $(searchForm)).val(pageNumber);
		}
		if($('#'+_KEY_PAGE_BLOCK, $(searchForm)).size() == 0){
			uxl.addHidden(searchForm, _KEY_PAGE_BLOCK, parseInt(pageNumber/10, 10));
		}else{
			$('#'+_KEY_PAGE_BLOCK, $(searchForm)).val(parseInt(pageNumber/10, 10));
		}					
	}
};

boardCommon.initPageNum = function(){
	_BOARD_RECOVERY_PAGENUM = 1;
	boardCommon.recoveryParameter(_BOARD_RECOVERY_PAGENUM);
};
