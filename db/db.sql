/* SQL Manager Lite for MySQL                              5.6.4.50082 */
/* ------------------------------------------------------------------- */
/* Host     : localhost                                                */
/* Port     : 3306                                                     */
/* Database : helpmga                                                  */


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES 'utf8' */;

SET FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS `helpmga`;

CREATE DATABASE `helpmga`
    CHARACTER SET 'latin1'
    COLLATE 'latin1_swedish_ci';

USE `helpmga`;

/* Dropping database objects */

DROP VIEW IF EXISTS `view_ordem_servico_produto`;
DROP VIEW IF EXISTS `view_ordem_servico_custo`;
DROP VIEW IF EXISTS `view_ordem_servico`;
DROP TABLE IF EXISTS `tab_ordem_servico_produto`;
DROP TABLE IF EXISTS `tab_produto`;
DROP TABLE IF EXISTS `tab_ordem_servico_custo`;
DROP TABLE IF EXISTS `tab_tipo_servico`;
DROP TABLE IF EXISTS `tab_empresa`;
DROP TABLE IF EXISTS `tab_caixa`;
DROP TABLE IF EXISTS `tab_tipo_receita_despesa`;
DROP TABLE IF EXISTS `tab_contapr_parcela`;
DROP TABLE IF EXISTS `tab_contapr`;
DROP TABLE IF EXISTS `tab_ordem_servico`;
DROP TABLE IF EXISTS `tab_usuario`;
DROP TABLE IF EXISTS `tab_fornecedor`;
DROP TABLE IF EXISTS `tab_cliente`;

/* Structure for the `tab_cliente` table : */

CREATE TABLE `tab_cliente` (
  `cli_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `cli_nome` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cli_cpf` VARCHAR(40) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cli_ativo` CHAR(1) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cli_contato_telefone1` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cli_contato_telefone1_observacao` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cli_contato_telefone2` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cli_contato_telefone2_observacao` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cli_contato_telefone3` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cli_contato_telefone3_observacao` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`cli_id`)
) ENGINE=InnoDB
AUTO_INCREMENT=3 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Structure for the `tab_fornecedor` table : */

CREATE TABLE `tab_fornecedor` (
  `for_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `for_nome` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `for_cnpj` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `for_ativo` CHAR(1) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`for_id`)
) ENGINE=InnoDB
AUTO_INCREMENT=2 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Structure for the `tab_usuario` table : */

CREATE TABLE `tab_usuario` (
  `usu_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `usu_nome_acesso` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `usu_senha_acesso` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `usu_nome_completo` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `usu_email` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `usu_avatar` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `usu_ativo` TINYINT(4) DEFAULT NULL,
  `usu_administrador` CHAR(1) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`usu_id`)
) ENGINE=InnoDB
AUTO_INCREMENT=2 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Structure for the `tab_ordem_servico` table : */

CREATE TABLE `tab_ordem_servico` (
  `ors_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `cli_id` INTEGER(11) DEFAULT NULL,
  `usu_id` INTEGER(11) DEFAULT NULL,
  `ors_data_hora` DATE DEFAULT NULL,
  `ors_valida_ate` DATE DEFAULT NULL,
  `ors_finalizada` ENUM('S','N') COLLATE latin1_swedish_ci DEFAULT 'N',
  `ors_criado_em` DATETIME DEFAULT NULL,
  `ors_criado_por` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ors_modificao_em` DATETIME DEFAULT NULL,
  `ors_modificado_por` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `ors_valor_produtos` FLOAT DEFAULT NULL,
  `ors_valor_servicos` FLOAT DEFAULT NULL,
  `ors_valor_total` FLOAT DEFAULT NULL,
  `ors_observacao` TEXT COLLATE latin1_swedish_ci,
  PRIMARY KEY USING BTREE (`ors_id`),
  KEY `cli_id` USING BTREE (`cli_id`),
  KEY `usu_id` USING BTREE (`usu_id`),
  CONSTRAINT `tab_ordem_servico_fk1` FOREIGN KEY (`cli_id`) REFERENCES `tab_cliente` (`cli_id`),
  CONSTRAINT `tab_ordem_servico_fk2` FOREIGN KEY (`usu_id`) REFERENCES `tab_usuario` (`usu_id`)
) ENGINE=InnoDB
AUTO_INCREMENT=5 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Structure for the `tab_contapr` table : */

CREATE TABLE `tab_contapr` (
  `con_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `cli_id` INTEGER(11) DEFAULT NULL,
  `for_id` INTEGER(11) DEFAULT NULL,
  `usu_id` INTEGER(11) DEFAULT NULL,
  `ors_id` INTEGER(11) DEFAULT NULL,
  `con_data` DATE DEFAULT NULL,
  `con_tipo` ENUM('P','R') COLLATE latin1_swedish_ci DEFAULT NULL,
  `con_criado_em` DATETIME DEFAULT NULL,
  `con_criado_por` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `con_modificao_em` DATETIME DEFAULT NULL,
  `con_modificado_por` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `con_valor_documento` FLOAT DEFAULT NULL,
  `con_observacao` TEXT COLLATE latin1_swedish_ci,
  PRIMARY KEY USING BTREE (`con_id`),
  KEY `cli_id` USING BTREE (`cli_id`),
  KEY `for_id` USING BTREE (`for_id`),
  KEY `usu_id` USING BTREE (`usu_id`),
  KEY `ors_id` USING BTREE (`ors_id`),
  CONSTRAINT `tab_contapr_fk1` FOREIGN KEY (`cli_id`) REFERENCES `tab_cliente` (`cli_id`),
  CONSTRAINT `tab_contapr_fk2` FOREIGN KEY (`for_id`) REFERENCES `tab_fornecedor` (`for_id`),
  CONSTRAINT `tab_contapr_fk3` FOREIGN KEY (`usu_id`) REFERENCES `tab_usuario` (`usu_id`),
  CONSTRAINT `tab_contapr_fk4` FOREIGN KEY (`ors_id`) REFERENCES `tab_ordem_servico` (`ors_id`)
) ENGINE=InnoDB
AUTO_INCREMENT=20 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Structure for the `tab_contapr_parcela` table : */

CREATE TABLE `tab_contapr_parcela` (
  `cop_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `con_id` INTEGER(11) DEFAULT NULL,
  `cop_parcela` INTEGER(11) DEFAULT NULL,
  `cop_valor` FLOAT(9,3) DEFAULT NULL,
  `cop_valor_juros` FLOAT DEFAULT NULL,
  `cop_valor_multa` FLOAT DEFAULT NULL,
  `cop_data_vencimento` DATE DEFAULT NULL,
  `cop_data_pagamento` DATE DEFAULT NULL,
  `cop_modificado_em` DATETIME DEFAULT NULL,
  `cop_modificado_por` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cop_observacao` TEXT COLLATE latin1_swedish_ci,
  PRIMARY KEY USING BTREE (`cop_id`),
  KEY `con_id` USING BTREE (`con_id`),
  KEY `cop_id` USING BTREE (`cop_id`, `con_id`),
  KEY `con_id_2` USING BTREE (`con_id`, `cop_id`),
  CONSTRAINT `tab_contapr_parcela_fk1` FOREIGN KEY (`con_id`) REFERENCES `tab_contapr` (`con_id`)
) ENGINE=InnoDB
AUTO_INCREMENT=41 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Structure for the `tab_tipo_receita_despesa` table : */

CREATE TABLE `tab_tipo_receita_despesa` (
  `trd_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `trd_nome` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `trd_tipo` CHAR(1) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`trd_id`)
) ENGINE=InnoDB
AUTO_INCREMENT=5 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Structure for the `tab_caixa` table : */

CREATE TABLE `tab_caixa` (
  `cxa_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `con_id` INTEGER(11) DEFAULT NULL,
  `cop_id` INTEGER(11) DEFAULT NULL,
  `trd_id` INTEGER(11) DEFAULT NULL,
  `usu_id` INTEGER(11) DEFAULT NULL,
  `cxa_data` DATE DEFAULT NULL,
  `cxa_tipo` ENUM('C','D') COLLATE latin1_swedish_ci DEFAULT NULL,
  `cxa_valor` FLOAT(9,3) DEFAULT NULL,
  `cxa_criado_em` DATETIME DEFAULT NULL,
  `cxa_criado_por` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cxa_modificado_em` DATETIME DEFAULT NULL,
  `cxa_modificado_por` VARCHAR(50) COLLATE latin1_swedish_ci DEFAULT NULL,
  `cxa_observacao` TEXT COLLATE latin1_swedish_ci,
  PRIMARY KEY USING BTREE (`cxa_id`),
  KEY `con_id` USING BTREE (`con_id`),
  KEY `con_id_2` USING BTREE (`con_id`, `cop_id`),
  KEY `trd_id` USING BTREE (`trd_id`),
  KEY `usu_id` USING BTREE (`usu_id`),
  CONSTRAINT `tab_caixa_fk1` FOREIGN KEY (`con_id`) REFERENCES `tab_contapr` (`con_id`),
  CONSTRAINT `tab_caixa_fk2` FOREIGN KEY (`con_id`, `cop_id`) REFERENCES `tab_contapr_parcela` (`con_id`, `cop_id`),
  CONSTRAINT `tab_caixa_fk3` FOREIGN KEY (`trd_id`) REFERENCES `tab_tipo_receita_despesa` (`trd_id`),
  CONSTRAINT `tab_caixa_fk4` FOREIGN KEY (`usu_id`) REFERENCES `tab_usuario` (`usu_id`)
) ENGINE=InnoDB
AUTO_INCREMENT=19 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Structure for the `tab_empresa` table : */

CREATE TABLE `tab_empresa` (
  `emp_id` INTEGER(11) NOT NULL,
  `emp_razao_social` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `emp_fantasia` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `emp_endereco` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `emp_endereco_cidade` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `emp_tel_contato` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  `emp_tel_contato2` VARCHAR(30) COLLATE latin1_swedish_ci DEFAULT NULL,
  PRIMARY KEY USING BTREE (`emp_id`)
) ENGINE=InnoDB
ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Structure for the `tab_tipo_servico` table : */

CREATE TABLE `tab_tipo_servico` (
  `tps_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `tps_descricao` VARCHAR(100) COLLATE latin1_swedish_ci DEFAULT NULL,
  `tps_valor` FLOAT DEFAULT NULL,
  PRIMARY KEY USING BTREE (`tps_id`)
) ENGINE=InnoDB
AUTO_INCREMENT=4 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Structure for the `tab_ordem_servico_custo` table : */

CREATE TABLE `tab_ordem_servico_custo` (
  `osc_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `ors_id` INTEGER(11) DEFAULT NULL,
  `tps_id` INTEGER(11) DEFAULT NULL,
  `osc_quantidade` INTEGER(11) DEFAULT NULL,
  `osc_valor` FLOAT(9,3) DEFAULT NULL,
  `osc_valor_desconto` FLOAT(9,3) DEFAULT NULL,
  `osc_valor_total` FLOAT(9,3) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`osc_id`),
  KEY `ors_id` USING BTREE (`ors_id`),
  KEY `tps_id` USING BTREE (`tps_id`),
  CONSTRAINT `tab_ordem_servico_custo_fk1` FOREIGN KEY (`ors_id`) REFERENCES `tab_ordem_servico` (`ors_id`),
  CONSTRAINT `tab_ordem_servico_custo_fk2` FOREIGN KEY (`tps_id`) REFERENCES `tab_tipo_servico` (`tps_id`)
) ENGINE=InnoDB
AUTO_INCREMENT=22 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Structure for the `tab_produto` table : */

CREATE TABLE `tab_produto` (
  `pro_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `for_id` INTEGER(11) DEFAULT NULL,
  `pro_nome` VARCHAR(200) COLLATE latin1_swedish_ci DEFAULT NULL,
  `pro_garantia_tempo` INTEGER(11) DEFAULT NULL,
  `pro_garantia_unidade` INTEGER(11) DEFAULT NULL,
  `pro_tipo_produto` CHAR(1) COLLATE latin1_swedish_ci DEFAULT NULL,
  `pro_valor_sugerido` FLOAT(9,3) DEFAULT NULL,
  `pro_valor_sugerido_margem` FLOAT(9,3) DEFAULT NULL,
  `pro_ativo` CHAR(1) COLLATE latin1_swedish_ci DEFAULT NULL,
  `pro_observacao` TEXT COLLATE latin1_swedish_ci,
  PRIMARY KEY USING BTREE (`pro_id`),
  KEY `for_id` USING BTREE (`for_id`),
  CONSTRAINT `tab_produto_fk1` FOREIGN KEY (`for_id`) REFERENCES `tab_fornecedor` (`for_id`)
) ENGINE=InnoDB
AUTO_INCREMENT=2 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Structure for the `tab_ordem_servico_produto` table : */

CREATE TABLE `tab_ordem_servico_produto` (
  `orp_id` INTEGER(11) NOT NULL AUTO_INCREMENT,
  `ors_id` INTEGER(11) DEFAULT NULL,
  `pro_id` INTEGER(11) DEFAULT NULL,
  `orp_quantidade` INTEGER(11) DEFAULT NULL,
  `orp_valor` FLOAT(9,3) DEFAULT NULL,
  `orp_valor_desconto` FLOAT(9,3) DEFAULT NULL,
  `orp_valor_total` FLOAT(9,3) DEFAULT NULL,
  PRIMARY KEY USING BTREE (`orp_id`),
  KEY `ors_id` USING BTREE (`ors_id`),
  KEY `pro_id` USING BTREE (`pro_id`),
  CONSTRAINT `tab_ordem_servico_produto_fk1` FOREIGN KEY (`ors_id`) REFERENCES `tab_ordem_servico` (`ors_id`),
  CONSTRAINT `tab_ordem_servico_produto_fk2` FOREIGN KEY (`pro_id`) REFERENCES `tab_produto` (`pro_id`)
) ENGINE=InnoDB
AUTO_INCREMENT=15 ROW_FORMAT=DYNAMIC CHARACTER SET 'latin1' COLLATE 'latin1_swedish_ci'
;

/* Definition for the `view_ordem_servico` view : */

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `view_ordem_servico`
AS
select
  `ors`.`ors_id` AS `ors_id`,
  `ors`.`cli_id` AS `cli_id`,
  `ors`.`usu_id` AS `usu_id`,
  `ors`.`ors_data_hora` AS `ors_data_hora`,
  `ors`.`ors_valida_ate` AS `ors_valida_ate`,
  `ors`.`ors_finalizada` AS `ors_finalizada`,
  `ors`.`ors_criado_em` AS `ors_criado_em`,
  `ors`.`ors_criado_por` AS `ors_criado_por`,
  `ors`.`ors_modificao_em` AS `ors_modificao_em`,
  `ors`.`ors_modificado_por` AS `ors_modificado_por`,
  `ors`.`ors_valor_produtos` AS `ors_valor_produtos`,
  `ors`.`ors_valor_servicos` AS `ors_valor_servicos`,
  `ors`.`ors_valor_total` AS `ors_valor_total`,
  `ors`.`ors_observacao` AS `ors_observacao`,
  `cli`.`cli_nome` AS `cli_nome`
from
  (`tab_ordem_servico` `ors`
  join `tab_cliente` `cli` on ((`cli`.`cli_id` = `ors`.`cli_id`)));

/* Definition for the `view_ordem_servico_custo` view : */

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `view_ordem_servico_custo`
AS
select
  `ors`.`osc_id` AS `osc_id`,
  `ors`.`ors_id` AS `ors_id`,
  `ors`.`tps_id` AS `tps_id`,
  `ors`.`osc_quantidade` AS `osc_quantidade`,
  `ors`.`osc_valor` AS `osc_valor`,
  `ors`.`osc_valor_desconto` AS `osc_valor_desconto`,
  `ors`.`osc_valor_total` AS `osc_valor_total`,
  `tps`.`tps_descricao` AS `tps_descricao`
from
  (`tab_ordem_servico_custo` `ors`
  join `tab_tipo_servico` `tps` on ((`tps`.`tps_id` = `ors`.`tps_id`)));

/* Definition for the `view_ordem_servico_produto` view : */

CREATE ALGORITHM=UNDEFINED DEFINER='root'@'localhost' SQL SECURITY DEFINER VIEW `view_ordem_servico_produto`
AS
select
  `ors`.`orp_id` AS `orp_id`,
  `ors`.`ors_id` AS `ors_id`,
  `ors`.`pro_id` AS `pro_id`,
  `ors`.`orp_quantidade` AS `orp_quantidade`,
  `ors`.`orp_valor` AS `orp_valor`,
  `ors`.`orp_valor_desconto` AS `orp_valor_desconto`,
  `ors`.`orp_valor_total` AS `orp_valor_total`,
  `pro`.`pro_nome` AS `pro_nome`
from
  (`tab_ordem_servico_produto` `ors`
  join `tab_produto` `pro` on ((`pro`.`pro_id` = `ors`.`pro_id`)));

/* Data for the `tab_cliente` table  (LIMIT 0,500) */

INSERT INTO `tab_cliente` (`cli_id`, `cli_nome`, `cli_cpf`, `cli_ativo`, `cli_contato_telefone1`, `cli_contato_telefone1_observacao`, `cli_contato_telefone2`, `cli_contato_telefone2_observacao`, `cli_contato_telefone3`, `cli_contato_telefone3_observacao`) VALUES
  (1,'GILBERTO SANCHES CRUZ','04616372942','S','(44) 96340-9553','TESTE','','','',''),
  (2,'RAFAEL','0','S','(11) 11111-1111','','','','','');
COMMIT;

/* Data for the `tab_fornecedor` table  (LIMIT 0,500) */

INSERT INTO `tab_fornecedor` (`for_id`, `for_nome`, `for_cnpj`, `for_ativo`) VALUES
  (1,'FORNECEDOR PADRAO','0','S');
COMMIT;

/* Data for the `tab_usuario` table  (LIMIT 0,500) */

INSERT INTO `tab_usuario` (`usu_id`, `usu_nome_acesso`, `usu_senha_acesso`, `usu_nome_completo`, `usu_email`, `usu_avatar`, `usu_ativo`, `usu_administrador`) VALUES
  (1,'gilberto','WjNOak1Ua3hNamd6','GILBERTO SANCHES CRUZ','gilbertoscruz@gmail.com','avatar5.png',0,'S');
COMMIT;

/* Data for the `tab_ordem_servico` table  (LIMIT 0,500) */

INSERT INTO `tab_ordem_servico` (`ors_id`, `cli_id`, `usu_id`, `ors_data_hora`, `ors_valida_ate`, `ors_finalizada`, `ors_criado_em`, `ors_criado_por`, `ors_modificao_em`, `ors_modificado_por`, `ors_valor_produtos`, `ors_valor_servicos`, `ors_valor_total`, `ors_observacao`) VALUES
  (1,1,1,'2018-03-28','2018-03-30','S','2018-03-28 00:00:00',NULL,'2018-04-10 00:53:46','gilberto',40,0,40,'OBS'),
  (2,1,1,'2018-04-04','2018-05-04','S','2018-04-04 14:02:45','','2018-04-09 18:49:12','gilberto',20,0,20,'teste de ordem de servico'),
  (3,NULL,1,'2018-04-09','2018-05-09','S','2018-04-09 19:28:00','gilberto','2018-04-10 00:52:11','gilberto',100,105.1,205.1,''),
  (4,1,1,'2018-05-04','2018-06-03','S','2018-05-04 11:02:27','gilberto','2018-05-04 11:02:46','gilberto',20,25,45,'');
COMMIT;

/* Data for the `tab_contapr` table  (LIMIT 0,500) */

INSERT INTO `tab_contapr` (`con_id`, `cli_id`, `for_id`, `usu_id`, `ors_id`, `con_data`, `con_tipo`, `con_criado_em`, `con_criado_por`, `con_modificao_em`, `con_modificado_por`, `con_valor_documento`, `con_observacao`) VALUES
  (2,1,NULL,1,NULL,'2018-04-09','R','2018-04-10 00:43:28','gilberto',NULL,'',10,' asdasdasd as das das dasd asdas da'),
  (6,1,NULL,1,1,'2018-04-10','R','2018-04-10 00:47:01','gilberto',NULL,'',40,'asda sdsd asas dasd'),
  (7,1,NULL,1,3,'2018-04-10','R','2018-04-10 00:51:59','gilberto',NULL,'',205.1,'asdsad'),
  (8,1,NULL,1,3,'2018-04-10','R','2018-04-10 00:52:10','gilberto',NULL,'',205.1,'asdasd'),
  (9,1,NULL,1,1,'2018-04-10','R','2018-04-10 00:53:46','gilberto',NULL,'',40,'asdasd'),
  (10,1,NULL,1,NULL,'2018-04-10','R','2018-04-10 14:54:07','gilberto',NULL,'',50.01,'asdasd'),
  (11,1,NULL,1,NULL,'2018-04-10','R','2018-04-10 15:02:03','gilberto',NULL,'',1500,'asdasd'),
  (12,1,NULL,1,NULL,'2018-04-10','R','2018-04-10 15:08:24','gilberto',NULL,'',50,'asd'),
  (13,1,NULL,1,NULL,'2018-05-03','R','2018-05-03 21:19:02','gilberto',NULL,'',500,'dsf sdfs fas sdf asdfdsafads fdsa sd fasd'),
  (14,1,NULL,1,4,'2018-05-04','R','2018-05-04 11:02:46','gilberto',NULL,'',45,''),
  (15,1,NULL,1,NULL,'2018-05-20','R','2018-05-20 17:01:38','gilberto',NULL,'',500,''),
  (16,NULL,NULL,1,NULL,'2018-05-25','P','2018-05-25 23:56:01','gilberto',NULL,'',50,'teste de pagamentos'),
  (17,NULL,1,1,NULL,'2018-05-25','P','2018-05-25 23:56:17','gilberto',NULL,'',50,'teste de pagamentos'),
  (18,NULL,1,1,NULL,'2018-05-25','P','2018-05-25 23:56:40','gilberto',NULL,'',50,'teste de pagamentos'),
  (19,NULL,1,1,NULL,'2018-05-25','P','2018-05-25 23:57:33','gilberto',NULL,'',50,'teste de pagamentos');
COMMIT;

/* Data for the `tab_contapr_parcela` table  (LIMIT 0,500) */

INSERT INTO `tab_contapr_parcela` (`cop_id`, `con_id`, `cop_parcela`, `cop_valor`, `cop_valor_juros`, `cop_valor_multa`, `cop_data_vencimento`, `cop_data_pagamento`, `cop_modificado_em`, `cop_modificado_por`, `cop_observacao`) VALUES
  (1,2,1,10.000,NULL,NULL,'2018-04-09','2018-05-20','2018-05-20 16:59:59','gilberto',NULL),
  (7,6,1,8.000,NULL,NULL,'2018-05-10','2018-05-25','2018-05-25 23:33:24','gilberto',NULL),
  (8,6,2,8.000,NULL,NULL,'2018-06-11','2018-05-25','2018-05-25 23:35:02','gilberto',NULL),
  (9,6,3,8.000,NULL,NULL,'2018-07-10','2018-05-25','2018-05-25 23:38:36','gilberto','sdas asd asdas dsaffffffffffffffffffffffffffff4444444444444444444444444444444444444'),
  (10,6,4,8.000,NULL,NULL,'2018-08-10',NULL,NULL,NULL,NULL),
  (11,6,5,8.000,NULL,NULL,'2018-09-10',NULL,NULL,NULL,NULL),
  (12,7,1,102.550,0,0,'2018-05-10',NULL,NULL,NULL,NULL),
  (13,7,2,102.550,0,0,'2018-06-11',NULL,NULL,NULL,NULL),
  (14,8,1,102.550,0,0,'2018-05-10',NULL,NULL,NULL,NULL),
  (15,8,2,102.550,0,0,'2018-06-11',NULL,NULL,NULL,NULL),
  (16,9,1,40.000,0,0,'2018-05-10',NULL,NULL,NULL,NULL),
  (17,10,1,16.670,0,0,'2018-05-10','2018-04-12','2018-04-12 00:41:41','gilberto',NULL),
  (18,10,2,16.670,0,0,'2018-06-11','2018-04-12','2018-04-12 00:44:37','gilberto',NULL),
  (19,10,3,16.670,0,0,'2018-07-10','2018-05-03','2018-05-03 21:14:45','gilberto',NULL),
  (20,11,1,750.000,0,0,'2018-05-10','2018-04-12','2018-04-12 00:33:33','gilberto',NULL),
  (21,11,2,750.000,0,0,'2018-06-11','2018-04-12','2018-04-12 00:37:02','gilberto',NULL),
  (22,12,1,50.000,0,0,'2018-05-10','1969-12-31','2018-04-12 00:30:37','gilberto',NULL),
  (23,13,1,100.000,0,0,'2018-06-04','2018-05-03','2018-05-03 21:19:17','gilberto',NULL),
  (24,13,2,100.000,0,0,'2018-07-03','2018-05-03','2018-05-03 22:07:41','gilberto',NULL),
  (25,13,3,100.000,0,0,'2018-08-03','2018-05-20','2018-05-20 16:57:33','gilberto',NULL),
  (26,13,4,100.000,0,0,'2018-09-03',NULL,NULL,NULL,NULL),
  (27,13,5,100.000,0,0,'2018-10-03',NULL,NULL,NULL,NULL),
  (28,14,1,22.500,0,0,'2018-06-04','2018-05-04','2018-05-04 11:03:05','gilberto',NULL),
  (29,14,2,22.500,0,0,'2018-07-04','2018-05-04','2018-05-04 11:03:22','gilberto',NULL),
  (30,15,1,166.670,0,0,'2018-06-20',NULL,NULL,NULL,NULL),
  (31,15,2,166.670,0,0,'2018-07-20',NULL,NULL,NULL,NULL),
  (32,15,3,166.670,0,0,'2018-08-20',NULL,NULL,NULL,NULL),
  (33,16,1,25.000,0,0,'2018-06-25',NULL,NULL,NULL,NULL),
  (34,16,2,25.000,0,0,'2018-07-25',NULL,NULL,NULL,NULL),
  (35,17,1,25.000,0,0,'2018-06-25',NULL,NULL,NULL,NULL),
  (36,17,2,25.000,0,0,'2018-07-25',NULL,NULL,NULL,NULL),
  (37,18,1,25.000,0,0,'2018-06-25',NULL,NULL,NULL,NULL),
  (38,18,2,25.000,0,0,'2018-07-25',NULL,NULL,NULL,NULL),
  (39,19,1,25.000,0,0,'2018-06-25','2018-05-26','2018-05-26 00:06:21','gilberto','teste de pagamentos'),
  (40,19,2,25.000,0,0,'2018-07-25',NULL,NULL,NULL,NULL);
COMMIT;

/* Data for the `tab_tipo_receita_despesa` table  (LIMIT 0,500) */

INSERT INTO `tab_tipo_receita_despesa` (`trd_id`, `trd_nome`, `trd_tipo`) VALUES
  (1,'RECEITAS GERAIS','R'),
  (2,'DESPESAS GERAIS','D'),
  (3,'ALUGUEL','D'),
  (4,'ALIMENTAÇÃO','D');
COMMIT;

/* Data for the `tab_caixa` table  (LIMIT 0,500) */

INSERT INTO `tab_caixa` (`cxa_id`, `con_id`, `cop_id`, `trd_id`, `usu_id`, `cxa_data`, `cxa_tipo`, `cxa_valor`, `cxa_criado_em`, `cxa_criado_por`, `cxa_modificado_em`, `cxa_modificado_por`, `cxa_observacao`) VALUES
  (2,12,22,1,1,'2018-04-12','C',50.000,'2018-04-12 00:30:39','gilberto',NULL,NULL,'baixa de parcela'),
  (3,11,20,1,1,'2018-04-12','C',750.000,'2018-04-12 00:33:36','gilberto',NULL,NULL,'asdasd sfsd dfsf sdfsdfsdf dsfa dfs df'),
  (4,11,21,1,1,'2018-04-12','C',750.000,'2018-04-12 00:37:03','gilberto',NULL,NULL,'asdasd fdfa fdf dsafasfd'),
  (5,10,17,1,1,'2018-04-12','C',16.670,'2018-04-12 00:41:41','gilberto',NULL,NULL,'asdasd a sfds fadsfsdfasd fsdfsdfds f'),
  (6,10,18,1,1,'2018-04-12','C',16.670,'2018-04-12 00:44:37','gilberto',NULL,NULL,'asdasd ada dasdasdasdasdsafasdfdsf dsfds'),
  (7,10,19,1,1,'2018-05-03','C',16.670,'2018-05-03 21:14:45','gilberto',NULL,NULL,'asdasd sdfs dfsdfsddsf sf'),
  (8,13,23,1,1,'2018-05-03','C',100.000,'2018-05-03 21:19:17','gilberto',NULL,NULL,'dsf sdfs fas sdf asdfdsafads fdsa sd fasd'),
  (9,13,24,1,1,'2018-05-03','C',100.000,'2018-05-03 22:07:41','gilberto',NULL,NULL,'dsf sdfs fas sdf asdfdsafads fdsa sd fasd'),
  (10,14,28,1,1,'2018-05-04','C',22.500,'2018-05-04 11:03:05','gilberto',NULL,NULL,'a asddasd asda sds as dasd asd asd'),
  (11,14,29,1,1,'2018-05-04','C',22.500,'2018-05-04 11:03:22','gilberto',NULL,NULL,'d asd das dasd asasas das'),
  (12,13,25,1,1,'2018-05-20','C',100.000,'2018-05-20 16:57:33','gilberto',NULL,NULL,'dsf sdfs fas sdf asdfdsafads fdsa sd fasd'),
  (13,2,1,1,1,'2018-05-20','C',10.000,'2018-05-20 16:59:59','gilberto',NULL,NULL,' asdasdasd as das das dasd asdas da'),
  (14,6,7,1,1,'2018-05-25','C',8.000,'2018-05-25 23:33:24','gilberto',NULL,NULL,'asda sdsd asas dasd asdsa dasdasd'),
  (15,6,8,1,1,'2018-05-25','C',8.000,'2018-05-25 23:35:02','gilberto',NULL,NULL,'asda sdsd asas dasd as asdsadsadas'),
  (16,6,9,1,1,'2018-05-25','C',8.000,'2018-05-25 23:38:24','gilberto',NULL,NULL,'sdas asd asdas dsaffffffffffffffffffffffffffff4444444444444444444444444444444444444'),
  (17,6,9,1,1,'2018-05-25','C',8.000,'2018-05-25 23:38:36','gilberto',NULL,NULL,'sdas asd asdas dsaffffffffffffffffffffffffffff4444444444444444444444444444444444444'),
  (18,19,39,1,1,'2018-05-26','D',25.000,'2018-05-26 00:06:21','gilberto',NULL,NULL,'teste de pagamentos');
COMMIT;

/* Data for the `tab_tipo_servico` table  (LIMIT 0,500) */

INSERT INTO `tab_tipo_servico` (`tps_id`, `tps_descricao`, `tps_valor`) VALUES
  (1,'LIMPEZA DO AR CONDICIONADO',10.51),
  (2,'FILTRO DO AR CONDICIONADO',25),
  (3,'TROCA DE FILTRO DE AGUA',5);
COMMIT;

/* Data for the `tab_ordem_servico_custo` table  (LIMIT 0,500) */

INSERT INTO `tab_ordem_servico_custo` (`osc_id`, `ors_id`, `tps_id`, `osc_quantidade`, `osc_valor`, `osc_valor_desconto`, `osc_valor_total`) VALUES
  (20,3,1,10,10.510,0.000,105.100),
  (21,4,2,1,25.000,0.000,25.000);
COMMIT;

/* Data for the `tab_produto` table  (LIMIT 0,500) */

INSERT INTO `tab_produto` (`pro_id`, `for_id`, `pro_nome`, `pro_garantia_tempo`, `pro_garantia_unidade`, `pro_tipo_produto`, `pro_valor_sugerido`, `pro_valor_sugerido_margem`, `pro_ativo`, `pro_observacao`) VALUES
  (1,1,'PRODUTO TESTE',1,1,'P',20.000,50.000,'S','OBSERVACAO');
COMMIT;

/* Data for the `tab_ordem_servico_produto` table  (LIMIT 0,500) */

INSERT INTO `tab_ordem_servico_produto` (`orp_id`, `ors_id`, `pro_id`, `orp_quantidade`, `orp_valor`, `orp_valor_desconto`, `orp_valor_total`) VALUES
  (10,1,1,2,20.000,0.000,40.000),
  (12,2,1,1,20.000,0.000,20.000),
  (13,3,1,5,20.000,0.000,100.000),
  (14,4,1,1,20.000,0.000,20.000);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;