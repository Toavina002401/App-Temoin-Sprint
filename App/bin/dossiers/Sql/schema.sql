CREATE TABLE Utilisateur(
   id SERIAL,
   pseudo VARCHAR(255)  NOT NULL,
   mdp VARCHAR(255)  NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE Avion(
   id SERIAL,
   date_fabrication DATE NOT NULL,
   modele VARCHAR(255)  NOT NULL,
   code_avion VARCHAR(50)  NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE Classe(
   id SERIAL,
   nom VARCHAR(255)  NOT NULL,
   prix_base NUMERIC(16,2)   NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE Aeroport(
   id SERIAL,
   code_iata VARCHAR(50)  NOT NULL,
   ville VARCHAR(255)  NOT NULL,
   pays VARCHAR(255)  NOT NULL,
   PRIMARY KEY(id)
);

CREATE TABLE Vol(
   id SERIAL,
   date_depart TIMESTAMP NOT NULL,
   date_arrivee TIMESTAMP NOT NULL,
   delai_reservation_heures INTEGER,
   delai_annulation_heures INTEGER,
   aeroport_arrivee_id INTEGER NOT NULL,
   aeroport_depart_id INTEGER NOT NULL,
   id_avion INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(aeroport_arrivee_id) REFERENCES Aeroport(id) ON DELETE CASCADE,
   FOREIGN KEY(aeroport_depart_id) REFERENCES Aeroport(id) ON DELETE CASCADE,
   FOREIGN KEY(id_avion) REFERENCES Avion(id) ON DELETE CASCADE,
   CONSTRAINT unique_vol UNIQUE (
      date_depart,
      date_arrivee,
      aeroport_arrivee_id,
      aeroport_depart_id,
      id_avion,
      delai_reservation_heures,
      delai_annulation_heures
   )
);

CREATE TABLE Promotion(
   id SERIAL,
   pourcentage NUMERIC(4,2)   NOT NULL,
   id_classe INTEGER NOT NULL,
   id_vol INTEGER NOT NULL,
   nb_sieges INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(id_classe) REFERENCES Classe(id) ON DELETE CASCADE,
   FOREIGN KEY(id_vol) REFERENCES Vol(id) ON DELETE CASCADE
);

CREATE TABLE Reservation(
   id SERIAL,
   date_reservation TIMESTAMP NOT NULL,
   statut BOOLEAN NOT NULL,
   prix_final NUMERIC(16,2)   NOT NULL,
   clients VARCHAR(50)  NOT NULL,
   id_classe INTEGER NOT NULL,
   id_vol INTEGER NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(id_classe) REFERENCES Classe(id) ON DELETE CASCADE,
   FOREIGN KEY(id_vol) REFERENCES Vol(id) ON DELETE CASCADE
);

CREATE TABLE Avion_Classe(
   id_avion INTEGER,
   id_classe INTEGER,
   nb_sieges INTEGER NOT NULL,
   PRIMARY KEY(id_avion, id_classe),
   FOREIGN KEY(id_avion) REFERENCES Avion(id) ON DELETE CASCADE,
   FOREIGN KEY(id_classe) REFERENCES Classe(id) ON DELETE CASCADE
);
