CREATE SCHEMA IF NOT EXISTS SailingDB;
USE SailingDB;

DROP TABLE IF EXISTS Reserves;
DROP TABLE IF EXISTS Sailors;
DROP TABLE IF EXISTS Captains;
DROP TABLE IF EXISTS Boats;

-- Sailors

CREATE TABLE Sailors(
  `Sname` VARCHAR(20) NOT NULL,
  `SID` INT AUTO_INCREMENT PRIMARY KEY,
  `Rating` INT,
  `Age` INT NOT NULL
);

INSERT INTO Sailors VALUES
  ('Marx', 23, 8, 52),
  ('Martin', 25, 9, 51),
  ('Adams', 27, 8, 36),
  ('Carrey', 33, 10, 22);

-- Captains

CREATE TABLE Captains(
  `Cname` VARCHAR(20) NOT NULL,
  `CID` INT AUTO_INCREMENT PRIMARY KEY,
  `Rating` INT,
  `Age` INT NOT NULL
);

INSERT INTO Captains VALUES
  ('Marx', 23, 8, 52),
  ('Martin', 25, 9, 51),
  ('Adams', 27, 8, 36),
  ('Carrey', 33, 10, 22);

-- Boats

CREATE TABLE Boats(
  `Bname` VARCHAR(20) NOT NULL,
  `BID` INT AUTO_INCREMENT PRIMARY KEY,
  `Fee` INT NOT NULL,
  `Location` VARCHAR(20) NOT NULL
);

INSERT INTO Boats VALUES
  ('Wayfarer', 109, 120, 'Hout Bay'),
  ('SeaPride', 108, 500, 'Fish Hock'),
  ('Yuppie', 101, 400, 'Hout Bay'),
  ('Joy', 104, 200, 'Hout Bay');

-- Reserves

CREATE TABLE Reserves(
  `SID` INT NOT NULL,
  `BID` INT NOT NULL,
  `Day` DATE NOT NULL,
  `Deposit` INT NOT NULL,
  PRIMARY KEY(`SID`, `BID`),
  CONSTRAINT Reserves_SID FOREIGN KEY(`SID`) REFERENCES Sailors(`SID`)
    ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT Reserves_BID FOREIGN KEY(`BID`) REFERENCES Boats(`BID`)
    ON DELETE RESTRICT ON UPDATE RESTRICT
);

INSERT INTO Reserves VALUES
  (23, 109, '2014-08-01', 120),
  (23, 108, '2014-08-08', 120),
  (25, 101, '2014-08-08', 0),
  (27, 101, '2014-08-09', 100),
  (27, 109, '2014-08-15', 120),
  (33, 109, '2014-09-04', 0),
  (33, 104, '2014-09-11', 0);
