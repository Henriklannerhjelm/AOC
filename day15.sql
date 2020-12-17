DECLARE  @hl_temp TABLE(id Int Identity(1, 1),val  int)
DECLARE @i int,  @val int
INSERT INTO @hl_temp VALUES (1),(0),(18),(10),(19),(6)
--#1 441
SELECT @val = val,@i=id from #hl_temp order by id asc
WHILE(@i<2020) BEGIN
	SELECT @val=ISNULL(max(id)-min(id),0) from (SELECT TOP 2 id from @hl_temp where val=@val order by id desc) t
	INSERT INTO @hl_temp (val) VALUES (@val)
	SET @i=@i+1
END
SELECT @val	

--#2 -10613991
CREATE TABLE hl_temp (id Int,val  int ,diff int)
CREATE INDEX ix_temp ON hl_temp (val,diff)
CREATE CLUSTERED INDEX IX_TestTable_TestCol1 ON dbo.hl_temp (val);   

DECLARE @i int,  @val int
INSERT INTO hl_temp (val,id,diff) VALUES (1,1,0),(0,2,0),(18,3,0),(10,4,0),(19,5,0),(6,6,0)
SELECT @val = val,@i=id from hl_temp order by id asc
WHILE(@i<30000000) BEGIN
	SELECT @i=@i+1,@val=diff from hl_temp where val=@val 
	UPDATE hl_temp SET diff = @i-id,id=@i where val=@val
	IF(@@ROWCOUNT=0) INSERT INTO hl_temp (id,val,diff) VALUES (@i,@val,0)
END
SELECT @val




