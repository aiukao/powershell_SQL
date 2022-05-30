Invoke-Sqlcmd -query "
merge into [dbo].[test]
using   openrowset ( bulk 'c:\temp\add.csv',
                    formatfile = 'c:\temp\test.xml',
                    firstrow = 2) as new
ON [test].[a] = new.[a]
WHEN MATCHED THEN
    update set
        b = new.a,
        c = new.b,
        d = new.c,
        e = new.d,
        f = new.e
WHEN NOT MATCHED THEN
    insert (
        a,
        b,
        c,
        d,
        e,
        f
        )
    values (
    new.a,
    new.b,
    new.c,
    new.d,
    new.e,
    new.f
    );" ` -ServerInstance '.\SQLEXPRESS'
