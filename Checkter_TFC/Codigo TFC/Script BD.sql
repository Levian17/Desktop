CREATE DATABASE Pruebas;
USE Pruebas;

-- Crear la tabla Usuario
CREATE TABLE Usuario (
    ID_Usuario INT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(50) NOT NULL,
    Premium BOOLEAN,
    ELO INT
);

-- Crear la tabla Club
CREATE TABLE Club (
    ID_Club INT PRIMARY KEY,
    Members INT
);

-- Crear la tabla Review
CREATE TABLE Review (
    ID_Review INT PRIMARY KEY,
    Text TEXT,
    Score INT,
    ID_Usuario INT,
    ID_Club INT,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_Club) REFERENCES Club(ID_Club)
);

-- Crear la tabla Game
CREATE TABLE Game (
    ID_Game INT PRIMARY KEY,
    Type VARCHAR(50),
    Mean_ELO INT,
    White_ID INT,
    Black_ID INT,
    Moves TEXT,
    FOREIGN KEY (White_ID) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (Black_ID) REFERENCES Usuario(ID_Usuario)
);

-- Crear la tabla Date
CREATE TABLE Date (
    ID_Date INT PRIMARY KEY,
    Year INT,
    Month INT,
    Day INT
);

-- Crear la tabla intermedia entre Usuario y Club para la relación "Integrates"
CREATE TABLE Usuario_Club (
    ID_Usuario INT,
    ID_Club INT,
    PRIMARY KEY (ID_Usuario, ID_Club),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_Club) REFERENCES Club(ID_Club)
);

-- Crear la tabla intermedia entre Usuario y Usuario para la relación "Challenges"
CREATE TABLE Usuario_Challenges (
    Challenger_ID INT,
    Challengee_ID INT,
    PRIMARY KEY (Challenger_ID, Challengee_ID),
    FOREIGN KEY (Challenger_ID) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (Challengee_ID) REFERENCES Usuario(ID_Usuario)
);

-- Crear la tabla intermedia entre Usuario y Game para la relación "Plays"
CREATE TABLE Usuario_Game (
    ID_Usuario INT,
    ID_Game INT,
    PRIMARY KEY (ID_Usuario, ID_Game),
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario),
    FOREIGN KEY (ID_Game) REFERENCES Game(ID_Game)
);

-- Crear la tabla intermedia entre Review y Date para la relación "Associated"
CREATE TABLE Review_Date (
    ID_Review INT,
    ID_Date INT,
    PRIMARY KEY (ID_Review, ID_Date),
    FOREIGN KEY (ID_Review) REFERENCES Review(ID_Review),
    FOREIGN KEY (ID_Date) REFERENCES Date(ID_Date)
);

-- Crear la tabla intermedia entre Game y Date para la relación "Takes Place"
CREATE TABLE Game_Date (
    ID_Game INT,
    ID_Date INT,
    PRIMARY KEY (ID_Game, ID_Date),
    FOREIGN KEY (ID_Game) REFERENCES Game(ID_Game),
    FOREIGN KEY (ID_Date) REFERENCES Date(ID_Date)
);

