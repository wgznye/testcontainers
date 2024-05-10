
CREATE TABLE `t_functional_service`
(
    `id`           int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`          varchar(32) NOT NULL COMMENT '业务主键',
    `deleted`      int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `service_code` varchar(50) NOT NULL COMMENT '服务编码',
    `service_name` varchar(50) NOT NULL COMMENT '服务名称',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_service_code` (`service_code`)
) COMMENT ='系统功能服务表';
