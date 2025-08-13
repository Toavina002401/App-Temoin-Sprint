package dossiers.Modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Random;
import java.util.Vector;

import dossiers.Connection.ConnexionPool;

public class Prix {
    private int id;
    private int id_vol;
    private int id_classe;
    private double montant;

    double[] tabAffaire = {
        120000, 145000, 138000, 160000, 125000, 150000, 155000, 140000, 165000, 130000,
        148000, 142000, 135000, 158000, 127000, 149000, 153000, 136000, 162000, 141000,
        157000, 146000, 139000, 151000, 133000, 159000, 144000, 137000, 150000, 128000,
        163000, 147000, 132000, 154000, 134000, 160000, 138000, 152000, 129000, 161000,
        143000, 156000, 131000, 155000, 140000, 158000, 135000, 150000, 136000, 162000
    };

    double[] tabEconomie = {
        50000, 55000, 52000, 58000, 51000, 60000, 53000, 57000, 56000, 54000,
        59000, 52500, 53500, 56500, 51500, 59500, 50500, 57500, 54500, 55500,
        56500, 53500, 52000, 58000, 51000, 59000, 50000, 57000, 55500, 54000,
        58500, 52500, 53000, 56500, 51500, 59500, 50500, 57500, 54500, 55500,
        56000, 53000, 52000, 58000, 51000, 59000, 50000, 57000, 55500, 54000
    };

    double[] tabPremier = {
        200000, 250000, 220000, 240000, 210000, 260000, 230000, 245000, 225000, 235000,
        255000, 215000, 225000, 250000, 205000, 265000, 200000, 240000, 235000, 255000,
        245000, 220000, 210000, 260000, 215000, 250000, 205000, 245000, 230000, 225000,
        255000, 210000, 220000, 250000, 215000, 265000, 200000, 240000, 235000, 255000,
        245000, 220000, 210000, 260000, 215000, 250000, 205000, 245000, 230000, 225000
    };


    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
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
    public double getMontant() {
        return montant;
    }
    public void setMontant(double montant) {
        this.montant = montant;
    }

    public Vector<Prix> genererPrix(int idVol) {
        Vector<Prix> prixVol = new Vector<>();
        Random rand = new Random();

        // 1. Prix Économique
        Prix eco = new Prix();
        eco.setId_vol(idVol);
        eco.setId_classe(2); // 2 = Économique
        eco.setMontant(tabEconomie[rand.nextInt(tabEconomie.length)]);
        prixVol.add(eco);

        // 2. Prix Affaire
        Prix affaire = new Prix();
        affaire.setId_vol(idVol);
        affaire.setId_classe(1); // 1 = Affaire
        affaire.setMontant(tabAffaire[rand.nextInt(tabAffaire.length)]);
        prixVol.add(affaire);

        // 3. Prix Première
        Prix premier = new Prix();
        premier.setId_vol(idVol);
        premier.setId_classe(3); // 3 = Première
        premier.setMontant(tabPremier[rand.nextInt(tabPremier.length)]);
        prixVol.add(premier);

        return prixVol;
    }

    public static void save(int idVol) {
        Prix p = new Prix();
        Vector<Prix> prixVol = p.genererPrix(idVol);

        try (Connection conn = ConnexionPool.connecter()) {
            conn.setAutoCommit(false); // Transaction

            String checkSql = "SELECT * FROM prix WHERE id_vol = ? AND id_classe = ?";
            String insertSql = "INSERT INTO prix (id_vol, id_classe, montant) VALUES (?, ?, ?)";

            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql);
                PreparedStatement insertStmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {

                for (Prix prix : prixVol) {
                    // Vérification doublon
                    checkStmt.setInt(1, prix.getId_vol());
                    checkStmt.setInt(2, prix.getId_classe());

                    ResultSet rs = checkStmt.executeQuery();
                    if (rs.next()) {
                        System.out.println("Prix déjà existant pour le vol " + idVol + " et classe " + prix.getId_classe());
                        continue; // passer au suivant
                    }

                    // Insertion
                    insertStmt.setInt(1, prix.getId_vol());
                    insertStmt.setInt(2, prix.getId_classe());
                    insertStmt.setDouble(3, prix.getMontant());
                    insertStmt.executeUpdate();

                    try (ResultSet keys = insertStmt.getGeneratedKeys()) {
                        if (keys.next()) {
                            prix.setId(keys.getInt(1));
                        }
                    }

                    System.out.println("Prix inséré : vol=" + idVol + ", classe=" + prix.getId_classe() + ", montant=" + prix.getMontant());
                }

                conn.commit();
            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
