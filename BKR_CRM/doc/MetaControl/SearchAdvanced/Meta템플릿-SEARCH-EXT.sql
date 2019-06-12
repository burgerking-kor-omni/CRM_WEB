SELECT * FROM META_TEMPLATE WHERE TYPE2 = 'LYT';

SELECT * FROM META_CONTROL_TYPE WHERE TYPE = 'LYT' ORDER BY TEMPLATEID ASC;

SELECT * FROM META_FOLDER;

SELECT * FROM META_FOLDER_FILE WHERE FOLDER_ID = '9';

SELECT * FROM META_CONTROL_TYPE_ATTRIBUTE WHERE TYPE = 'LYT' AND TYPEDEF='SEARCH';



/* 1. 컨트롤 템플릿 추가 */
INSERT INTO META_TEMPLATE
SELECT 'LYTCTL013T'
      , TYPE1
      , TYPE2
      , '013' AS TYPE3
      , '검색-확장 레이아웃'
      , '<div class="ub-layout search-advanced close" id="@id@" name="@id@" IsContainer="true">
		<div class="ub-layout advance" @height@>
			@@
		</div>
	</div>'
      , '검색-확장 레이아웃'
      , PROJECTNAME
      , STATUS
      , '2015-04-22'
      , REGUSER
      , '2015-04-22'
      , LASTUSER
 FROM META_TEMPLATE      
WHERE TEMPLATEID = 'LYTCTL001T';


/* 2. 컨트롤 타입 추가 */
INSERT INTO META_CONTROL_TYPE
SELECT TYPE
      , 'SEARCH-EXT'
      , 'LYTCTL013T'
      , '검색-확장 레이아웃'
      , '검색-확장 레이아웃'
      , EXTENDCLASS
      , STATUS
      , REGDATE
      , REGUSER
      , LASTDATE
      , LASTUSER
 FROM META_CONTROL_TYPE      
WHERE TEMPLATEID = 'LYTCTL001T';

/* 3. 폴더 파일 맵핑 */
INSERT INTO META_FOLDER_FILE(
		FOLDER_ID
	  , FILE_ID1
	  , FILE_ID2
	  , FOLDER_TYPE
	  , PROJECT_ID
)VALUES(
		'9'
	  , 'LYT'
	  , 'SEARCH-EXT'
	  , 'CONTROL'
	  , 'P000000002'
);

/* 4. 컨트롤 속성 */
INSERT INTO META_CONTROL_TYPE_ATTRIBUTE
SELECT TYPE
      , 'SEARCH-EXT'
      , ATTRIBUTE
      , SECTIONCLASS
      , PARSETYPE
      , MANDATORY
      , VALUECLASS
      , INITVALUE
      , DESCRIPTION
      , STATUS
      , FIXEDATTR
  FROM META_CONTROL_TYPE_ATTRIBUTE 
 WHERE TYPE = 'LYT' AND TYPEDEF='SEARCH';

/* 5. width 속성 삭제 */ 
DELETE FROM META_CONTROL_TYPE_ATTRIBUTE WHERE TYPE = 'LYT' AND TYPEDEF='SEARCH-EXT' AND ATTRIBUTE='width';


