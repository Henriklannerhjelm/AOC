CREATE TABLE #hl_temp(id Int Identity(1, 1),dep  int)
INSERT INTO #HL_TEMP (dep) 
select REPLACE(value,'x','0') from STRING_SPLIT ('13,x,x,41,x,x,x,37,x,x,x,x,x,419,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,19,x,x,x,23,x,x,x,x,x,29,x,421,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,x,17',',')

--#1
DECLARE @arr AS INT=1002394
select top 1 dep-(@arr%dep),dep,(dep-(@arr%dep))*dep from #hl_temp where dep>0
ORDEr by dep-(@arr%dep)

--#2
declare @inc as bigint=1, @i int = 1, @result as bigint=0,@bus as INT
while (@i <= (select count(1) from #hl_temp))
BEGIN
	select @bus=CASE WHEN dep=0 then 1 else dep end from #hl_temp where id=@i
    while ((@result + @i) % @bus != 0)
    	set @result = @result + @inc; if ((@result + @i) % @bus = 0) set @inc *= @bus;
    SELECT @i=@i+1
END
select @result


