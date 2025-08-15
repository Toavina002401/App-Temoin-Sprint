package com.example.Configuration.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.Configuration.module.ConfigPersonnel;
import com.example.Configuration.repository.ConfigPersonnelRepository;

import java.util.List;
import java.util.Optional;

@Service
public class ConfigPersonnelService {

    @Autowired
    private ConfigPersonnelRepository repository;

    /**
     * Met à jour uniquement la remise pour un code_personnel donné
     * @param codePersonnel code du personnel à modifier
     * @param nouvelleRemise nouvelle valeur de remise
     * @return ConfigPersonnel mis à jour
     * @throws Exception si le code n'existe pas
     */
    public ConfigPersonnel updateRemiseByCode(int codePersonnel, double nouvelleRemise) throws Exception {
        Optional<ConfigPersonnel> existing = repository.findAll()
                .stream()
                .filter(c -> c.getCodePersonnel() == codePersonnel)
                .findFirst();

        if (existing.isEmpty()) {
            throw new Exception("Aucune configuration trouvée pour le code personnel : " + codePersonnel);
        }

        ConfigPersonnel cp = existing.get();
        cp.setRemise(nouvelleRemise);

        return repository.save(cp);
    }

    /**
     * Récupère toutes les configurations
     */
    public List<ConfigPersonnel> getAllConfig() {
        return repository.findAll();
    }
}
