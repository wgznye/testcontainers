package com.shdatalink.example;

import org.springframework.data.jpa.repository.JpaRepository;

public interface DemoRepository extends JpaRepository<DemoEntity, Long> {}
