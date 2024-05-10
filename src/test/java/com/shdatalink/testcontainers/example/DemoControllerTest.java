package com.shdatalink.testcontainers.example;

import com.shdatalink.example.DemoEntity;
import com.shdatalink.example.DemoRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.web.client.TestRestTemplate;

import javax.annotation.Resource;

import static org.assertj.core.api.Assertions.assertThat;

class DemoControllerTest extends AbstractIntegrationTest {

    @Autowired
    TestRestTemplate restTemplate;

    @Resource
    DemoRepository demoRepository;

    @Test
    void simpleTest() {
        String fooResource = "/foo";

        restTemplate.put(fooResource, "bar");

        assertThat(restTemplate.getForObject(fooResource, String.class)).as("value is set").isEqualTo("bar");
    }

    @Test
    void simpleJPATest() {
        DemoEntity demoEntity = new DemoEntity();
        demoEntity.setValue("Some value");
        demoRepository.saveAndFlush(demoEntity);

        DemoEntity result = restTemplate.getForObject("/" + demoEntity.getId(), DemoEntity.class);

        assertThat(result.getValue()).as("value is set").isEqualTo("Some value");
    }
}
