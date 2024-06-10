USE Pract10WpfDB;
GO

CREATE TABLE Specialites(
	ID_Specialist INT PRIMARY KEY IDENTITY (1,1) NOT NULL,
	SpecialistName NVARCHAR(50) NOT NULL
);
GO

INSERT INTO Specialites(SpecialistName)
	VALUES
	('Офтальмолог'),
	('Стоматолог'),
	('Невролог'),
	('Психиатор'),
	('Терапевт'),
	('Педиатор'),
	('Хирург'),
	('Окулист')
GO


CREATE TABLE Patient(
	ID_Patient BIGINT PRIMARY KEY,
	Surname NVARCHAR(50) NOT NULL,
	NamePatient NVARCHAR(50) NOT NULL,
	Patronymic NVARCHAR(50) NULL,
	BirhDate DATE NOT NULL,
	AddressOfPatient NVARCHAR(255) NOT NULL,
	LivingAddress NVARCHAR(255) NOT NULL,
	Phone NVARCHAR(18) NULL,
	Email NVARCHAR(50) NULL,
	Nickname NVARCHAR(50) NULL
);
GO


CREATE TABLE Directions(
	ID_Direction CHAR(18) PRIMARY KEY,
	Specialist_ID INT NOT NULL,
	FOREIGN KEY (Specialist_ID) REFERENCES Specialites (ID_Specialist),
	Patient_ID BIGINT NOT NULL,
	FOREIGN KEY (Patient_ID) REFERENCES Patient (ID_Patient)
);
GO


CREATE TABLE Doctor(
	ID_Doctor INT PRIMARY KEY IDENTITY (1,1),
	Surname NVARCHAR(50) NOT NULL,
	NameDoctor NVARCHAR(50) NOT NULL,
	Patronymic NVARCHAR(50) NULL,
	Specialist_ID INT NOT NULL,
	FOREIGN KEY (Specialist_ID) REFERENCES Specialites (ID_Specialist),
	EnterPassword NVARCHAR(50) NOT NULL,
	WorkAddress NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE Admin_(
	ID_Admin INT PRIMARY KEY IDENTITY (1,1),
	Surname NVARCHAR(50) NOT NULL,
	NameAdmin NVARCHAR(50) NOT NULL,
	Patronymic NVARCHAR(50) NULL,
	EnterPassword NVARCHAR(50) NOT NULL
);
GO

INSERT INTO Admin_(Surname, NameAdmin, Patronymic, EnterPassword)
	VALUES
	('Петров', 'Глеб', 'Александрович', 'admin123')
GO

CREATE TABLE Statuses(
	ID_Status INT PRIMARY KEY IDENTITY (1,1),
	NameStatus NVARCHAR(50) NOT NULL
);
GO

INSERT INTO Statuses(NameStatus)
	VALUES
	('Актуальна'),
	('Не актуальна')
GO

CREATE TABLE Appoinments(
	ID_Appoinment INT PRIMARY KEY IDENTITY (1,1),
	AppointmentDate DATE NOT NULL,
	AppointmentTime TIME NOT NULL,
	Doctor_ID INT NOT NULL,
	FOREIGN KEY (Doctor_ID) REFERENCES Doctor (ID_Doctor),
	Patient_ID BIGINT NOT NULL,
	FOREIGN KEY (Patient_ID) REFERENCES Patient (ID_Patient),
	Status_ID INT NULL,
	FOREIGN KEY (Status_ID) REFERENCES Statuses (ID_Status),
);
GO

CREATE TABLE AppoinmentDocument(
	ID_AppoinmentDocument INT NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Appoinments(ID_Appoinment),
	RTF NVARCHAR(max) NOT NULL
);
GO

CREATE TABLE AnalysDocument(
	ID_AppoinmentDocument INT NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Appoinments(ID_Appoinment),
	RTF NVARCHAR(max) NOT NULL
);
GO

CREATE TABLE ResearchDocument(
	ID_AppoinmentDocument INT NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES Appoinments(ID_Appoinment),
	RTF NVARCHAR(max) NOT NULL,
	Attachment VARBINARY(max)
);
GO