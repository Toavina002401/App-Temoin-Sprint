package dossiers.Modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import dossiers.Connection.ConnexionPool;

public class Avion {
    private int id;
    private String date_fabrication;
    private String modele;
    private String code_avion;

    
    public Avion() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate_fabrication() {
        return date_fabrication;
    }

    public void setDate_fabrication(String date_fabrication) {
        this.date_fabrication = date_fabrication;
    }

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public String getCode_avion() {
        return code_avion;
    }

    public void setCode_avion(String code_avion) {
        this.code_avion = code_avion;
    }

    public static Vector<Avion> getAll() throws Exception {
        Vector<Avion> valiny = new Vector<>();
        
        String query = "SELECT * FROM avion";
        
        try (Connection conn = ConnexionPool.connecter();
            Statement stm = conn.createStatement();
            ResultSet rsl = stm.executeQuery(query)) {
            
            while (rsl.next()) {
                Avion avion = new Avion();
                avion.setId(rsl.getInt(1));
                avion.setDate_fabrication(rsl.getString(2));
                avion.setModele(rsl.getString(3));
                avion.setCode_avion(rsl.getString(4));
                valiny.add(avion);
            }
        } catch (SQLException e) {
            throw e;
        }  
        return valiny;
    }

    public static Avion getById(int id) throws Exception {
        Avion avion = null;
        
        String query = "SELECT * FROM avion WHERE id = ?";
        
        try (Connection conn = ConnexionPool.connecter();
            PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            try (ResultSet rsl = pstmt.executeQuery()) {
                if (rsl.next()) {
                    avion = new Avion();
                    avion.setId(rsl.getInt(1));
                    avion.setDate_fabrication(rsl.getString(2));
                    avion.setModele(rsl.getString(3));
                    avion.setCode_avion(rsl.getString(4));
                }
            }
        } catch (SQLException e) {
            throw e;
        }
        return avion;
    }

    
}
