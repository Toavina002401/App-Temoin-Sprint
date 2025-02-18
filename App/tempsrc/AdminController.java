package dossiers.Controlleur;

import controlleur.annotation.AnnotationControlleur;
import controlleur.annotation.Url;
import controlleur.fonction.ModelView;

@AnnotationControlleur
public class AdminController {

    @Url("/")
    public ModelView login() {
        ModelView mv = new ModelView("/view/index.jsp");
        return mv;
    }
}