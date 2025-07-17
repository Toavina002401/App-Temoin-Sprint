package dossiers.Modules;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import dossiers.Connection.ConnexionPool;

public class Classe {
    private int id;
    private String nom;
    private double prix_base;

    public Classe() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public double getPrix_base() {
        return prix_base;
    }
    
    public void setPrix_base(double prix_base) {
        this.prix_base = prix_base;
    }

    public static Vector<Classe> getAll() throws Exception {
        Vector<Classe> valiny = new Vector<>();
        
        String query = "SELECT * FROM classe";
        
        try (Connection conn = ConnexionPool.connecter();
            Statement stm = conn.createStatement();
            ResultSet rsl = stm.executeQuery(query)) {
            
            while (rsl.next()) {
                Classe classe = new Classe();
                classe.setId(rsl.getInt(1));
                classe.setNom(rsl.getString(2));
                classe.setPrix_base(rsl.getDouble(3));
                valiny.add(classe);
            }
        } catch (SQLException e) {
            throw e;
        }  
        return valiny;
    }
    
}
