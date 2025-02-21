package dossiers.Controlleur;

import controlleur.annotation.AnnotationControlleur;
import controlleur.annotation.Get;
import controlleur.annotation.Url;
import controlleur.fonction.ModelView;
import controlleur.source.CustomeSession;

@AnnotationControlleur
public class AdminController {
    private CustomeSession session;
    private String baseUrl = "http://localhost:8080/AppTemoin";

    @Url("/")
    public ModelView index() {
        ModelView mv = new ModelView("/view/index.jsp");
        session.add("baseUrl", baseUrl);
        return mv;
    }

    @Get
    @Url("/backOffice")
    public ModelView login() {
        ModelView mv = new ModelView("/view/backoffice/index.jsp");
        session.add("baseUrl", baseUrl);
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
    public ModelView rechercheMultiCritere() {
        ModelView mv = new ModelView("/view/backoffice/rechercheMultiCritere.jsp");
        session.add("baseUrl", baseUrl);
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