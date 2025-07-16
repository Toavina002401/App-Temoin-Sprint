package dossiers.Connection;

import java.sql.Connection;

import org.apache.commons.dbcp2.BasicDataSource;

public class ConnexionPool {
    private static BasicDataSource dataSource;
    private static String url = "jdbc:postgresql://localhost:5432/AppTemoin"; 
    private static String user = "postgres";
    private static String password = "Belouh";

    static {
        try {
            dataSource = new BasicDataSource();
            dataSource.setUrl(url);
            dataSource.setUsername(user);
            dataSource.setPassword(password);
            dataSource.setDriverClassName("org.postgresql.Driver");

            dataSource.setMinIdle(2);           // Nombre minimum de connexions inactives
            dataSource.setMaxIdle(5);           // Nombre maximum de connexions inactives
            dataSource.setMaxTotal(10);         // Nombre maximum de connexions dans le pool
            dataSource.setMaxWaitMillis(30000); // Temps maximum d'attente pour une connexion (en ms)
        } catch (Exception e) {
            throw new RuntimeException("Erreur lors de l'initialisation du pool de connexions : " + e.getMessage(), e);
        }
    }

    public static Connection connecter() throws Exception {
        return dataSource.getConnection();
    }

    public static void deconnecter() {
        try {
            if (dataSource != null) {
                dataSource.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
