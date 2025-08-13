package dossiers.Modules;

public class FilleReservation {
    private int id;             // ID de la ligne fille
    private int id_reservation; // Référence vers la réservation parente
    private int personnel;      // ID du personnel (ou passager)
    private int nb_sieges;      // Nombre de sièges réservés

    // --- Constructeurs ---
    public FilleReservation() {}

    public FilleReservation(int id_reservation, int personnel, int nb_sieges) {
        this.id_reservation = id_reservation;
        this.personnel = personnel;
        this.nb_sieges = nb_sieges;
    }

    // --- Getters & Setters ---
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getId_reservation() {
        return id_reservation;
    }
    public void setId_reservation(int id_reservation) {
        this.id_reservation = id_reservation;
    }

    public int getPersonnel() {
        return personnel;
    }
    public void setPersonnel(int personnel) {
        this.personnel = personnel;
    }

    public int getNb_sieges() {
        return nb_sieges;
    }
    public void setNb_sieges(int nb_sieges) {
        this.nb_sieges = nb_sieges;
    }
}

