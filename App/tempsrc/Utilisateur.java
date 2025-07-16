package dossiers.Modules;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import dossiers.Connection.ConnexionPool;

public class Utilisateur {
    private int id;
    private String pseudo;
    private String mdp;

    public Utilisateur() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPseudo() {
        return pseudo;
    }

    public void setPseudo(String pseudo) {
        this.pseudo = pseudo;
    }

    public String getMdp() {
        return mdp;
    }

    public void setMdp(String mdp) {
        this.mdp = mdp;
    }

    public static int authentifier(String pseudo, String mdp) throws Exception {
        String query = "SELECT id FROM Utilisateur WHERE pseudo = ? AND mdp = ?";
        String checkPseudo = "SELECT id FROM Utilisateur WHERE pseudo = ?";

        try (Connection conn = ConnexionPool.connecter();
             PreparedStatement stmt = conn.prepareStatement(query);
             PreparedStatement stmtPseudo = conn.prepareStatement(checkPseudo)) {
            stmtPseudo.setString(1, pseudo);
            try (ResultSet rsPseudo = stmtPseudo.executeQuery()) {
                if (!rsPseudo.next()) {
                    return -2; 
                }
            }

            stmt.setString(1, pseudo);
            stmt.setString(2, mdp);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id"); 
                } else {
                    return -1; 
                }
            }
        } catch (Exception e) {
            throw e;
        }
    }
}
