package dossiers.Modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Vector;

import dossiers.Connection.ConnexionPool;

public class Promotion {
    private int id;
    private double pourcentage;
    private int idClasse;
    private int idVol;
    private int nbSieges;


    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public double getPourcentage() {
        return pourcentage;
    }
    public void setPourcentage(double pourcentage) {
        this.pourcentage = pourcentage;
    }
    public int getIdClasse() {
        return idClasse;
    }
    public void setIdClasse(int idClasse) {
        this.idClasse = idClasse;
    }
    public int getIdVol() {
        return idVol;
    }
    public void setIdVol(int idVol) {
        this.idVol = idVol;
    }
    public int getNbSieges() {
        return nbSieges;
    }
    public void setNbSieges(int nbSieges) {
        this.nbSieges = nbSieges;
    }

    public Promotion(){}

    public Promotion save() throws Exception {
        try (Connection conn = ConnexionPool.connecter()) {

            // Vérification doublon
            String checkSql = "SELECT * FROM promotion WHERE pourcentage = ? AND id_classe = ? AND id_vol = ? AND nb_sieges = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setDouble(1, this.getPourcentage());
                checkStmt.setInt(2, this.getIdClasse());
                checkStmt.setInt(3, this.getIdVol());
                checkStmt.setInt(4, this.getNbSieges());

                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    // Promotion déjà existante → on la retourne
                    Promotion promoExistante = new Promotion();
                    promoExistante.setId(rs.getInt("id"));
                    promoExistante.setPourcentage(rs.getDouble("pourcentage"));
                    promoExistante.setIdClasse(rs.getInt("id_classe"));
                    promoExistante.setIdVol(rs.getInt("id_vol"));
                    promoExistante.setNbSieges(rs.getInt("nb_sieges"));

                    System.out.println("Promotion deja enregistrée");
                    return promoExistante;
                }
            }

            // Aucun doublon → insertion
            String insertSql = "INSERT INTO promotion (pourcentage, id_classe, id_vol, nb_sieges) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setDouble(1, this.getPourcentage());
                stmt.setInt(2, this.getIdClasse());
                stmt.setInt(3, this.getIdVol());
                stmt.setInt(4, this.getNbSieges());
                stmt.executeUpdate();

                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        this.setId(rs.getInt(1));
                    }
                }
            }

            System.out.println("Promotion enregistrée avec succès");

        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw new Exception("Erreur lors de la création d'une promotion : " + e.getMessage());
        }
        return this;
    }

    public static Vector<Promotion> getAllByIdVol(int idVol) throws Exception {
        Vector<Promotion> valiny = new Vector<>();
        try (Connection conn = ConnexionPool.connecter()) {

            String sql = "SELECT * FROM promotion WHERE id_vol = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, idVol);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
                    Promotion promo = new Promotion();
                    promo.setId(rs.getInt("id"));
                    promo.setPourcentage(rs.getDouble("pourcentage"));
                    promo.setIdClasse(rs.getInt("id_classe"));
                    promo.setIdVol(rs.getInt("id_vol"));
                    promo.setNbSieges(rs.getInt("nb_sieges"));
                    valiny.add(promo);
                }
            }

        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw new Exception("Erreur lors de la récupération des promotions du vol " + idVol + " : " + e.getMessage());
        }
        return valiny;
    }

    public static Vector<Vector<Promotion>> getPromo(Vector<Vol> listeVol)throws Exception{
        Vector<Vector<Promotion>> valiny = new Vector<>();
        for (int i = 0; i < listeVol.size(); i++) {
            Vector<Promotion> temp = new Vector<>();
            temp = Promotion.getAllByIdVol(listeVol.elementAt(i).getId());
            valiny.add(temp);
        }
        return valiny;
    }

}
