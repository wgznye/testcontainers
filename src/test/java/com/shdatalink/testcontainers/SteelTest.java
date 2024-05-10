package com.shdatalink.testcontainers;

import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.web.client.RestTemplate;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.containers.output.Slf4jLogConsumer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.utility.DockerImageName;

public class SteelTest {
    private static final Network network = Network.newNetwork();

    // 定义 MySQL 容器
    @Container
    private static final MySQLContainer<?> mysqlContainer = new MySQLContainer<>("mysql:latest")
            .withDatabaseName("dg_steel")
            .withUsername("root")
            .withExposedPorts(3306)
            .withPassword("")
            .withNetwork(network)
            ;
    @Container
    private static final GenericContainer<?> javaContainer = new GenericContainer<>(DockerImageName.parse("dg_steel"))
            .withExposedPorts(9090)
            .withNetwork(network);
    @BeforeAll
    public static void setUp() {
        mysqlContainer.start();
        javaContainer.start();
    }

    @Test
    public void testDgSteel() {
        String mysqlHost = mysqlContainer.getHost();
        int mysqlPort = mysqlContainer.getMappedPort(3306);
        String mysqlJdbcUrl = "jdbc:mysql://" + mysqlHost + ":" + mysqlPort + "/dg_steel";

        // 获取 Java 容器的连接信息
        String javaHost = javaContainer.getHost();
        int javaPort = javaContainer.getMappedPort(9090);
        String javaUrl = "http://" + javaHost + ":" + javaPort;

        System.out.println("MySQL JDBC URL: " + mysqlJdbcUrl);
        System.out.println("javaUrl: " + javaUrl);


    }

}
