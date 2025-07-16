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
import dossiers.Modules.Utilisateur;

@AnnotationControlleur
public class AdminController {
    private CustomeSession session;
    private String baseUrl = "http://localhost:8080/AppTemoin";

    @Get
    @Url("/backOffice")
    public ModelView login() {
        ModelView mv = new ModelView("/view/backoffice/index.jsp");
        session.add("baseUrl", baseUrl);
        return mv;
    }

    @Get
    @Url("/deconnexion")
    public ModelView deconnexion() {
        ModelView mv = new ModelView("/view/backoffice/index.jsp");
        session.add("authUser", false); 
        session.add("baseUrl", baseUrl);
        return mv;
    }

    @Post
    @Url("/login")
    public ModelView traitementLogin(@Param("pseudo") String pseudo,@Param("pwd") String pwd) throws Exception {
        int auth = Utilisateur.authentifier(pseudo, pwd);
        ModelView mv = null;
        session.add("baseUrl", baseUrl);
        if (auth > 0) {
            mv = new ModelView("/view/backoffice/home.jsp");
            session.add("authUser", true); 
        }else{
            mv = new ModelView("/view/backoffice/index.jsp");
            mv.addObject("logsAuth", auth);
            mv.addObject("logsPseudo", pseudo);
            mv.addObject("logspwd", pwd);
        }
        return mv;
    }

    @Get
    @Url("/backOffice/home")
    public ModelView home() {
        ModelView mv = new ModelView("/view/backoffice/home.jsp");
        session.add("baseUrl", baseUrl);
        return mv;
    }

    @Get
    @Url("/backOffice/promotion")
    public ModelView promotion() {
        ModelView mv = new ModelView("/view/backoffice/promotion.jsp");
        session.add("baseUrl", baseUrl);
        return mv;
    }

    @Get
    @Url("/backOffice/reservation")
    public ModelView reservation() {
        ModelView mv = new ModelView("/view/backoffice/reservation.jsp");
        session.add("baseUrl", baseUrl);
        return mv;
    }

    @Get
    @Url("/backOffice/rechercheMultiCritere")
    public ModelView rechercheMultiCritere() throws Exception {
        ModelView mv = new ModelView("/view/backoffice/rechercheMultiCritere.jsp");
        Vector<Aeroport> listeAeroport = Aeroport.getAll();
        Vector<Avion> listeAvion = Avion.getAll();
        Vector<Classe> listeClasse = Classe.getAll();
        session.add("baseUrl", baseUrl);
        mv.addObject("listeAeroport", listeAeroport);
        mv.addObject("listeAvion", listeAvion);
        mv.addObject("listeClasse", listeClasse);
        return mv;
    }

    @Get
    @Url("/backOffice/crudVol")
    public ModelView crudVol() {
        ModelView mv = new ModelView("/view/backoffice/crudVol.jsp");
        session.add("baseUrl", baseUrl);
        return mv;
    }
}