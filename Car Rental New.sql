CREATE DATABASE RentCar

/*
location, car, booking, customer, admin, billing */

CREATE TABLE [Location]
	(
	LocationID bigint NOT NULL
		CONSTRAINT PK_LocationID PRIMARY KEY,
	LocationName varchar (25) NOT NULL,
	Street varchar (15) NOT NULL,
	City varchar (15) NOT NULL,
	ZipCode bigint NOT NULL
	)

CREATE TABLE Car
	(
	CarID bigint NOT NULL
		CONSTRAINT PK_CarID Primary Key,
	RegisterNumber bigint NOT NULL,
	Model varchar (15) NOT NULL,
	Brand varchar (15) NOT NULL,
	LocationID bigint NOT NULL
		CONSTRAINT FK_LocationID Foreign Key
		REFERENCES [Location] (LocationID),
	RentPrice bigint NOT NULL,
	TransmitType varchar (15) NOT NULL
	)

ALTER TABLE [Location]
	ADD CONSTRAINT FK_Location
	FOREIGN KEY (ZipCode)
	REFERENCES dbo.Car (CarID)

CREATE TABLE Booking
	(
	BookingID bigint NOT NULL
		CONSTRAINT PK_BookingID PRIMARY KEY,
	FromDate date NOT NULL,
	EndDate date NOT NULL,
	CustomerID bigint NOT NULL, /* alter table this */
	CarID bigint NOT NULL
		CONSTRAINT FK_CarID FOREIGN KEY
		REFERENCES [Car] (CarID)
	)

CREATE TABLE Customer
	(
	CustomerID bigint NOT NULL
		CONSTRAINT PK_CustomerID PRIMARY KEY,
	UserName varchar (15) NOT NULL,
	FullName varchar (25) NOT NULL,
	Email varchar (25) NOT NULL,
	PhoneNumber int NOT NULL,
	[Password] varchar (15) NOT NULL
	)
/* dito ka mag alter table, gawin fk 
si CustID from Booking to custID ni Customer Table*/

ALTER TABLE [Booking]
	ADD CONSTRAINT FK_CustomerID
	FOREIGN KEY (CustomerID)
	REFERENCES dbo.Customer (CustomerID)

/* dagdag si Status kasi nalimutan */
ALTER TABLE Booking
	ADD [Status] varchar (15) NOT NULL

CREATE TABLE [Admin] 
	(
	AdminID bigint NOT NULL,
	UserName varchar (15) NOT NULL
		CONSTRAINT PK_UserName PRIMARY KEY,
	AdminCarID bigint NOT NULL
		CONSTRAINT FK_AdminCarID FOREIGN KEY
		REFERENCES [Car] (CarID)
	)

/* alter table username in customer to be FK */
ALTER TABLE Customer
	ADD CONSTRAINT FK_UserName
	FOREIGN KEY (UserName)
	REFERENCES [Admin] (UserName)

CREATE TABLE Billing
	(
	BillingID bigint NOT NULL
		CONSTRAINT PK_BillingID PRIMARY KEY,
	BillDate date NOT NULL,
	BillStatus bigint NOT NULL,
	TotalAmount bigint NOT NULL,
	BookingID bigint NOT NULL
		CONSTRAINT FK_BookingID FOREIGN KEY
		REFERENCES dbo.Booking (BookingID)
	)