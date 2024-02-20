
CREATE DATABASE [Library]

USE Library

CREATE TABLE Author
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(20),
	Surname NVARCHAR(20)
)

CREATE TABLE Books
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(20),
	AuthorId INT FOREIGN KEY REFERENCES Author(Id),
	PageCount INT
)
ALTER TABLE Books
ADD Price INT




SELECT * FROM Author

INSERT INTO Author
VALUES
('Name1','Surname1'),
('Name2','Surname2'),
('Name3','Surname3'),
('Name4','Surname4'),
('Name5','Surname5'



SELECT * FROM Books

INSERT INTO Books
VALUES
('book1',3,50),
('book2',1,60),
('book3',3,70),
('book4',5,40),
('book5',2,30),
('book6',1,80),
('book7',4,90),
('book8',4,35),
('book9',5,66),
('book10',1,70)
--Books ve Authors table-larınız olsun
 --(one to many realtion) Id,Name,PageCount ve
-- AuthorFullName columnlarının valuelarını
--qaytaran bir view yaradın
CREATE VIEW Book_Info 
AS
SELECT b.Id, b.Name, b.PageCount, CONCAT(a.Name, ' ', a.Surname) AS AuthorFullName
FROM Books b
JOIN Author a ON b.AuthorId = a.Id

SELECT * FROM Book_Info 




--Göndərilmiş axtarış dəyərinə görə həmin axtarış
-- dəyəri name və ya authorFullName-lərində olan Book-ları
-- Id,Name,PageCount,AuthorFullName columnları şəklində
-- göstərən procedure yazın
CREATE PROCEDURE USP_Search
@SEARCH NVARCHAR(20)
AS
SELECT b.Id, b.Name, b.PageCount, CONCAT(a.Name, ' ', a.Surname) AS AuthorFullName
FROM Books b
JOIN Author a ON b.AuthorId = a.Id
WHERE b.Name LIKE CONCAT('%',@SEARCH,'%') OR CONCAT(a.Name, ' ', a.Surname) LIKE CONCAT('%',@SEARCH, '%');

EXEC USP_Search 'name1 surname1'




--Book tabledaki verilmiş id-li datanın qiymıətini verilmiş yeni qiymətə update edən procedure yazın.--
CREATE PROCEDURE USP_Update
@ID INT,
@Price INT
AS
UPDATE Books Set Price = @Price Where Id = @ID

SELECT*FROM Books
EXEC USP_Update 10,20


--Authors-ları Id,FullName,BooksCount,MaxPageCount şəklində qaytaran view yaradırsınız
--Bunu tam yaza bilmedim :(

SELECT 
    A.Id AS Id,
    CONCAT(A.Name, ' ', A.Surname) AS FullName,
    COUNT(B.Id) AS BooksCount,
    MAX(B.PageCount) AS MaxPageCount
FROM Author A
LEFT JOIN Books B ON A.Id = B.AuthorId
GROUP BY A.Id, FullName



CREATE VIEW Count_Max 
AS
SELECT A.Id AS Id, 
CONCAT(a.Name, ' ', a.Surname) AS AuthorFullName,
COUNT(b.Id) As BookCount,
Max(b.PageCount)
FROM Author a
left join Books b ON b.AuthorId = a.Id
GROUP BY Id,AuthorFullName










