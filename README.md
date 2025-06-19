# Grand Horizon Hotel
## Overview
The GHH_db (Grand Harmony Hotel Database) is a comprehensive relational database designed to streamline and manage the core operations of a hotel, including guest management, room allocation, reservations, service tracking, and payment processing. The system ensures efficient data organization, supports query-driven insights, and promotes scalability for real-world hotel operations. This project implements normalized tables with proper relationships and enforces data integrity using keys and constraints, enabling reliable and consistent data management.

## Objectives 
#### 1. Guest Management:
 Store and retrieve complete guest information including personal details and identification.
#### 2. Room Inventory Tracking:
Maintain details of each room, such as type, floor, occupancy, and availability.
#### 3. Reservation Handling:
 Record guest bookings, check-in/out dates, occupancy details, and reservation status.
#### 4. Service Integration:
 Manage various hotel services availed by guests during their stay, including quantity, pricing, and dates.
#### 5. Revenue & Performance Insights:
Enable queries to calculate income from reservations and services, identify high-value guests, and highlight usage patterns.
#### 6. Operational Queries: 
Support business logic for available rooms, pending payments, and other daily operations using SQL queries.
#### 7. Data Integrity & Relationships:
 Ensure all entities are properly linked using primary and foreign keys to maintain consistency across the database.

## Creating Database
``` sql
CREATE DATABASE GHH_db;
USE GHH_db;
```
## Creating Tables
### Table:
``` sql
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
```
### Table:
``` sql
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
```
### Table:
``` sql
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
```
### Table:
``` sql
CREATE TABLE Services(
    service_id         INT PRIMARY KEY,
    service_name       VARCHAR(100),
    description        TEXT,
    price              DECIMAL(10,2),
    is_charge_per_day  BOOLEAN
);

SELECT * FROM Services;
```
### Table:
``` sql
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
```
#### 1. List all guests sorted by last name alphabetically.
``` sql
SELECT * FROM Guests
ORDER BY last_name;
```
#### 2. Show all available rooms (not currently reserved) for a given date range.
``` sql
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
```
#### 3. Find all reservations with a status of "Checked-out".
``` sql
SELECT * FROM Reservations
WHERE status='Checked-out';
```
#### 4. Display guests who haven't provided an email address.
``` sql
SELECT * FROM Guests
WHERE email IS NULL;
```
#### 5. Count how many reservations each guest has made.
``` sql
SELECT 
        g.guest_id,CONCAT(g.first_name,' ' ,g.last_name) AS Guest_Name,COUNT(re.reservation_id) AS Total_Reservations
FROM Guests g
LEFT JOIN Reservations re
ON g.guest_id=re.guest_id
GROUP BY g.guest_id;
```
#### 6. Find all standard rooms with a double bed.
``` sql
SELECT * FROM Rooms
WHERE room_type='Standard' AND bed_type='Double';
```
#### 7. List reservations that include children.
``` sql
SELECT * FROM Reservations
WHERE children !=0;
```
#### 8. Show rooms with balconies on floors 2 and above.
``` sql
SELECT * FROM Rooms
WHERE floor>=2 AND has_balcony=TRUE;
```
#### 9. Find reservations longer than 5 nights.
``` sql
SELECT *, TIMESTAMPDIFF(DAY,check_in,check_out) AS Total_Nights FROM Reservations
WHERE TIMESTAMPDIFF(DAY,check_in,check_out)>5;
```
#### 10. Display smoking rooms that are currently available.
``` sql
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
```
#### 11. Calculate the total revenue from all paid reservations.
``` sql
SELECT payment_status, SUM(total_amount) AS Total_Revenue FROM Reservations
WHERE payment_status='Paid'
GROUP BY payment_status;
```
#### 12. Show the average spending per reservation by room type.
``` sql
SELECT r.room_type, AVG(re.total_amount) AS Average_Spending 
FROM Rooms r
LEFT JOIN Reservations re
ON r.room_id=re.room_id
GROUP BY r.room_type;
```
#### 13. Find reservations with outstanding payments (status = 'Pending' or 'Partially Paid').
``` sql
SELECT * FROM Reservations 
WHERE payment_status IN ('Pending','Partially Paid');
```
#### 14. Calculate the total service charges for each reservation.
``` sql
SELECT re.* , SUM(rs.total_price) AS Service_Charges
FROM Reservations re
LEFT JOIN Reservation_services rs
ON re.reservation_id=rs.reservation_id
GROUP BY re.reservation_id;
```
#### 15. List the top 5 most profitable reservations.
``` sql
SELECT re.* ,       (re.total_amount+SUM(rs.total_price)) AS Total_Profit
FROM Reservations re
JOIN Reservation_services rs
ON re.reservation_id=rs.reservation_id
GROUP BY re.reservation_id
ORDER BY Total_Profit DESC
LIMIT 5;
```
#### 16. Find which services are most frequently booked.
``` sql
SELECT s.* ,COUNT(rs.id) AS Bookings
FROM Services s
LEFT JOIN Reservation_services rs
ON s.service_id=rs.service_id
GROUP BY s.service_id
ORDER BY Bookings DESC
LIMIT 3;
```
#### 17. Show reservations that included airport transfer service.
``` sql
SELECT re.*, s.service_name 
FROM Reservations re
JOIN Reservation_services rs 
ON re.reservation_id=rs.reservation_id
JOIN Services s
ON s.service_id=rs.service_id
WHERE s.service_name='Airport Transfer';
```
#### 18. Calculate the total daily revenue from breakfast buffets.
``` sql
SELECT rs.service_date, SUM(rs.total_price) AS Daily_Revenue,s.service_name
FROM Reservation_services rs
JOIN Services s
ON rs.service_id=s.service_id
WHERE s.service_name='Breakfast Buffet' 
GROUP BY rs.service_date
ORDER BY rs.service_date;
```
## Conclusion
The GHH_db project effectively models a real-world hotel management system, providing a robust backend for managing guests, reservations, rooms, and services. It enables efficient tracking of room availability, guest preferences, revenue, and service utilization. The SQL queries implemented demonstrate practical business insights and decision-making capabilities. With further enhancements such as stored procedures, triggers, and reporting views, this system can be scaled and integrated into a fully functional hotel management software solution.


