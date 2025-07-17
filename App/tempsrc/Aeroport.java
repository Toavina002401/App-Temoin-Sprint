package dossiers.Modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import dossiers.Connection.ConnexionPool;

public class Aeroport {
    private int id;
    private String code_iata;
    private String ville;
    private String pays;

    public Aeroport() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode_iata() {
        return code_iata;
    }

    public void setCode_iata(String code_iata) {
        this.code_iata = code_iata;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }

    public String getPays() {
        return pays;
    }

    public void setPays(String pays) {
        this.pays = pays;
    }

    public static Vector<Aeroport> getAll() throws Exception {
        Vector<Aeroport> valiny = new Vector<>();
        
        String query = "SELECT * FROM aeroport";
        
        try (Connection conn = ConnexionPool.connecter();
            Statement stm = conn.createStatement();
            ResultSet rsl = stm.executeQuery(query)) {
            
            while (rsl.next()) {
                Aeroport aero = new Aeroport();
                aero.setId(rsl.getInt(1));
                aero.setCode_iata(rsl.getString(2));
                aero.setVille(rsl.getString(3));
                aero.setPays(rsl.getString(4));
                valiny.add(aero);
            }
        } catch (SQLException e) {
            throw e;
        }  
        return valiny;
    }

    public static Aeroport getById(int id) throws Exception {
        Aeroport aeroport = null;
        
        String query = "SELECT * FROM aeroport WHERE id = ?";
        
        try (Connection conn = ConnexionPool.connecter();
            PreparedStatement pstmt = conn.prepareStatement(query)) {
            
            pstmt.setInt(1, id);
            try (ResultSet rsl = pstmt.executeQuery()) {
                if (rsl.next()) {
                    aeroport = new Aeroport();
                    aeroport.setId(rsl.getInt(1));
                    aeroport.setCode_iata(rsl.getString(2));
                    aeroport.setVille(rsl.getString(3));
                    aeroport.setPays(rsl.getString(4));
                }
            }
        } catch (SQLException e) {
            throw e;
        }
        return aeroport;
    }

}
