package com.liuyanzhao.sens.user;

import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * @author liuyanzhao
 */
@Slf4j
@SpringBootApplication
@EnableCaching
@EnableScheduling
@MapperScan("com.liuyanzhao.sens.user.mapper")
public class SensUserApplication {
    public static void main(String[] args) {
        ApplicationContext context = SpringApplication.run(SensUserApplication.class, args);
        String serverPort = context.getEnvironment().getProperty("server.port");
        log.info("【SENS USER】 started at http://localhost:" + serverPort);
    }
}
