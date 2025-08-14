package dossiers.Modules;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Vector;

import controlleur.annotation.AnnotationObject;
import controlleur.annotation.Range;
import controlleur.annotation.Required;
import dossiers.Connection.ConnexionPool;

@AnnotationObject
public class Vol {
    private int id;

    @Required
    private String date_depart;

    @Required
    private String date_arrivee;

    @Required
    @Range(min=1,max =48)
    private int delai_reservation_heures;

    @Required
    @Range(min=1,max =48)
    private int delai_annulation_heures;

    @Required
    private int id_aeroport_arrivee;

    @Required
    private int id_aeroport_depart;

    @Required
    private int id_avion;

    private Aeroport aeroport_arrivee;
    private Aeroport aeroport_depart;
    private Avion avion;
    private double economie;
    private double affaire;
    private double premiere;

    public Vol() {
    }

    public double getAffaire() {
        return affaire;
    }

    public void setAffaire(double affaire) {
        this.affaire = affaire;
    }

    public double getPremiere() {
        return premiere;
    }

    public void setPremiere(double premiere) {
        this.premiere = premiere;
    }

    public double getEconomie() {
        return economie;
    }

    public void setEconomie(double economie) {
        this.economie = economie;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate_depart() {
        return date_depart;
    }

    public void setDate_depart(String date_depart) {
        this.date_depart = date_depart;
    }

    public String getDate_arrivee() {
        return date_arrivee;
    }

    public void setDate_arrivee(String date_arrivee) {
        this.date_arrivee = date_arrivee;
    }

    public int getDelai_reservation_heures() {
        return delai_reservation_heures;
    }

    public void setDelai_reservation_heures(int delai_reservation_heures) {
        this.delai_reservation_heures = delai_reservation_heures;
    }

    public int getDelai_annulation_heures() {
        return delai_annulation_heures;
    }

    public void setDelai_annulation_heures(int delai_annulation_heures) {
        this.delai_annulation_heures = delai_annulation_heures;
    }

    public Aeroport getAeroport_arrivee() {
        return aeroport_arrivee;
    }

    public void setAeroport_arrivee(Aeroport aeroport_arrivee) {
        this.aeroport_arrivee = aeroport_arrivee;
    }

    public Aeroport getAeroport_depart() {
        return aeroport_depart;
    }

    public void setAeroport_depart(Aeroport aeroport_depart) {
        this.aeroport_depart = aeroport_depart;
    }

    public Avion getAvion() {
        return avion;
    }

    public void setAvion(Avion avion) {
        this.avion = avion;
    }

    public boolean valid(){
        boolean valiny = true;
        if (this.date_depart == null || this.date_depart.equals("")) {
            valiny = false;
        }
        if (this.date_arrivee == null || this.date_arrivee.equals("")) {
            valiny = false;
        }
        if (this.id_avion == 0 || this.id_avion < 0) {
            valiny = false;
        }
        if (this.id_aeroport_arrivee == 0 || this.id_aeroport_arrivee < 0) {
            valiny = false;
        }
        if (this.id_aeroport_depart == 0 || this.id_aeroport_depart < 0) {
            valiny = false;
        }
        if (this.delai_reservation_heures == 0 || (this.delai_reservation_heures < 1 && this.delai_reservation_heures > 48)) {
            valiny = false;
        }
        if (this.delai_annulation_heures == 0 || (this.delai_annulation_heures < 1 && this.delai_annulation_heures > 48)) {
            valiny = false;
        }
        return valiny;
    }

    public Vector<Vol> save() throws Exception {
        Vector<Vol> valiny = new Vector<>();
        try (
            Connection conn = ConnexionPool.connecter();
        ) {
            String departFormate = this.date_depart.replace("T", " ") + ":00";
            String arriveeFormate = this.date_arrivee.replace("T", " ") + ":00";

            // Vérification de doublon avec récupération du vol existant
            String checkSql = "SELECT * FROM Vol WHERE date_depart = ? AND date_arrivee = ? " +
                            "AND delai_reservation_heures = ? AND delai_annulation_heures = ? " +
                            "AND aeroport_arrivee_id = ? AND aeroport_depart_id = ? AND id_avion = ?";
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setTimestamp(1, Timestamp.valueOf(departFormate));
                checkStmt.setTimestamp(2, Timestamp.valueOf(arriveeFormate));
                checkStmt.setInt(3, this.delai_reservation_heures);
                checkStmt.setInt(4, this.delai_annulation_heures);
                checkStmt.setInt(5, this.id_aeroport_arrivee);
                checkStmt.setInt(6, this.id_aeroport_depart);
                checkStmt.setInt(7, this.id_avion);

                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    // Remplir l'objet Vol existant
                    Vol volExistant = new Vol();
                    volExistant.id = rs.getInt("id");
                    volExistant.date_depart = rs.getTimestamp("date_depart").toString();
                    volExistant.date_arrivee = rs.getTimestamp("date_arrivee").toString();
                    volExistant.delai_reservation_heures = rs.getInt("delai_reservation_heures");
                    volExistant.delai_annulation_heures = rs.getInt("delai_annulation_heures");
                    volExistant.id_aeroport_arrivee = rs.getInt("aeroport_arrivee_id");
                    volExistant.id_aeroport_depart = rs.getInt("aeroport_depart_id");
                    volExistant.id_avion = rs.getInt("id_avion");

                    // Charger les objets liés
                    volExistant.aeroport_arrivee = Aeroport.getById(volExistant.id_aeroport_arrivee);
                    volExistant.aeroport_depart = Aeroport.getById(volExistant.id_aeroport_depart);
                    volExistant.avion = Avion.getById(volExistant.id_avion);

                    valiny.add(volExistant);
                    return valiny; // retourner directement le vol existant
                }
            }

            // Si aucun doublon, insérer
            try (PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO Vol (date_depart, date_arrivee, delai_reservation_heures, delai_annulation_heures, aeroport_arrivee_id, aeroport_depart_id, id_avion) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS)) {

                stmt.setTimestamp(1, Timestamp.valueOf(departFormate));
                stmt.setTimestamp(2, Timestamp.valueOf(arriveeFormate));
                stmt.setInt(3, this.delai_reservation_heures);
                stmt.setInt(4, this.delai_annulation_heures);
                stmt.setInt(5, this.id_aeroport_arrivee);
                stmt.setInt(6, this.id_aeroport_depart);
                stmt.setInt(7, this.id_avion);

                stmt.executeUpdate();

                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        this.id = rs.getInt(1);
                        Prix.save(this.id);
                    }
                }
            }

            // Charger les objets liés
            this.aeroport_arrivee = Aeroport.getById(this.id_aeroport_arrivee);
            this.aeroport_depart = Aeroport.getById(this.id_aeroport_depart);
            this.avion = Avion.getById(this.id_avion);
            valiny.add(this);

        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw new Exception("Erreur lors de la sauvegarde du vol : " + e.getMessage());
        }

        return valiny;
    }


    public Vector<Vol> update(int id) throws Exception {
        Vector<Vol> valiny = new Vector<>();
        try (
            Connection conn = ConnexionPool.connecter();
            PreparedStatement stmt = conn.prepareStatement(
                "UPDATE Vol SET date_depart = ?, date_arrivee = ?, delai_reservation_heures = ?, delai_annulation_heures = ?, aeroport_arrivee_id = ?, aeroport_depart_id = ?, id_avion = ? WHERE id = ?"
            )
        ) {
            String departFormate = this.date_depart.replace("T", " ") + ":00";
            String arriveeFormate = this.date_arrivee.replace("T", " ") + ":00";
            stmt.setTimestamp(1, Timestamp.valueOf(departFormate));
            stmt.setTimestamp(2, Timestamp.valueOf(arriveeFormate));
            stmt.setInt(3, this.delai_reservation_heures);
            stmt.setInt(4, this.delai_annulation_heures);
            stmt.setInt(5, this.id_aeroport_arrivee);
            stmt.setInt(6, this.id_aeroport_depart);
            stmt.setInt(7, this.id_avion);
            stmt.setInt(8, id);

            int affectedRows = stmt.executeUpdate();
            System.out.println("Nombre de row affecter pour le modifiction est "+ affectedRows);

            // Mettre à jour les objets liés
            this.aeroport_arrivee = Aeroport.getById(this.id_aeroport_arrivee);
            this.aeroport_depart = Aeroport.getById(this.id_aeroport_depart);
            this.avion = Avion.getById(this.id_avion);
            valiny.add(this);

        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw new Exception("Erreur lors de la mise à jour du vol : " + e.getMessage());
        }
        return valiny;
    }

    public static void delete(int idVol) throws Exception {
        try (
            Connection conn = ConnexionPool.connecter();
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM Vol WHERE id = ?")
        ) {
            stmt.setInt(1, idVol);
            int affectedRows = stmt.executeUpdate();
            System.out.println("Nombre de lignes affectées : " + affectedRows + " pour le suppresion du vol id=" + idVol);


        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw new Exception("Erreur lors de la suppression du vol : " + e.getMessage());
        }
    }

    public static Vol getById(int idVol) throws Exception {
        Vol vol = null;

        String query = "SELECT * FROM Vol WHERE id = ?";

        try (
            Connection conn = ConnexionPool.connecter();
            PreparedStatement stmt = conn.prepareStatement(query)
        ) {
            stmt.setInt(1, idVol);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    vol = new Vol();
                    vol.id = rs.getInt("id");
                    vol.date_depart = rs.getString("date_depart");
                    vol.date_arrivee = rs.getString("date_arrivee");
                    vol.delai_reservation_heures = rs.getInt("delai_reservation_heures");
                    vol.delai_annulation_heures = rs.getInt("delai_annulation_heures");
                    vol.id_aeroport_arrivee = rs.getInt("aeroport_arrivee_id");
                    vol.id_aeroport_depart = rs.getInt("aeroport_depart_id");
                    vol.id_avion = rs.getInt("id_avion");

                    // Charger les objets liés
                    vol.aeroport_arrivee = Aeroport.getById(vol.id_aeroport_arrivee);
                    vol.aeroport_depart = Aeroport.getById(vol.id_aeroport_depart);
                    vol.avion = Avion.getById(vol.id_avion);
                    Vector<Prix> lesprix = Prix.getPrix(vol.getId());
                    for (int i = 0; i < lesprix.size(); i++) {
                        if (lesprix.elementAt(i).getId_classe() == 1) {
                            vol.setEconomie(lesprix.elementAt(i).getMontant());
                        }
                        if (lesprix.elementAt(i).getId_classe() == 2) {
                            vol.setAffaire(lesprix.elementAt(i).getMontant());
                        }
                        if (lesprix.elementAt(i).getId_classe() == 3) {
                            vol.setPremiere(lesprix.elementAt(i).getMontant());
                        }
                    }
                } else {
                    throw new Exception("Aucun vol trouvé avec l'ID : " + idVol);
                }
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
            throw new Exception("Erreur lors de la récupération du vol : " + e.getMessage());
        }

        return vol;
    }

    public static Vector<Vol> getAll() throws Exception {
        Vector<Vol> valiny = new Vector<>();
        
        String query = """
            SELECT v.id, v.date_depart, v.date_arrivee, v.delai_reservation_heures, v.delai_annulation_heures,
                   ad.id AS aeroport_depart_id, ad.code_iata AS aeroport_depart_code, ad.ville AS aeroport_depart_ville, ad.pays AS aeroport_depart_pays,
                   aa.id AS aeroport_arrivee_id, aa.code_iata AS aeroport_arrivee_code, aa.ville AS aeroport_arrivee_ville, aa.pays AS aeroport_arrivee_pays,
                   av.id AS avion_id, av.date_fabrication, av.modele, av.code_avion
            FROM Vol v
            JOIN Aeroport ad ON v.aeroport_depart_id = ad.id
            JOIN Aeroport aa ON v.aeroport_arrivee_id = aa.id
            JOIN Avion av ON v.id_avion = av.id
        """;

        try (Connection conn = ConnexionPool.connecter();
            Statement stm = conn.createStatement();
            ResultSet rsl = stm.executeQuery(query)) {

            while (rsl.next()) {
                Vol vol = new Vol();
                vol.setId(rsl.getInt("id"));
                vol.setDate_depart(rsl.getString("date_depart"));
                vol.setDate_arrivee(rsl.getString("date_arrivee"));
                vol.setDelai_reservation_heures(rsl.getInt("delai_reservation_heures"));
                vol.setDelai_annulation_heures(rsl.getInt("delai_annulation_heures"));

                Aeroport aeroportDepart = new Aeroport();
                aeroportDepart.setId(rsl.getInt("aeroport_depart_id"));
                aeroportDepart.setCode_iata(rsl.getString("aeroport_depart_code"));
                aeroportDepart.setVille(rsl.getString("aeroport_depart_ville"));
                aeroportDepart.setPays(rsl.getString("aeroport_depart_pays"));
                vol.setAeroport_depart(aeroportDepart);

                Aeroport aeroportArrivee = new Aeroport();
                aeroportArrivee.setId(rsl.getInt("aeroport_arrivee_id"));
                aeroportArrivee.setCode_iata(rsl.getString("aeroport_arrivee_code"));
                aeroportArrivee.setVille(rsl.getString("aeroport_arrivee_ville"));
                aeroportArrivee.setPays(rsl.getString("aeroport_arrivee_pays"));
                vol.setAeroport_arrivee(aeroportArrivee);

                Avion avion = new Avion();
                avion.setId(rsl.getInt("avion_id"));
                avion.setDate_fabrication(rsl.getString("date_fabrication"));
                avion.setModele(rsl.getString("modele"));
                avion.setCode_avion(rsl.getString("code_avion"));
                vol.setAvion(avion);

                valiny.add(vol);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return valiny;
    }
    
    public Vector<Vol> rechercherVols(Integer aeroportDepart, Integer aeroportArrive, Integer avion,String dateDepart, String dateArrivee, Integer classe) throws Exception {
        Vector<Vol> vols = new Vector<>();

        StringBuilder sql = new StringBuilder(
            "SELECT v.id, v.date_depart, v.date_arrivee, v.delai_reservation_heures, v.delai_annulation_heures, " +
            "       ad.id AS aeroport_depart_id, ad.code_iata AS aeroport_depart_code, ad.ville AS aeroport_depart_ville, ad.pays AS aeroport_depart_pays, " +
            "       aa.id AS aeroport_arrivee_id, aa.code_iata AS aeroport_arrivee_code, aa.ville AS aeroport_arrivee_ville, aa.pays AS aeroport_arrivee_pays, " +
            "       av.id AS avion_id, av.date_fabrication, av.modele, av.code_avion " +
            "FROM Vol v " +
            "JOIN Aeroport ad ON v.aeroport_depart_id = ad.id " +
            "JOIN Aeroport aa ON v.aeroport_arrivee_id = aa.id " +
            "JOIN Avion av ON v.id_avion = av.id " +
            (classe != null ? "JOIN Avion_Classe ac ON av.id = ac.id_avion " : "") +
            "WHERE 1=1"
        );

        if (aeroportDepart != null) sql.append(" AND v.aeroport_depart_id = ?");
        if (aeroportArrive != null) sql.append(" AND v.aeroport_arrivee_id = ?");
        if (avion != null) sql.append(" AND v.id_avion = ?");
        if (dateDepart != null && !dateDepart.isEmpty()) sql.append(" AND DATE(v.date_depart) = ?");
        if (dateArrivee != null && !dateArrivee.isEmpty()) sql.append(" AND DATE(v.date_arrivee) = ?");
        if (classe != null) sql.append(" AND ac.id_classe = ?");

        try (
            Connection conn = ConnexionPool.connecter();
            PreparedStatement stmt = conn.prepareStatement(sql.toString())
        ) {
            int paramIndex = 1;
            if (aeroportDepart != null) stmt.setInt(paramIndex++, aeroportDepart);
            if (aeroportArrive != null) stmt.setInt(paramIndex++, aeroportArrive);
            if (avion != null) stmt.setInt(paramIndex++, avion);
            if (dateDepart != null && !dateDepart.isEmpty()) stmt.setDate(paramIndex++, Date.valueOf(dateDepart));
            if (dateArrivee != null && !dateArrivee.isEmpty()) stmt.setDate(paramIndex++, Date.valueOf(dateArrivee));
            if (classe != null) stmt.setInt(paramIndex++, classe);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Vol vol = new Vol();
                    vol.setId(rs.getInt("id"));
                    vol.setDate_depart(rs.getString("date_depart"));
                    vol.setDate_arrivee(rs.getString("date_arrivee"));
                    vol.setDelai_reservation_heures(rs.getInt("delai_reservation_heures"));
                    vol.setDelai_annulation_heures(rs.getInt("delai_annulation_heures"));

                    Aeroport depart = new Aeroport();
                    depart.setId(rs.getInt("aeroport_depart_id"));
                    depart.setCode_iata(rs.getString("aeroport_depart_code"));
                    depart.setVille(rs.getString("aeroport_depart_ville"));
                    depart.setPays(rs.getString("aeroport_depart_pays"));
                    vol.setAeroport_depart(depart);

                    Aeroport arrivee = new Aeroport();
                    arrivee.setId(rs.getInt("aeroport_arrivee_id"));
                    arrivee.setCode_iata(rs.getString("aeroport_arrivee_code"));
                    arrivee.setVille(rs.getString("aeroport_arrivee_ville"));
                    arrivee.setPays(rs.getString("aeroport_arrivee_pays"));
                    vol.setAeroport_arrivee(arrivee);

                    Avion avionObj = new Avion();
                    avionObj.setId(rs.getInt("avion_id"));
                    avionObj.setDate_fabrication(rs.getString("date_fabrication"));
                    avionObj.setModele(rs.getString("modele"));
                    avionObj.setCode_avion(rs.getString("code_avion"));
                    vol.setAvion(avionObj);

                    vols.add(vol);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Erreur lors de la récupération des vols.");
        }

        return vols;
    }

    public static Vector<Vol> getVolDispo() throws Exception {
        Vector<Vol> valiny = new Vector<>();
        
        String query = """
            SELECT v.id, v.date_depart, v.date_arrivee, v.delai_reservation_heures, v.delai_annulation_heures,
                ad.id AS aeroport_depart_id, ad.code_iata AS aeroport_depart_code, ad.ville AS aeroport_depart_ville, ad.pays AS aeroport_depart_pays,
                aa.id AS aeroport_arrivee_id, aa.code_iata AS aeroport_arrivee_code, aa.ville AS aeroport_arrivee_ville, aa.pays AS aeroport_arrivee_pays,
                av.id AS avion_id, av.date_fabrication, av.modele, av.code_avion
            FROM Vol v
            JOIN Aeroport ad ON v.aeroport_depart_id = ad.id
            JOIN Aeroport aa ON v.aeroport_arrivee_id = aa.id
            JOIN Avion av ON v.id_avion = av.id
            WHERE v.date_depart > CURRENT_TIMESTAMP
            ORDER BY v.date_depart ASC
        """;

        try (Connection conn = ConnexionPool.connecter();
            Statement stm = conn.createStatement();
            ResultSet rsl = stm.executeQuery(query)) {

            while (rsl.next()) {
                Vol vol = new Vol();
                vol.setId(rsl.getInt("id"));
                vol.setDate_depart(rsl.getString("date_depart"));
                vol.setDate_arrivee(rsl.getString("date_arrivee"));
                vol.setDelai_reservation_heures(rsl.getInt("delai_reservation_heures"));
                vol.setDelai_annulation_heures(rsl.getInt("delai_annulation_heures"));

                Aeroport aeroportDepart = new Aeroport();
                aeroportDepart.setId(rsl.getInt("aeroport_depart_id"));
                aeroportDepart.setCode_iata(rsl.getString("aeroport_depart_code"));
                aeroportDepart.setVille(rsl.getString("aeroport_depart_ville"));
                aeroportDepart.setPays(rsl.getString("aeroport_depart_pays"));
                vol.setAeroport_depart(aeroportDepart);

                Aeroport aeroportArrivee = new Aeroport();
                aeroportArrivee.setId(rsl.getInt("aeroport_arrivee_id"));
                aeroportArrivee.setCode_iata(rsl.getString("aeroport_arrivee_code"));
                aeroportArrivee.setVille(rsl.getString("aeroport_arrivee_ville"));
                aeroportArrivee.setPays(rsl.getString("aeroport_arrivee_pays"));
                vol.setAeroport_arrivee(aeroportArrivee);

                Avion avion = new Avion();
                avion.setId(rsl.getInt("avion_id"));
                avion.setDate_fabrication(rsl.getString("date_fabrication"));
                avion.setModele(rsl.getString("modele"));
                avion.setCode_avion(rsl.getString("code_avion"));
                vol.setAvion(avion);

                Vector<Prix> lesprix = Prix.getPrix(vol.getId());
                for (int i = 0; i < lesprix.size(); i++) {
                    if (lesprix.elementAt(i).getId_classe() == 1) {
                        vol.setEconomie(lesprix.elementAt(i).getMontant());
                    }
                    if (lesprix.elementAt(i).getId_classe() == 2) {
                        vol.setAffaire(lesprix.elementAt(i).getMontant());
                    }
                    if (lesprix.elementAt(i).getId_classe() == 3) {
                        vol.setPremiere(lesprix.elementAt(i).getMontant());
                    }
                }

                valiny.add(vol);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return valiny;
    }


    public static Vector<Vol> getVolDispoReservation() throws Exception {
        Vector<Vol> valiny = new Vector<>();
        
        String query = """
            SELECT v.id, v.date_depart, v.date_arrivee, v.delai_reservation_heures, v.delai_annulation_heures,
                ad.id AS aeroport_depart_id, ad.code_iata AS aeroport_depart_code, ad.ville AS aeroport_depart_ville, ad.pays AS aeroport_depart_pays,
                aa.id AS aeroport_arrivee_id, aa.code_iata AS aeroport_arrivee_code, aa.ville AS aeroport_arrivee_ville, aa.pays AS aeroport_arrivee_pays,
                av.id AS avion_id, av.date_fabrication, av.modele, av.code_avion
            FROM Vol v
            JOIN Aeroport ad ON v.aeroport_depart_id = ad.id
            JOIN Aeroport aa ON v.aeroport_arrivee_id = aa.id
            JOIN Avion av ON v.id_avion = av.id
            WHERE CURRENT_TIMESTAMP BETWEEN 
                (v.date_depart - (v.delai_reservation_heures * INTERVAL '1 hour'))
                AND v.date_depart
            ORDER BY v.date_depart ASC
        """;


        try (Connection conn = ConnexionPool.connecter();
            Statement stm = conn.createStatement();
            ResultSet rsl = stm.executeQuery(query)) {

            while (rsl.next()) {
                Vol vol = new Vol();
                vol.setId(rsl.getInt("id"));
                vol.setDate_depart(rsl.getString("date_depart"));
                vol.setDate_arrivee(rsl.getString("date_arrivee"));
                vol.setDelai_reservation_heures(rsl.getInt("delai_reservation_heures"));
                vol.setDelai_annulation_heures(rsl.getInt("delai_annulation_heures"));

                Aeroport aeroportDepart = new Aeroport();
                aeroportDepart.setId(rsl.getInt("aeroport_depart_id"));
                aeroportDepart.setCode_iata(rsl.getString("aeroport_depart_code"));
                aeroportDepart.setVille(rsl.getString("aeroport_depart_ville"));
                aeroportDepart.setPays(rsl.getString("aeroport_depart_pays"));
                vol.setAeroport_depart(aeroportDepart);

                Aeroport aeroportArrivee = new Aeroport();
                aeroportArrivee.setId(rsl.getInt("aeroport_arrivee_id"));
                aeroportArrivee.setCode_iata(rsl.getString("aeroport_arrivee_code"));
                aeroportArrivee.setVille(rsl.getString("aeroport_arrivee_ville"));
                aeroportArrivee.setPays(rsl.getString("aeroport_arrivee_pays"));
                vol.setAeroport_arrivee(aeroportArrivee);

                Avion avion = new Avion();
                avion.setId(rsl.getInt("avion_id"));
                avion.setDate_fabrication(rsl.getString("date_fabrication"));
                avion.setModele(rsl.getString("modele"));
                avion.setCode_avion(rsl.getString("code_avion"));
                vol.setAvion(avion);

                Vector<Prix> lesprix = Prix.getPrix(vol.getId());
                for (int i = 0; i < lesprix.size(); i++) {
                    if (lesprix.elementAt(i).getId_classe() == 1) {
                        vol.setEconomie(lesprix.elementAt(i).getMontant());
                    }
                    if (lesprix.elementAt(i).getId_classe() == 2) {
                        vol.setAffaire(lesprix.elementAt(i).getMontant());
                    }
                    if (lesprix.elementAt(i).getId_classe() == 3) {
                        vol.setPremiere(lesprix.elementAt(i).getMontant());
                    }
                }

                valiny.add(vol);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return valiny;
    }

    public int getId_aeroport_arrivee() {
        return id_aeroport_arrivee;
    }

    public void setId_aeroport_arrivee(int id_aeroport_arrivee) {
        this.id_aeroport_arrivee = id_aeroport_arrivee;
    }

    public int getId_aeroport_depart() {
        return id_aeroport_depart;
    }

    public void setId_aeroport_depart(int id_aeroport_depart) {
        this.id_aeroport_depart = id_aeroport_depart;
    }

    public int getId_avion() {
        return id_avion;
    }

    public void setId_avion(int id_avion) {
        this.id_avion = id_avion;
    }


}
