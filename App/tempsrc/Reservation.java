package dossiers.Modules;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import dossiers.Connection.ConnexionPool;
import jakarta.servlet.http.Part;

public class Reservation {
    public static String destination = "D:\\Boss\\ITU\\Session4\\Web Dynamic\\App-Temoin-Sprint\\Passeport\\"; 

    public static void sauvegarde(Part passport){
        String nomFichier = passport.getSubmittedFileName();
        File fichierFinal = new File(Reservation.destination, nomFichier);
        try (InputStream input = passport.getInputStream();
            FileOutputStream output = new FileOutputStream(fichierFinal)) {

            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }catch (Exception e) {
            System.out.println("misy erreur ato "+ e.getMessage());
        }
    }

    private int id;
    private String date_reservation;
    private String clients;
    private int id_vol;
    private int id_classe;
    private String chemin_passport;


    public static String getDestination() {
        return destination;
    }
    public static void setDestination(String destination) {
        Reservation.destination = destination;
    }
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getDate_reservation() {
        return date_reservation;
    }
    public void setDate_reservation(String date_reservation) {
        this.date_reservation = date_reservation;
    }
    public String getClients() {
        return clients;
    }
    public void setClients(String clients) {
        this.clients = clients;
    }
    public int getId_vol() {
        return id_vol;
    }
    public void setId_vol(int id_vol) {
        this.id_vol = id_vol;
    }
    public int getId_classe() {
        return id_classe;
    }
    public void setId_classe(int id_classe) {
        this.id_classe = id_classe;
    }
    public String getChemin_passport() {
        return chemin_passport;
    }
    public void setChemin_passport(String chemin_passport) {
        this.chemin_passport = chemin_passport;
    }

    public Reservation save(Vector<FilleReservation> details) throws Exception {
        try (Connection conn = ConnexionPool.connecter()) {
            conn.setAutoCommit(false); // Transaction

            // 🔍 1. Vérification doublon
            String checkSql = """
                SELECT * FROM reservation 
                WHERE date_reservation = ? 
                AND clients = ? 
                AND id_vol = ? 
                AND id_classe = ? 
                AND chemin_passport = ?
            """;
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setTimestamp(1, Timestamp.valueOf(this.getDate_reservation())); 
                checkStmt.setString(2, this.getClients());
                checkStmt.setInt(3, this.getId_vol());
                checkStmt.setInt(4, this.getId_classe());
                checkStmt.setString(5, this.getChemin_passport());

                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    Reservation existante = new Reservation();
                    existante.setId(rs.getInt("id"));
                    existante.setDate_reservation(rs.getString("date_reservation"));
                    existante.setClients(rs.getString("clients"));
                    existante.setId_vol(rs.getInt("id_vol"));
                    existante.setId_classe(rs.getInt("id_classe"));
                    existante.setChemin_passport(rs.getString("chemin_passport"));

                    System.out.println("Réservation déjà enregistrée");
                    return existante;
                }
            }

            // 📝 2. Insertion dans Reservation
            String insertSql = """
                INSERT INTO reservation (date_reservation, clients, id_vol, chemin_passport, id_classe)
                VALUES (?, ?, ?, ?, ?)
            """;
            try (PreparedStatement stmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setTimestamp(1, Timestamp.valueOf(this.getDate_reservation()));
                stmt.setString(2, this.getClients());
                stmt.setInt(3, this.getId_vol());
                stmt.setString(4, this.getChemin_passport());
                stmt.setInt(5, this.getId_classe());
                stmt.executeUpdate();

                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        this.setId(rs.getInt(1));
                    }
                }
            }

            // ➕ 3. Insertion dans Fille_Reservation si fourni
            if (details != null && !details.isEmpty()) {
                String insertFille = """
                    INSERT INTO fille_reservation (id_reservation, personnel, nb_sieges)
                    VALUES (?, ?, ?)
                """;
                try (PreparedStatement stmtFille = conn.prepareStatement(insertFille)) {
                    for (FilleReservation fr : details) {
                        stmtFille.setInt(1, this.getId());
                        stmtFille.setInt(2, fr.getPersonnel());
                        stmtFille.setInt(3, fr.getNb_sieges());
                        stmtFille.addBatch();
                    }
                    stmtFille.executeBatch();
                }
            }

            conn.commit();
            System.out.println("Réservation enregistrée avec succès");

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("Erreur lors de l'enregistrement de la réservation : " + e.getMessage());
        }

        return this;
    }

    public static Vector<FilleReservation> getFille(String bebe,String enfant,String adulte){
        Vector<FilleReservation> valiny = new Vector<>();
        int bebeInt = Integer.parseInt(bebe);
        int enfantInt = Integer.parseInt(enfant);
        int adulteInt = Integer.parseInt(adulte);

        if (bebeInt > 0) {
            FilleReservation rf = new FilleReservation();
            rf.setPersonnel(10);
            rf.setNb_sieges(bebeInt);
            valiny.add(rf);
        }
        if (enfantInt > 0) {
            FilleReservation rf = new FilleReservation();
            rf.setPersonnel(100);
            rf.setNb_sieges(enfantInt);
            valiny.add(rf);
        }
        if (adulteInt > 0) {
            FilleReservation rf = new FilleReservation();
            rf.setPersonnel(1000);
            rf.setNb_sieges(adulteInt);
            valiny.add(rf);
        }
        return valiny;
    }

}
