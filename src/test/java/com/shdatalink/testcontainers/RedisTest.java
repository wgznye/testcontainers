package com.shdatalink.testcontainers;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.BeforeEach;
import org.testcontainers.containers.GenericContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.testcontainers.utility.DockerImageName;
import redis.clients.jedis.Jedis;

import static org.junit.Assert.assertEquals;

@Testcontainers
public class RedisTest {

    @Container
    public GenericContainer redisContainer = new GenericContainer(DockerImageName.parse("redis:latest"))
            .withExposedPorts(6379);



    @BeforeEach
    public void setUp() {
        redisContainer.start();
    }

    @Test
    public void testRedis() {
        // 获取 Redis 主机和端口
        String redisHost = redisContainer.getHost();
        Integer redisPort = redisContainer.getMappedPort(6379);

        // 创建 Jedis 客户端连接到 Redis 容器
        try (Jedis jedis = new Jedis(redisHost, redisPort)) {
            // 测试 Redis 是否可用
            jedis.set("testKey", "testValue");
            String value = jedis.get("testKey");
            System.out.println("Redis value: " + value);
            Assertions.assertEquals("testValue", value);
        }
    }

}
