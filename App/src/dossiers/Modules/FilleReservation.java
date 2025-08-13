package dossiers.Modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import dossiers.Connection.ConnexionPool;

public class FilleReservation {
    private int id;             // ID de la ligne fille
    private int id_reservation; // Référence vers la réservation parente
    private int personnel;      // ID du personnel (ou passager)
    private int nb_sieges;      // Nombre de sièges réservés

    // --- Constructeurs ---
    public FilleReservation() {}

    public FilleReservation(int id_reservation, int personnel, int nb_sieges) {
        this.id_reservation = id_reservation;
        this.personnel = personnel;
        this.nb_sieges = nb_sieges;
    }

    // --- Getters & Setters ---
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getId_reservation() {
        return id_reservation;
    }
    public void setId_reservation(int id_reservation) {
        this.id_reservation = id_reservation;
    }

    public int getPersonnel() {
        return personnel;
    }
    public void setPersonnel(int personnel) {
        this.personnel = personnel;
    }

    public int getNb_sieges() {
        return nb_sieges;
    }
    public void setNb_sieges(int nb_sieges) {
        this.nb_sieges = nb_sieges;
    }


    public static Vector<FilleReservation> getByReservation(int idReservation) throws Exception {
        Vector<FilleReservation> liste = new Vector<>();

        String query = "SELECT * FROM Fille_Reservation WHERE id_reservation = ?";

        try (
            Connection conn = ConnexionPool.connecter();
            PreparedStatement stmt = conn.prepareStatement(query)
        ) {
            stmt.setInt(1, idReservation);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    FilleReservation fr = new FilleReservation();
                    fr.setId(rs.getInt("id"));
                    fr.setId_reservation(rs.getInt("id_reservation"));
                    fr.setPersonnel(rs.getInt("personnel"));
                    fr.setNb_sieges(rs.getInt("nb_sieges"));
                    liste.add(fr);
                }
            }
        } catch (Exception e) {
            throw new Exception("Erreur lors de la récupération des filles de réservation : " + e.getMessage());
        }

        return liste;
    }
}

