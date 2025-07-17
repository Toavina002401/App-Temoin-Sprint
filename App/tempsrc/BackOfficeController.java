package dossiers.Controlleur;

import java.util.Vector;

import controlleur.annotation.AnnotationControlleur;
import controlleur.annotation.Get;
import controlleur.annotation.Param;
import controlleur.annotation.Post;
import controlleur.annotation.Url;
import controlleur.fonction.ModelView;
import controlleur.source.CustomeSession;
import dossiers.Modules.Aeroport;
import dossiers.Modules.Avion;
import dossiers.Modules.Classe;
import dossiers.Modules.Vol;

@AnnotationControlleur
public class BackOfficeController {
    private CustomeSession session;
    private String baseUrl = "http://localhost:8080/AppTemoin";
    
    @Post
    @Url("/backOffice/recherche")
    public ModelView rechercheMultiCritere(@Param("aeroportDepart") String aeroportDepart,
            @Param("aeroportArrive") String aeroportArrive, @Param("avion") String avion, @Param("classe") String classe,
            @Param("dateDepart") String dateDepart, @Param("dateArrive") String dateArrive) throws Exception {
        ModelView mv = new ModelView("/view/backoffice/rechercheMultiCritere.jsp");
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
        return mv;
    }

    @Get
    @Url("/backOffice/formulaireVol")
    public ModelView formulaireCreate()throws Exception {
        ModelView mv = new ModelView("/view/backoffice/create.jsp");
        Vector<Aeroport> listeAeroport = Aeroport.getAll();
        Vector<Avion> listeAvion = Avion.getAll();
        session.add("baseUrl", baseUrl);
        mv.addObject("listeAeroport", listeAeroport);
        mv.addObject("listeAvion", listeAvion);
        return mv;
    }

    @Get
    @Url("/backOffice/vol")
    public ModelView create(@Param("vol") Vol vol)throws Exception {
        String referer = "/backOffice/formulaireVol";
        ModelView mv = new ModelView("/view/backoffice/create.jsp");
        Vector<Aeroport> listeAeroport = Aeroport.getAll();
        Vector<Avion> listeAvion = Avion.getAll();
        session.add("baseUrl", baseUrl);
        mv.addObject("listeAeroport", listeAeroport);
        mv.addObject("listeAvion", listeAvion);
        mv.addObject("referer", referer);
        if (vol.valid()) {
            mv.addObject("valider", true);
            mv.addObject("listeVols", vol.save());
        }
        return mv;
    }
}
