--Create the Database
CREATE DATABASE Thala_hotel;
--Use the database
USE Thala_hotel;

--Create all the Tables (Tables should have constraints, Primary Keys, Map the Foreign Keys) 

--Creating Employee Table
CREATE TABLE Employee(
	Employee_ID INT PRIMARY KEY,
	Employee_Name VARCHAR(50) NOT NULL,
	Staff_Role VARCHAR(50) NOT NULL,
	Employee_Phone_Number VARCHAR(15) NOT NULL,
	Employee_Email VARCHAR(255) NOT NULL UNIQUE
);


--Creating the Service Table
CREATE TABLE Service(
	Service_ID INT ,
	Service_Name VARCHAR(50) NOT NULL,
	Service_Description VARCHAR(255),
	Service_Price INT NOT NULL,
	Emp_ID INT NOT NULL,

	PRIMARY KEY(Service_ID),

	CONSTRAINT FK_Service_Employee FOREIGN KEY(Emp_ID) 
	REFERENCES Employee(Employee_ID)
	ON DELETE CASCADE--If a row in the parent table is deleted, all related rows in the child table are also deleted.--
);

--Creating the Guest Table
CREATE TABLE Guest(
	Guest_ID INT,
	Guest_Name VARCHAR(50) NOT NULL,
	Phone_Number VARCHAR(15) NOT NULL,
	Guest_Email VARCHAR(255) NOT NULL UNIQUE,
	Guest_address VARCHAR(255)

	PRIMARY KEY(Guest_ID),
);

--Creating the Serviced_Guest Table
CREATE TABLE Serviced_Guest(
	Ser_ID INT NOT NULL UNIQUE,
	Gst_ID INT NOT NULL UNIQUE,
	Date DATE NOT NULL,
	Time DATETIME NOT NULL

	PRIMARY KEY(Ser_ID,Gst_ID),

	CONSTRAINT FK_ServicedGuest_Employee FOREIGN KEY(Ser_ID) 
	REFERENCES Employee(Employee_ID)
	ON DELETE CASCADE,

	CONSTRAINT FK_ServicedGuest_Guest FOREIGN KEY(Gst_ID) 
	REFERENCES Guest(Guest_ID)
	ON DELETE CASCADE
);

--Create the Room Table
CREATE TABLE Room(
	Room_ID INT,
	Room_Name VARCHAR(15),
	Room_Type VARCHAR(15),
	Room_Rate DECIMAL(10,2),
	Room_Number INT

	PRIMARY KEY(Room_ID)
);

--Creating the Reservation Table
CREATE TABLE Reservation(
	ReservationID INT,
	Rsv_Gst_ID INT NOT NULL UNIQUE,
	Rsv_Room_ID INT NOT NULL UNIQUE,
	No_Of_Guest INT NOT NULL ,
	Cheacking_Date DATE NOT NULL,
	Cheacking_Out DATE NOT NULL,
	TIME DATETIME NOT NULL,
	Reservation_Date DATE NOT NULL,

	PRIMARY KEY(ReservationID),

	CONSTRAINT FK_Reservation_Guest FOREIGN KEY(Rsv_Gst_ID) 
	REFERENCES Guest(Guest_ID)
	ON DELETE CASCADE,

	CONSTRAINT FK_Reservation_Room FOREIGN KEY(Rsv_Room_ID) 
	REFERENCES Room(Room_ID)
	ON DELETE CASCADE
);

--Creating Event Table
CREATE TABLE Event(
	Event_ID INT,
	Event_Name VARCHAR(50),
	Event_Date DATE,
	Event_Location VARCHAR(15),
	Event_Description VARCHAR(255)

	PRIMARY KEY(Event_ID)
);



--Creating the table Guest Attented Events
CREATE TABLE Guest_Attented_Events(
	Gst_Atnd_Evnt_Event_ID INT NOT NULL,
	Gst_Atnd_Evnt_Guest_ID INT NOT NULL,
	Date DATE NOT NULL,
	Time DATETIME NOT NULL

	PRIMARY KEY(Gst_Atnd_Evnt_Event_ID,Gst_Atnd_Evnt_Guest_ID),

	CONSTRAINT FK_Guest_Attented_Events_Event FOREIGN KEY(Gst_Atnd_Evnt_Event_ID) 
	REFERENCES Event(Event_ID)
	ON DELETE CASCADE,

	CONSTRAINT FK_Guest_Attented_Events_Guest FOREIGN KEY(Gst_Atnd_Evnt_Guest_ID) 
	REFERENCES Guest(Guest_ID)
	ON DELETE CASCADE
);

--Creating the Review Table
CREATE TABLE Review(
	Review_ID INT,
	Review_Comment VARCHAR(500),
	Review_Date DATE,
	Review_Rating DECIMAL(10,2),
	Rvew_Guest_ID INT,

	PRIMARY KEY(Review_ID),
	CONSTRAINT FK_Review_Guest FOREIGN KEY(Rvew_Guest_ID) 
	REFERENCES Guest(Guest_ID) 
	ON DELETE CASCADE,
);

--Creating the Payment Table
CREATE TABLE Payment(
	Payment_ID INT ,
	Payment_Date DATE NOT NULL,
	Payment_Amount DECIMAL(10,5) NOT NULL,
	Payment_Method VARCHAR(20) NOT NULL,
	pmt_Reservation_ID INT NOT NULL UNIQUE,

	PRIMARY KEY(Payment_ID),

	CONSTRAINT FK_Payment_Reservation FOREIGN KEY(pmt_Reservation_ID) 
	REFERENCES Reservation(ReservationID)
	ON DELETE CASCADE,
);

--Insert at least 10 records for each table. 
--Inserting Data in to Employee Table
INSERT INTO Employee (Employee_ID, Employee_Name, Staff_Role, Employee_Phone_Number, Employee_Email)
VALUES
(1, 'John Doe', 'Manager', '1234567890', 'john.doe@example.com'),
(2, 'Jane Smith', 'Receptionist', '0987654321', 'jane.smith@example.com'),
(3, 'Michael Johnson', 'Housekeeper', '2345678901', 'michael.johnson@example.com'),
(4, 'Emily Davis', 'Concierge', '3456789012', 'emily.davis@example.com'),
(5, 'Sarah Wilson', 'Chef', '4567890123', 'sarah.wilson@example.com'),
(6, 'David Martinez', 'Bellhop', '5678901234', 'david.martinez@example.com'),
(7, 'Laura Garcia', 'Event Planner', '6789012345', 'laura.garcia@example.com'),
(8, 'Robert Lee', 'Security', '7890123456', 'robert.lee@example.com'),
(9, 'Linda Brown', 'Bartender', '8901234567', 'linda.brown@example.com'),
(10, 'James Anderson', 'Maintenance', '9012345678', 'james.anderson@example.com');

--Inserting Data in to Service Table
INSERT INTO Service (Service_ID, Service_Name, Service_Description, Service_Price, Emp_ID)
VALUES
(1, 'Room Cleaning', 'Daily room cleaning service', 50, 3),
(2, 'Concierge Service', 'Personal assistance for guests', 100, 4),
(3, 'Event Planning', 'Organizing events', 500, 7),
(4, 'Room Service', 'Food and drinks delivered to the room', 75, 5),
(5, 'Luggage Assistance', 'Help with luggage', 30, 6),
(6, 'Security Service', 'Ensuring safety', 150, 8),
(7, 'Bar Service', 'Beverages at the bar', 60, 9),
(8, 'Maintenance Service', 'Room maintenance and repair', 100, 10),
(9, 'Chef Special', 'Custom meals prepared by the chef', 200, 5),
(10, 'VIP Event Planning', 'Exclusive event organization', 1000, 7);

--Inserting Data in to Guest Table
INSERT INTO Guest (Guest_ID, Guest_Name, Phone_Number, Guest_Email, Guest_address)
VALUES
(1, 'Alice Brown', '1111111111', 'alice.brown@example.com', '123 Elm St'),
(2, 'Bob Johnson', '2222222222', 'bob.johnson@example.com', '456 Oak St'),
(3, 'Carol Williams', '3333333333', 'carol.williams@example.com', '789 Pine St'),
(4, 'David Taylor', '4444444444', 'david.taylor@example.com', '101 Maple St'),
(5, 'Eve Smith', '5555555555', 'eve.smith@example.com', '202 Birch St'),
(6, 'Frank Wright', '6666666666', 'frank.wright@example.com', '303 Cedar St'),
(7, 'Grace Harris', '7777777777', 'grace.harris@example.com', '404 Walnut St'),
(8, 'Henry Clark', '8888888888', 'henry.clark@example.com', '505 Chestnut St'),
(9, 'Ivy Allen', '9999999999', 'ivy.allen@example.com', '606 Spruce St'),
(10, 'Jack King', '0000000000', 'jack.king@example.com', '707 Ash St');

--Inserting Data in to Serviced_Guest Table
INSERT INTO Serviced_Guest (Ser_ID, Gst_ID, Date, Time)
VALUES
(1, 1, '2024-08-25', '2024-08-25 14:30:00'),
(2, 2, '2024-08-26', '2024-08-26 10:00:00'),
(3, 3, '2024-08-27', '2024-08-27 09:30:00'),
(4, 4, '2024-08-28', '2024-08-28 15:00:00'),
(5, 5, '2024-08-29', '2024-08-29 12:00:00'),
(6, 6, '2024-08-30', '2024-08-30 11:00:00'),
(7, 7, '2024-08-31', '2024-08-31 16:00:00'),
(8, 8, '2024-09-01', '2024-09-01 13:30:00'),
(9, 9, '2024-09-02', '2024-09-02 14:00:00'),
(10, 10, '2024-09-03', '2024-09-03 17:00:00');

----Inserting Data in to Room Table
INSERT INTO Room (Room_ID, Room_Name, Room_Type, Room_Rate, Room_Number)
VALUES
(1, 'Deluxe', 'Single', 150.00, 101),
(2, 'Deluxe', 'Double', 200.00, 102),
(3, 'Suite', 'Single', 300.00, 201),
(4, 'Suite', 'Double', 350.00, 202),
(5, 'Executive', 'Single', 400.00, 301),
(6, 'Executive', 'Double', 450.00, 302),
(7, 'Presidential', 'Suite', 1000.00, 401),
(8, 'Standard', 'Single', 100.00, 501),
(9, 'Standard', 'Double', 120.00, 502),
(10, 'Economy', 'Single', 80.00, 601);

-- Inserting Data into Reservation Table
INSERT INTO Reservation (ReservationID, Rsv_Gst_ID, Rsv_Room_ID, No_Of_Guest, Cheacking_Date, Cheacking_Out, TIME, Reservation_Date)
VALUES
(1, 1, 1, 2, '2024-08-25', '2024-08-27', '2024-08-25 12:00:00', '2024-08-20'),
(2, 2, 2, 1, '2024-08-26', '2024-08-28', '2024-08-26 14:00:00', '2024-08-21'),
(3, 3, 3, 2, '2024-08-27', '2024-08-29', '2024-08-27 16:00:00', '2024-08-22'),
(4, 4, 4, 3, '2024-08-28', '2024-08-30', '2024-08-28 10:00:00', '2024-08-23'),
(5, 5, 5, 1, '2024-08-29', '2024-08-31', '2024-08-29 18:00:00', '2024-08-24'),
(6, 6, 6, 2, '2024-08-30', '2024-09-01', '2024-08-30 09:00:00', '2024-08-25'),
(7, 7, 7, 4, '2024-08-31', '2024-09-02', '2024-08-31 11:00:00', '2024-08-26'),
(8, 8, 8, 2, '2024-09-01', '2024-09-03', '2024-09-01 13:00:00', '2024-08-27'),
(9, 9, 9, 3, '2024-09-02', '2024-09-04', '2024-09-02 15:00:00', '2024-08-28'),
(10, 10, 10, 1, '2024-09-03', '2024-09-05', '2024-09-03 17:00:00', '2024-08-29');


-- Inserting Data into Event Table
INSERT INTO Event (Event_ID, Event_Name, Event_Date, Event_Location, Event_Description)
VALUES
(1, 'Conference', '2024-09-01', 'Main Hall', 'Business conference with keynote speakers'),
(2, 'Wedding', '2024-09-02', 'Banquet Hall', 'Elegant wedding ceremony and reception'),
(3, 'Concert', '2024-09-03', 'Outdoor Stage', 'Live music concert featuring local bands'),
(4, 'Workshop', '2024-09-04', 'Conference Room', 'Educational workshop on digital marketing'),
(5, 'Gala Dinner', '2024-09-05', 'Grand Ballroom', 'Formal gala dinner with awards ceremony'),
(6, 'Product Lch', '2024-09-06', 'Exhibition Hall', 'Launch event for new product line'),
(7, 'Charity Auct', '2024-09-07', 'Banquet Hall', 'Charity auction to support local causes'),
(8, 'Networking', '2024-09-08', 'Main Hall', 'Networking event for industry professionals'),
(9, 'Theater Perf', '2024-09-09', 'Theater Room', 'Evening of drama and performances'),
(10, 'Holiday Party', '2024-09-10', 'Grand Ballroom', 'Festive party to celebrate the holiday season');

-- Inserting Data into Guest_Attented_Events Table
INSERT INTO Guest_Attented_Events(Gst_Atnd_Evnt_Event_ID, Gst_Atnd_Evnt_Guest_ID, Date, Time)
VALUES
(1, 1, '2024-09-01', '2024-09-01 09:00:00'),
(1, 2, '2024-09-01', '2024-09-01 09:00:00'),
(2, 3, '2024-09-02', '2024-09-02 11:00:00'),
(2, 4, '2024-09-02', '2024-09-02 11:00:00'),
(3, 5, '2024-09-03', '2024-09-03 18:00:00'),
(3, 6, '2024-09-03', '2024-09-03 18:00:00'),
(4, 7, '2024-09-04', '2024-09-04 10:00:00'),
(4, 8, '2024-09-04', '2024-09-04 10:00:00'),
(5, 9, '2024-09-05', '2024-09-05 20:00:00'),
(5, 10, '2024-09-05', '2024-09-05 20:00:00');

-- Inserting Data into Review Table
INSERT INTO Review (Review_ID, Review_Comment, Review_Date, Review_Rating, Rvew_Guest_ID)
VALUES
(1, 'Excellent service and beautiful room!', '2024-08-26', 5.00, 1),
(2, 'The food was great, but the room was small.', '2024-08-27', 4.00, 2),
(3, 'Had a wonderful stay, will come back again.', '2024-08-28', 5.00, 3),
(4, 'Good value for money, but noisy at night.', '2024-08-29', 3.50, 4),
(5, 'Perfect for business travelers, very convenient.', '2024-08-30', 4.50, 5),
(6, 'The event facilities were top-notch.', '2024-08-31', 5.00, 6),
(7, 'Friendly staff but slow check-in process.', '2024-09-01', 3.00, 7),
(8, 'Great location and amenities.', '2024-09-02', 4.75, 8),
(9, 'The suite was luxurious, worth the price.', '2024-09-03', 5.00, 9),
(10, 'Good experience overall, but room service was delayed.', '2024-09-04', 3.75, 10);

-- Inserting Data into Payment Table
-- Inserting Data into Payment Table
INSERT INTO Payment (Payment_ID, Payment_Date, Payment_Amount, Payment_Method, pmt_Reservation_ID)
VALUES
(1, '2024-08-25', 150.00, 'Credit Card', 1),
(2, '2024-08-26', 200.00, 'Debit Card', 2),
(3, '2024-08-27', 300.00, 'Credit Card', 3),
(4, '2024-08-28', 350.00, 'Cash', 4),
(5, '2024-08-29', 400.00, 'Credit Card', 5),
(6, '2024-08-30', 450.00, 'Debit Card', 6),
(7, '2024-08-31', 1000.00, 'Credit Card', 7),
(8, '2024-09-01', 120.00, 'Cash', 8),
(9, '2024-09-02', 300.00, 'Credit Card', 9),
(10, '2024-09-03', 80.00, 'Debit Card', 10);




--3. Frequently Asked Questions: SQL SELECT Queries
	--1)Get all guests who stayed more than once:
SELECT Guest_Name, COUNT(*) AS Stays
FROM Guest g
JOIN Reservation r ON g.Guest_ID = r.Rsv_Gst_ID
GROUP BY Guest_Name
HAVING COUNT(*) > 1;

	--2)List all rooms that have not been reserved:
SELECT Room_Name, Room_Type
FROM Room
WHERE Room_ID NOT IN (SELECT Rsv_Room_ID FROM Reservation);

	--3)Get the total amount of money earned by each employee:
SELECT e.Employee_Name, SUM(s.Service_Price) AS Total_Earnings
FROM Employee e
JOIN Service s ON e.Employee_ID = s.Emp_ID
JOIN Serviced_Guest sg ON s.Service_ID = sg.Ser_ID
GROUP BY e.Employee_Name;

	--4)Find the most frequently attended event:
SELECT TOP 1 
    e.Event_Name, 
    COUNT(*) AS Attendance
FROM Event e
JOIN Guest_Attented_Events gae ON e.Event_ID = gae.Gst_Atnd_Evnt_Event_ID
GROUP BY e.Event_Name
ORDER BY Attendance DESC;


	--5)List the highest-rated services:
SELECT TOP 5 
    s.Service_Name, 
    AVG(r.Review_Rating) AS Average_Rating
FROM Service s
JOIN Review r ON s.Service_ID = r.Service_ID
GROUP BY s.Service_Name
ORDER BY Average_Rating DESC;


--4. Advanced SQL Queries Using GROUP BY, ORDER BY, and HAVING
	--Total number of guests per event, ordered by most attended:
SELECT e.Event_Name, COUNT(gae.Gst_Atnd_Evnt_Guest_ID) AS Total_Attendees
FROM Event e
INNER JOIN Guest_Attended_Events gae ON e.Event_ID = gae.Gst_Atnd_Evnt_Event_ID
GROUP BY e.Event_Name
ORDER BY Total_Attendees DESC;

	--List employees who have handled more than 5 services:
SELECT e.Employee_Name, COUNT(s.Service_ID) AS Services_Handled
FROM Employee e
JOIN Service s ON e.Employee_ID = s.Emp_ID
GROUP BY e.Employee_Name
HAVING COUNT(s.Service_ID) > 5;

	--Average room rate per room type:
SELECT Room_Type, AVG(Room_Rate) AS Average_Rate
FROM Room
GROUP BY Room_Type;


SELECT Guest.Guest_Name, Event.Event_Name
FROM Guest
JOIN Guest_Attented_Events ON Guest.Guest_ID = Guest_Attented_Events.Gst_Atnd_Evnt_Guest_ID
JOIN Event ON Guest_Attented_Events.Gst_Atnd_Evnt_Event_ID = Event.Event_ID
WHERE Event.Event_Name = 'Conference';




DROP TABLE Employee;
DROP TABLE Event;
DROP TABLE Guest;
DROP TABLE Guest_Attented_Events;
DROP TABLE Reservation;
DROP TABLE Room;
DROP TABLE Service;
DROP TABLE Serviced_Guest;
DROP TABLE Payment;

SELECT * FROM Employee;
SELECT * FROM Event;
SELECT * FROM Guest;
SELECT * FROM Guest_Attented_Events;
SELECT * FROM Reservation;
SELECT * FROM Room;
SELECT * FROM Service;
SELECT * FROM Serviced_Guest;
SELECT * FROM Review;
SELECT * FROM Payment;