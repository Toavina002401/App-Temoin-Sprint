package dossiers.Controlleur;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Vector;

import controlleur.annotation.AnnotationControlleur;
import controlleur.annotation.Param;
import controlleur.annotation.Post;
import controlleur.annotation.Url;
import controlleur.fonction.ModelView;
import controlleur.source.CustomeSession;
import dossiers.Modules.Aeroport;
import dossiers.Modules.Avion;
import dossiers.Modules.Classe;
import dossiers.Modules.FilleReservation;
import dossiers.Modules.Promotion;
import dossiers.Modules.Reservation;
import dossiers.Modules.Vol;
import jakarta.servlet.http.Part;

@AnnotationControlleur
public class FrontOfficeController {
    private CustomeSession session;
    private String baseUrl = "http://localhost:8080/AppTemoin";

    @Url("/")
    public ModelView index() throws Exception {
        ModelView mv = new ModelView("/view/index.jsp");
        Vector<Aeroport> listeAeroport = Aeroport.getAll();
        Vector<Avion> listeAvion = Avion.getAll();
        Vector<Classe> listeClasse = Classe.getAll();
        session.add("baseUrl", baseUrl);
        mv.addObject("listeAeroport", listeAeroport);
        mv.addObject("listeAvion", listeAvion);
        mv.addObject("listeClasse", listeClasse);
        return mv;
    }

    @Url("/frontOffice/dispo")
    public ModelView volDispo() throws Exception {
        ModelView mv = new ModelView("/view/index.jsp");
        Vector<Aeroport> listeAeroport = Aeroport.getAll();
        Vector<Avion> listeAvion = Avion.getAll();
        Vector<Classe> listeClasse = Classe.getAll();
        Vector<Vol> liste = Vol.getVolDispo();
        Vector<Vector<Promotion>> lesPromos = Promotion.getPromo(liste);
        session.add("baseUrl", baseUrl);
        mv.addObject("listeAeroport", listeAeroport);
        mv.addObject("listeAvion", listeAvion);
        mv.addObject("listeClasse", listeClasse);
        mv.addObject("dispo", true);
        mv.addObject("listeVolsReservation", liste);
        mv.addObject("lesPromos", lesPromos);
        return mv;
    }

    
    @Post
    @Url("/frontOffice/reserver")
    public ModelView reserver(@Param("idVolRes") String idVolRes,@Param("nomClient") String nomClient,@Param("prenomClient") String prenomClient,@Param("passport") Part passport
    ,@Param("ClassReservation") String ClassReservation,@Param("bebe") String bebe,@Param("enfant") String enfant,@Param("adulte") String adulte) throws Exception {
        
        ModelView mv = new ModelView("/view/index.jsp");
        Vector<Aeroport> listeAeroport = Aeroport.getAll();
        Vector<Avion> listeAvion = Avion.getAll();
        Vector<Classe> listeClasse = Classe.getAll();
        Vector<Vol> liste = Vol.getVolDispo();
        Vector<Vector<Promotion>> lesPromos = Promotion.getPromo(liste);
        session.add("baseUrl", baseUrl);
        mv.addObject("listeAeroport", listeAeroport);
        mv.addObject("listeAvion", listeAvion);
        mv.addObject("listeClasse", listeClasse);
        mv.addObject("dispo", true);
        mv.addObject("listeVolsReservation", liste);
        mv.addObject("lesPromos", lesPromos);

        Reservation res = new Reservation();
        res.setId_vol(Integer.parseInt(idVolRes));
        res.setClients(prenomClient+" "+nomClient);
        res.setId_classe(Integer.parseInt(ClassReservation));
        res.setChemin_passport(passport.getSubmittedFileName());
        res.setDate_reservation(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

        Vector<FilleReservation> fille = Reservation.getFille(bebe, enfant, adulte);
        res.save(fille);
        Reservation.sauvegarde(passport);
        return mv;
    }


    @Post
    @Url("/frontOffice/recherche")
    public ModelView rechercheMultiCritere(@Param("aeroportDepart") String aeroportDepart,
            @Param("aeroportArrive") String aeroportArrive, @Param("avion") String avion, @Param("classe") String classe,
            @Param("dateDepart") String dateDepart, @Param("dateArrive") String dateArrive) throws Exception {
        ModelView mv = new ModelView("/view/index.jsp");
        Vector<Aeroport> listeAeroport = Aeroport.getAll();
        Vector<Avion> listeAvion = Avion.getAll();
        Vector<Classe> listeClasse = Classe.getAll();
        session.add("baseUrl", baseUrl);
        mv.addObject("listeAeroport", listeAeroport);
        mv.addObject("listeAvion", listeAvion);
        mv.addObject("listeClasse", listeClasse);
        mv.addObject("search", true);
        mv.addObject("selectedAeroportDepart", aeroportDepart);
        mv.addObject("selectedAeroportArrive", aeroportArrive);
        mv.addObject("selectedAvion", avion);
        mv.addObject("selectedClasse", classe);
        mv.addObject("selectedDateDepart", dateDepart);
        mv.addObject("selectedDateArrive", dateArrive);

        // Convertir les paramètres en Integer (null si vide)
        Integer idAeroportDepart = (aeroportDepart != null && !aeroportDepart.isEmpty()) ? Integer.parseInt(aeroportDepart) : null;
        Integer idAeroportArrive = (aeroportArrive != null && !aeroportArrive.isEmpty()) ? Integer.parseInt(aeroportArrive) : null;
        Integer idAvion = (avion != null && !avion.isEmpty()) ? Integer.parseInt(avion) : null;
        Integer idClasse = (classe != null && !classe.isEmpty()) ? Integer.parseInt(classe) : null;

        // Appel de la méthode de recherche
        Vol volObj = new Vol();
        Vector<Vol> resultats = volObj.rechercherVols(idAeroportDepart, idAeroportArrive, idAvion, dateDepart, dateArrive, idClasse);
        mv.addObject("listeVols", resultats);
        System.out.println("Recherche Multicritere FrontOffice");
        return mv;
    }
}