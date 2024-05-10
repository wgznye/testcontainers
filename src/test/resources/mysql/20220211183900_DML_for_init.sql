-- // DML_for_init
-- Migration SQL that makes the change goes here.

INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (1, '1', 0, 'COAL_ZYYH', '煤炭供应链金融服务(类中原银行)');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (2, '2', 0, 'GRAIN', '粮食仓单服务');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (3, '3', 0, 'COAL_TERMINAL', '煤炭供应链终端服务');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (4, '4', 0, 'COAL_SMBL', '煤炭供应链金融服务(类善美保理)');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (5, '5', 0, 'CINDA', '信达资产服务');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (6, '6', 0, 'FULL_BUSINESS_LINE', '全业务线服务');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (7, '7', 0, 'STEEL', '钢材供应链');
INSERT INTO t_functional_service (id, bid, deleted, service_code, service_name) VALUES (8, '8', 0, 'SHANMEI_BILL_CENTER', '票据中心');


-- 金融企业观察员14不可以审批 361 362     124预警订阅.  193出仓单管理-转仓审批
delete  from t_role_permission  where role_id =14 and permission_id = 361;
delete  from t_role_permission  where role_id =14 and permission_id = 362;
delete  from t_role_permission  where role_id =14 and permission_id = 124;
delete  from t_role_permission  where role_id =14 and permission_id = 193;

--  核心企业 仓储员管理21  355仓储管理-仓房管理  356仓储管理-仓房历史    357关联资金方审批 358封仓 359仓请  360解除封仓
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('7b6fd7e88f0411ecb8040f8fa27d8d4b','21', '355');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('8bf67e788f0411ecb8040f8fa27d8d4b','21', '356');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('e35fc6568f0411ecb8040f8fa27d8d4b','21', '357');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('f434b87e8f0411ecb8040f8fa27d8d4b','21', '358');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('fb179bca8f0411ecb8040f8fa27d8d4b','21', '359');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('ffc02ebc8f0411ecb8040f8fa27d8d4b','21', '360');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('51e720e2908611ecb1a8429421e72607','5', '78');



--  添加预警新增权限 /删除权限
INSERT INTO `t_permission`( `bid`, `created_by`, `created_name`, `created_date`, `last_modified_by`, `last_modified_name`, `last_modified_date`, `deleted`, `parent_id`, `parent_ids`, `name`, `perm`, `type`, `level`) VALUES ( 'a47c871e92ea11ecaa37b3548cc01f5b', NULL, NULL, '2022-02-21 18:38:48', NULL, NULL, NULL, 0, 124, '78,122,124,', '预警新增', 'warehouse:warnManage:add', 'BUTTON', 2);
INSERT INTO `t_permission`( `bid`, `created_by`, `created_name`, `created_date`, `last_modified_by`, `last_modified_name`, `last_modified_date`, `deleted`, `parent_id`, `parent_ids`, `name`, `perm`, `type`, `level`) VALUES ( 'df9b7f6c92ea11ecaa37b3548cc01f5b', NULL, NULL, '2022-02-21 18:38:48', NULL, NULL, NULL, 0, 124, '78,122,124,', '预警删除', 'warehouse:warnManage:deleted', 'BUTTON', 2);

--   预警操作（新增/删除）核心企业（企业管理员1、仓储员21） 金融企业（企业管理员13、仓储业务员27）
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('dc730dc292eb11ecaa37b3548cc01f5b','1', 'a47c871e92ea11ecaa37b3548cc01f5b');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('070f1daa92ec11ecaa37b3548cc01f5b','1', 'df9b7f6c92ea11ecaa37b3548cc01f5b');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('0bcce0ac92ec11ecaa37b3548cc01f5b','21', 'a47c871e92ea11ecaa37b3548cc01f5b');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('103fffca92ec11ecaa37b3548cc01f5b','21', 'df9b7f6c92ea11ecaa37b3548cc01f5b');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('20cb1cc692ec11ecaa37b3548cc01f5b','13', 'a47c871e92ea11ecaa37b3548cc01f5b');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('25aaeb1892ec11ecaa37b3548cc01f5b','13', 'df9b7f6c92ea11ecaa37b3548cc01f5b');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('2b888ea092ec11ecaa37b3548cc01f5b','27', 'a47c871e92ea11ecaa37b3548cc01f5b');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('30809a4292ec11ecaa37b3548cc01f5b','27', 'df9b7f6c92ea11ecaa37b3548cc01f5b');

-- 业务员添加企业账号管理权限
INSERT INTO t_role_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, role_id, permission_id) VALUES ('212o6f22938n11ec9cc7403859186ddu', null, null, null, null, null, null, 0, '2', '49');
INSERT INTO t_role_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, role_id, permission_id) VALUES ('212p6f22938m11ec9cc7403859186ddt', null, null, null, null, null, null, 0, '8', '49');
INSERT INTO t_role_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, role_id, permission_id) VALUES ('212p6f22938e11ec9cc7408859186ddi', null, null, null, null, null, null, 0, '18', '49');
INSERT INTO t_role_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, role_id, permission_id) VALUES ('212p6f22938t11ec9cc7409859186ddt', null, null, null, null, null, null, 0, '23', '49');
-- 添加 更换企业管理员、解绑按钮 权限
INSERT INTO t_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, parent_id, parent_ids, name, perm, type, level) VALUES ('df9b7f6e92ea11ecav37b3548cc01f5b', null, null, '2022-02-21 18:38:48', null, null, null, 0, 49, '49,', '解绑', 'company:user:unbound', 'BUTTON', 2);
INSERT INTO t_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, parent_id, parent_ids, name, perm, type, level) VALUES ('df9b7f6r92ea11ecay37b3548cc01f5b', null, null, '2022-02-21 18:38:48', null, null, null, 0, 49, '49,', '更换企业管理员', 'company:user:change:admin', 'BUTTON', 2);
-- 企业管理员添加更换企业管理员、解绑按钮
INSERT INTO t_role_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, role_id, permission_id) VALUES ('212o6f22938n11ec9c17403859186ddu', null, null, null, null, null, null, 0, '1', 'df9b7f6e92ea11ecav37b3548cc01f5b');
INSERT INTO t_role_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, role_id, permission_id) VALUES ('212p6f22938b11ec9c27403859186ddt', null, null, null, null, null, null, 0, '1', 'df9b7f6r92ea11ecay37b3548cc01f5b');
INSERT INTO t_role_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, role_id, permission_id) VALUES ('212o6f22938v11ec9c37403859186dda', null, null, null, null, null, null, 0, '7', 'df9b7f6e92ea11ecav37b3548cc01f5b');
INSERT INTO t_role_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, role_id, permission_id) VALUES ('212p6f22938c11ec9c47403859186dds', null, null, null, null, null, null, 0, '7', 'df9b7f6r92ea11ecay37b3548cc01f5b');
INSERT INTO t_role_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, role_id, permission_id) VALUES ('212o6f22938x11ec9c57403859186ddd', null, null, null, null, null, null, 0, '17', 'df9b7f6e92ea11ecav37b3548cc01f5b');
INSERT INTO t_role_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, role_id, permission_id) VALUES ('212p6f22938z11ec9c67403859186ddf', null, null, null, null, null, null, 0, '17', 'df9b7f6r92ea11ecay37b3548cc01f5b');
INSERT INTO t_role_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, role_id, permission_id) VALUES ('212o6f22938p11ec9c77403859186ddg', null, null, null, null, null, null, 0, '22', 'df9b7f6e92ea11ecav37b3548cc01f5b');
INSERT INTO t_role_permission (bid, created_by, created_name, created_date, last_modified_by, last_modified_name, last_modified_date, deleted, role_id, permission_id) VALUES ('212p6f22938k11ec9c87403859186ddh', null, null, null, null, null, null, 0, '22', 'df9b7f6r92ea11ecay37b3548cc01f5b');

--  核心企业仓储员 21  332 warehouse:myServiceFee:statements:confirm 确认
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('15239c62957711ecad009af1ebc61d3f','21', '332');

INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('8de6abe08fd611ec93ffaf6d152371cb','21', '70');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('9a14abb08fd611ec93ffaf6d152371cb','21', '71');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('9f3389868fd611ec93ffaf6d152371cb','21', '353');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('a406a0068fd611ec93ffaf6d152371cb','21', '354');
-- 核心企业 仓储员管理21  财务员5     329 warehouse:myServiceFee 330warehouse:myServiceFee:statements 331warehouse:myServiceFee:bill 334warehouse:myServiceFee:statements:download 335warehouse:myServiceFee:statements:view
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('b85a4d9e8fd811ec93ffaf6d152371cb','21', '329');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('bd1fb60c8fd811ec93ffaf6d152371cb','21', '330');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('c15ab1688fd811ec93ffaf6d152371cb','21', '331');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('c53a18d28fd811ec93ffaf6d152371cb','21', '334');
INSERT INTO `t_role_permission`(`bid`,`role_id`, `permission_id`) VALUES ('db99a7c88fd811ec93ffaf6d152371cb','21', '335');

-- //@UNDO
-- SQL to undo the change goes here.


