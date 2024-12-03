CREATE DATABASE ToDoListDB
GO
USE ToDoListDB
GO

CREATE TABLE Categories (
	CategoryId INT PRIMARY KEY IDENTITY(1,1),
	CategoryName VARCHAR(35) NOT NULL,
	CategoryLocation VARCHAR(35) NOT NULL
);

CREATE TABLE Tasks (
	TaskId INT PRIMARY KEY IDENTITY(1,1),
	FkCategoryId INT,
	TaskStatus BIT DEFAULT 0,
	TaskName VARCHAR(35),
	TaskDate SMALLDATETIME DEFAULT DATEADD(WEEK, 1, GETDATE()),

	FOREIGN KEY (FkCategoryId) REFERENCES Categories(CategoryId)
);


--- Minst tre kategorier (till exempel "Arbete", "Hem", "Studier")
--- Minst åtta uppgifter fördelade över de olika kategorierna

INSERT INTO Categories
VALUES	('Work','Work Place'),
		('Cleaning','Home'),
		('Worship','Church');


		-- FkCategoryId INT,
	--TaskStatus BIT DEFAULT 0,
	--TaskName VARCHAR(35),
	--TaskDate SMALLDATETIME DEFAULT DATEADD(WEEK, 1, GETDATE()),
INSERT INTO Tasks
VALUES	(1, NULL,'Pray','2024-12-03'),
		(1, 0,'Clean the Facility',NULL),
		(1,1,'Morning Prayer','2024-12-02'),
		(2,NULL,'Laundry',NULL),
		(3,NULL,'Cleaning',NULL),
		(2,NULL,'Clean Room','2024-12-05'),
		(2,NULL,'Dishwasher',NULL),
		(2,NULL,'Vacuum','2024-12-24');

INSERT INTO Tasks(FkCategoryId, TaskName)
VALUES	(3,'Snooker');

--- Lista alla tasks med tillhörande kategorier
SELECT t.TaskName AS Task, c.CategoryName AS Category
FROM Tasks t
JOIN Categories c ON t.FkCategoryId = c.CategoryId;
--- Filtrera och visa tasks för en specifik kategori (t.ex. "Arbete")
SELECT t.TaskName AS Task, c.CategoryName AS Category
FROM Tasks t
JOIN Categories c ON t.FkCategoryId = c.CategoryId
WHERE c.CategoryName = 'Work';
--- Lista alla uppgifter som har deadline inom en vecka
SELECT DISTINCT *
FROM Tasks t
WHERE t.TaskDate >= GETDATE() AND t.TaskDate <= DATEADD(DAY, 7, GETDATE());
--- Visa alla uppgifter sorterade efter deadline
SELECT DISTINCT *
FROM Tasks t
ORDER BY T.TaskDate;
--- Lista alla uppgifter med status "Pågående"
SELECT DISTINCT *
FROM Tasks t
WHERE T.TaskStatus = 1;

--**Modifiera data**
--- Lägg till en ny kategori med ett specifikt namn och beskrivning
INSERT INTO Categories
VALUES	('Study','School');
--- Uppdatera status på en uppgift till "Avslutad" för en specifik task
UPDATE Tasks
SET TaskStatus = 1
WHERE TaskId = 10;
--- Ta bort en kategori samt dess tillhörande uppgifter
DELETE FROM Categories
WHERE CategoryName = 'Work';
DELETE FROM Tasks
WHERE FkCategoryId = 1;
--- Uppdatera deadline för en specifik uppgift till ett nytt datum
UPDATE Tasks
SET TaskDate = DATEADD(YEAR, 2, GETDATE())
WHERE TaskId = 10;

