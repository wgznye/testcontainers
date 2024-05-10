package com.shdatalink.example;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Optional;

@Service
public class DemoService {
    @Resource
    private  DemoRepository demoRepository;

    public DemoEntity getDemoEntity(Long id) {
        return Optional.of(demoRepository.getById(id)).orElseThrow(() -> new RuntimeException("Entity not found"));
    }
}
