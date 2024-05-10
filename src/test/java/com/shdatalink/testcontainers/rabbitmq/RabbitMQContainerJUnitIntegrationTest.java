package com.shdatalink.testcontainers.rabbitmq;

import org.junit.ClassRule;
import org.junit.Test;
import org.testcontainers.containers.RabbitMQContainer;

import static org.assertj.core.api.Assertions.assertThat;

public class RabbitMQContainerJUnitIntegrationTest {

    @ClassRule
    public static RabbitMQContainer rabbitMQContainer = new RabbitMQContainer(RabbitMQTestImages.RABBITMQ_IMAGE);

    @Test
    public void shouldStart() {
        assertThat(rabbitMQContainer.isRunning()).isTrue();
    }
}
