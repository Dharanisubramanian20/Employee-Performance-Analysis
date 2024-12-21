CREATE DATABASE Employee;
use Employee;
Drop Database Employee;
CREATE TABLE Employees (
  EmployeeID INT PRIMARY KEY,
  Name VARCHAR(255),
  Department VARCHAR(255),
  JobTitle VARCHAR(255)
);

CREATE TABLE PerformanceReviews (
  ReviewID INT PRIMARY KEY,
  EmployeeID INT,
  ReviewDate DATE,
  Rating INT,
  Comments VARCHAR(255),
  FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Goals (
  GoalID INT PRIMARY KEY,
  EmployeeID INT,
  GoalDescription VARCHAR(255),
  TargetDate DATE,
  FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE GoalProgress (
  ProgressID INT PRIMARY KEY,
  GoalID INT,
  ProgressDate DATE,
  ProgressPercentage INT,
  FOREIGN KEY (GoalID) REFERENCES Goals(GoalID)
);

INSERT INTO Employees (EmployeeID, Name, Department, JobTitle)
VALUES
  (1, 'John Doe', 'Sales', 'Sales Representative'),
  (2, 'Jane Smith', 'Marketing', 'Marketing Manager'),
  (3, 'Bob Johnson', 'IT', 'Software Developer');

INSERT INTO PerformanceReviews (ReviewID, EmployeeID, ReviewDate, Rating, Comments)
VALUES
  (1, 1, '2022-01-01', 4, 'Excellent sales performance'),
  (2, 2, '2022-02-01', 5, 'Outstanding marketing campaign'),
  (3, 3, '2022-03-01', 3, 'Good progress on software development');

INSERT INTO Goals (GoalID, EmployeeID, GoalDescription, TargetDate)
VALUES
  (1, 1, 'Increase sales by 20%', '2022-12-31'),
  (2, 2, 'Launch new marketing campaign', '2022-06-30'),
  (3, 3, 'Complete software development project', '2022-09-30');

INSERT INTO GoalProgress (ProgressID, GoalID, ProgressDate, ProgressPercentage)
VALUES
  (1, 1, '2022-03-31', 10),
  (2, 2, '2022-04-30', 50),
  (3, 3, '2022-05-31', 100);

-- Analyzing Employee Performance

-- Average performance rating by department
SELECT Department, AVG(Rating) AS AverageRating
FROM Employees
JOIN PerformanceReviews ON Employees.EmployeeID = PerformanceReviews.EmployeeID
GROUP BY Department;

-- Employee performance rating trend over time
SELECT EmployeeID, ReviewDate, Rating
FROM PerformanceReviews
ORDER BY EmployeeID, ReviewDate;

-- Goal completion percentage by employee
SELECT Employees.EmployeeID, Employees.Name, AVG(GoalProgress.ProgressPercentage) AS AverageGoalCompletion
FROM Employees
JOIN Goals ON Employees.EmployeeID = Goals.EmployeeID
JOIN GoalProgress ON Goals.GoalID = GoalProgress.GoalID
GROUP BY Employees.EmployeeID, Employees.Name;

-- Employees who have not met their goals
SELECT Employees.EmployeeID, Employees.Name, Goals.GoalDescription
FROM Employees
JOIN Goals ON Employees.EmployeeID = Goals.EmployeeID
WHERE Goals.GoalID NOT IN (
  SELECT GoalID
  FROM GoalProgress
  WHERE ProgressPercentage >= 100
);



