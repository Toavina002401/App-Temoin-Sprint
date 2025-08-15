package com.example.Configuration.module;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "Utilisateur")
@Getter
@Setter
public class Utilisateur {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String pseudo;

    @Column(nullable = false)
    private String mdp;
}
