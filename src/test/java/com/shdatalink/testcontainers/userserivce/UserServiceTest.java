package com.shdatalink.testcontainers.userserivce;

import com.shdatalink.testcontainers.mysql.MySQLTestImages;
import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.Test;
import org.springframework.web.client.RestTemplate;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.containers.MySQLContainer;
import org.testcontainers.containers.Network;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.testcontainers.utility.MountableFile;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.assertNotNull;

@Testcontainers
public class UserServiceTest {

    // 定义共享网络
    private static final Network network = Network.newNetwork();

    // 定义 MySQL 容器
    @Container
    private static final MySQLContainer<?> mysqlContainer = new MySQLContainer<>(MySQLTestImages.MYSQL_LATEST_IMAGE)
            .withNetworkAliases("mysql")
            .withDatabaseName("dg_user_1") //容器别名
            .withUsername("dg_user")
            .withExposedPorts(3306)
            .withPassword("123456")
            .withNetwork(network);

    @Container
    private static final GenericContainer<?> container = new GenericContainer<>(UserTestImages.DG_USER_IMAGE)
            .dependsOn(mysqlContainer)
            .withEnv("SPRING_DATASOURCE_URL", "jdbc:mysql://mysql:3306/dg_user_1?useUnicode=true&characterEncoding=utf8&useSSL=false")//使用mysql容器别名链接
            .withNetwork(network);

    @BeforeAll
    public static void init() {
        mysqlContainer.start();
        assertThat(mysqlContainer.isRunning()).isTrue();
    }

    @AfterAll
    public static void end() {
        System.out.println("end");
    }

    @Test
    public void testDgUser()  throws Exception {
        container.start();
        assertThat(container.isRunning()).isTrue();

        String containerId = mysqlContainer.getContainerId();
        System.out.println("containerId>>>" + containerId);
        // 在测试方法中获取映射端口
        Integer mappedPort = mysqlContainer.getMappedPort(3306);
        // 确保映射端口不为空
        assertNotNull(mappedPort, "Mapped port should not be null");
        // 获取 MySQL 容器的连接信息
        String jdbcUrl = mysqlContainer.getJdbcUrl();
        String username = mysqlContainer.getUsername();
        String password = mysqlContainer.getPassword();
        System.out.println("User jdbcUrl: " + jdbcUrl + ", username: " + username);

        RestTemplate restTemplate = new RestTemplate();
        String javaHost = container.getHost();
        Integer javaPort = container.getFirstMappedPort();
        String javaUrl = "http://" + javaHost + ":" + javaPort;

        String serviceUrl = javaUrl + "/dg-user-api/api/login/code";
        // 调用服务并打印返回结果
        String response = restTemplate.getForObject(serviceUrl, String.class);
        System.out.println("Response from service: " + response);
        container.stop();
    }

}
