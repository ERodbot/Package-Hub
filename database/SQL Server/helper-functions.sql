CREATE FUNCTION dbo.ConcatString(@string NVARCHAR(MAX)) RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN '''' + REPLACE(@string, '''', '''''') + '''';
END

CREATE FUNCTION dbo.ConcatInteger(@value INT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN CAST(@value AS NVARCHAR(MAX));
END

CREATE FUNCTION dbo.ConcatDate(@value DATE)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN '''' + CONVERT(NVARCHAR, @value, 120) + ''''; -- Format as 'YYYY-MM-DD'
END

CREATE FUNCTION dbo.ConcatDateTime(@value DATETIME)
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN '''' + CONVERT(NVARCHAR, @value, 120) + ''''; -- Format as 'YYYY-MM-DD HH:MI:SS'
END
