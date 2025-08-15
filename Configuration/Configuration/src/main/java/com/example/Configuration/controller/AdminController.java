package com.example.Configuration.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.Configuration.module.ConfigPersonnel;
import com.example.Configuration.service.ConfigPersonnelService;
import com.example.Configuration.service.UtilisateurService;

@Controller
public class AdminController {

    @Autowired
    private UtilisateurService utilisateurService;

    @Autowired
    private ConfigPersonnelService service;
    
    @RequestMapping("/")
    public String index() {
        return "index";
    }

    @PostMapping("/login")
    public String login(@RequestParam String pseudo,@RequestParam String mdp,Model model) {
        int result = utilisateurService.authentifier(pseudo, mdp);
        // On remet les valeurs pour que le formulaire les garde
        model.addAttribute("pseudo", pseudo);
        model.addAttribute("mdp", mdp);
        if (result == -2) {
            model.addAttribute("errorPseudo", "Le pseudo saisi n'existe pas. Veuillez vérifier et réessayer..");
            return "index";
        }
        if (result == -1) {
            model.addAttribute("errorMdp", "Votre mot de passe est invalide. Veuillez réessayer..");
            return "index";
        }

        return "redirect:/home"; // succès → redirection
    }

    @GetMapping("/home")
    public String home(Model model) {
        List<ConfigPersonnel> configs = service.getAllConfig(); 
        model.addAttribute("configs", configs);
        return "home";
    }

    @PostMapping("/update-remise")
    public String updateRemise(@RequestParam int code, @RequestParam double remise,Model model) throws Exception {
        service.updateRemiseByCode(code, remise);
        return "redirect:/home";
    }
}
