CREATE DATABASE GHH_db;
USE GHH_db;

CREATE TABLE Guests(
    guest_id    INT PRIMARY KEY,
    first_name  VARCHAR(25) NOT NULL,
    last_name   VARCHAR(25) NOT NULL,
    email       TEXT,
    phone       VARCHAR(15) UNIQUE,
    address     TEXT,
    city        VARCHAR(50),
    country     VARCHAR(25),
    id_type     VARCHAR(50),
    id_number   VARCHAR(50)
);

SELECT * FROM Guests;

INSERT INTO Guests VALUES
	(1001, 'James', 'Wilson', 'j.wilson@email.com', '+15551234567', '123 Main St', 'New York', 'USA', 'Passport', 'P12345678'),
	(1002, 'Sarah', 'Johnson', 's.johnson@email.com', '+15559876543', '456 Oak Ave', 'Los Angeles', 'USA', 'Driver License', 'DL87654321'),
	(1003, 'Robert', 'Brown', NULL, '+442071234567', '789 High Rd', 'London', 'UK', 'Passport', 'PUK987654'),
	(1004, 'Emily', 'Davis', 'e.davis@email.com', '+61391234567', '321 King St', 'Sydney', 'Australia', 'National ID', 'AUS654321'),
	(1005, 'Michael', 'Miller', 'm.miller@email.com', '+81312345678', '654 Ginza St', 'Tokyo', 'Japan', 'Passport', 'PJPN456789'),
	(1006, 'Jessica', 'Taylor', 'j.taylor@email.com', '+33123456789', '159 Champs-Élysées', 'Paris', 'France', 'National ID', 'FR789123'),
	(1007, 'David', 'Anderson', NULL, '+861012345678', '852 Nanjing Rd', 'Shanghai', 'China', 'Passport', 'PCN123789'),
	(1008, 'Olivia', 'Thomas', 'o.thomas@email.com', '+525512345678', '753 Reforma Ave', 'Mexico City', 'Mexico', 'Driver License', 'DLMX456123'),
	(1009, 'Daniel', 'White', 'd.white@email.com', '+4915123456789', '426 Friedrichstr', 'Berlin', 'Germany', 'Passport', 'PDEU789456'),
	(1010, 'Sophia', 'Martin', NULL, '+390612345678', '963 Via Veneto', 'Rome', 'Italy', 'National ID', 'IT123456');

CREATE TABLE Rooms(
    room_id          INT PRIMARY KEY,
    room_number      VARCHAR(10) NOT NULL,
    room_type        VARCHAR(50),
    floor            INT,
    max_occupancy    INT,
    price_per_night  DECIMAL(10,2) NOT NULL,
    has_balcony      BOOLEAN,
    is_smoking       BOOLEAN,
    bed_type         VARCHAR(25)
);

SELECT * FROM Rooms;

INSERT INTO Rooms VALUES
	(2001, '101', 'Standard', 1, 2, 120.00, FALSE, FALSE, 'Double'),
	(2002, '102', 'Standard', 1, 2, 120.00, FALSE, TRUE, 'Double'),
	(2003, '201', 'Deluxe', 2, 3, 180.00, TRUE, FALSE, 'Queen'),
	(2004, '202', 'Deluxe', 2, 3, 180.00, TRUE, FALSE, 'Queen'),
	(2005, '301', 'Suite', 3, 4, 250.00, TRUE, FALSE, 'King'),
	(2006, '302', 'Suite', 3, 4, 250.00, TRUE, FALSE, 'King'),
	(2007, '401', 'Executive Suite', 4, 2, 350.00, TRUE, FALSE, 'King'),
	(2008, '402', 'Executive Suite', 4, 2, 350.00, TRUE, FALSE, 'King'),
	(2009, '501', 'Presidential Suite', 5, 4, 500.00, TRUE, FALSE, 'King'),
	(2010, '502', 'Presidential Suite', 5, 4, 500.00, TRUE, FALSE, 'King'),
	(2011, '103', 'Standard', 1, 2, 120.00, FALSE, FALSE, 'Twin'),
	(2012, '104', 'Standard', 1, 2, 120.00, FALSE, TRUE, 'Twin'),
	(2013, '203', 'Deluxe', 2, 3, 180.00, TRUE, FALSE, 'Double'),
	(2014, '204', 'Deluxe', 2, 3, 180.00, TRUE, FALSE, 'Double'),
	(2015, '303', 'Suite', 3, 4, 250.00, TRUE, FALSE, 'Queen');

CREATE TABLE Reservations(
    reservation_id    INT PRIMARY KEY,
    guest_id          INT,
    room_id           INT,
    check_in          DATE,
    check_out         DATE,
    adults            INT,
    children          INT,
    total_amount      DECIMAL(10,2),
    status            VARCHAR(50),
    payment_status    VARCHAR(50),
    FOREIGN KEY (guest_id) REFERENCES  Guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES 
Rooms(room_id)
);

SELECT * FROM Reservations;

INSERT INTO Reservations VALUES
	(3001, 1001, 2001, '2023-11-01', '2023-11-05', 2, 0, 480.00, 'Checked-out', 'Paid'),
	(3002, 1002, 2003, '2023-11-02', '2023-11-07', 2, 1, 900.00, 'Checked-out', 'Paid'),
	(3003, 1003, 2005, '2023-11-03', '2023-11-06', 2, 2, 750.00, 'Checked-out', 'Paid'),
	(3004, 1004, 2007, '2023-11-05', '2023-11-10', 2, 0, 1750.00, 'Checked-out', 'Paid'),
	(3005, 1005, 2009, '2023-11-10', '2023-11-15', 4, 0, 2500.00, 'Confirmed', 'Partially Paid'),
	(3006, 1006, 2011, '2023-11-12', '2023-11-14', 1, 0, 240.00, 'Confirmed', 'Pending'),
	(3007, 1007, 2013, '2023-11-15', '2023-11-20', 2, 1, 900.00, 'Confirmed', 'Pending'),
	(3008, 1008, 2015, '2023-11-18', '2023-11-22', 2, 2, 1000.00, 'Confirmed', 'Paid'),
	(3009, 1009, 2002, '2023-11-20', '2023-11-25', 2, 0, 600.00, 'Confirmed', 'Pending'),
	(3010, 1010, 2004, '2023-11-22', '2023-11-27', 2, 1, 900.00, 'Confirmed', 'Paid');

CREATE TABLE Services(
    service_id         INT PRIMARY KEY,
    service_name       VARCHAR(100),
    description        TEXT,
    price              DECIMAL(10,2),
    is_charge_per_day  BOOLEAN
);

SELECT * FROM Services;

INSERT INTO Services VALUES
	(4001, 'Breakfast Buffet', 'Continental breakfast buffet', 15.00, FALSE),
	(4002, 'Airport Transfer', 'Round-trip airport shuttle', 50.00, FALSE),
	(4003, 'Spa Access', 'Full-day spa access', 75.00, TRUE),
	(4004, 'Parking', 'Valet parking per day', 25.00, TRUE),
	(4005, 'Laundry', 'Express laundry service', 20.00, FALSE),
	(4006, 'Mini Bar', 'Daily mini bar restock', 30.00, TRUE),
	(4007, 'Room Service', '24/7 room service', 10.00, FALSE),
	(4008, 'Business Center', 'Computer and printer access', 15.00, FALSE),
	(4009, 'Gym Access', '24-hour fitness center', 0.00, FALSE),
	(4010, 'Pet Fee', 'Pet accommodation fee per stay', 50.00, FALSE);

CREATE TABLE Reservation_services(
    id               INT PRIMARY KEY,
    reservation_id   INT,
    service_id       INT,
    quantity         INT,
    service_date     DATE,
    total_price      DECIMAL(10,2),
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservation_id),
    FOREIGN KEY (service_id) REFERENCES Services(service_id) 
);

SELECT * FROM Reservation_services;

INSERT INTO Reservation_services VALUES
	(5001, 3001, 4001, 4, '2023-11-02', 60.00),
	(5002, 3001, 4004, 4, NULL, 100.00),
	(5003, 3002, 4002, 1, '2023-11-03', 50.00),
	(5004, 3003, 4003, 3, '2023-11-04', 225.00),
	(5005, 3004, 4006, 5, NULL, 150.00),
	(5006, 3005, 4007, 5, NULL, 50.00),
	(5007, 3006, 4001, 2, '2023-11-13', 30.00),
	(5008, 3007, 4002, 1, '2023-11-16', 50.00),
	(5009, 3008, 4005, 2, '2023-11-19', 40.00),
	(5010, 3009, 4008, 3, NULL, 45.00);

-- 1. List all guests sorted by last name alphabetically.
SELECT * FROM Guests
ORDER BY last_name;

-- 2. Show all available rooms (not currently reserved) for a given date range.
SELECT r.*,COUNT(re.reservation_id) AS Total_Reservations
FROM Rooms r
LEFT JOIN Reservations re
ON r.room_id=re.room_id
WHERE  NOT EXISTS( 
	SELECT * FROM Reservations re
	WHERE re.room_id=r.room_id
	AND (
		'2023-11-17'<re.check_out AND '2023-11-21'>=re.check_in
	)
)
GROUP BY r.room_id;

-- 3. Find all reservations with a status of "Checked-out".
SELECT * FROM Reservations
WHERE status='Checked-out';

-- 4. Display guests who haven't provided an email address.
SELECT * FROM Guests
WHERE email IS NULL;

-- 5. Count how many reservations each guest has made.
SELECT 
	g.guest_id,CONCAT(g.first_name,' ' ,g.last_name) AS Guest_Name,COUNT(re.reservation_id) AS Total_Reservations
FROM Guests g
LEFT JOIN Reservations re
ON g.guest_id=re.guest_id
GROUP BY g.guest_id;

-- 6. Find all standard rooms with a double bed.
SELECT * FROM Rooms
WHERE room_type='Standard' AND bed_type='Double';

-- 7. List reservations that include children.
SELECT * FROM Reservations
WHERE children !=0;

-- 8. Show rooms with balconies on floors 2 and above.
SELECT * FROM Rooms
WHERE floor>=2 AND has_balcony=TRUE;

-- 9. Find reservations longer than 5 nights.
SELECT *, TIMESTAMPDIFF(DAY,check_in,check_out) AS Total_Nights FROM Reservations
WHERE TIMESTAMPDIFF(DAY,check_in,check_out)>5;

-- 10. Display smoking rooms that are currently available.
SELECT r.*
FROM Rooms r
WHERE r.is_smoking=TRUE AND NOT
 EXISTS( 
	SELECT * FROM Reservations re
	WHERE re.room_id=r.room_id
	AND (
		CURRENT_DATE<re.check_out AND CURRENT_DATE >=re.check_in
	)
);

-- 11. Calculate the total revenue from all paid reservations.
SELECT payment_status, SUM(total_amount) AS Total_Revenue FROM Reservations
WHERE payment_status='Paid'
GROUP BY payment_status;

-- 12. Show the average spending per reservation by room type.
SELECT r.room_type, AVG(re.total_amount) AS Average_Spending 
FROM Rooms r
LEFT JOIN Reservations re
ON r.room_id=re.room_id
GROUP BY r.room_type;

-- 13. Find reservations with outstanding payments (status = 'Pending' or 'Partially Paid').
SELECT * FROM Reservations 
WHERE payment_status IN ('Pending','Partially Paid');

-- 14. Calculate the total service charges for each reservation.
SELECT re.* , SUM(rs.total_price) AS Service_Charges
FROM Reservations re
LEFT JOIN Reservation_services rs
ON re.reservation_id=rs.reservation_id
GROUP BY re.reservation_id;

-- 15. List the top 5 most profitable reservations.
SELECT re.* ,
	(re.total_amount+SUM(rs.total_price)) AS Total_Profit
FROM Reservations re
JOIN Reservation_services rs
ON re.reservation_id=rs.reservation_id
GROUP BY re.reservation_id
ORDER BY Total_Profit DESC
LIMIT 5;

-- 16. Find which services are most frequently booked.
SELECT s.* ,COUNT(rs.id) AS Bookings
FROM Services s
LEFT JOIN Reservation_services rs
ON s.service_id=rs.service_id
GROUP BY s.service_id
ORDER BY Bookings DESC
LIMIT 3;

-- 17. Show reservations that included airport transfer service.
SELECT re.*, s.service_name 
FROM Reservations re
JOIN Reservation_services rs 
ON re.reservation_id=rs.reservation_id
JOIN Services s
ON s.service_id=rs.service_id
WHERE s.service_name='Airport Transfer';

-- 18. Calculate the total daily revenue from breakfast buffets.
SELECT rs.service_date, SUM(rs.total_price) AS Daily_Revenue,s.service_name
FROM Reservation_services rs
JOIN Services s
ON rs.service_id=s.service_id
WHERE s.service_name='Breakfast Buffet' 
GROUP BY rs.service_date
ORDER BY rs.service_date;
