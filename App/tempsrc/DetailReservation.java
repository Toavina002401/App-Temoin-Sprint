package dossiers.Modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import dossiers.Connection.ConnexionPool;

public class DetailReservation {
    private String date_reservation;
    private String clients;
    private Vol vol;
    private String chemin_passport;
    private int id_classe;
    private Vector<FilleReservation> filleReservation;
    private Vector<Promotion> sespromotion;
    private double prixFinaleClasse;
    private static final Map<Integer, Integer> configPersonnel = new HashMap<>() {{
        put(10, 10);
        put(100, 40);
        put(1000, 100);
    }};
    private Map<Integer, Double> prixFinalPersonnel = new HashMap<>();
    private double prixTotal;



    public Map<Integer, Double> getPrixFinalPersonnel() {
        return prixFinalPersonnel;
    }

    public void setPrixFinalPersonnel(Map<Integer, Double> prixFinalPersonnel) {
        this.prixFinalPersonnel = prixFinalPersonnel;
    }

    public Map<Integer, Integer> getConfigPersonnel() {
        return configPersonnel;
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

    public Vol getVol() {
        return vol;
    }

    public void setVol(Vol vol) {
        this.vol = vol;
    }

    public String getChemin_passport() {
        return chemin_passport;
    }

    public void setChemin_passport(String chemin_passport) {
        this.chemin_passport = chemin_passport;
    }

    public Vector<FilleReservation> getFilleReservation() {
        return filleReservation;
    }

    public void setFilleReservation(Vector<FilleReservation> filleReservation) {
        this.filleReservation = filleReservation;
    }

    public Vector<Promotion> getSespromotion() {
        return sespromotion;
    }

    public void setSespromotion(Vector<Promotion> sespromotion) {
        this.sespromotion = sespromotion;
    }

    public double getPrixFinaleClasse() {
        return prixFinaleClasse;
    }

    public void setPrixFinaleClasse(double prixFinaleClasse) {
        this.prixFinaleClasse = prixFinaleClasse;
    }

    public double getPrixTotal() {
        return prixTotal;
    }

    public void setPrixTotal(double prixTotal) {
        this.prixTotal = prixTotal;
    }

    public int getId_classe() {
        return id_classe;
    }

    public void setId_classe(int id_classe) {
        this.id_classe = id_classe;
    }


    public static DetailReservation getDetail(int idReservation) throws Exception {
        DetailReservation valiny = new DetailReservation();

        try (Connection con = ConnexionPool.connecter()) {
            String sqlReservation = """
                SELECT r.date_reservation, r.clients, r.chemin_passport, r.id_vol, r.id_classe
                FROM Reservation r
                WHERE r.id = ?
            """;
            try (PreparedStatement ps = con.prepareStatement(sqlReservation)) {
                ps.setInt(1, idReservation);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    valiny.setDate_reservation(rs.getTimestamp("date_reservation").toString());
                    valiny.setClients(rs.getString("clients"));
                    valiny.setChemin_passport(rs.getString("chemin_passport"));
                    int idClasse = rs.getInt("id_classe");
                    valiny.setId_classe(idClasse);

                    // 2️⃣ Récupération du vol
                    int idVol = rs.getInt("id_vol");
                    valiny.setVol(Vol.getById(idVol));

                    // 3️⃣ Filles réservations
                    valiny.setFilleReservation(FilleReservation.getByReservation(idReservation));

                    // 4️⃣ Promotions du vol
                    valiny.setSespromotion(Promotion.getAllByIdVol(idVol));

                    // 5️⃣ Prix final classe
                    double prixClasse = 0;
                    String sqlPrix = "SELECT montant FROM Prix WHERE id_vol = ? AND id_classe = ?";

                    try (PreparedStatement psPrix = con.prepareStatement(sqlPrix)) {
                        psPrix.setInt(1, idVol);
                        psPrix.setInt(2, idClasse);

                        try (ResultSet rsPrix = psPrix.executeQuery()) {
                            if (rsPrix.next()) {
                                prixClasse = rsPrix.getDouble("montant");
                            }
                        }
                    }

                    // 6️⃣ Application des promotions
                    for (Promotion promo : valiny.getSespromotion()) {
                        int classePromo = promo.getIdClasse();
                        double reduction = promo.getPourcentage();

                        if (classePromo == idClasse) {
                            prixClasse *= (1 - reduction / 100);
                        } 
                    }
                    valiny.setPrixFinaleClasse(prixClasse);

                    // 7️⃣ Calcul du prix pour chaque personnel selon nb sièges réservés
                    Map<Integer, Double> prixPerso = new HashMap<>();
                    double total = 0;
                    for (FilleReservation fr : valiny.getFilleReservation()) {
                        int personnel = fr.getPersonnel(); 
                        int nb = fr.getNb_sieges();
                        double val = DetailReservation.configPersonnel.get(personnel);
                        double somme = ((valiny.getPrixFinaleClasse() * val) / 100) * nb;
                        total += somme;
                        prixPerso.put(personnel, somme);

                    }
                    valiny.setPrixFinalPersonnel(prixPerso);
                    valiny.setPrixTotal(total);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return valiny;
    }



}
