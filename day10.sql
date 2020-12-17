CREATE TABLE #hl_temp(id Int Identity(1, 1),val  int)
INSERT INTO #HL_TEMP (val) VALUES (2),(3)


SELECT val from (select 114 as val union all select 114 as val union all select 114 as val union all select   51 union all select   0 union all select   143 union all select   122 union all select   26 union all select   121 union all select   90 union all select   20 union all select   113 union all select   8 union all select   138 union all select   57 union all select   44 union all select   135 union all select   76 union all select   134 union all select   15 union all select   21 union all select   119 union all select   52 union all select   118 union all select   107 union all select   99 union all select   73 union all select   72 union all select   106 union all select   41 union all select   129 union all select   83 union all select   19 union all select   66 union all select   132 union all select   56 union all select   32 union all select   79 union all select   27 union all select   115 union all select   112 union all select   58 union all select   102 union all select   64 union all select   50 union all select   2 union all select   39 union all select   3 union all select   77 union all select   85 union all select   103 union all select   140 union all select   28 union all select   133 union all select   78 union all select   34 union all select   13 union all select   61 union all select   25 union all select   35 union all select   89 union all select   40 union all select   7 union all select   24 union all select   33 union all select   96 union all select   108 union all select   71 union all select   11 union all select   128 union all select   92 union all select   111 union all select   55 union all select   80 union all select   91 union all select   31 union all select   70 union all select   101 union all select   14 union all select   18 union all select   12 union all select   4 union all select   84 union all select   125 union all select   120 union all select   100 union all select   65 union all select   86 union all select   93 union all select   67 union all select   139 union all select   1 union all select   47 union all select   38 ) t order by val

--#1
SELECT SUM(CASE WHEN DIFF=1 THEN 1 ELSE 0 END)*SUM(CASE WHEN DIFF=3 THEN 1 ELSE 0 END) FROM(
	SELECT (min(h2.val)-min(h1.val)) as diff
	FROM #hl_temp h1 
    INNER JOIN #hl_temp h2 on  h2.val>h1.val and h2.val<h1.val+4
	group by h1.val
)t 

--#2
;WITH Volts AS
(
    SELECT val as n, ID-1 as val,0 as del, CAST(1 AS DECIMAL (18,0)) as summa
	FROM #hl_temp h1 where val=0
    UNION ALL
	SELECT  n=n+1,h1.val,CASE WHEN h1.val-v.val=1 THEN del+1 ELSE 0 END,
			CAST(CASE WHEN h1.val-v.val!=1 THEN CASE del WHEN 2 THEN summa*2 WHEN 3 THEN summa*4 WHEN 4 THEN summa*7 ELSE SUMMA END ELSE summa END AS DECIMAL(18,0))
	FROM Volts v INNER JOIN #hl_temp h1 on  H1.ID=n+1 --AND H1.ID<V.N+4
	WHERE n<99
)
SELECT * from Volts  OPTION (MAXRECURSION 1001) 

