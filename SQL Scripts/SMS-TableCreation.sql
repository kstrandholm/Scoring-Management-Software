

CREATE TABLE Categories(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL
)

CREATE TABLE Comments(
    ID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX),
    Category_ID INT NOT NULL
            REFERENCES Categories(ID)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)

CREATE TABLE Studios(
    ID INT IDENTITY PRIMARY KEY,
    Name NVARCHAR(MAX) NOT NULL,
    
)