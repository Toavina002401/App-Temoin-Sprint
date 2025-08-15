package com.example.Configuration.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.example.Configuration.module.ConfigPersonnel;

public interface ConfigPersonnelRepository extends JpaRepository<ConfigPersonnel, Long> {
}
