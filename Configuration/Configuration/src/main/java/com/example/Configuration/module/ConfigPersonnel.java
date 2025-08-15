package com.example.Configuration.module;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "configpersonnel")
@Getter
@Setter
public class ConfigPersonnel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String personnel;

    @Column(name = "code_personnel")
    private Integer codePersonnel;

    private Double remise;
}
