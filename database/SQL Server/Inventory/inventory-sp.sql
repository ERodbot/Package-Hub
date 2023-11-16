CREATE OR ALTER PROCEDURE GetProductsByCategory
    @categoryId INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Category] WHERE idCategory = @categoryId)
    BEGIN
        DECLARE @ErrorMessage NVARCHAR(200) = 'No existe la categoría con id ' + CAST(@categoryId AS NVARCHAR);
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
    END

    SELECT
        P.[name] AS ProductName,
        C.[name] AS CategoryName,
        P.[price],
        I.[path] AS ImagePath
    FROM
        [dbo].[Products] AS P
    INNER JOIN
        [dbo].[Category] AS C ON P.[idCategory] = C.[idCategory]
    LEFT JOIN
        [dbo].[ImagesXProducts] AS IP ON P.[idProduct] = IP.[idProduct]
    LEFT JOIN
        [dbo].[Images] AS I ON IP.[idImage] = I.[idImage]
    WHERE
        P.[idCategory] = @categoryId;
END;
GO


-------------------------------------------------------------

CREATE OR ALTER PROCEDURE [dbo].[GetProductDetails]
    @productName NVARCHAR(100)  
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [dbo].[Products] WHERE name = @productName)
    BEGIN
        SELECT
            Pr.name AS ProductName,
            Pr.description AS Description,
            B.name AS Brand,
            C.name AS Color,
            M.name AS Material,
            Pr.weight AS Weight,
            Pr.price AS UnitPrice,
            I.name AS ImageName,
            I.path AS ImagePath
        FROM
            [dbo].[Products] AS Pr
        LEFT JOIN
            [dbo].[Brands] AS B ON Pr.idBrand = B.idBrand
        LEFT JOIN
            [dbo].[Colors] AS C ON Pr.idColor = C.idColor
        LEFT JOIN
            [dbo].[MaterialsXProduct] AS MP ON Pr.idProduct = MP.idProduct
        LEFT JOIN
            [dbo].[Materials] AS M ON MP.idMaterial = M.idMaterial
        LEFT JOIN
            [dbo].[ImagesXProducts] AS IP ON Pr.idProduct = IP.idProduct
        LEFT JOIN
            [dbo].[Images] AS I ON IP.idImage = I.idImage
        WHERE
            Pr.name = @productName;
    END
    ELSE
    BEGIN
        DECLARE @ErrorMessage VARCHAR(100) = 'No existe el producto ingresado'
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN; 
    END
END;



----------------------------------------------------------
CREATE OR ALTER PROCEDURE [dbo].[GetProductImages]
    @productName NVARCHAR(100)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM [dbo].[Products] WHERE name = @productName)
    BEGIN
        SELECT
            I.name AS ImageName,
            I.path AS ImagePath
        FROM
            [dbo].[ImagesXProducts] AS IP
        INNER JOIN
            [dbo].[Images] AS I ON IP.idImage = I.idImage
        INNER JOIN
            [dbo].[Products] AS Pr ON IP.idProduct = Pr.idProduct
        WHERE
            Pr.name = @productName;
    END
    ELSE
    BEGIN
        DECLARE @ErrorMessage VARCHAR(100) = 'No existe el producto ingresado'
        RAISERROR (@ErrorMessage, 16, 1);
        RETURN; 
    END
END;
GO


--------------------------------------------------------

CREATE OR ALTER PROCEDURE UpdateProductQuantity
    @productName NVARCHAR(100),
    @quantityToSubtract INT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Products] WHERE name = @productName)
    BEGIN
        DECLARE @ErrorProduct NVARCHAR(200) = 'No existe el producto con nombre ' + @productName;
        RAISERROR(@ErrorProduct, 16, 1);
        RETURN;
    END

    IF @quantityToSubtract < 0
    BEGIN
        DECLARE @ErrorQuantity NVARCHAR(200) = 'La cantidad a restar no puede ser un valor negativo.';
        RAISERROR(@ErrorQuantity, 16, 1);
        RETURN;
    END

    DECLARE @newQuantity INT;

    SELECT @newQuantity = [quantity] - @quantityToSubtract
    FROM [dbo].[Products]
    WHERE [name] = @productName;

    IF @newQuantity >= 0
    BEGIN
        UPDATE [dbo].[Products]
        SET
            [quantity] = @newQuantity
        WHERE
            [name] = @productName;
    END
    ELSE
    BEGIN
        DECLARE @ErrorNegativeQuantity NVARCHAR(200) = 'La cantidad resultante sería menor que cero.';
        RAISERROR(@ErrorNegativeQuantity, 16, 1);
        RETURN;
    END
END;
GO



--------------------------------------------------------
CREATE OR ALTER PROCEDURE ValidateProductAvailability
    @productName NVARCHAR(100),
    @quantityToCheck INT,
    @result INT OUTPUT
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM [dbo].[Products] WHERE name = @productName)
    BEGIN
        DECLARE @ErrorProduct NVARCHAR(200) = 'No existe el producto con nombre ' + @productName;
        RAISERROR(@ErrorProduct, 16, 1);
        SET @result = -1; -- Producto no encontrado
        RETURN;
    END

    DECLARE @currentQuantity INT;

    SELECT @currentQuantity = [quantity]
    FROM [dbo].[Products]
    WHERE [name] = @productName;

    IF @currentQuantity >= @quantityToCheck
    BEGIN
        SET @result = 1; -- Suficientes productos disponibles
    END
    ELSE
    BEGIN
        SET @result = -1; -- No hay suficientes productos disponibles
    END
END;
GO