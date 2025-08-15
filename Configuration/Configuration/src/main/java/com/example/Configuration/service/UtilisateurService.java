package com.example.Configuration.service;

import com.example.Configuration.module.Utilisateur;
import com.example.Configuration.repository.UtilisateurRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class UtilisateurService {

    @Autowired
    private UtilisateurRepository utilisateurRepository;

    public int authentifier(String pseudo, String mdp) {
        // Vérifie si le pseudo existe
        Optional<Utilisateur> userByPseudo = utilisateurRepository.findByPseudo(pseudo);
        if (userByPseudo.isEmpty()) {
            return -2; // Pseudo inexistant
        }

        // Vérifie si pseudo + mdp correspondent
        Optional<Utilisateur> user = utilisateurRepository.findByPseudoAndMdp(pseudo, mdp);
        if (user.isEmpty()) {
            return -1; // Mot de passe incorrect
        }

        // Retourne l'ID si authentifié
        return user.get().getId();
    }
}
