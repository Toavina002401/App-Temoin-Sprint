/******************** Données du table Utilisateur  ***************************/
INSERT INTO Utilisateur(pseudo,mdp) VALUES ('Administrateur','Admin123');
INSERT INTO Utilisateur(pseudo,mdp) VALUES ('Mr Judge','Judge123');
/******************** Fin Données du table Utilisateur  ***************************/

/******************** Données du table Avion  ***************************/
INSERT INTO Avion (date_fabrication, modele, code_avion) VALUES
('2018-06-15', 'Airbus A320', 'A320-XYZ'),
('2020-03-22', 'Boeing 737', 'B737-ABC'),
('2015-09-10', 'Airbus A350', 'A350-DEF'),
('2017-12-05', 'Boeing 777', 'B777-GHI'),
('2019-07-30', 'Bombardier CRJ900', 'CRJ900-JKL'),
('2016-11-20', 'Embraer E190', 'E190-MNO'),
('2021-05-14', 'Boeing 787', 'B787-PQR'),
('2014-08-01', 'Airbus A380', 'A380-STU'),
('2013-04-18', 'ATR 72', 'ATR72-VWX'),
('2019-10-07', 'Airbus A220', 'A220-YZ');
/******************** Fin Données du table Avion  ***************************/

/******************** Données du table Classe  ***************************/
INSERT INTO Classe (nom, prix_base) VALUES
('Économique', 150.00),
('Affaires', 600.00),
('Première', 1200.00);
/******************** Fin Données du table Classe  ***************************/

/******************** Données du table Aeroport  ***************************/
INSERT INTO Aeroport (code_iata, ville, pays) VALUES
('CDG', 'Paris', 'France'),
('JFK', 'New York', 'États-Unis'),
('LHR', 'Londres', 'Royaume-Uni'),
('DXB', 'Dubaï', 'Émirats Arabes Unis'),
('HND', 'Tokyo', 'Japon'),
('SIN', 'Singapour', 'Singapour'),
('FRA', 'Francfort', 'Allemagne'),
('AMS', 'Amsterdam', 'Pays-Bas'),
('LAX', 'Los Angeles', 'États-Unis'),
('MAD', 'Madrid', 'Espagne'),
('PEK', 'Pékin', 'Chine'),
('SYD', 'Sydney', 'Australie'),
('GRU', 'São Paulo', 'Brésil'),
('YYZ', 'Toronto', 'Canada');
/******************** Fin Données du table Aeroport  ***************************/

/******************** Données du table Avion_Classe  ***************************/
INSERT INTO Avion_Classe (id_avion, id_classe, nb_sieges) VALUES
(1, 1, 180),  -- Airbus A320, Économique
(1, 2, 24),   -- Airbus A320, Affaires
(1, 3, 8),    -- Airbus A320, Première

(2, 1, 200),  -- Boeing 737, Économique
(2, 2, 30),   -- Boeing 737, Affaires
(2, 3, 10),   -- Boeing 737, Première

(3, 1, 270),  -- Airbus A350, Économique
(3, 2, 40),   -- Airbus A350, Affaires
(3, 3, 20),   -- Airbus A350, Première

(4, 1, 300),  -- Boeing 777, Économique
(4, 2, 50),   -- Boeing 777, Affaires
(4, 3, 25),   -- Boeing 777, Première

(5, 1, 90),   -- Bombardier CRJ900, Économique
(5, 2, 16),   -- Bombardier CRJ900, Affaires
(5, 3, 0),    -- Bombardier CRJ900, Pas de Première classe

(6, 1, 100),  -- Embraer E190, Économique
(6, 2, 20),   -- Embraer E190, Affaires
(6, 3, 0),    -- Embraer E190, Pas de Première classe

(7, 1, 250),  -- Boeing 787, Économique
(7, 2, 35),   -- Boeing 787, Affaires
(7, 3, 15),   -- Boeing 787, Première

(8, 1, 500),  -- Airbus A380, Économique
(8, 2, 80),   -- Airbus A380, Affaires
(8, 3, 50),   -- Airbus A380, Première

(9, 1, 70),   -- ATR 72, Économique
(9, 2, 10),   -- ATR 72, Affaires
(9, 3, 0),    -- ATR 72, Pas de Première classe

(10, 1, 130), -- Airbus A220, Économique
(10, 2, 18),  -- Airbus A220, Affaires
(10, 3, 5);   -- Airbus A220, Première

/******************** Fin Données du table Avion_Classe  ***************************/

/******************** Données du table Vol  ***************************/
INSERT INTO Vol (date_depart, date_arrivee, delai_reservation_heures, delai_annulation_heures, aeroport_arrivee_id, aeroport_depart_id, id_avion) VALUES
-- Paris (CDG) -> New York (JFK) : ~5830 km, ~6h30 de vol
('2023-10-01 08:00:00', '2023-10-01 14:30:00', 24, 6, 2, 1, 1),

-- New York (JFK) -> Londres (LHR) : ~5560 km, ~6h10 de vol
('2023-10-02 09:00:00', '2023-10-02 15:10:00', 24, 6, 3, 2, 2),

-- Dubaï (DXB) -> Tokyo (HND) : ~8350 km, ~9h15 de vol
('2023-10-03 10:00:00', '2023-10-03 19:15:00', 24, 6, 5, 4, 3),

-- Tokyo (HND) -> Singapour (SIN) : ~5300 km, ~6h de vol
('2023-10-04 11:00:00', '2023-10-04 17:00:00', 24, 6, 6, 5, 4),

-- Francfort (FRA) -> Amsterdam (AMS) : ~360 km, ~0h45 de vol
('2023-10-05 12:00:00', '2023-10-05 12:45:00', 12, 3, 8, 7, 5),

-- Los Angeles (LAX) -> Madrid (MAD) : ~9400 km, ~10h30 de vol
('2023-10-06 13:00:00', '2023-10-06 23:30:00', 24, 6, 10, 9, 6),

-- Pékin (PEK) -> Sydney (SYD) : ~9000 km, ~10h de vol
('2023-10-07 14:00:00', '2023-10-08 00:00:00', 24, 6, 12, 11, 7),

-- São Paulo (GRU) -> Toronto (YYZ) : ~8000 km, ~9h de vol
('2023-10-08 15:00:00', '2023-10-09 00:00:00', 24, 6, 14, 13, 8),

-- Paris (CDG) -> Dubaï (DXB) : ~5500 km, ~6h10 de vol
('2023-10-09 16:00:00', '2023-10-09 22:10:00', 24, 6, 4, 1, 9),

-- New York (JFK) -> Tokyo (HND) : ~10800 km, ~12h de vol
('2023-10-10 17:00:00', '2023-10-11 05:00:00', 24, 6, 5, 2, 10),

-- Londres (LHR) -> Singapour (SIN) : ~10800 km, ~12h de vol
('2023-10-11 18:00:00', '2023-10-12 06:00:00', 24, 6, 6, 3, 1),

-- Dubaï (DXB) -> Francfort (FRA) : ~5000 km, ~5h30 de vol
('2023-10-12 19:00:00', '2023-10-13 00:30:00', 24, 6, 7, 4, 2),

-- Tokyo (HND) -> Los Angeles (LAX) : ~8800 km, ~9h45 de vol
('2023-10-13 20:00:00', '2023-10-14 05:45:00', 24, 6, 9, 5, 3),

-- Singapour (SIN) -> Sydney (SYD) : ~6300 km, ~7h de vol
('2023-10-14 21:00:00', '2023-10-15 04:00:00', 24, 6, 12, 6, 4),

-- Amsterdam (AMS) -> Madrid (MAD) : ~1450 km, ~2h de vol
('2023-10-15 22:00:00', '2023-10-16 00:00:00', 12, 3, 10, 8, 5);

/******************** Fin Données du table Vol  ***************************/