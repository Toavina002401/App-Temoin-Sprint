package dossiers.Modules;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import controlleur.annotation.AnnotationObject;
import controlleur.annotation.Required;
import dossiers.Connection.ConnexionPool;

@AnnotationObject
public class Vol {
    private int id;
    @Required
    private String date_depart;
    @Required
    private String date_arrivee;
    private int delai_reservation_heures;
    private int delai_annulation_heures;
    @Required
    private Aeroport aeroport_arrivee;
    @Required
    private Aeroport aeroport_depart;
    @Required
    private Avion avion;

    
    public Vol() {
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


}
