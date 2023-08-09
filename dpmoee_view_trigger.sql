/*
SQLyog Community v13.2.0 (64 bit)
MySQL - 8.0.30 : Database - db_dpmoee
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_dpmoee` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_dpmoee`;

/* Trigger structure for table `loghistory` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trigger_oee` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trigger_oee` BEFORE INSERT ON `loghistory` FOR EACH ROW BEGIN
	SET @line_id = (SELECT `line_id` FROM `mmachines` WHERE `id` = new.machine_id LIMIT 1);
	SET @check_daily = (SELECT
		COUNT(id) FROM mdailyactivities
		WHERE line_id = @line_id 
		AND DATE_FORMAT(NOW(), '%h:%i') BETWEEN `tmstart` AND `tmfinish`);
	IF(@check_daily < 1) THEN
		SET @check_oee = (SELECT line_id FROM moee WHERE line_id = @line_id ORDER BY id DESC LIMIT 1);
		SET @last_status = (select `status` FROM `loghistory` where machine_id = new.machine_id order by id desc limit 1);
		call oee_shifts(@shift);
		IF(new.name = 'STATUS') THEN
			IF((@last_status = new.status) AND @check_oee is not null) THEN
				call update_durasi(@line_id);
			ELSE
				call insert_durasi(@line_id, new.status, (SELECT @shift));
			END if;
		ELSEIF(new.name = 'COUNTING') THEN
			call update_counting(@line_id, new.status);
		ELSE
			CALL update_reject(@line_id, new.status);
		END if;
	END IF;
    END */$$


DELIMITER ;

/* Trigger structure for table `mconfig` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trigger_mconfig` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trigger_mconfig` BEFORE INSERT ON `mconfig` FOR EACH ROW BEGIN
	SET @hitung = (SELECT COUNT(*)+1 FROM mconfig);
	IF(@hitung < 10) THEN
		SET new.config_id = CONCAT('00',@hitung);
	ELSEIF(@hitung < 100) THEN
		SET new.config_id = CONCAT('0',@hitung);
	ELSE
		SET new.config_id = @hitung;
	END IF;
    END */$$


DELIMITER ;

/* Trigger structure for table `mline` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trigger_line` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trigger_line` BEFORE INSERT ON `mline` FOR EACH ROW BEGIN
	SET @jumlah = (SELECT id FROM mline ORDER BY id DESC LIMIT 1);
	IF(@jumlah) THEN
		SET new.id = @jumlah+1;
	ELSE
		SET new.id = 1;
	END IF;
    END */$$


DELIMITER ;

/* Trigger structure for table `mplanorder` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trigger_planorder` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trigger_planorder` BEFORE INSERT ON `mplanorder` FOR EACH ROW BEGIN
	SET @tgl = CONVERT(CONCAT(DATE_FORMAT(NOW(),'%y%m%d')), UNSIGNED);
	SET @datecode = CONVERT(LEFT(SUBSTRING_INDEX((SELECT txtbatchcode FROM `mplanorder` ORDER BY txtbatchcode DESC LIMIT 1),"-",-1), 6), UNSIGNED);
	SET @hitung = CONVERT(SUBSTR(SUBSTRING_INDEX((SELECT txtbatchcode FROM `mplanorder` ORDER BY txtbatchcode DESC LIMIT 1),"-",-1), 7, 4), UNSIGNED) + 1;
	    IF (LEFT(@tgl, 4)  = LEFT(@datecode, 4)) THEN
		IF (@hitung < 10) THEN
		    SET new.txtbatchcode = CONCAT('DPM-ORDER-', @tgl,'00',@hitung);
		ELSEIF (@hitung < 100) THEN
		    SET new.txtbatchcode = CONCAT('DPM-ORDER-', @tgl,'0',@hitung);
		ELSE
		    SET new.txtbatchcode = CONCAT('DPM-ORDER-', @tgl, @hitung);
		END IF;
	    ELSE
		SET new.txtbatchcode = CONCAT("DPM-ORDER-",@tgl,"001");
	    END IF;
    END */$$


DELIMITER ;

/* Trigger structure for table `mworkingtime` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trigger_shift_code` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `trigger_shift_code` BEFORE INSERT ON `mworkingtime` FOR EACH ROW BEGIN
	set @jumlah = (SELECT id from mworkingtime order by id desc limit 1);
	if(@jumlah) then
		set new.id = @jumlah+1;
	else
		set new.id = 1;
	end if;
    END */$$


DELIMITER ;

/* Procedure structure for procedure `insert_durasi` */

/*!50003 DROP PROCEDURE IF EXISTS  `insert_durasi` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_durasi`(IN `line` BIGINT, IN `new_status` INT, IN `shift_id` BIGINT)
BEGIN
		declare last_start time;
		declare act_id bigint;
		declare part VARCHAR(64);
		SELECT `part_number` INTO part
			FROM v_part_running
			WHERE zone = (SELECT
			`variable`
			FROM mconfig
			WHERE `description` = (SELECT
			txtlinename
			FROM mline
			WHERE id = `line`));
		SELECT `finish` INTO last_start FROM moee WHERE line_id = line ORDER BY id DESC LIMIT 1;
		SELECT `id` into act_id from mactivitycode
			WHERE line_id = line
			and txtcategory = 'pr'
			limit 1;
		if(last_start is null OR last_start = '') then
			IF(new_status = 1) THEN
				INSERT INTO moee (line_id, shift_id, tanggal, `start`, `finish`, lamakejadian, part_number, activity_id) VALUES
				(line, shift_id, DATE_FORMAT(NOW(), '%Y-%m-%d'), DATE_FORMAT(NOW(), '%k:%i:%s'),
				ADDTIME(DATE_FORMAT(NOW(), '%k:%i:%s'), 1), 1, part, act_id);
			ELSE
				INSERT INTO moee (line_id, shift_id, tanggal, `start`, `finish`, lamakejadian, part_number) VALUES
				(line, shift_id, DATE_FORMAT(NOW(), '%Y-%m-%d'), DATE_FORMAT(NOW(), '%k:%i:%s'),
				ADDTIME(DATE_FORMAT(NOW(), '%k:%i:%s'), 1), 1, part, 14);
			END IF;
		else
			IF(new_status = 1) THEN
				INSERT INTO moee (line_id, shift_id, tanggal, `start`, `finish`, lamakejadian, part_number, activity_id) VALUES
				(line, shift_id, DATE_FORMAT(NOW(), '%Y-%m-%d'), last_start, ADDTIME(last_start, 1), 1, part, act_id);
			ELSE
				INSERT INTO moee (line_id, shift_id, tanggal, `start`, `finish`, lamakejadian, part_number) VALUES
				(line, shift_id, DATE_FORMAT(NOW(), '%Y-%m-%d'), last_start, ADDTIME(last_start, 1), 1, part, 14);
			END IF;
		end if;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `oee_shifts` */

/*!50003 DROP PROCEDURE IF EXISTS  `oee_shifts` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `oee_shifts`(OUT `shift_id` BIGINT)
BEGIN
		declare hasil1 bigint;
		SELECT id into hasil1
		FROM mworkingtime
		WHERE TIMESTAMP(CURDATE(), TIME(NOW()))
		BETWEEN TIMESTAMP(CURDATE(), tmstart) AND TIMESTAMP(ADDDATE(CURDATE(), intinterval), tmfinish);
		IF(hasil1 is not null) then
			SELECT id INTO shift_id
			FROM mworkingtime
			WHERE TIMESTAMP(CURDATE(), TIME(NOW()))
			BETWEEN TIMESTAMP(CURDATE(), tmstart) AND TIMESTAMP(ADDDATE(CURDATE(), intinterval), tmfinish);
		else
			SELECT id INTO shift_id
			FROM mworkingtime
			WHERE TIMESTAMP(CURDATE(), TIME(NOW()))
			BETWEEN TIMESTAMP(SUBDATE(CURDATE(), INTERVAL intinterval DAY), tmstart) AND TIMESTAMP(CURDATE(), tmfinish);
		end if;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `update_counting` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_counting` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_counting`(IN `line` BIGINT, IN `counting` INT)
BEGIN
		UPDATE moee SET output = (output+counting) WHERE line_id = line ORDER BY id DESC LIMIT 1;
	END */$$
DELIMITER ;

/* Procedure structure for procedure `update_durasi` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_durasi` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_durasi`(IN `line` BIGINT)
BEGIN
	UPDATE moee SET lamakejadian = (lamakejadian+1), finish = addtime(finish, 1) WHERE line_id = line ORDER BY id DESC LIMIT 1;
END */$$
DELIMITER ;

/* Procedure structure for procedure `update_reject` */

/*!50003 DROP PROCEDURE IF EXISTS  `update_reject` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `update_reject`(IN `line` BIGINT, IN `counting` INT)
BEGIN
		UPDATE moee SET reject = (reject+counting) WHERE line_id = line ORDER BY id DESC LIMIT 1;
	END */$$
DELIMITER ;

/*Table structure for table `v_calc_poe` */

DROP TABLE IF EXISTS `v_calc_poe`;

/*!50001 DROP VIEW IF EXISTS `v_calc_poe` */;
/*!50001 DROP TABLE IF EXISTS `v_calc_poe` */;

/*!50001 CREATE TABLE  `v_calc_poe`(
 `id` bigint unsigned ,
 `line_id` bigint unsigned ,
 `tanggal` date ,
 `shift_id` bigint ,
 `txtbatchcode` varchar(64) ,
 `item_id` int ,
 `ct` int ,
 `actual_speed` decimal(10,2) ,
 `speed_loss` decimal(10,2) ,
 `defect_loss` decimal(10,2) ,
 `downtime_loss` decimal(35,0) ,
 `total_mi` decimal(32,0) ,
 `total_sh` decimal(32,0) ,
 `total_downtime` decimal(34,0) ,
 `working_time` decimal(32,0) ,
 `loading_time` decimal(33,0) ,
 `operating_time` decimal(32,0) ,
 `net_optime` decimal(35,2) ,
 `value_adding` decimal(39,5) ,
 `ar` decimal(10,2) ,
 `pr` decimal(10,2) ,
 `qr` decimal(10,2) ,
 `oee` decimal(10,2) ,
 `total_output` decimal(10,0) ,
 `utilization_rate` decimal(10,2) 
)*/;

/*Table structure for table `v_part_running` */

DROP TABLE IF EXISTS `v_part_running`;

/*!50001 DROP VIEW IF EXISTS `v_part_running` */;
/*!50001 DROP TABLE IF EXISTS `v_part_running` */;

/*!50001 CREATE TABLE  `v_part_running`(
 `id` int unsigned ,
 `pos_id` int ,
 `epc_no` varchar(50) ,
 `sap_id` varchar(50) ,
 `part_number` varchar(50) ,
 `part_name` varchar(50) ,
 `ct` int ,
 `qty` int ,
 `zone` varchar(50) 
)*/;

/*Table structure for table `v_shift_oee` */

DROP TABLE IF EXISTS `v_shift_oee`;

/*!50001 DROP VIEW IF EXISTS `v_shift_oee` */;
/*!50001 DROP TABLE IF EXISTS `v_shift_oee` */;

/*!50001 CREATE TABLE  `v_shift_oee`(
 `id` bigint unsigned ,
 `line_id` int ,
 `shift_id` int ,
 `tanggal` date ,
 `ct` int ,
 `working_time` decimal(36,4) ,
 `operating_time` decimal(37,4) ,
 `total_mi` decimal(36,4) ,
 `total_sh` decimal(36,4) ,
 `total_downtime` decimal(36,4) ,
 `capacity` decimal(10,2) ,
 `avaibility_rate` decimal(10,2) ,
 `performance_rate` decimal(10,2) ,
 `quality_rate` decimal(10,2) ,
 `utilization` decimal(10,2) 
)*/;

/*View structure for view v_calc_poe */

/*!50001 DROP TABLE IF EXISTS `v_calc_poe` */;
/*!50001 DROP VIEW IF EXISTS `v_calc_poe` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_calc_poe` AS select `v_oee_daily`.`id` AS `id`,`v_oee_daily`.`line_id` AS `line_id`,`v_oee_daily`.`tanggal` AS `tanggal`,`v_oee_daily`.`shift_id` AS `shift_id`,`v_oee_daily`.`txtbatchcode` AS `txtbatchcode`,`v_oee_daily`.`item_id` AS `item_id`,`v_oee_daily`.`ct` AS `ct`,`v_oee_daily`.`actual_speed` AS `actual_speed`,`v_oee_daily`.`speed_loss` AS `speed_loss`,`v_oee_daily`.`defect_loss` AS `defect_loss`,`v_oee_daily`.`downtime_loss` AS `downtime_loss`,`v_oee_daily`.`total_mi` AS `total_mi`,`v_oee_daily`.`total_sh` AS `total_sh`,`v_oee_daily`.`total_downtime` AS `total_downtime`,`v_oee_daily`.`working_time` AS `working_time`,`v_oee_daily`.`loading_time` AS `loading_time`,`v_oee_daily`.`operating_time` AS `operating_time`,`v_oee_daily`.`net_optime` AS `net_optime`,`v_oee_daily`.`value_adding` AS `value_adding`,`v_oee_daily`.`avaibility_rate` AS `ar`,`v_oee_daily`.`performance_rate` AS `pr`,`v_oee_daily`.`quality_rate` AS `qr`,cast(((((`v_oee_daily`.`avaibility_rate` / 100) * (`v_oee_daily`.`performance_rate` / 100)) * (`v_oee_daily`.`quality_rate` / 100)) * 100) as decimal(10,2)) AS `oee`,`v_oee_daily`.`total_output` AS `total_output`,cast(((`v_oee_daily`.`loading_time` / `v_oee_daily`.`working_time`) * 100) as decimal(10,2)) AS `utilization_rate` from `v_oee_daily` */;

/*View structure for view v_part_running */

/*!50001 DROP TABLE IF EXISTS `v_part_running` */;
/*!50001 DROP VIEW IF EXISTS `v_part_running` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_part_running` AS select max(`kanban_in`.`id`) AS `id`,`kanban_in`.`pos_id` AS `pos_id`,`kanban_in`.`epc_no` AS `epc_no`,`kanban`.`sap_id` AS `sap_id`,`item`.`part_number` AS `part_number`,`item`.`part_name` AS `part_name`,`item`.`ct` AS `ct`,`kanban_in`.`qty` AS `qty`,substring_index(substring_index(`kanban`.`zone`,' ',2),' ',-(1)) AS `zone` from ((`tbl_tr_kanban_pw_in` `kanban_in` join `tb_m_kanban` `kanban` on((`kanban`.`epc` = `kanban_in`.`epc_no`))) join `tb_m_item_parts` `item` on((`item`.`sap_id` = `kanban`.`sap_id`))) group by `kanban`.`zone` */;

/*View structure for view v_shift_oee */

/*!50001 DROP TABLE IF EXISTS `v_shift_oee` */;
/*!50001 DROP VIEW IF EXISTS `v_shift_oee` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_shift_oee` AS select `moee`.`id` AS `id`,`moee`.`line_id` AS `line_id`,`moee`.`shift_id` AS `shift_id`,`moee`.`tanggal` AS `tanggal`,`item`.`ct` AS `ct`,(sum(`moee`.`lamakejadian`) / 60) AS `working_time`,((sum(`moee`.`lamakejadian`) / 60) - sum((case when (`mact`.`txtcategory` <> 'pr') then (`moee`.`lamakejadian` / 60) else 0 end))) AS `operating_time`,sum((case when (`mact`.`txtcategory` = 'mi') then (`moee`.`lamakejadian` / 60) else 0 end)) AS `total_mi`,sum((case when (`mact`.`txtcategory` = 'sh') then (`moee`.`lamakejadian` / 60) else 0 end)) AS `total_sh`,sum((case when (`mact`.`txtcategory` <> 'pr') then (`moee`.`lamakejadian` / 60) else 0 end)) AS `total_downtime`,cast((((sum(`moee`.`lamakejadian`) / 60) - sum((case when (`mact`.`txtcategory` <> 'pr') then (`moee`.`lamakejadian` / 60) else 0 end))) / `item`.`ct`) as decimal(10,2)) AS `capacity`,cast(((((sum(`moee`.`lamakejadian`) / 60) - sum((case when (`mact`.`txtcategory` <> 'pr') then (`moee`.`lamakejadian` / 60) else 0 end))) / (sum(`moee`.`lamakejadian`) / 60)) * 100) as decimal(10,2)) AS `avaibility_rate`,cast(((((`item`.`ct` / 60) * sum(`moee`.`output`)) / ((sum(`moee`.`lamakejadian`) / 60) - sum((case when (`mact`.`txtcategory` <> 'pr') then (`moee`.`lamakejadian` / 60) else 0 end)))) * 100) as decimal(10,2)) AS `performance_rate`,cast((((sum(`moee`.`output`) - sum(`moee`.`reject`)) / sum(`moee`.`output`)) * 100) as decimal(10,2)) AS `quality_rate`,cast((((`moee`.`working_time` - sum((case when (`mact`.`txtcategory` <> 'pr') then (`moee`.`lamakejadian` / 60) else 0 end))) / `item`.`ct`) * 100) as decimal(10,2)) AS `utilization` from ((`moee` left join `tb_m_item_parts` `item` on((`item`.`part_number` = `moee`.`part_number`))) left join `mactivitycode` `mact` on((`mact`.`id` = `moee`.`activity_id`))) group by `moee`.`shift_id`,`moee`.`tanggal` */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
