-- // Bootstrap.sql

-- This is the only SQL script file that is NOT
-- a valid migration and will not be run or tracked
-- in the changelog.  There is no @UNDO section.

-- // Do I need this file?

-- New projects likely won't need this file.
-- Existing projects will likely need this file.
-- It's unlikely that this bootstrap should be run
-- in the production environment.

-- // Purpose

-- The purpose of this file is to provide a facility
-- to initialize the database to a state before MyBatis
-- SQL migrations were applied.  If you already have
-- a database in production, then you probably have
-- a script that you run on your developer machine
-- to initialize the database.  That script can now
-- be put in this bootstrap file (but does not have
-- to be if you are comfortable with your current process.

-- // Running

-- The bootstrap SQL is run with the "migrate bootstrap"
-- command.  It must be run manually, it's never run as
-- part of the regular migration process and will never
-- be undone. Variables (e.g. ${variable}) are still
-- parsed in the bootstrap SQL.

-- After the boostrap SQL has been run, you can then
-- use the migrations and the changelog for all future
-- database change management.


CREATE TABLE `t_audit_log`
(
    `id`            int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`           varchar(32)  NOT NULL COMMENT '业务主键',
    `deleted`       int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `audit_model`   varchar(50)  NOT NULL COMMENT '审批类型',
    `biz_key`       varchar(50)  NOT NULL COMMENT '业务表唯一键',
    `opt_type`      varchar(50)  NOT NULL COMMENT '操作类型',
    `opt_time`      datetime     NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '操作时间',
    `operator`      varchar(100) NOT NULL COMMENT '操作人',
    `audit_result`  varchar(32)           DEFAULT NULL COMMENT '审批结果（通过:PASS,驳回:REJECT)',
    `audit_opinion` varchar(255)          DEFAULT NULL COMMENT '审批意见',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`)
) COMMENT ='审批记录基础表';

CREATE TABLE `t_bank`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50)  DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50)  DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime     DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50)  DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50)  DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime     DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `bank_name`          varchar(100) DEFAULT NULL COMMENT '银行名称',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`)
) COMMENT ='银行信息表';

CREATE TABLE `t_company`
(
    `id`                              int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                             varchar(32)  NOT NULL COMMENT '业务主键',
    `created_by`                      varchar(50)           DEFAULT NULL,
    `created_name`                    varchar(50)           DEFAULT NULL COMMENT '创建人名称',
    `created_date`                    datetime              DEFAULT NULL,
    `last_modified_by`                varchar(50)           DEFAULT NULL,
    `last_modified_name`              varchar(50)           DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date`              datetime              DEFAULT NULL,
    `deleted`                         int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `company_type`                    varchar(20)  NOT NULL COMMENT '企业类型',
    `name`                            varchar(100) NOT NULL COMMENT '企业名称',
    `abbreviation`                    varchar(20)           DEFAULT NULL COMMENT '企业简称',
    `abbreviation_spell`              varchar(50)           DEFAULT NULL COMMENT '企业简称拼音',
    `establish_date`                  date                  DEFAULT NULL COMMENT '成立日期',
    `uscc`                            varchar(64)  NOT NULL COMMENT '统一社会信用代码',
    `uscc_img`                        varchar(255)          DEFAULT NULL COMMENT '营业执照正本',
    `licence_begin_date`              date                  DEFAULT NULL COMMENT '营业执照开始日期',
    `licence_end_date`                date                  DEFAULT NULL COMMENT '营业执照截止日期',
    `license_end_date_is_long_valid`  tinyint(1) DEFAULT '0' COMMENT '营业期限是否长期有效',
    `area`                            varchar(64)           DEFAULT NULL COMMENT '所在地区',
    `address`                         varchar(500)          DEFAULT NULL COMMENT '详细地址',
    `legal_person_name`               varchar(64)           DEFAULT NULL COMMENT '法人姓名',
    `legal_person_card_no`            varchar(20)           DEFAULT NULL COMMENT '法人证件号',
    `legal_person_card_img`           varchar(255)          DEFAULT NULL COMMENT '法人证件',
    `auth_license_img`                varchar(255)          DEFAULT NULL COMMENT '企业认证授权书',
    `receive_paper_flag`              tinyint(1) DEFAULT '0' COMMENT '是否收到纸质材料',
    `legal_person_card_valid_time`    date                  DEFAULT NULL COMMENT '法人身份证有效期',
    `legal_person_card_is_long_valid` tinyint(1) DEFAULT '0' COMMENT '法人身份证是否长期有效',
    `agent_person_name`               varchar(64)           DEFAULT NULL COMMENT '代理人姓名',
    `agent_person_card_no`            varchar(20)           DEFAULT NULL COMMENT '代理人身份证号码',
    `agent_person_card_valid_time`    date                  DEFAULT NULL COMMENT '代理人身份证有效期',
    `agent_person_card_is_long_valid` tinyint(1) DEFAULT '0' COMMENT '代理人身份证是否长期有效',
    `agent_person_card_img`           varchar(255)          DEFAULT NULL COMMENT '代理人证件',
    `contract_sign_address`           varchar(100)          DEFAULT NULL COMMENT '合同签约地点',
    `modify_company_type_reason`      varchar(500)          DEFAULT NULL COMMENT '变更企业类型原因',
    `modify_company_type_date`        datetime              DEFAULT NULL COMMENT '变更企业类型时间',
    `verification_method`             varchar(10)  NOT NULL DEFAULT 'STRONG' COMMENT '认证方式(强认证:STRONG,弱认证:WEAK)',
    `verification_place`              varchar(10)  NOT NULL DEFAULT 'PC' COMMENT '认证渠道',
    `join_date`                       datetime              DEFAULT NULL COMMENT '认证时间',
    `admin_id`                        varchar(32)           DEFAULT NULL COMMENT '企业管理员Id',
    `group_id`                        varchar(32)           DEFAULT NULL COMMENT '集团ID',
    `status`                          varchar(20)  NOT NULL DEFAULT 'NORMAL' COMMENT '状态(NORMAL-正常,FREEZE-冻结)',
    `reason`                          varchar(500)          DEFAULT NULL COMMENT '冻结原因',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_uscc` (`uscc`, `deleted`)
) COMMENT ='企业信息表';

CREATE TABLE `t_company_account`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32)  NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50) DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `company_uscc`       varchar(50)  NOT NULL COMMENT '企业uscc',
    `company_name`       varchar(100) NOT NULL COMMENT '企业名称',
    `account_name`       varchar(255) NOT NULL COMMENT '账户名称',
    `account_no`         varchar(100) NOT NULL COMMENT '账户号',
    `account_type`       varchar(20)  NOT NULL COMMENT '账户类型',
    `bank_name`          varchar(100) NOT NULL COMMENT '银行名称',
    `province`           varchar(50)  NOT NULL COMMENT '开户省',
    `province_code`      varchar(50) DEFAULT NULL COMMENT '开户省',
    `city`               varchar(50)  NOT NULL COMMENT '开户城市',
    `city_code`          varchar(50) DEFAULT NULL COMMENT '开户城市',
    `subbranch_name`     varchar(100) NOT NULL COMMENT '支行名称',
    `subbranch_no`       varchar(100) NOT NULL COMMENT '支行联行号',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_company_uscc_account_no` (`company_uscc`, `account_no`, `deleted`)
) COMMENT ='企业银行账户表';

CREATE TABLE `t_company_admin_modify_log`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50)  DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50)  DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime     DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50)  DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50)  DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime     DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `old_admin_id`       varchar(32) NOT NULL COMMENT '原管理员ID',
    `old_admin_name`     varchar(50) NOT NULL COMMENT '旧管理员名称',
    `new_admin_id`       varchar(32) NOT NULL COMMENT '新管理员ID',
    `account`            varchar(100) DEFAULT NULL COMMENT '账户名',
    `admin_name`         varchar(64)  DEFAULT NULL COMMENT '管理员姓名',
    `admin_mobile`       varchar(11)  DEFAULT NULL COMMENT '管理员手机号',
    `ident_type`         varchar(20)  DEFAULT NULL COMMENT '管理员证件类型',
    `idcard`             varchar(20)  DEFAULT NULL COMMENT '管理员证件号码',
    `attachment`         varchar(255) DEFAULT NULL COMMENT '附件路径',
    `company_uscc`       varchar(32)  DEFAULT NULL COMMENT '企业uscc',
    `company_name`       varchar(255) DEFAULT NULL COMMENT '企业名称',
    `audit_time`         datetime     DEFAULT NULL COMMENT '审批时间',
    `audit_status`       varchar(20)  DEFAULT NULL COMMENT '审核状态',
    `operator`           varchar(32)  DEFAULT NULL COMMENT '操作员姓名',
    `audit_opinion`      varchar(255) DEFAULT NULL COMMENT '审核意见',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`)
) COMMENT ='管理员更换审核记录表';


CREATE TABLE `t_company_auth_log`
(
    `id`                              int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                             varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`                      varchar(50)          DEFAULT NULL,
    `created_name`                    varchar(50)          DEFAULT NULL COMMENT '创建人名称',
    `created_date`                    datetime             DEFAULT NULL,
    `last_modified_by`                varchar(50)          DEFAULT NULL,
    `last_modified_name`              varchar(50)          DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date`              datetime             DEFAULT NULL,
    `deleted`                         int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `audit_status`                    varchar(20)          DEFAULT NULL COMMENT '认证状态',
    `verification_place`              varchar(10) NOT NULL DEFAULT 'PC' COMMENT '认证渠道',
    `audit_opinion`                   varchar(500)         DEFAULT NULL COMMENT '审批意见',
    `audit_time`                      datetime             DEFAULT NULL COMMENT '审批时间',
    `auditor_id`                      varchar(32)          DEFAULT NULL COMMENT '审批人ID',
    `auditor_name`                    varchar(64)          DEFAULT NULL COMMENT '审批人名称',
    `personal_user_id`                varchar(32)          DEFAULT NULL COMMENT '申请人ID',
    `company_type`                    varchar(20)          DEFAULT NULL COMMENT '企业类型',
    `auth_company_type`               varchar(20)          DEFAULT NULL COMMENT '认证企业类型(贸易商-TRADER、终端-TERMINAL、金融机构-FINANCIAL_ORG、港口-PORT)',
    `open_service`                    varchar(100)         DEFAULT NULL COMMENT '企业开通服务',
    `name`                            varchar(100)         DEFAULT NULL COMMENT '企业名称',
    `abbreviation`                    varchar(20)          DEFAULT NULL COMMENT '企业简称',
    `abbreviation_spell`              varchar(20)          DEFAULT NULL COMMENT '企业简称拼音',
    `uscc`                            varchar(50)          DEFAULT NULL COMMENT '统一社会信用代码',
    `establish_date`                  date                 DEFAULT NULL COMMENT '成立日期',
    `area`                            varchar(64)          DEFAULT NULL COMMENT '所在地区',
    `address`                         varchar(200)         DEFAULT NULL COMMENT '详细地址',
    `legal_person_name`               varchar(64)          DEFAULT NULL COMMENT '法人姓名',
    `legal_person_card_no`            varchar(20)          DEFAULT NULL COMMENT '法人证件号',
    `legal_person_card_img`           varchar(255)         DEFAULT NULL COMMENT '法人证件',
    `legal_person_card_valid_time`    date                 DEFAULT NULL COMMENT '法人身份证有效期',
    `legal_person_card_is_long_valid` tinyint(1) DEFAULT '0' COMMENT '法人身份证是否长期有效(0:否,1:是)',
    `agent_person_name`               varchar(64)          DEFAULT NULL COMMENT '代理人姓名',
    `agent_person_card_no`            varchar(20)          DEFAULT NULL COMMENT '代理人身份证号码',
    `agent_person_card_valid_time`    date                 DEFAULT NULL COMMENT '代理人身份证有效期',
    `agent_person_card_is_long_valid` tinyint(1) DEFAULT '0' COMMENT '代理人身份证是否长期有效(0:否,1:是)',
    `agent_person_card_img`           varchar(500)         DEFAULT NULL COMMENT '代理人证件',
    `uscc_img`                        varchar(255)         DEFAULT NULL COMMENT '营业执照正本',
    `licence_end_date`                date                 DEFAULT NULL COMMENT '营业执照截止日期',
    `license_end_date_is_long_valid`  tinyint(1) DEFAULT '0' COMMENT '营业期限是否长期有效(0:否,1:是)',
    `auth_license_img`                varchar(255)         DEFAULT NULL COMMENT '企业认证授权书',
    `receive_paper_flag`              tinyint(1) DEFAULT '0' COMMENT '是否收到纸质材料 0 否 1 是',
    `contract_sign_address`           varchar(100)         DEFAULT NULL COMMENT '合同签约地点',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`)
) COMMENT ='企业认证记录';


CREATE TABLE `t_company_check_rule`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32)  NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL,
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL,
    `last_modified_by`   varchar(50) DEFAULT NULL,
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `code`               varchar(20)  NOT NULL COMMENT '规则编号',
    `name`               varchar(255) NOT NULL COMMENT '规则名称',
    `description`        varchar(255) NOT NULL COMMENT '规则描述',
    `disabled`           tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否启用（0：启用  1：停用）',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_code` (`code`, `deleted`)
) COMMENT ='企业规则表';


CREATE TABLE `t_company_check_rule_rel`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL,
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL,
    `last_modified_by`   varchar(50) DEFAULT NULL,
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `company_uscc`       varchar(64) NOT NULL COMMENT '企业uscc',
    `rule_code`          varchar(20) NOT NULL COMMENT '规则编号',
    `disabled`           tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否启用（0：启用  1：停用）',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_company_uscc_rule_code` (`company_uscc`, `rule_code`, `deleted`)
) COMMENT ='企业与规则关系表';


CREATE TABLE `t_company_group`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL,
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL,
    `last_modified_by`   varchar(50) DEFAULT NULL,
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `name`               varchar(64) NOT NULL COMMENT '集团名称',
    `code`               varchar(20) NOT NULL COMMENT '集团编码',
    `disabled`           tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否启用（0：启用  1：停用）',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_code` (`code`, `deleted`)
) COMMENT ='集团信息表';

CREATE TABLE `t_company_group_attachment`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32)  NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50) DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `company_group_id`   varchar(32)  NOT NULL COMMENT '集团ID',
    `attachment_name`    varchar(50)  NOT NULL COMMENT '附件名称',
    `attachment_ext`     varchar(50)  NOT NULL COMMENT '附件后缀',
    `attachment_path`    varchar(200) NOT NULL COMMENT '附件路径',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`)
) COMMENT ='集团证明材料表';

CREATE TABLE `t_company_group_subsidiaries`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50)          DEFAULT NULL,
    `created_name`       varchar(50)          DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime             DEFAULT NULL,
    `last_modified_by`   varchar(50)          DEFAULT NULL,
    `last_modified_name` varchar(50)          DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime             DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `company_group_id`   varchar(32) NOT NULL COMMENT '集团ID',
    `company_name`       varchar(64) NOT NULL COMMENT '下属公司名称',
    `company_uscc`       varchar(64) NOT NULL COMMENT '下属公司uscc',
    `status`             varchar(50) NOT NULL DEFAULT 'NORMAL' COMMENT '认证状态(CERTIFICATION_APPROVAL-认证审批中,UNAUTHORIZED-未认证,AUTHENTICATED-已认证)',
    `disabled`           tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否启用（0：启用  1：停用）',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_company_group_subsidiaries` (`company_group_id`, `company_uscc`, `deleted`)
) COMMENT ='集团下属公司信息表';


CREATE TABLE `t_company_info_pushing`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50) DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `receiver_uscc`      varchar(64) NOT NULL COMMENT '接受方统一社会信用代码',
    `company_uscc`       varchar(64) NOT NULL COMMENT '被推送方统一社会信用代码',
    `company_source`     varchar(20) NOT NULL COMMENT '被推送方企业属性(CORE_COMPANY:核心企业类型 TRADER:一般贸易商)',
    `push_time`          datetime    DEFAULT NULL COMMENT '最后一次推送成功时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_receiver_uscc_company_uscc` (`receiver_uscc`, `company_uscc`)
) COMMENT ='企业信息推送记录表';


CREATE TABLE `t_company_invoice`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32)  NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50) DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `company_uscc`       varchar(50)  NOT NULL COMMENT '企业uscc',
    `company_name`       varchar(100) NOT NULL COMMENT '企业名称',
    `address`            varchar(255) NOT NULL COMMENT '注册地址',
    `subbranch_name`     varchar(100) NOT NULL COMMENT '开户行',
    `account_no`         varchar(100) NOT NULL COMMENT '银行账号',
    `contact_phone`      varchar(20) DEFAULT NULL COMMENT '联系人电话',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`)
) COMMENT ='公司开票信息表';

CREATE TABLE `t_company_linkman`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32)  NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50) DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `company_uscc`       varchar(50)  NOT NULL COMMENT '企业uscc',
    `contact_name`       varchar(50)  NOT NULL COMMENT '联系人姓名',
    `contact_phone`      varchar(20)  NOT NULL COMMENT '联系人电话',
    `contact_area`       varchar(255) NOT NULL COMMENT '联系人所在地区',
    `contact_address`    varchar(255) NOT NULL COMMENT '联系人详细地址',
    `contact_email`      varchar(100) NOT NULL COMMENT '联系人电子邮箱',
    `contact_id_card`    varchar(20) DEFAULT NULL COMMENT '联系人身份证号',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`)
) COMMENT ='订单联系人信息表';


CREATE TABLE `t_company_modify_log`
(
    `id`                           int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                          varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`                   varchar(50)  DEFAULT NULL,
    `created_name`                 varchar(50)  DEFAULT NULL COMMENT '创建人名称',
    `created_date`                 datetime     DEFAULT NULL,
    `last_modified_by`             varchar(50)  DEFAULT NULL,
    `last_modified_name`           varchar(50)  DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date`           datetime     DEFAULT NULL,
    `deleted`                      int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `operator_company_uscc`        varchar(50)  DEFAULT NULL COMMENT '操作员所属企业uscc',
    `operator`                     varchar(32)  DEFAULT NULL COMMENT '操作员姓名',
    `name`                         varchar(255) DEFAULT NULL COMMENT '名称',
    `uscc`                         varchar(50)  DEFAULT NULL COMMENT '统一社会信用代码',
    `legal_person_name`            varchar(20)  DEFAULT NULL COMMENT '法人姓名',
    `legal_person_card_no`         varchar(20)  DEFAULT NULL COMMENT '法人证件号',
    `abbreviation`                 varchar(50)  DEFAULT NULL COMMENT '企业简称',
    `abbreviation_spell`           varchar(50)  DEFAULT NULL COMMENT '企业简称拼音',
    `modify_apply_img`             varchar(255) DEFAULT NULL COMMENT '企业基本信息申请证明',
    `uscc_img`                     varchar(255) DEFAULT NULL COMMENT '营业执照正本',
    `legal_person_card_img`        varchar(255) DEFAULT NULL COMMENT '法人证件',
    `modify_license_img`           varchar(255) DEFAULT NULL COMMENT '工商变更确认证明',
    `audit_status`                 varchar(20)  DEFAULT NULL COMMENT '审批状态',
    `audit_opinion`                varchar(200) DEFAULT NULL COMMENT '审批意见',
    `audit_time`                   datetime     DEFAULT NULL COMMENT '审批时间',
    `auditor_id`                   varchar(32)  DEFAULT NULL COMMENT '审批人ID',
    `auditor_name`                 varchar(64)  DEFAULT NULL COMMENT '审批人名称',
    `name_before`                  varchar(255) DEFAULT NULL COMMENT '企业名称变更前',
    `legal_person_name_before`     varchar(64)  DEFAULT NULL COMMENT '法人姓名变更前',
    `legal_person_card_no_before`  varchar(64)  DEFAULT NULL COMMENT '法人身份证变更前',
    `uscc_img_before`              varchar(255) DEFAULT NULL COMMENT '营业执照变更前',
    `legal_person_card_img_before` varchar(255) DEFAULT NULL COMMENT '法人证件变更前',
    `abbreviation_before`          varchar(50)  DEFAULT NULL COMMENT '企业简称变更前',
    `abbreviation_spell_before`    varchar(50)  DEFAULT NULL COMMENT '企业简称拼音变更前',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`)
) COMMENT ='企业信息变更记录表';


CREATE TABLE `t_company_service_rel`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50) DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `company_uscc`       varchar(50) NOT NULL COMMENT '企业uscc',
    `service_code`       varchar(50) NOT NULL COMMENT '已开通服务编码',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_company_uscc_service_code` (`company_uscc`, `service_code`, `deleted`)
) COMMENT ='企业已开通功能服务';

CREATE TABLE `t_company_type_service`
(
    `id`           int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`          varchar(32) NOT NULL COMMENT '业务主键',
    `deleted`      int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `service_code` varchar(50) NOT NULL COMMENT '服务编码',
    `company_type` varchar(50) NOT NULL COMMENT '核心企业类型',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_service_company_type` (`service_code`, `company_type`)
) COMMENT ='企业类型系统功能服务关系表';


CREATE TABLE `t_company_user`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32)  NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50)           DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50)           DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime              DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50)           DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50)           DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime              DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `company_uscc`       varchar(50)  NOT NULL COMMENT '企业uscc',
    `account`            varchar(100) NOT NULL COMMENT '账户名',
    `password`           varchar(255) NOT NULL COMMENT '密码',
    `personal_id`        varchar(32)           DEFAULT NULL COMMENT '关联个人用户',
    `link_time`          datetime              DEFAULT NULL COMMENT '关联时间',
    `error_count`        tinyint(4) DEFAULT '0' COMMENT '密码连续错误次数',
    `last_error_date`    datetime              DEFAULT NULL COMMENT '最近一次密码连续错误5次时间，用于冻结/自动解冻账号',
    `status`             varchar(20)  NOT NULL DEFAULT 'NORMAL' COMMENT '状态(NORMAL-正常,FREEZE-冻结)',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_account` (`account`, `deleted`),
    UNIQUE KEY `uk_company_personal_user_id` (`company_uscc`, `personal_id`, `deleted`)
) COMMENT ='企业用户表';

CREATE TABLE `t_company_user_apply_log`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50)          DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50)          DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime             DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50)          DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50)          DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime             DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `personal_user_id`   varchar(32) NOT NULL COMMENT '个人用户ID',
    `company_uscc`       varchar(50) NOT NULL COMMENT '企业uscc',
    `status`             varchar(20) NOT NULL DEFAULT 'TODO' COMMENT '状态(TODO：待验证 PASSED：通过 REJECTED：拒绝)',
    `apply_time`         datetime             DEFAULT NULL COMMENT '申请时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`)
) COMMENT ='企业用户申请记录表';


CREATE TABLE `t_company_user_invite_log`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50) DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `name`               varchar(50) NOT NULL COMMENT '员工姓名',
    `mobile`             varchar(11) NOT NULL COMMENT '邀请手机号',
    `company_uscc`       varchar(32) NOT NULL COMMENT '企业uscc',
    `company_user_id`    varchar(32) NOT NULL COMMENT '企业账号ID',
    `status`             varchar(20) NOT NULL COMMENT '状态(UNREG:未注册 UNLINKED:未关联 LINKED:已关联 CANCELED:已取消)',
    `invite_time`        datetime    DEFAULT NULL COMMENT '邀请时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`)
) COMMENT ='企业用户邀请记录表';


CREATE TABLE `t_company_user_role`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50) DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `company_user_id`    varchar(32) NOT NULL COMMENT '企业用户id',
    `role_id`            varchar(32) NOT NULL COMMENT '角色id',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_company_user_role` (`company_user_id`, `role_id`, `deleted`)
) COMMENT ='企业用户角色关联表';

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

CREATE TABLE `t_operation_log`
(
    `id`             int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`            varchar(32) NOT NULL COMMENT '业务主键',
    `deleted`        int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `module`         varchar(50) NOT NULL COMMENT '模块',
    `biz_key`        varchar(32) NOT NULL COMMENT '业务表唯一键',
    `operation_type` varchar(50) NOT NULL COMMENT '操作类型',
    `operation_time` datetime    NOT NULL COMMENT '操作时间',
    `operation_by`   varchar(50) NOT NULL COMMENT '操作人',
    `comments`       varchar(255) DEFAULT NULL COMMENT '操作内容',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`)
) COMMENT ='操作日志基础信息表';

CREATE TABLE `t_permission`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32)  NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50)  DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50)  DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime     DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50)  DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50)  DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime     DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `parent_id`          varchar(32) DEFAULT NULL COMMENT '父级权限id',
    `parent_ids`         varchar(1000) DEFAULT NULL COMMENT '父节点路径，逗号分隔',
    `name`               varchar(20)  NOT NULL COMMENT '权限名称',
    `perm`               varchar(100) NOT NULL COMMENT '权限编码',
    `type`               varchar(20)  NOT NULL COMMENT '权限类型',
    `level`              tinyint(4) NOT NULL COMMENT '权限层级',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_bo_permission` (`perm`, `deleted`)
) COMMENT ='权限表';

CREATE TABLE `t_personal`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50)  DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50)  DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime     DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50)  DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50)  DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime     DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `mobile`             varchar(11)  DEFAULT NULL COMMENT '手机号',
    `name`               varchar(30)  DEFAULT NULL COMMENT '真实姓名',
    `id_card`            varchar(20)  DEFAULT NULL COMMENT '身份证号',
    `sex`                varchar(10)  DEFAULT NULL COMMENT '性别：男,女,保密',
    `email`              varchar(45)  DEFAULT NULL COMMENT '邮箱',
    `area`               varchar(100) DEFAULT NULL COMMENT '所在地区',
    `address`            varchar(100) DEFAULT NULL COMMENT '详细地址',
    `auth`               tinyint(1) NOT NULL DEFAULT '0' COMMENT '实名认证(0-未认证,1-认证通过)',
    `auth_time`          datetime     DEFAULT NULL COMMENT '实名认证时间',
    `status`             varchar(20)  DEFAULT NULL COMMENT '状态(NORMAL-正常,FREEZE-冻结)',
    `register_source`    varchar(10)  DEFAULT 'PC' COMMENT '注册来源（PC;APP）',
    `pic_url`            varchar(255) DEFAULT NULL COMMENT '头像路径',
    `reason`             varchar(200) DEFAULT NULL COMMENT '冻结原因',
    `cur_company_uscc`   varchar(50)  DEFAULT NULL COMMENT '当前企业uscc',
    `cur_union_id`       varchar(50)  DEFAULT NULL COMMENT '当前绑定的微信用户标识',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `mobile` (`mobile`, `deleted`)
) COMMENT ='人员信息表';


CREATE TABLE `t_personal_mini_rel`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50) DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `personal_id`        varchar(32) NOT NULL COMMENT '个人表主键',
    `open_id`            varchar(50) NOT NULL COMMENT '小程序用户唯一标识',
    `union_id`           varchar(50) NOT NULL COMMENT '用户在微信开放平台帐号下的唯一标识',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_mini` (`personal_id`, `open_id`, `union_id`, `deleted`)
) COMMENT ='人员和小程序关联关系表';

CREATE TABLE `t_personal_receive_address`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32)  NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL,
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL,
    `last_modified_by`   varchar(50) DEFAULT NULL,
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `name`               varchar(100) NOT NULL COMMENT '收件人',
    `phone`              varchar(11)  NOT NULL COMMENT '手机号',
    `area`               varchar(100) NOT NULL COMMENT '地区',
    `address`            varchar(100) NOT NULL COMMENT '详细地址',
    `personal_id`        varchar(32)  NOT NULL COMMENT '关联人员ID',
    `disabled`           tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否启用（0：启用  1：停用）',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`)
) COMMENT ='个人收件地址';

CREATE TABLE `t_role`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50) DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `name`               varchar(20) NOT NULL COMMENT '角色名',
    `code`               varchar(20) NOT NULL COMMENT '角色编码',
    `company_type`       varchar(20) NOT NULL COMMENT '角色所属企业类型',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_company_type_code` (`company_type`, `code`, `deleted`)
) COMMENT ='角色表';


CREATE TABLE `t_role_permission`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50) DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `role_id`            varchar(32) NOT NULL COMMENT '角色id',
    `permission_id`      varchar(32) NOT NULL COMMENT '权限id',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_bid` (`bid`),
    UNIQUE KEY `uk_bo_role_permission` (`role_id`, `permission_id`, `deleted`)
) COMMENT ='角色权限关联表';

CREATE TABLE `t_service_permission`
(
    `id`                 int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
    `bid`                varchar(32) NOT NULL COMMENT '业务主键',
    `created_by`         varchar(50) DEFAULT NULL COMMENT '创建人ID',
    `created_name`       varchar(50) DEFAULT NULL COMMENT '创建人名称',
    `created_date`       datetime    DEFAULT NULL COMMENT '创建时间',
    `last_modified_by`   varchar(50) DEFAULT NULL COMMENT '修改人ID',
    `last_modified_name` varchar(50) DEFAULT NULL COMMENT '修改人名称',
    `last_modified_date` datetime    DEFAULT NULL,
    `deleted`            int(10) unsigned NOT NULL DEFAULT '0' COMMENT '是否删除',
    `service_code`       varchar(50) NOT NULL COMMENT '服务编码',
    `permission_id`      varchar(32) NOT NULL COMMENT '权限id',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_service_permission` (`service_code`, `permission_id`, `deleted`)
) COMMENT ='功能服务权限关联表';


