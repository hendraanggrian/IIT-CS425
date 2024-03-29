CREATE SCHEMA IF NOT EXISTS CTA;
USE CTA;

DROP TABLE IF EXISTS Trips;
DROP TABLE IF EXISTS Passes;
DROP TABLE IF EXISTS Passengers;
DROP TABLE IF EXISTS Railcars;
DROP TABLE IF EXISTS Trains;
DROP TABLE IF EXISTS Wagons;
DROP TABLE IF EXISTS Locomotives;
DROP TABLE IF EXISTS Stations;
DROP TABLE IF EXISTS Tracks;
DROP TABLE IF EXISTS Alerts;
DROP TABLE IF EXISTS Conductors;

CREATE TABLE Conductors(
  `social_sec` VARCHAR(10) PRIMARY KEY,
  `name` VARCHAR(50) NOT NULL,
  `birth` DATE NOT NULL,
  `age` INT NOT NULL,
  `phones` VARCHAR(50),
  CHECK(`age` >= 21)
);

CREATE TABLE Alerts(
  `alert_id` INT AUTO_INCREMENT PRIMARY KEY,
  `message` VARCHAR(280) NOT NULL,
  `date_start` DATE NOT NULL,
  `date_end` DATE NOT NULL,
  `social_sec` VARCHAR(10) NOT NULL,
  FOREIGN KEY(`social_sec`) REFERENCES Conductors(`social_sec`),
  CHECK(`date_start` < `date_end`)
);

CREATE TABLE Tracks(
  `track_color` VARCHAR(10) PRIMARY KEY
);

CREATE TABLE Stations(
  `station_lat` DECIMAL(8, 6),
  `station_lng` DECIMAL(9, 6),
  `station_color` VARCHAR(10),
  `name` VARCHAR(50) NOT NULL,
  `zip` VARCHAR(5) NOT NULL,
  `note` VARCHAR(280),
  `has_elevator` BOOLEAN NOT NULL DEFAULT 0,
  `has_parking` BOOLEAN NOT NULL DEFAULT 0,
  PRIMARY KEY(`station_lat`, `station_lng`, `station_color`),
  INDEX(`station_lat`),
  INDEX(`station_lng`),
  FOREIGN KEY(`station_color`) REFERENCES Tracks(`track_color`)
);

CREATE TABLE Locomotives(
  `serial_no` VARCHAR(4) PRIMARY KEY,
  `since` YEAR NOT NULL,
  CHECK(LENGTH(`serial_no`) = 4)
);

CREATE TABLE Wagons(
  `wagon_id` VARCHAR(4) PRIMARY KEY,
  `seats` INT NOT NULL,
  CHECK(LENGTH(`serial_no`) = 4)
);

CREATE TABLE Trains(
  `train_id` INT AUTO_INCREMENT PRIMARY KEY,
  `track_color` VARCHAR(10) NOT NULL,
  `serial_no` VARCHAR(4) NOT NULL,
  `social_sec` VARCHAR(10) NOT NULL,
  FOREIGN KEY(`track_color`) REFERENCES Tracks(`track_color`),
  FOREIGN KEY(`serial_no`) REFERENCES Locomotives(`serial_no`),
  FOREIGN KEY(`social_sec`) REFERENCES Conductors(`social_sec`)
);

CREATE TABLE Railcars(
  `train_id` INT,
  `wagon_id` VARCHAR(4),
  PRIMARY KEY(`train_id`, `wagon_id`),
  FOREIGN KEY(`train_id`) REFERENCES Trains(`train_id`),
  FOREIGN KEY(`wagon_id`) REFERENCES Wagons(`wagon_id`)
);

CREATE TABLE Passengers(
  `passenger_id` INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(50) NOT NULL
);

CREATE TABLE Passes(
  `pass_id` INT AUTO_INCREMENT PRIMARY KEY,
  `date_start` DATE NOT NULL,
  `date_end` DATE NOT NULL,
  `passenger_id` INT NOT NULL,
  FOREIGN KEY(`passenger_id`) REFERENCES Passengers(`passenger_id`),
  CHECK(`date_start` < `date_end`)
);

CREATE TABLE Trips(
  `timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  `passenger_id` INT,
  `fare` DECIMAL(13, 2),
  `pass_id` INT,
  `station_lat1` DECIMAL(8, 6) NOT NULL,
  `station_lng1` DECIMAL(9, 6) NOT NULL,
  `station_color1` VARCHAR(10) NOT NULL,
  `station_lat2` DECIMAL(8, 6),
  `station_lng2` DECIMAL(9, 6),
  `station_color2` VARCHAR(10),
  PRIMARY KEY(`timestamp`, `passenger_id`),
  FOREIGN KEY(`passenger_id`) REFERENCES Passengers(`passenger_id`),
  FOREIGN KEY(`pass_id`) REFERENCES Passes(`pass_id`),
  FOREIGN KEY(`station_lat1`) REFERENCES Stations(`station_lat`),
  FOREIGN KEY(`station_lng1`) REFERENCES Stations(`station_lng`),
  FOREIGN KEY(`station_color1`) REFERENCES Stations(`station_color`),
  FOREIGN KEY(`station_lat2`) REFERENCES Stations(`station_lat`),
  FOREIGN KEY(`station_lng2`) REFERENCES Stations(`station_lng`),
  FOREIGN KEY(`station_color2`) REFERENCES Stations(`station_color`)
);
