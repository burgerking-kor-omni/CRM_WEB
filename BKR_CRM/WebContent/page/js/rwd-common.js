/**
 * 반응형 웹 관련 공통 모듈
 */
var rwd = {};

/**
 * 반응형 웹 페이징 구성 (웹 일반페이지 / 모바일 간이 페이징)
 */
rwd.setPaging = function(pagerId, result, callback){
	if(uxl.isNull(pagerId)){
		uxl.error("pagerId is Undefined.");
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
   
    // Pager 객체 선언
    var $pager = uxl.isString(pagerId)? $('#'+pagerId) : pagerId;
    var $panel = $('<ul>');
    
    $pager.removeClass('area_paging').addClass('area_paging');
    $pager.empty().append($panel);
    
    // 웹용      :: << < 1 2 3 4 5 6 7 8 9 10 > >>
    // 모바일용 :: << < 1/10 > >>
    // 
//    if(pageList>1){
    	$panel.append('<li class="first"><a href="#none" pageNo=1>first</a></li>');
    	$panel.append('<li class="web prev" ><a href="#none" pageNo='+(startPageList-1)+'>prev</a></li>');
//    }

    for(var i=startPageList; i<=endPageList; i++){
		if(i==pageNum){
	    	$panel.append('<li class="web now"><a href="#none" pageNo='+(i)+'>'+(i)+'</a></li>');
        }else{
        	$panel.append('<li class="web"><a href="#none" pageNo='+(i)+'>'+(i)+'</a></li>');
        }
    }
    
    // 모바일용 페이징   << 1/10 >>
	$panel.append('<li class="mob prev"><a href="#none" pageNo='+(pageNum-1)+'>prev</a></li>');
	$panel.append('<li class="mob"><span class="m_paging"><strong class="now">'+pageNum+'</strong>/<span class="total">'+totalPage+'</span></span></li>');
	$panel.append('<li class="mob next"><a href="#none" pageNo='+(pageNum+1)+'>next</a></li>');
    
    // 다음 페이지 리스트가 있을 경우
//    if(totalPageList>pageList){
    	$panel.append('<li class="web next"><a href="#none" pageNo='+(i)+'>next</a></li>');
    	$panel.append('<li class="last"><a href="#none" pageNo='+(totalPage)+'>last</a></li>');
//    }
    
    // 전체 건수 처리
//    $(".ub-control.pagging[for='"+listId+"']").empty().append("<span class='total-count'>전체:"+uxl.setComma(totalCount)+"</span>").append(pageInner);

    //페이징 이벤트 바인딩
	$('a[pageNo]', $panel).click(function(event) {
		var pageNo = $(this).attr('pageNo');
		
		// 1~전체 페이지 범위에 존재하고 현재 페이지가 아닌경우
//		if(1 <= pageNo && pageNo <= totalPage && pageNo != pageNum){
		if(1 <= pageNo && pageNo <= totalPage){
			if(uxl.isFunction(callback)){
				// 페이징에서는 이전검색복구명령어를 초기화
				$(':hidden[name=searchRecoveryCommand]').val('');
				
				callback.call(this, pageNo);
			}else{
				alert('callback 함수는 Function으로 선언하세요.');
			}
		}
	});
    
};
