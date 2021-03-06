-- SYS_BOARD_ARTICLE
ALTER TABLE SYS_BOARD_ARTICLE   DROP SYS_BOARD_ARTICLE_PK;

ALTER TABLE SYS_BOARD_ARTICLE	ALTER COLUMN ID_ARTICLE VARCHAR(50) NOT NULL;
ALTER TABLE SYS_BOARD_ARTICLE	ALTER COLUMN NO_GROUP VARCHAR(50);
ALTER TABLE SYS_BOARD_ARTICLE	ALTER COLUMN ID_PARENT_ARTICLE VARCHAR(50);
ALTER TABLE SYS_BOARD_ARTICLE   ADD NO_ARTICLE  VARCHAR(50);

ALTER TABLE SYS_BOARD_ARTICLE
ADD CONSTRAINT SYS_BOARD_ARTICLE_PK PRIMARY KEY (ID_BOARD, ID_SUB, ID_ARTICLE);

-- SYS_BOARD_INQUIRY_HISTORY
ALTER TABLE SYS_BOARD_INQUIRY_HISTORY DROP SYS_BOARD_INQUIRY_HISTORY_PK;

ALTER TABLE SYS_BOARD_INQUIRY_HISTORY ALTER COLUMN ID_ARTICLE VARCHAR(50) NOT NULL;

ALTER TABLE SYS_BOARD_INQUIRY_HISTORY
ADD CONSTRAINT SYS_BOARD_INQUIRY_HISTORY_PK PRIMARY KEY (ID_ARTICLE, ID_BOARD, ID_HISTORY, ID_SUB)

-- SYS_BOARD_EVALUATION
ALTER TABLE SYS_BOARD_EVALUATION DROP SYS_BOARD_EVALUATION_PK;

ALTER TABLE SYS_BOARD_EVALUATION ALTER COLUMN ID_ARTICLE VARCHAR(50) NOT NULL;

ALTER TABLE SYS_BOARD_EVALUATION
ADD CONSTRAINT SYS_BOARD_EVALUATION_PK PRIMARY KEY (ID_ARTICLE, CD_EVALUATION, USER_ID, ID_BOARD, ID_SUB);


-- SYS_BOARD_REPLY
ALTER TABLE SYS_BOARD_REPLY DROP SYS_BOARD_REPLY_PK;

ALTER TABLE SYS_BOARD_REPLY ALTER COLUMN ID_ARTICLE VARCHAR(50) NOT NULL;
ALTER TABLE SYS_BOARD_REPLY ALTER COLUMN ID_REPLY VARCHAR(50) NOT NULL;
ALTER TABLE SYS_BOARD_REPLY ALTER COLUMN NO_GROUP VARCHAR(50);
ALTER TABLE SYS_BOARD_REPLY ALTER COLUMN ID_PARENT_REPLY VARCHAR(50);

ALTER TABLE SYS_BOARD_REPLY
ADD CONSTRAINT SYS_BOARD_REPLY_PK PRIMARY KEY (ID_ARTICLE, ID_REPLY, ID_BOARD, ID_SUB)

-- SYS_BOARD_ARTICLE_SHARE
ALTER TABLE SYS_BOARD_ARTICLE_SHARE DROP SYS_BOARD_ARTICLE_SHARE_PK;

ALTER TABLE SYS_BOARD_ARTICLE_SHARE ALTER COLUMN ID_ARTICLE VARCHAR(50) NOT NULL;

ALTER TABLE SYS_BOARD_ARTICLE_SHARE 
ADD CONSTRAINT SYS_BOARD_ARTICLE_SHARE_PK PRIMARY KEY (ID_BOARD, ID_ARTICLE, ID_SUB, ID_SHARE_TARGET);
