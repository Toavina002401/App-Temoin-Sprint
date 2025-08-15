package com.example.Configuration.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.example.Configuration.module.Utilisateur;
import java.util.Optional;

public interface UtilisateurRepository extends JpaRepository<Utilisateur, Integer> {
    Optional<Utilisateur> findByPseudo(String pseudo);
    Optional<Utilisateur> findByPseudoAndMdp(String pseudo, String mdp);
}
