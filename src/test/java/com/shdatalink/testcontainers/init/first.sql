-- // DML_for_init
-- Migration SQL that makes the change goes here.
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

INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (1, '1', 0, 'COAL_ZYYH', '煤炭供应链金融服务(类中原银行)');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (2, '2', 0, 'GRAIN', '粮食仓单服务');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (3, '3', 0, 'COAL_TERMINAL', '煤炭供应链终端服务');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (4, '4', 0, 'COAL_SMBL', '煤炭供应链金融服务(类善美保理)');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (5, '5', 0, 'CINDA', '信达资产服务');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (6, '6', 0, 'FULL_BUSINESS_LINE', '全业务线服务');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (7, '7', 0, 'STEEL', '钢材供应链');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (8, '8', 0, 'SHANMEI_BILL_CENTER', '票据中心');


-- //@UNDO
-- SQL to undo the change goes here.


