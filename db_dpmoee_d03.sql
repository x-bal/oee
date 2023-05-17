-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 25, 2022 at 10:40 AM
-- Server version: 5.7.33
-- PHP Version: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_dpmoee`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_durasi` (IN `line` BIGINT)   BEGIN
		declare last_start time;
		SELECT `finish` INTO last_start FROM oee WHERE line_id = line ORDER BY id DESC LIMIT 1;
		if(last_start is null OR last_start = '') then
			INSERT INTO oee (line_id, shift_id, tanggal, `start`, `finish`, lamakejadian) VALUES
			(line, 1, DATE_FORMAT(NOW(), '%Y-%m-%d'), DATE_FORMAT(NOW(), '%k:%i:%s'), ADDTIME(DATE_FORMAT(NOW(), '%k:%i:%s'), 1), 1);			
		else
			INSERT INTO oee (line_id, shift_id, tanggal, `start`, `finish`, lamakejadian) VALUES
			(line, 1, DATE_FORMAT(NOW(), '%Y-%m-%d'), last_start, ADDTIME(last_start, 1), 1);
		end if;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_counting` (IN `line` BIGINT, IN `counting` INT)   BEGIN
		UPDATE oee SET finish_good = (finish_good+counting) WHERE line_id = line ORDER BY id DESC LIMIT 1;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_durasi` (IN `line` BIGINT)   BEGIN
	UPDATE oee SET lamakejadian = (lamakejadian+1), finish = addtime(finish, 1) WHERE line_id = line ORDER BY id DESC LIMIT 1;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_reject` (IN `line` BIGINT, IN `counting` INT)   BEGIN
		UPDATE oee SET reject = (reject+counting) WHERE line_id = line ORDER BY id DESC LIMIT 1;
	END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `failed_jobs`
--

INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(1, '6f6678b3-6dcd-4261-943f-b320666069dc', 'database', 'default', '{\"uuid\":\"6f6678b3-6dcd-4261-943f-b320666069dc\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":10:{s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Events\\MqttSubscribe has been attempted too many times or run too long. The job may have previously timed out. in C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php:750\nStack trace:\n#0 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(504): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#1 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(418): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 1)\n#2 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#3 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(329): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#4 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(117): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#6 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#7 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#8 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#9 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#10 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#11 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#12 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#13 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#15 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 C:\\laragon\\www\\oee_kmi\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 {main}', '2022-10-15 06:02:01'),
(2, 'd770de29-f5a8-43e9-a328-9be728a40d48', 'database', 'default', '{\"uuid\":\"d770de29-f5a8-43e9-a328-9be728a40d48\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":10:{s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Events\\MqttSubscribe has been attempted too many times or run too long. The job may have previously timed out. in C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php:750\nStack trace:\n#0 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(504): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#1 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(418): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 1)\n#2 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#3 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(329): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#4 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(117): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#6 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#7 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#8 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#9 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#10 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#11 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#12 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#13 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#15 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 C:\\laragon\\www\\oee_kmi\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 {main}', '2022-10-15 06:05:47'),
(3, '1a56b772-20b4-4e05-9256-6b66d5b45f78', 'database', 'default', '{\"uuid\":\"1a56b772-20b4-4e05-9256-6b66d5b45f78\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Undefined index: qos in C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php:173\nStack trace:\n#0 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(173): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(8, \'Undefined index...\', \'C:\\\\laragon\\\\www\\\\...\', 173, Array)\n#1 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(273): Salman\\Mqtt\\MqttClass\\MqttService->subscribe(Array)\n#2 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\Mqtt.php(114): Salman\\Mqtt\\MqttClass\\MqttService->proc()\n#3 C:\\laragon\\www\\oee_kmi\\app\\Events\\MqttSubscribe.php(37): Salman\\Mqtt\\MqttClass\\Mqtt->ConnectAndSubscribe(\'test/topic/mesi...\', Object(Closure), 7068)\n#4 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Events\\MqttSubscribe->handle()\n#5 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#6 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#7 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#8 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#9 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#10 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Events\\MqttSubscribe))\n#11 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#12 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#13 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(120): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Events\\MqttSubscribe), false)\n#14 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Events\\MqttSubscribe))\n#15 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#16 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#17 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Events\\MqttSubscribe))\n#18 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#19 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#20 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#21 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(329): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#22 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(117): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#23 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#24 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#25 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#26 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#27 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#28 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#29 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#30 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#31 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#32 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 C:\\laragon\\www\\oee_kmi\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 {main}', '2022-10-15 06:07:23'),
(4, 'a1cf9619-053a-4060-a00e-600d7d8ec807', 'database', 'default', '{\"uuid\":\"a1cf9619-053a-4060-a00e-600d7d8ec807\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Events\\MqttSubscribe has been attempted too many times or run too long. The job may have previously timed out. in C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php:750\nStack trace:\n#0 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(504): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#1 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(418): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 1)\n#2 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#3 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(329): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#4 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(117): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#6 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#7 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#8 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#9 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#10 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#11 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#12 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#13 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#15 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 C:\\laragon\\www\\oee_kmi\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 {main}', '2022-10-15 06:13:31'),
(5, '97b1f5fd-e9ec-49ec-aed2-51b9702988c9', 'database', 'default', '{\"uuid\":\"97b1f5fd-e9ec-49ec-aed2-51b9702988c9\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Undefined index: qos in C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php:173\nStack trace:\n#0 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(173): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(8, \'Undefined index...\', \'C:\\\\laragon\\\\www\\\\...\', 173, Array)\n#1 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(273): Salman\\Mqtt\\MqttClass\\MqttService->subscribe(Array)\n#2 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\Mqtt.php(114): Salman\\Mqtt\\MqttClass\\MqttService->proc()\n#3 C:\\laragon\\www\\oee_kmi\\app\\Events\\MqttSubscribe.php(37): Salman\\Mqtt\\MqttClass\\Mqtt->ConnectAndSubscribe(\'test/topic/mesi...\', Object(Closure), 6407)\n#4 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Events\\MqttSubscribe->handle()\n#5 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#6 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#7 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#8 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#9 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#10 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Events\\MqttSubscribe))\n#11 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#12 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#13 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(120): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Events\\MqttSubscribe), false)\n#14 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Events\\MqttSubscribe))\n#15 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#16 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#17 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Events\\MqttSubscribe))\n#18 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#19 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#20 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#21 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(329): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#22 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(117): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#23 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#24 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#25 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#26 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#27 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#28 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#29 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#30 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#31 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#32 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 C:\\laragon\\www\\oee_kmi\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 {main}', '2022-10-15 06:14:32'),
(6, '285a1f97-4b17-4b32-bdd2-1cca40f6dfd7', 'database', 'default', '{\"uuid\":\"285a1f97-4b17-4b32-bdd2-1cca40f6dfd7\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Events\\MqttSubscribe has been attempted too many times or run too long. The job may have previously timed out. in C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php:750\nStack trace:\n#0 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(504): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#1 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(418): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 1)\n#2 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#3 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(329): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#4 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(117): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#6 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#7 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#8 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#9 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#10 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#11 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#12 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#13 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#15 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 C:\\laragon\\www\\oee_kmi\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 {main}', '2022-10-15 07:38:50'),
(7, '01ee451e-c740-41c2-84d2-9055bab2a1b3', 'database', 'default', '{\"uuid\":\"01ee451e-c740-41c2-84d2-9055bab2a1b3\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Undefined index: qos in C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php:173\nStack trace:\n#0 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(173): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(8, \'Undefined index...\', \'C:\\\\laragon\\\\www\\\\...\', 173, Array)\n#1 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(273): Salman\\Mqtt\\MqttClass\\MqttService->subscribe(Array)\n#2 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\Mqtt.php(114): Salman\\Mqtt\\MqttClass\\MqttService->proc()\n#3 C:\\laragon\\www\\oee_kmi\\app\\Events\\MqttSubscribe.php(37): Salman\\Mqtt\\MqttClass\\Mqtt->ConnectAndSubscribe(\'test/topic/mesi...\', Object(Closure), 8151)\n#4 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Events\\MqttSubscribe->handle()\n#5 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#6 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#7 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#8 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#9 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#10 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Events\\MqttSubscribe))\n#11 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#12 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#13 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(120): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Events\\MqttSubscribe), false)\n#14 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Events\\MqttSubscribe))\n#15 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#16 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#17 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Events\\MqttSubscribe))\n#18 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#19 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#20 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#21 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#22 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(117): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#23 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#24 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#25 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#26 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#27 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#28 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#29 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#30 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#31 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#32 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 C:\\laragon\\www\\oee_kmi\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 {main}', '2022-10-15 11:07:04');
INSERT INTO `failed_jobs` (`id`, `uuid`, `connection`, `queue`, `payload`, `exception`, `failed_at`) VALUES
(8, '24595910-6be3-491a-8e7c-9d3381d999f5', 'database', 'default', '{\"uuid\":\"24595910-6be3-491a-8e7c-9d3381d999f5\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Undefined index: qos in C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php:173\nStack trace:\n#0 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(173): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(8, \'Undefined index...\', \'C:\\\\laragon\\\\www\\\\...\', 173, Array)\n#1 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(273): Salman\\Mqtt\\MqttClass\\MqttService->subscribe(Array)\n#2 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\Mqtt.php(114): Salman\\Mqtt\\MqttClass\\MqttService->proc()\n#3 C:\\laragon\\www\\oee_kmi\\app\\Events\\MqttSubscribe.php(37): Salman\\Mqtt\\MqttClass\\Mqtt->ConnectAndSubscribe(\'test/topic/mesi...\', Object(Closure), 2378)\n#4 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Events\\MqttSubscribe->handle()\n#5 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#6 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#7 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#8 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#9 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#10 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Events\\MqttSubscribe))\n#11 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#12 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#13 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(120): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Events\\MqttSubscribe), false)\n#14 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Events\\MqttSubscribe))\n#15 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#16 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#17 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Events\\MqttSubscribe))\n#18 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#19 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#20 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#21 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#22 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(117): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#23 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#24 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#25 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#26 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#27 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#28 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#29 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#30 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#31 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#32 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 C:\\laragon\\www\\oee_kmi\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 {main}', '2022-10-15 11:09:56'),
(9, '3aa8767a-279a-4d1c-8527-84189ca73549', 'database', 'default', '{\"uuid\":\"3aa8767a-279a-4d1c-8527-84189ca73549\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Undefined index: qos in C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php:173\nStack trace:\n#0 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(173): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(8, \'Undefined index...\', \'C:\\\\laragon\\\\www\\\\...\', 173, Array)\n#1 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(273): Salman\\Mqtt\\MqttClass\\MqttService->subscribe(Array)\n#2 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\Mqtt.php(114): Salman\\Mqtt\\MqttClass\\MqttService->proc()\n#3 C:\\laragon\\www\\oee_kmi\\app\\Events\\MqttSubscribe.php(37): Salman\\Mqtt\\MqttClass\\Mqtt->ConnectAndSubscribe(\'test/topic/mesi...\', Object(Closure), 714)\n#4 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Events\\MqttSubscribe->handle()\n#5 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#6 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#7 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#8 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#9 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#10 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Events\\MqttSubscribe))\n#11 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#12 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#13 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(120): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Events\\MqttSubscribe), false)\n#14 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Events\\MqttSubscribe))\n#15 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#16 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#17 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Events\\MqttSubscribe))\n#18 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#19 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#20 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#21 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#22 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(117): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#23 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#24 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#25 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#26 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#27 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#28 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#29 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#30 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#31 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#32 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 C:\\laragon\\www\\oee_kmi\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 {main}', '2022-10-15 11:10:12'),
(10, '7ffbedb6-1b5f-4c50-aedc-76edd9895203', 'database', 'default', '{\"uuid\":\"7ffbedb6-1b5f-4c50-aedc-76edd9895203\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Undefined index: qos in C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php:173\nStack trace:\n#0 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(173): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(8, \'Undefined index...\', \'C:\\\\laragon\\\\www\\\\...\', 173, Array)\n#1 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(273): Salman\\Mqtt\\MqttClass\\MqttService->subscribe(Array)\n#2 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\Mqtt.php(114): Salman\\Mqtt\\MqttClass\\MqttService->proc()\n#3 C:\\laragon\\www\\oee_kmi\\app\\Events\\MqttSubscribe.php(37): Salman\\Mqtt\\MqttClass\\Mqtt->ConnectAndSubscribe(\'test/topic/mesi...\', Object(Closure), 5143)\n#4 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Events\\MqttSubscribe->handle()\n#5 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#6 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#7 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#8 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#9 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#10 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Events\\MqttSubscribe))\n#11 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#12 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#13 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(120): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Events\\MqttSubscribe), false)\n#14 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Events\\MqttSubscribe))\n#15 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#16 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#17 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Events\\MqttSubscribe))\n#18 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#19 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#20 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#21 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(329): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#22 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(117): Illuminate\\Queue\\Worker->runNextJob(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#23 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#24 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#25 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#26 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#27 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#28 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#29 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#30 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#31 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#32 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 C:\\laragon\\www\\oee_kmi\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 {main}', '2022-10-16 00:03:33'),
(11, '0990d7a3-28ed-4df1-ab80-c432b4901dca', 'database', 'default', '{\"uuid\":\"0990d7a3-28ed-4df1-ab80-c432b4901dca\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'Illuminate\\Queue\\MaxAttemptsExceededException: App\\Events\\MqttSubscribe has been attempted too many times or run too long. The job may have previously timed out. in C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php:750\nStack trace:\n#0 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(504): Illuminate\\Queue\\Worker->maxAttemptsExceededException(Object(Illuminate\\Queue\\Jobs\\DatabaseJob))\n#1 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(418): Illuminate\\Queue\\Worker->markJobAsFailedIfAlreadyExceedsMaxAttempts(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), 1)\n#2 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#3 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#4 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(117): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#5 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#6 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#7 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#8 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#9 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#10 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#11 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#12 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#13 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#14 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#15 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#16 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#17 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#18 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#19 C:\\laragon\\www\\oee_kmi\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#20 {main}', '2022-10-16 03:55:18'),
(12, 'd39be492-aee7-4671-8ca7-512c885bbaf9', 'database', 'default', '{\"uuid\":\"d39be492-aee7-4671-8ca7-512c885bbaf9\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 'ErrorException: Undefined index: qos in C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php:173\nStack trace:\n#0 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(173): Illuminate\\Foundation\\Bootstrap\\HandleExceptions->handleError(8, \'Undefined index...\', \'C:\\\\laragon\\\\www\\\\...\', 173, Array)\n#1 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\MqttService.php(273): Salman\\Mqtt\\MqttClass\\MqttService->subscribe(Array)\n#2 C:\\laragon\\www\\oee_kmi\\vendor\\salmanzafar\\laravel-mqtt\\src\\MqttClass\\Mqtt.php(114): Salman\\Mqtt\\MqttClass\\MqttService->proc()\n#3 C:\\laragon\\www\\oee_kmi\\app\\Events\\MqttSubscribe.php(37): Salman\\Mqtt\\MqttClass\\Mqtt->ConnectAndSubscribe(\'test/topic/mesi...\', Object(Closure), 2913)\n#4 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): App\\Events\\MqttSubscribe->handle()\n#5 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#6 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#7 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#8 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#9 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(128): Illuminate\\Container\\Container->call(Array)\n#10 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Bus\\Dispatcher->Illuminate\\Bus\\{closure}(Object(App\\Events\\MqttSubscribe))\n#11 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#12 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Bus\\Dispatcher.php(132): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#13 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(120): Illuminate\\Bus\\Dispatcher->dispatchNow(Object(App\\Events\\MqttSubscribe), false)\n#14 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(128): Illuminate\\Queue\\CallQueuedHandler->Illuminate\\Queue\\{closure}(Object(App\\Events\\MqttSubscribe))\n#15 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Pipeline\\Pipeline.php(103): Illuminate\\Pipeline\\Pipeline->Illuminate\\Pipeline\\{closure}(Object(App\\Events\\MqttSubscribe))\n#16 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(122): Illuminate\\Pipeline\\Pipeline->then(Object(Closure))\n#17 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\CallQueuedHandler.php(70): Illuminate\\Queue\\CallQueuedHandler->dispatchThroughMiddleware(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(App\\Events\\MqttSubscribe))\n#18 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Jobs\\Job.php(98): Illuminate\\Queue\\CallQueuedHandler->call(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Array)\n#19 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(428): Illuminate\\Queue\\Jobs\\Job->fire()\n#20 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(378): Illuminate\\Queue\\Worker->process(\'database\', Object(Illuminate\\Queue\\Jobs\\DatabaseJob), Object(Illuminate\\Queue\\WorkerOptions))\n#21 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Worker.php(172): Illuminate\\Queue\\Worker->runJob(Object(Illuminate\\Queue\\Jobs\\DatabaseJob), \'database\', Object(Illuminate\\Queue\\WorkerOptions))\n#22 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(117): Illuminate\\Queue\\Worker->daemon(\'database\', \'default\', Object(Illuminate\\Queue\\WorkerOptions))\n#23 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Queue\\Console\\WorkCommand.php(101): Illuminate\\Queue\\Console\\WorkCommand->runWorker(\'database\', \'default\')\n#24 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(36): Illuminate\\Queue\\Console\\WorkCommand->handle()\n#25 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Util.php(40): Illuminate\\Container\\BoundMethod::Illuminate\\Container\\{closure}()\n#26 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(93): Illuminate\\Container\\Util::unwrapIfClosure(Object(Closure))\n#27 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\BoundMethod.php(37): Illuminate\\Container\\BoundMethod::callBoundMethod(Object(Illuminate\\Foundation\\Application), Array, Object(Closure))\n#28 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Container\\Container.php(653): Illuminate\\Container\\BoundMethod::call(Object(Illuminate\\Foundation\\Application), Array, Array, NULL)\n#29 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(136): Illuminate\\Container\\Container->call(Array)\n#30 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Command\\Command.php(298): Illuminate\\Console\\Command->execute(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#31 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Command.php(121): Symfony\\Component\\Console\\Command\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Illuminate\\Console\\OutputStyle))\n#32 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(1024): Illuminate\\Console\\Command->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#33 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(299): Symfony\\Component\\Console\\Application->doRunCommand(Object(Illuminate\\Queue\\Console\\WorkCommand), Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#34 C:\\laragon\\www\\oee_kmi\\vendor\\symfony\\console\\Application.php(171): Symfony\\Component\\Console\\Application->doRun(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#35 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Console\\Application.php(94): Symfony\\Component\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#36 C:\\laragon\\www\\oee_kmi\\vendor\\laravel\\framework\\src\\Illuminate\\Foundation\\Console\\Kernel.php(129): Illuminate\\Console\\Application->run(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#37 C:\\laragon\\www\\oee_kmi\\artisan(37): Illuminate\\Foundation\\Console\\Kernel->handle(Object(Symfony\\Component\\Console\\Input\\ArgvInput), Object(Symfony\\Component\\Console\\Output\\ConsoleOutput))\n#38 {main}', '2022-10-16 03:56:40');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `queue`, `payload`, `attempts`, `reserved_at`, `available_at`, `created_at`) VALUES
(1, 'default', '{\"uuid\":\"5d4d4c75-dfd2-45d8-89a9-808a77cd70fb\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1665934966, 1665934966),
(2, 'default', '{\"uuid\":\"58b93f1c-76a3-42ce-9ee6-3789742f65f2\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1665944043, 1665944043),
(3, 'default', '{\"uuid\":\"fae682a3-dff3-4ecf-ae18-916f527390d8\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1665952597, 1665952597),
(4, 'default', '{\"uuid\":\"b1821b62-9f81-43e5-90f3-8aa8a72531e8\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666095635, 1666095635),
(5, 'default', '{\"uuid\":\"b389a1fd-6425-45a0-8f24-4a703b0bbd68\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666145275, 1666145275),
(6, 'default', '{\"uuid\":\"0226822b-e52c-4ad2-8038-c22f86a67ed4\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666214702, 1666214702),
(7, 'default', '{\"uuid\":\"3800ae08-e546-495a-b6f9-ff5ec2d0c5d3\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666214713, 1666214713),
(8, 'default', '{\"uuid\":\"e077954f-6915-47af-af55-94a7f8b74376\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666214829, 1666214829),
(9, 'default', '{\"uuid\":\"e9b0e25b-4e7c-40a5-8de8-4f9ed32f7fad\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666214843, 1666214843),
(10, 'default', '{\"uuid\":\"03a5889e-3951-4146-ad6d-d3ebc6dd74e3\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666274011, 1666274011),
(11, 'default', '{\"uuid\":\"28c10856-9679-4017-be19-71eab4cb748c\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666274263, 1666274263),
(12, 'default', '{\"uuid\":\"804f96da-f241-4351-8acb-4611cd0cb1f8\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666274837, 1666274837),
(13, 'default', '{\"uuid\":\"207931a3-9b27-4da7-88c5-790da42ad306\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666274961, 1666274961),
(14, 'default', '{\"uuid\":\"5405465e-3b69-4442-9131-2cdad6233469\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666275014, 1666275014),
(15, 'default', '{\"uuid\":\"e3e20b1e-6c8c-40a3-865c-c94bf832d428\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666275075, 1666275075),
(16, 'default', '{\"uuid\":\"b566d54b-9080-4387-b63a-0b0d27e24b50\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666275138, 1666275138),
(17, 'default', '{\"uuid\":\"b0c7e091-464e-4bdc-a22b-91d3b1be7312\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666275172, 1666275172),
(18, 'default', '{\"uuid\":\"bb85aa42-427c-4193-a3a9-56f8c60f8520\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666275245, 1666275245),
(19, 'default', '{\"uuid\":\"60b451cc-ab14-4259-89fe-97350405e2eb\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666275378, 1666275378),
(20, 'default', '{\"uuid\":\"c1b08484-cd6c-4e04-b059-8633b8a14a18\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666275595, 1666275595),
(21, 'default', '{\"uuid\":\"78fbfa72-90b3-403b-be12-2d948f31e725\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666349901, 1666349901),
(22, 'default', '{\"uuid\":\"416c5103-a206-4841-b242-2f39d4d73252\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666350994, 1666350994),
(23, 'default', '{\"uuid\":\"bd933449-bf54-40e4-b371-e9d6ceab58d8\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666351022, 1666351022),
(24, 'default', '{\"uuid\":\"5fc8c164-4a38-46a2-99b5-2325719c8263\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666351074, 1666351074),
(25, 'default', '{\"uuid\":\"77e6cf27-bdf9-4251-942d-e926bab1056d\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666359634, 1666359634),
(26, 'default', '{\"uuid\":\"08cf091a-fe33-4c7a-9285-929207cb71c0\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666375880, 1666375880),
(27, 'default', '{\"uuid\":\"dc79ed1c-0085-4e3f-ba5d-5f5dc1177e0e\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666376123, 1666376123),
(28, 'default', '{\"uuid\":\"b6a320ee-fb34-428b-b9b9-dc5dbd5ba47a\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666376169, 1666376169),
(29, 'default', '{\"uuid\":\"b8431686-d6f4-4651-80dc-1180a2f30bd1\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666426094, 1666426094),
(30, 'default', '{\"uuid\":\"cf119d73-153e-459c-96d7-cdc14811f3a9\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666426410, 1666426410),
(31, 'default', '{\"uuid\":\"4f252610-fa02-4b57-a131-0cb8f8e41bea\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666427057, 1666427057),
(32, 'default', '{\"uuid\":\"2d64b92e-abcc-4901-93b1-0b6e70ba3b92\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666427407, 1666427407),
(33, 'default', '{\"uuid\":\"529c542f-a0fc-4157-9a64-a2a1514d1f56\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666427477, 1666427477),
(34, 'default', '{\"uuid\":\"c034252a-aadc-442d-befd-971dbe286d77\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666427802, 1666427802),
(35, 'default', '{\"uuid\":\"3b1fc017-4406-4d82-b944-5c7ce1517c00\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666427852, 1666427852),
(36, 'default', '{\"uuid\":\"5ced81ee-71c3-4117-a59d-8bebc27373e1\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666428048, 1666428048),
(37, 'default', '{\"uuid\":\"c77ab783-3a89-4735-b211-55dd4eb9068d\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666428097, 1666428097),
(38, 'default', '{\"uuid\":\"4190d39b-7a5b-44d2-a8d7-00188758e3cb\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666428211, 1666428211),
(39, 'default', '{\"uuid\":\"335711d0-2b99-46fb-b94f-1502db3c9b1f\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666428515, 1666428515),
(40, 'default', '{\"uuid\":\"25246b99-04af-4111-b5ae-4bd9a26e919d\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666450951, 1666450951),
(41, 'default', '{\"uuid\":\"59028821-aef0-4a1f-87c9-30a79f98f3e9\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666452317, 1666452317),
(42, 'default', '{\"uuid\":\"6f229c1f-a91c-4744-898b-ff0af9f7f45a\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666459318, 1666459318),
(43, 'default', '{\"uuid\":\"3155cbe2-6d92-43e4-8ca9-22d5b5ae4434\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666468083, 1666468083),
(44, 'default', '{\"uuid\":\"c5d9b1cd-bd1c-418b-842b-b65bba5fcaee\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666505192, 1666505192),
(45, 'default', '{\"uuid\":\"61bd3cf7-29c6-4ec6-8527-6dbfe12f4572\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666508356, 1666508356),
(46, 'default', '{\"uuid\":\"86855363-4146-4c1f-ba55-8047f0e26530\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666510921, 1666510921),
(47, 'default', '{\"uuid\":\"fe80e47c-cc5b-4284-9fa7-1aad8626966b\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666510993, 1666510993),
(48, 'default', '{\"uuid\":\"0eef88ef-eea6-4fd0-a752-3d6789277b96\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666511061, 1666511061),
(49, 'default', '{\"uuid\":\"2d78f725-3210-479c-9edc-42ee354c7e02\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666518646, 1666518646),
(50, 'default', '{\"uuid\":\"1908b308-f152-42bb-b2c2-b7e91946a8cd\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666533017, 1666533017),
(51, 'default', '{\"uuid\":\"ff8935cc-a283-46d2-a454-4b0c32184592\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666566277, 1666566277),
(52, 'default', '{\"uuid\":\"6e5633ba-17f3-4cdb-9b67-07fec3025b68\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666567869, 1666567869),
(53, 'default', '{\"uuid\":\"fcda6056-34c8-4167-bb7d-f141a51ffaa8\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666568225, 1666568225),
(54, 'default', '{\"uuid\":\"0bc5a9b5-0829-43cf-902d-143236462853\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666568785, 1666568785),
(55, 'default', '{\"uuid\":\"49dc5dca-1569-49c5-a314-0f5753ef2742\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666570491, 1666570491),
(56, 'default', '{\"uuid\":\"fbf87730-7339-492b-a707-e008261938e5\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666570799, 1666570799),
(57, 'default', '{\"uuid\":\"fb19fa61-377d-4bab-a224-4fcb37a4cf31\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666572217, 1666572217),
(58, 'default', '{\"uuid\":\"4459a2a7-916c-4270-9b5f-920db149058e\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666572253, 1666572253),
(59, 'default', '{\"uuid\":\"75ca6dc8-ffa4-4ea9-b3c9-c05ad3be7bf6\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666572299, 1666572299),
(60, 'default', '{\"uuid\":\"e1a035de-6083-4e8f-9161-875741543a22\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666588364, 1666588364),
(61, 'default', '{\"uuid\":\"12bd57cb-e91f-4e7b-9ba3-9314284efd9f\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666588954, 1666588954),
(62, 'default', '{\"uuid\":\"010d0197-7699-460f-a058-e310415be4d7\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666589909, 1666589909),
(63, 'default', '{\"uuid\":\"577bfbcb-f422-4089-8e2b-bda436d60497\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666590054, 1666590054),
(64, 'default', '{\"uuid\":\"ed3a6020-2b2a-468f-ad02-8f9a24fafa9e\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666592437, 1666592437),
(65, 'default', '{\"uuid\":\"c9ccf973-b782-4c6a-b205-8a5dc6611cbd\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666593672, 1666593672),
(66, 'default', '{\"uuid\":\"37a38015-591c-4b07-8842-d215bd6a9516\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666595377, 1666595377),
(67, 'default', '{\"uuid\":\"70c32c30-db98-4ae3-9dd3-4903a5bca0ad\",\"displayName\":\"App\\\\Events\\\\MqttSubscribe\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":0,\"retryUntil\":null,\"data\":{\"commandName\":\"App\\\\Events\\\\MqttSubscribe\",\"command\":\"O:24:\\\"App\\\\Events\\\\MqttSubscribe\\\":11:{s:7:\\\"timeout\\\";i:0;s:6:\\\"socket\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:0:{}}\"}}', 0, NULL, 1666595412, 1666595412);

-- --------------------------------------------------------

--
-- Table structure for table `level_access`
--

CREATE TABLE `level_access` (
  `level_id` bigint(20) UNSIGNED NOT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `level_access`
--

INSERT INTO `level_access` (`level_id`, `menu_id`, `created_at`, `updated_at`) VALUES
(7, 1, '2022-09-30 22:10:15', '2022-09-30 22:10:15'),
(7, 10, '2022-09-30 22:10:20', '2022-09-30 22:10:20'),
(8, 1, '2022-09-30 22:30:21', '2022-09-30 22:30:21'),
(8, 11, '2022-09-30 22:30:26', '2022-09-30 22:30:26'),
(4, 1, '2022-10-22 20:28:14', '2022-10-22 20:28:14'),
(10, 1, '2022-10-24 00:22:58', '2022-10-24 00:22:58'),
(10, 16, '2022-10-24 00:22:58', '2022-10-24 00:22:58'),
(10, 19, '2022-10-24 00:22:58', '2022-10-24 00:22:58'),
(10, 25, '2022-10-24 00:22:58', '2022-10-24 00:22:58'),
(9, 1, '2022-10-24 00:24:12', '2022-10-24 00:24:12'),
(9, 20, '2022-10-24 00:24:12', '2022-10-24 00:24:12'),
(9, 23, '2022-10-24 00:24:12', '2022-10-24 00:24:12'),
(9, 24, '2022-10-24 00:24:12', '2022-10-24 00:24:12'),
(6, 1, '2022-10-24 00:24:30', '2022-10-24 00:24:30'),
(6, 15, '2022-10-24 00:24:30', '2022-10-24 00:24:30'),
(6, 16, '2022-10-24 00:24:30', '2022-10-24 00:24:30'),
(6, 25, '2022-10-24 00:24:30', '2022-10-24 00:24:30'),
(3, 1, '2022-10-24 05:39:21', '2022-10-24 05:39:21'),
(3, 18, '2022-10-24 05:39:21', '2022-10-24 05:39:21'),
(3, 21, '2022-10-24 05:39:21', '2022-10-24 05:39:21'),
(3, 22, '2022-10-24 05:39:21', '2022-10-24 05:39:21'),
(15, 1, '2022-10-24 05:39:51', '2022-10-24 05:39:51'),
(15, 18, '2022-10-24 05:39:51', '2022-10-24 05:39:51'),
(15, 21, '2022-10-24 05:39:51', '2022-10-24 05:39:51'),
(15, 22, '2022-10-24 05:39:51', '2022-10-24 05:39:51'),
(16, 1, '2022-10-24 07:08:39', '2022-10-24 07:08:39'),
(16, 23, '2022-10-24 07:08:39', '2022-10-24 07:08:39'),
(16, 24, '2022-10-24 07:08:39', '2022-10-24 07:08:39'),
(16, 26, '2022-10-24 07:08:39', '2022-10-24 07:08:39'),
(1, 1, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 2, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 3, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 4, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 5, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 6, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 7, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 8, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 9, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 12, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 13, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 14, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 17, '2022-10-29 07:07:32', '2022-10-29 07:07:32'),
(1, 28, '2022-10-29 07:07:32', '2022-10-29 07:07:32');

-- --------------------------------------------------------

--
-- Table structure for table `line_users`
--

CREATE TABLE `line_users` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `line_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `line_users`
--

INSERT INTO `line_users` (`user_id`, `line_id`, `created_at`, `updated_at`) VALUES
(5, 1, '2022-10-12 20:39:48', '2022-10-12 20:39:48'),
(12, 1, '2022-10-12 20:44:38', '2022-10-12 20:44:38'),
(13, 1, '2022-10-12 20:44:53', '2022-10-12 20:44:53'),
(14, 1, '2022-10-12 20:45:45', '2022-10-12 20:45:45'),
(15, 1, '2022-10-12 20:46:41', '2022-10-12 20:46:41'),
(10, 1, '2022-10-12 20:51:09', '2022-10-12 20:51:09'),
(11, 1, '2022-10-12 20:52:28', '2022-10-12 20:52:28'),
(8, 1, '2022-10-12 20:55:30', '2022-10-12 20:55:30'),
(21, 1, '2022-10-12 21:24:14', '2022-10-12 21:24:14'),
(22, 1, '2022-10-12 21:42:30', '2022-10-12 21:42:30'),
(23, 1, '2022-10-12 21:43:02', '2022-10-12 21:43:02'),
(24, 1, '2022-10-12 21:43:47', '2022-10-12 21:43:47'),
(25, 1, '2022-10-12 21:46:28', '2022-10-12 21:46:28'),
(26, 1, '2022-10-12 21:47:13', '2022-10-12 21:47:13'),
(27, 1, '2022-10-12 21:47:55', '2022-10-12 21:47:55'),
(28, 1, '2022-10-12 21:51:00', '2022-10-12 21:51:00'),
(29, 1, '2022-10-12 21:52:16', '2022-10-12 21:52:16'),
(30, 1, '2022-10-12 21:55:20', '2022-10-12 21:55:20'),
(31, 1, '2022-10-12 21:55:56', '2022-10-12 21:55:56'),
(32, 1, '2022-10-12 21:57:28', '2022-10-12 21:57:28'),
(33, 1, '2022-10-12 21:58:03', '2022-10-12 21:58:03'),
(34, 1, '2022-10-12 21:58:36', '2022-10-12 21:58:36'),
(35, 1, '2022-10-12 21:59:13', '2022-10-12 21:59:13'),
(36, 1, '2022-10-12 22:00:01', '2022-10-12 22:00:01'),
(37, 1, '2022-10-12 22:00:41', '2022-10-12 22:00:41'),
(5, 1, '2022-10-12 20:39:48', '2022-10-12 20:39:48'),
(12, 1, '2022-10-12 20:44:38', '2022-10-12 20:44:38'),
(13, 1, '2022-10-12 20:44:53', '2022-10-12 20:44:53'),
(14, 1, '2022-10-12 20:45:45', '2022-10-12 20:45:45'),
(15, 1, '2022-10-12 20:46:41', '2022-10-12 20:46:41'),
(10, 1, '2022-10-12 20:51:09', '2022-10-12 20:51:09'),
(11, 1, '2022-10-12 20:52:28', '2022-10-12 20:52:28'),
(8, 1, '2022-10-12 20:55:30', '2022-10-12 20:55:30'),
(21, 1, '2022-10-12 21:24:14', '2022-10-12 21:24:14'),
(22, 1, '2022-10-12 21:42:30', '2022-10-12 21:42:30'),
(23, 1, '2022-10-12 21:43:02', '2022-10-12 21:43:02'),
(24, 1, '2022-10-12 21:43:47', '2022-10-12 21:43:47'),
(25, 1, '2022-10-12 21:46:28', '2022-10-12 21:46:28'),
(26, 1, '2022-10-12 21:47:13', '2022-10-12 21:47:13'),
(27, 1, '2022-10-12 21:47:55', '2022-10-12 21:47:55'),
(28, 1, '2022-10-12 21:51:00', '2022-10-12 21:51:00'),
(29, 1, '2022-10-12 21:52:16', '2022-10-12 21:52:16'),
(30, 1, '2022-10-12 21:55:20', '2022-10-12 21:55:20'),
(31, 1, '2022-10-12 21:55:56', '2022-10-12 21:55:56'),
(32, 1, '2022-10-12 21:57:28', '2022-10-12 21:57:28'),
(33, 1, '2022-10-12 21:58:03', '2022-10-12 21:58:03'),
(34, 1, '2022-10-12 21:58:36', '2022-10-12 21:58:36'),
(35, 1, '2022-10-12 21:59:13', '2022-10-12 21:59:13'),
(36, 1, '2022-10-12 22:00:01', '2022-10-12 22:00:01'),
(37, 1, '2022-10-12 22:00:41', '2022-10-12 22:00:41'),
(16, 1, '2022-10-22 08:32:34', '2022-10-22 08:32:34'),
(9, 1, '2022-10-26 20:14:51', '2022-10-26 20:14:51');

-- --------------------------------------------------------

--
-- Table structure for table `loghistory`
--

CREATE TABLE `loghistory` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `machine_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(64) NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `loghistory`
--
DELIMITER $$
CREATE TRIGGER `trigger_oee` BEFORE INSERT ON `loghistory` FOR EACH ROW BEGIN
	SET @line_id = (SELECT `line_id` FROM `db_dpmoee`.`mmachines` WHERE `id` = new.machine_id LIMIT 1);
	SET @check_oee = (SELECT line_id FROM oee WHERE line_id = @line_id ORDER BY id DESC LIMIT 1);
	SET @last_status = (select `status` FROM `loghistory` where machine_id = new.machine_id order by id desc limit 1);
	IF(new.name = 'STATUS') THEN
		IF((@last_status = new.status) AND @check_oee is not null) THEN
			call update_durasi(@line_id);
		ELSE
			call insert_durasi(@line_id);
		END if;
	ELSEIF(new.name = 'COUNTING') THEN
		call update_counting(@line_id, new.status);
	ELSE 
		CALL update_reject(@line_id, new.status);
	END if;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `mactivitycode`
--

CREATE TABLE `mactivitycode` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `line_id` bigint(20) UNSIGNED NOT NULL,
  `txtactivitycode` char(16) NOT NULL,
  `txtcategory` char(100) NOT NULL,
  `txtactivityname` varchar(128) NOT NULL,
  `txtactivityitem` varchar(200) NOT NULL,
  `txtdescription` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mactivitycode`
--

INSERT INTO `mactivitycode` (`id`, `line_id`, `txtactivitycode`, `txtcategory`, `txtactivityname`, `txtactivityitem`, `txtdescription`, `created_at`, `updated_at`) VALUES
(1, 1, 'pr', 'pr', 'Produksi lancar', 'Produksi lancar', 'Produksi lancar', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 1, 'Sh.1', 'sh', 'Tidak ada order', '', 'Tidak ada order', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(3, 1, 'Sh.2', 'sh', 'Training', '', 'Training', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, 1, 'Sh.3', 'sh', 'Trial', '', 'Trial', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 1, 'Sh.4', 'sh', 'Event ', '', 'Event ', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(6, 1, 'Sh.5', 'sh', 'AM activity  ', 'Weekly Cleaning', 'AM activity  -Weekly Cleaning', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, 1, 'Sh.6', 'sh', 'AM activity  ', 'Meeting CG', 'AM activity  -Meeting CG', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(8, 1, 'Sh.7', 'sh', 'AM activity  ', 'Checking screen siever, metal cathcer, Auger', 'AM activity  -Checking screen siever, metal cathcer, Auger', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(9, 1, 'Sh.8', 'sh', 'Waiting Material', 'RM/PM (Eksternal/Principal)', 'Waiting Material-RM/PM (Eksternal/Principal)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(10, 1, 'Sh.9', 'sh', 'Istirahat', '', 'Istirahat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(11, 1, 'Sh.10', 'sh', 'extra time', '', 'extra time', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(12, 1, 'Sh.11', 'sh', 'Wet Cleaning', '', 'Wet Cleaning', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(13, 1, 'Sh.12', 'sh', 'Sholat', '', 'Sholat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(14, 1, 'Sh.13', 'sh', 'Others', '', 'Others', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(15, 1, 'Br.1', 'br', 'Problem forklift ', 'batere', 'Problem forklift  - batere', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(16, 1, 'Br.2', 'br', 'Problem forklift ', 'hidrolik', 'Problem forklift  - hidrolik', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(17, 1, 'Br.3', 'br', 'Problem Tipper ', 'vibrating motor', 'Problem Tipper  - vibrating motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(18, 1, 'Br.4', 'br', 'Problem Tipper ', 'Piston Pneumatic', 'Problem Tipper  - Piston Pneumatic', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(19, 1, 'Br.5', 'br', 'Problem Tipper ', 'Flexible Tipper to powder tank', 'Problem Tipper  - Flexible Tipper to powder tank', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(20, 1, 'Br.6', 'br', 'Problem Alimentation', 'problem powder tank (sensor)', 'Problem Alimentation - problem powder tank (sensor)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(21, 1, 'Br.7', 'br', 'Problem Alimentation', 'problem powder tank (motor)', 'Problem Alimentation - problem powder tank (motor)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(22, 1, 'Br.8', 'br', 'Problem Alimentation', 'Flexible powder tank to vibrating conveyor', 'Problem Alimentation - Flexible powder tank to vibrating conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(23, 1, 'Br.9', 'br', 'Problem Alimentation', 'problem (motor) vibrating conveyor', 'Problem Alimentation - problem (motor) vibrating conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(24, 1, 'Br.10', 'br', 'Problem Alimentation', 'Flexible vibrating conveyor to siever', 'Problem Alimentation - Flexible vibrating conveyor to siever', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(25, 1, 'Br.11', 'br', 'Problem Alimentation', 'problem (motor) Siever', 'Problem Alimentation - problem (motor) Siever', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(26, 1, 'Br.12', 'br', 'Problem Alimentation', 'Limit Switch tailling cut', 'Problem Alimentation - Limit Switch tailling cut', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(27, 1, 'Br.13', 'br', 'Problem Alimentation', 'Metal Catcher', 'Problem Alimentation - Metal Catcher', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(28, 1, 'Br.14', 'br', 'Problem Alimentation', 'Flexible siever to Metal Catcher', 'Problem Alimentation - Flexible siever to Metal Catcher', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(29, 1, 'Br.15', 'br', 'Problem Alimentation', 'Flexible metal catcher to buffer hopper', 'Problem Alimentation - Flexible metal catcher to buffer hopper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(30, 1, 'Br.16', 'br', 'Problem Alimentation', 'problem Buffer hopper (sensor)', 'Problem Alimentation - problem Buffer hopper (sensor)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(31, 1, 'Br.17', 'br', 'Problem Alimentation', 'Flexible buffer hopper to vibrating conveyor', 'Problem Alimentation - Flexible buffer hopper to vibrating conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(32, 1, 'Br.18', 'br', 'Problem Alimentation', 'problem (motor) vibrating conveyor mezzanin', 'Problem Alimentation - problem (motor) vibrating conveyor mezzanin', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(33, 1, 'Br.19', 'br', 'Problem Alimentation', 'Flexible vibrating conveyor to hopper filling', 'Problem Alimentation - Flexible vibrating conveyor to hopper filling', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(34, 1, 'Br.20', 'br', 'SACHET FILLING Alufo Line', 'alufo', 'SACHET FILLING Alufo Line - alufo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(35, 1, 'Br.21', 'br', 'SACHET FILLING Alufo Line', 'code', 'SACHET FILLING Alufo Line - code', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(36, 1, 'Br.22', 'br', 'SACHET FILLING Alufo Line', 'roll', 'SACHET FILLING Alufo Line - roll', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(37, 1, 'Br.23', 'br', 'SACHET FILLING Alufo Line', 'Sensor Alufo', 'SACHET FILLING Alufo Line-Sensor Alufo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(38, 1, 'Br.24', 'br', 'SACHET FILLING Alufo Line', 'Overload - Cross jaw', 'SACHET FILLING Alufo Line-Overload - Cross jaw', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(39, 1, 'Br.25', 'br', 'SACHET FILLING Alufo Line', 'Overload - Vertical seal', 'SACHET FILLING Alufo Line-Overload - Vertical seal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(40, 1, 'Br.26', 'br', 'Motor Agitator', '', 'Motor Agitator', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(41, 1, 'Br.27', 'br', 'Motor Auger', '', 'Motor Auger', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(42, 1, 'Br.28', 'br', 'SACHET FILLING Powder Line', 'hopper', 'SACHET FILLING Powder Line - hopper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(43, 1, 'Br.29', 'br', 'SACHET FILLING Powder Line', 'agitator', 'SACHET FILLING Powder Line - agitator', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(44, 1, 'Br.30', 'br', 'SACHET FILLING Powder Line', 'Auger', 'SACHET FILLING Powder Line - Auger', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(45, 1, 'Br.31', 'br', 'SACHET FILLING Powder Line', 'forming Tube', 'SACHET FILLING Powder Line - forming Tube', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(46, 1, 'Br.32', 'br', 'SACHET FILLING Powder Line', 'forming Collar', 'SACHET FILLING Powder Line - forming Collar', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(47, 1, 'Br.33', 'br', 'SACHET FILLING Powder Line', 'closer', 'SACHET FILLING Powder Line - closer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(48, 1, 'Br.34', 'br', 'SACHET FILLING Powder Line', 'transport Belt', 'SACHET FILLING Powder Line - transport Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(49, 1, 'Br.35', 'br', 'SACHET FILLING Powder Line', 'supply Nitrogen', 'SACHET FILLING Powder Line - supply Nitrogen', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(50, 1, 'Br.36', 'br', 'SACHET FILLING Powder Line', 'RO Online', 'SACHET FILLING Powder Line - RO Online', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(51, 1, 'Br.37', 'br', 'SACHET FILLING Powder Line', 'Rotary Closer', 'SACHET FILLING Powder Line - Rotary Closer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(52, 1, 'Br.38', 'br', 'SACHET FILLING Powder Line', 'Sensor Closer', 'SACHET FILLING Powder Line - Sensor Closer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(53, 1, 'Br.39', 'br', 'SACHET FILLING Sealer', 'vertical', 'SACHET FILLING Sealer - vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(54, 1, 'Br.40', 'br', 'SACHET FILLING Sealer', 'cross', 'SACHET FILLING Sealer - cross', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(55, 1, 'Br.41', 'br', 'SACHET FILLING Sealer', 'Busa Cross jaw', 'SACHET FILLING Sealer - Busa Cross jaw', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(56, 1, 'Br.42', 'br', 'SACHET FILLING Sealer', 'knife', 'SACHET FILLING Sealer - knife', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(57, 1, 'Br.43', 'br', 'SACHET FILLING Vaccum Pump ', 'Vaccum Pump', 'SACHET FILLING Vaccum Pump  - Vaccum Pump', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(58, 1, 'Br.44', 'br', 'SACHET FILLING ', 'Driver', 'SACHET FILLING  - Driver', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(59, 1, 'Br.45', 'br', 'Discharge Belt Conveying', 'Discharge Belt Conveying', 'Discharge Belt Conveying - Discharge Belt Conveying', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(60, 1, 'Br.46', 'br', 'CHECK WEIGHER Housing/Panel', 'motor', 'CHECK WEIGHER Housing/Panel - motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(61, 1, 'Br.47', 'br', 'CHECK WEIGHER Housing/Panel', 'mechanical Parts', 'CHECK WEIGHER Housing/Panel - mechanical Parts', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(62, 1, 'Br.48', 'br', 'CHECK WEIGHER Conveying', 'conveyor', 'CHECK WEIGHER Conveying - conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(63, 1, 'Br.49', 'br', 'CHECK WEIGHER Conveying', 'operating Unit/Display', 'CHECK WEIGHER Conveying - operating Unit/Display', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(64, 1, 'Br.50', 'br', 'CHECK WEIGHER Conveying', 'eject Unit', 'CHECK WEIGHER Conveying - eject Unit', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(65, 1, 'Br.51', 'br', 'CHECK WEIGHER Panel Box ', 'Panel Box ', 'CHECK WEIGHER Panel Box  - Panel Box ', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(66, 1, 'Br.52', 'br', 'Cartoner - Tooth belt', 'motor 1', 'Cartoner - Tooth belt - motor 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(67, 1, 'Br.53', 'br', 'Cartoner - Tooth belt', 'conveyor 1', 'Cartoner - Tooth belt - conveyor 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(68, 1, 'Br.54', 'br', 'Cartoner - Tooth belt', 'motor 2', 'Cartoner - Tooth belt - motor 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(69, 1, 'Br.55', 'br', 'Cartoner - Tooth belt', 'conveyor 2', 'Cartoner - Tooth belt - conveyor 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(70, 1, 'Br.56', 'br', 'Stacker ', 'Panel 1', 'Stacker  - Panel 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(71, 1, 'Br.57', 'br', 'Stacker ', 'Panel 2', 'Stacker  - Panel 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(72, 1, 'Br.58', 'br', 'Stacker ', 'Acceleration belt 1 - Motor', 'Stacker  - Acceleration belt 1 - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(73, 1, 'Br.59', 'br', 'Stacker ', 'Acceleration belt 1 - Belt', 'Stacker  - Acceleration belt 1 - Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(74, 1, 'Br.60', 'br', 'Stacker ', 'Acceleration belt 1 - Sensor', 'Stacker  - Acceleration belt 1 - Sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(75, 1, 'Br.61', 'br', 'Stacker ', 'Acceleration belt 2 - Motor', 'Stacker  - Acceleration belt 2 - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(76, 1, 'Br.62', 'br', 'Stacker ', 'Acceleration belt 2 - Belt', 'Stacker  - Acceleration belt 2 - Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(77, 1, 'Br.63', 'br', 'Stacker ', 'Acceleration belt 2 - Sensor', 'Stacker  - Acceleration belt 2 - Sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(78, 1, 'Br.64', 'br', 'Stacker ', 'Bag Loader 1, Atas', 'Stacker  - Bag Loader 1, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(79, 1, 'Br.65', 'br', 'Stacker ', 'Bag Loader 1, Tengah', 'Stacker  - Bag Loader 1, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(80, 1, 'Br.66', 'br', 'Stacker ', 'Bag Loader 1, Bawah', 'Stacker  - Bag Loader 1, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(81, 1, 'Br.67', 'br', 'Stacker ', 'Belt Bag Loader 1, Atas', 'Stacker  - Belt Bag Loader 1, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(82, 1, 'Br.68', 'br', 'Stacker ', 'Belt Bag Loader 1, Tengah', 'Stacker  - Belt Bag Loader 1, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(83, 1, 'Br.69', 'br', 'Stacker ', 'Belt Bag Loader 1, Bawah', 'Stacker  - Belt Bag Loader 1, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(84, 1, 'Br.70', 'br', 'Stacker ', 'Motor Bag Loader 1, Atas', 'Stacker  - Motor Bag Loader 1, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(85, 1, 'Br.71', 'br', 'Stacker ', 'Motor Bag Loader 1, Tengah', 'Stacker  - Motor Bag Loader 1, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(86, 1, 'Br.72', 'br', 'Stacker ', 'Motor Bag Loader 1, Bawah', 'Stacker  - Motor Bag Loader 1, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(87, 1, 'Br.73', 'br', 'Stacker ', 'Sensor Bag Loader 1, Atas', 'Stacker  - Sensor Bag Loader 1, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(88, 1, 'Br.74', 'br', 'Stacker ', 'Sensor Bag Loader 1, Tengah', 'Stacker  - Sensor Bag Loader 1, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(89, 1, 'Br.75', 'br', 'Stacker ', 'Sensor Bag Loader 1, Bawah', 'Stacker  - Sensor Bag Loader 1, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(90, 1, 'Br.76', 'br', 'Stacker ', 'Bag Loader 2, Atas', 'Stacker  - Bag Loader 2, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(91, 1, 'Br.77', 'br', 'Stacker ', 'Bag Loader 2, Tengah', 'Stacker  - Bag Loader 2, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(92, 1, 'Br.78', 'br', 'Stacker ', 'Bag Loader 2, Bawah', 'Stacker  - Bag Loader 2, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(93, 1, 'Br.79', 'br', 'Stacker ', 'Belt Bag Loader 2, Atas', 'Stacker  - Belt Bag Loader 2, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(94, 1, 'Br.80', 'br', 'Stacker ', 'Belt Bag Loader 2, Tengah', 'Stacker  - Belt Bag Loader 2, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(95, 1, 'Br.81', 'br', 'Stacker ', 'Belt Bag Loader 2, Bawah', 'Stacker  - Belt Bag Loader 2, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(96, 1, 'Br.82', 'br', 'Stacker ', 'Motor Bag Loader 2, Atas', 'Stacker  - Motor Bag Loader 2, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(97, 1, 'Br.83', 'br', 'Stacker ', 'Motor Bag Loader 2, Tengah', 'Stacker  - Motor Bag Loader 2, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(98, 1, 'Br.84', 'br', 'Stacker ', 'Motor Bag Loader 2, Bawah', 'Stacker  - Motor Bag Loader 2, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(99, 1, 'Br.85', 'br', 'Stacker ', 'Sensor Bag Loader 2, Atas', 'Stacker  - Sensor Bag Loader 2, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(100, 1, 'Br.86', 'br', 'Stacker ', 'Sensor Bag Loader 2, Tengah', 'Stacker  - Sensor Bag Loader 2, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(101, 1, 'Br.87', 'br', 'Stacker ', 'Sensor Bag Loader 2, Bawah', 'Stacker  - Sensor Bag Loader 2, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(102, 1, 'Br.88', 'br', 'Scoop Feeder', 'Panel', 'Scoop Feeder - Panel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(103, 1, 'Br.89', 'br', 'Scoop Feeder', 'Sensor Bunker', 'Scoop Feeder - Sensor Bunker', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(104, 1, 'Br.90', 'br', 'Scoop Feeder', 'Motor Bunker', 'Scoop Feeder - Motor Bunker', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(105, 1, 'Br.91', 'br', 'Scoop Feeder', 'Conveyor bunker', 'Scoop Feeder - Conveyor bunker', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(106, 1, 'Br.92', 'br', 'Scoop Feeder', 'Motor Lifter', 'Scoop Feeder - Motor Lifter', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(107, 1, 'Br.93', 'br', 'Scoop Feeder', 'Conveyor Lifter', 'Scoop Feeder - Conveyor Lifter', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(108, 1, 'Br.94', 'br', 'Scoop Feeder', 'Motor Sweeper', 'Scoop Feeder - Motor Sweeper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(109, 1, 'Br.95', 'br', 'Scoop Feeder', 'Conveyor Sweeper', 'Scoop Feeder - Conveyor Sweeper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(110, 1, 'Br.96', 'br', 'Scoop Feeder', 'Bowl 1', 'Scoop Feeder - Bowl 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(111, 1, 'Br.97', 'br', 'Scoop Feeder', 'Air Nozzle Bowl 1', 'Scoop Feeder - Air Nozzle Bowl 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(112, 1, 'Br.98', 'br', 'Scoop Feeder', 'Bowl 2', 'Scoop Feeder - Bowl 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(113, 1, 'Br.99', 'br', 'Scoop Feeder', 'Air Nozzle Bowl 2', 'Scoop Feeder - Air Nozzle Bowl 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(114, 1, 'Br.100', 'br', 'Scoop Feeder', 'Vibrating Motor 1', 'Scoop Feeder - Vibrating Motor 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(115, 1, 'Br.101', 'br', 'Scoop Feeder', 'Vibrating Motor 2', 'Scoop Feeder - Vibrating Motor 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(116, 1, 'Br.102', 'br', 'Scoop Feeder', 'Sensor Belt track Spoon 1', 'Scoop Feeder - Sensor Belt track Spoon 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(117, 1, 'Br.103', 'br', 'Scoop Feeder', 'Belt track Spoon 1', 'Scoop Feeder - Belt track Spoon 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(118, 1, 'Br.104', 'br', 'Scoop Feeder', 'Sensor Belt track Spoon 2', 'Scoop Feeder - Sensor Belt track Spoon 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(119, 1, 'Br.105', 'br', 'Scoop Feeder', 'Belt track Spoon 2', 'Scoop Feeder - Belt track Spoon 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(120, 1, 'Br.106', 'br', 'Scoop Feeder', 'Rotary Finger 1', 'Scoop Feeder - Rotary Finger 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(121, 1, 'Br.107', 'br', 'Scoop Feeder', 'Rotary Finger 2', 'Scoop Feeder - Rotary Finger 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(122, 1, 'Br.108', 'br', 'Scoop Feeder', 'Sensor Finger', 'Scoop Feeder - Sensor Finger', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(123, 1, 'Br.109', 'br', 'Scoop Feeder', 'Star Wheel 1', 'Scoop Feeder - Star Wheel 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(124, 1, 'Br.110', 'br', 'Scoop Feeder', 'Star Wheel 2', 'Scoop Feeder - Star Wheel 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(125, 1, 'Br.111', 'br', 'Scoop Feeder', 'Sensor Star Wheel 1', 'Scoop Feeder - Sensor Star Wheel 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(126, 1, 'Br.112', 'br', 'Scoop Feeder', 'Sensor Star Wheel 2', 'Scoop Feeder - Sensor Star Wheel 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(127, 1, 'Br.113', 'br', 'Scoop Feeder', 'Motor Vacuum 1', 'Scoop Feeder - Motor Vacuum 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(128, 1, 'Br.114', 'br', 'Scoop Feeder', 'Motor Vacuum 2', 'Scoop Feeder - Motor Vacuum 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(129, 1, 'Br.115', 'br', 'Scoop Feeder', 'Kapasitor Spooner 1', 'Scoop Feeder - Kapasitor Spooner 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(130, 1, 'Br.116', 'br', 'Scoop Feeder', 'Kapasitor Spooner 2', 'Scoop Feeder - Kapasitor Spooner 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(131, 1, 'Br.117', 'br', 'Cartoner', 'Air Pressure', 'Cartoner - Air Pressure', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(132, 1, 'Br.118', 'br', 'Cartoner', 'Magazine Conveyor - Belt', 'Cartoner - Magazine Conveyor - Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(133, 1, 'Br.119', 'br', 'Cartoner', 'Magazine Conveyor - Motor Servo', 'Cartoner - Magazine Conveyor - Motor Servo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(134, 1, 'Br.120', 'br', 'Cartoner', 'Magazine Conveyor - Sensor', 'Cartoner - Magazine Conveyor - Sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(135, 1, 'Br.121', 'br', 'Cartoner', 'Magazine Guide Penahan Folding - Atas', 'Cartoner - Magazine Guide Penahan Folding - Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(136, 1, 'Br.122', 'br', 'Cartoner', 'Magazine Guide Penahan Folding - Bawah', 'Cartoner - Magazine Guide Penahan Folding - Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(137, 1, 'Br.123', 'br', 'Cartoner', 'Panel control FB', 'Cartoner - Panel control FB', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(138, 1, 'Br.124', 'br', 'Cartoner', 'Panel Cooler 1', 'Cartoner - Panel Cooler 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(139, 1, 'Br.125', 'br', 'Cartoner', 'Panel Cooler 2', 'Cartoner - Panel Cooler 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(140, 1, 'Br.126', 'br', 'Cartoner', 'Panel Componen Sensor FB', 'Cartoner - Panel Componen Sensor FB', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(141, 1, 'Br.127', 'br', 'Cartoner', 'Panel Lampu Indikator', 'Cartoner - Panel Lampu Indikator', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(142, 1, 'Br.128', 'br', 'Cartoner', 'Rotary pick box - Suction cup', 'Cartoner - Rotary pick box - Suction cup', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(143, 1, 'Br.129', 'br', 'Cartoner', 'Rotary pick box - Suction pipe', 'Cartoner - Rotary pick box - Suction pipe', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(144, 1, 'Br.130', 'br', 'Cartoner', 'Rotary pick box - Belt Rotary', 'Cartoner - Rotary pick box - Belt Rotary', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(145, 1, 'Br.131', 'br', 'Cartoner', 'Rotary pick box - Suction filter', 'Cartoner - Rotary pick box - Suction filter', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(146, 1, 'Br.132', 'br', 'Cartoner', 'Rotary pick box - Air Vacuum', 'Cartoner - Rotary pick box - Air Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(147, 1, 'Br.133', 'br', 'Cartoner', 'Piston Smoother', 'Cartoner - Piston Smoother', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(148, 1, 'Br.134', 'br', 'Cartoner', 'Motor Smoother', 'Cartoner - Motor Smoother', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(149, 1, 'Br.135', 'br', 'Cartoner', 'Conveyor Casette - Plat adjust', 'Cartoner - Conveyor Casette - Plat adjust', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(150, 1, 'Br.136', 'br', 'Cartoner', 'Conveyor Casette - Plat Insertion', 'Cartoner - Conveyor Casette - Plat Insertion', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(151, 1, 'Br.137', 'br', 'Cartoner', 'Conveyor Casette - Assistant Bucket', 'Cartoner - Conveyor Casette - Assistant Bucket', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(152, 1, 'Br.138', 'br', 'Cartoner', 'Conveyor Casette - Teplon', 'Cartoner - Conveyor Casette - Teplon', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(153, 1, 'Br.139', 'br', 'Cartoner', 'Conveyor Casette - Rantai Adjust', 'Cartoner - Conveyor Casette - Rantai Adjust', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(154, 1, 'Br.140', 'br', 'Cartoner', 'Conveyor Casette - Rantai Insertion', 'Cartoner - Conveyor Casette - Rantai Insertion', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(155, 1, 'Br.141', 'br', 'Cartoner', 'Conveyor Casette - Motor Rantai Adjust', 'Cartoner - Conveyor Casette - Motor Rantai Adjust', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(156, 1, 'Br.142', 'br', 'Cartoner', 'Conveyor Casette - Motor Rantai Insertion', 'Cartoner - Conveyor Casette - Motor Rantai Insertion', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(157, 1, 'Br.143', 'br', 'Cartoner', 'Folding Conveyor - Top Guide', 'Cartoner - Folding Conveyor - Top Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(158, 1, 'Br.144', 'br', 'Cartoner', 'Folding Conveyor - Guide Inside', 'Cartoner - Folding Conveyor - Guide Inside', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(159, 1, 'Br.145', 'br', 'Cartoner', 'Folding Conveyor - Guide Outside', 'Cartoner - Folding Conveyor - Guide Outside', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(160, 1, 'Br.146', 'br', 'Cartoner', 'Folding Conveyor - Chain & Sprocket Inside', 'Cartoner - Folding Conveyor - Chain & Sprocket Inside', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(161, 1, 'Br.147', 'br', 'Cartoner', 'Folding Conveyor - Chain & Sprocket Outside', 'Cartoner - Folding Conveyor - Chain & Sprocket Outside', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(162, 1, 'Br.148', 'br', 'Cartoner', 'Folding Conveyor - Motor Chain Inside', 'Cartoner - Folding Conveyor - Motor Chain Inside', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(163, 1, 'Br.149', 'br', 'Cartoner', 'Folding Conveyor - Motor Chain Outside', 'Cartoner - Folding Conveyor - Motor Chain Outside', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(164, 1, 'Br.150', 'br', 'Cartoner', 'Sensor Diverter', 'Cartoner - Sensor Diverter', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(165, 1, 'Br.151', 'br', 'Cartoner', 'Piston Diverter', 'Cartoner - Piston Diverter', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(166, 1, 'Br.152', 'br', 'Cartoner', 'Selenoid Diverter', 'Cartoner - Selenoid Diverter', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(167, 1, 'Br.153', 'br', 'Cartoner', 'Actuator', 'Cartoner - Actuator', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(168, 1, 'Br.154', 'br', 'Cartoner', 'Bag Pusher - Chain', 'Cartoner - Bag Pusher - Chain', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(169, 1, 'Br.155', 'br', 'Cartoner', 'Bag Pusher - Pusher Chip', 'Cartoner - Bag Pusher - Pusher Chip', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(170, 1, 'Br.156', 'br', 'Cartoner', 'Bag Pusher - Shaft Pusher', 'Cartoner - Bag Pusher - Shaft Pusher', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(171, 1, 'Br.157', 'br', 'Cartoner', 'Bag Pusher - Sensor Jamp Product', 'Cartoner - Bag Pusher - Sensor Jamp Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(172, 1, 'Br.158', 'br', 'Cartoner', 'Bag Pusher - Ejector', 'Cartoner - Bag Pusher - Ejector', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(173, 1, 'Br.159', 'br', 'Cartoner', 'Guide Pembuka Lidah - Atas', 'Cartoner - Guide Pembuka Lidah - Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(174, 1, 'Br.160', 'br', 'Cartoner', 'Guide Pembuka Lidah - Bawah', 'Cartoner - Guide Pembuka Lidah - Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(175, 1, 'Br.161', 'br', 'Cartoner', 'Flap Closured Atas', 'Cartoner - Flap Closured Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(176, 1, 'Br.162', 'br', 'Cartoner', 'Flap Closured Bawah', 'Cartoner - Flap Closured Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(177, 1, 'Br.163', 'br', 'Cartoner', 'Sensor Folding Box', 'Cartoner - Sensor Folding Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(178, 1, 'Br.164', 'br', 'Cartoner', 'Sensor Spoon', 'Cartoner - Sensor Spoon', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(179, 1, 'Br.165', 'br', 'Cartoner', 'Sensor Alufo', 'Cartoner - Sensor Alufo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(180, 1, 'Br.166', 'br', 'Cartoner', 'Sensor Product corect in box', 'Cartoner - Sensor Product corect in box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(181, 1, 'Br.167', 'br', 'Cartoner', 'Sensor Product available in box', 'Cartoner - Sensor Product available in box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(182, 1, 'Br.168', 'br', 'Cartoner', 'Sensor Safety Door FB', 'Cartoner - Sensor Safety Door FB', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(183, 1, 'Br.169', 'br', 'Cartoner', 'Printer FB - printer unit', 'Cartoner - Printer FB - printer unit', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(184, 1, 'Br.170', 'br', 'Cartoner', 'Printer FB - Display', 'Cartoner - Printer FB - Display', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(185, 1, 'Br.171', 'br', 'Cartoner', 'Printer FB - hose', 'Cartoner - Printer FB - hose', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(186, 1, 'Br.172', 'br', 'Cartoner', 'Printer FB - printer Head', 'Cartoner - Printer FB - printer Head', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(187, 1, 'Br.173', 'br', 'Cartoner', 'Printer FB - sensor', 'Cartoner - Printer FB - sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(188, 1, 'Br.174', 'br', 'Cartoner', 'Sensor Open Flap FB', 'Cartoner - Sensor Open Flap FB', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(189, 1, 'Br.175', 'br', 'Cartoner', 'Glueing System - box Glue', 'Cartoner - Glueing System - box Glue', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(190, 1, 'Br.176', 'br', 'Cartoner', 'Glueing System - Hose', 'Cartoner - Glueing System - Hose', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(191, 1, 'Br.177', 'br', 'Cartoner', 'Glueing System - Nozzle', 'Cartoner - Glueing System - Nozzle', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(192, 1, 'Br.178', 'br', 'Cartoner', 'Glueing System - Guide pelipat Bawah', 'Cartoner - Glueing System - Guide pelipat Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(193, 1, 'Br.179', 'br', 'Cartoner', 'Glueing System - Guide pelipat Atas', 'Cartoner - Glueing System - Guide pelipat Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(194, 1, 'Br.180', 'br', 'Cartoner', 'Barcode - Panel', 'Cartoner - Barcode - Panel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(195, 1, 'Br.181', 'br', 'Cartoner', 'Barcode - sensor', 'Cartoner - Barcode - sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(196, 1, 'Br.182', 'br', 'Cartoner', 'Discharge belt - belt', 'Cartoner - Discharge belt - belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(197, 1, 'Br.183', 'br', 'Cartoner', 'Discharge belt - Motor', 'Cartoner - Discharge belt - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(198, 1, 'Br.184', 'br', 'Cartoner', 'Discharge belt - teflon Ejector', 'Cartoner - Discharge belt - teflon Ejector', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(199, 1, 'Br.185', 'br', 'Cartoner', 'Discharge belt - Sensor', 'Cartoner - Discharge belt - Sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(200, 1, 'Br.186', 'br', 'Conveyor Output Folding Box', 'Belt', 'Conveyor Output Folding Box - Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(201, 1, 'Br.187', 'br', 'Conveyor Output Folding Box', 'Bearing & Shaft', 'Conveyor Output Folding Box - Bearing & Shaft', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(202, 1, 'Br.188', 'br', 'Conveyor Output Folding Box', 'Motor', 'Conveyor Output Folding Box - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(203, 1, 'Br.189', 'br', 'Dalsa', 'Camera', 'Dalsa - Camera', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(204, 1, 'Br.190', 'br', 'Dalsa', 'Display', 'Dalsa - Display', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(205, 1, 'Br.191', 'br', 'Dalsa', 'Sensor', 'Dalsa - Sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(206, 1, 'Br.192', 'br', 'Dalsa', 'UPS', 'Dalsa - UPS', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(207, 1, 'Br.193', 'br', 'Dalsa', 'Power Supply', 'Dalsa - Power Supply', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(208, 1, 'Br.194', 'br', 'X-ray', 'Motor', 'X-ray - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(209, 1, 'Br.195', 'br', 'X-ray', 'Belt Conveyor', 'X-ray - Belt Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(210, 1, 'Br.196', 'br', 'X-ray', 'Bearing & Shaft', 'X-ray - Bearing & Shaft', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(211, 1, 'Br.197', 'br', 'X-ray', 'Sensor photocell & reflektor', 'X-ray - Sensor photocell & reflektor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(212, 1, 'Br.198', 'br', 'X-ray', 'Screen', 'X-ray - Screen', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(213, 1, 'Br.199', 'br', 'X-ray', 'Panel', 'X-ray - Panel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(214, 1, 'Br.200', 'br', 'Casepacker', 'Air Pressure', 'Casepacker - Air Pressure', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(215, 1, 'Br.201', 'br', 'Casepacker - Infeed Conveyor', 'Guide', 'Casepacker - Infeed Conveyor - Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(216, 1, 'Br.202', 'br', 'Casepacker - Infeed Conveyor', 'Belt', 'Casepacker - Infeed Conveyor - Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(217, 1, 'Br.203', 'br', 'Casepacker - Infeed Conveyor', 'Motor', 'Casepacker - Infeed Conveyor - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(218, 1, 'Br.204', 'br', 'Casepacker - Infeed Conveyor', 'Chain & Sprocket', 'Casepacker - Infeed Conveyor - Chain & Sprocket', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(219, 1, 'Br.205', 'br', 'Casepacker - Infeed Conveyor', 'Potensio speed', 'Casepacker - Infeed Conveyor - Potensio speed', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(220, 1, 'Br.206', 'br', 'Casepacker - Conveyor Product', 'Piston Stopper', 'Casepacker - Conveyor Product - Piston Stopper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(221, 1, 'Br.207', 'br', 'Casepacker - Conveyor Product', 'Teflon Piston Stopper', 'Casepacker - Conveyor Product - Teflon Piston Stopper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(222, 1, 'Br.208', 'br', 'Casepacker - Conveyor Product', 'Unit Solenoid Piston Stopper', 'Casepacker - Conveyor Product - Unit Solenoid Piston Stopper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(223, 1, 'Br.209', 'br', 'Casepacker - Conveyor Product', 'Hose & Conector Piston Stopper', 'Casepacker - Conveyor Product - Hose & Conector Piston Stopper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(224, 1, 'Br.210', 'br', 'Casepacker - Conveyor Product', 'Sensor Counting Product 1', 'Casepacker - Conveyor Product - Sensor Counting Product 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(225, 1, 'Br.211', 'br', 'Casepacker - Conveyor Product', 'Sensor Counting Product 2', 'Casepacker - Conveyor Product - Sensor Counting Product 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(226, 1, 'Br.212', 'br', 'Casepacker - Conveyor Product', 'Motor', 'Casepacker - Conveyor Product - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(227, 1, 'Br.213', 'br', 'Casepacker - Conveyor Product', 'Belt', 'Casepacker - Conveyor Product - Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(228, 1, 'Br.214', 'br', 'Casepacker - Conveyor Product', 'Chain & Sprocket', 'Casepacker - Conveyor Product - Chain & Sprocket', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(229, 1, 'Br.215', 'br', 'Casepacker - Transfer Counting', 'Piston Horizontal', 'Casepacker - Transfer Counting - Piston Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(230, 1, 'Br.216', 'br', 'Casepacker - Transfer Counting', 'Teflon Piston Horizontal', 'Casepacker - Transfer Counting - Teflon Piston Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(231, 1, 'Br.217', 'br', 'Casepacker - Transfer Counting', 'Unit Solenoid Piston Horizontal', 'Casepacker - Transfer Counting - Unit Solenoid Piston Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(232, 1, 'Br.218', 'br', 'Casepacker - Transfer Counting', 'Hose & Conector Piston Horizontal', 'Casepacker - Transfer Counting - Hose & Conector Piston Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(233, 1, 'Br.219', 'br', 'Casepacker - Transfer Counting', 'Shaft Linier Piston Horizontal', 'Casepacker - Transfer Counting - Shaft Linier Piston Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(234, 1, 'Br.220', 'br', 'Casepacker - Transfer Counting', 'Piston Vertical', 'Casepacker - Transfer Counting - Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(235, 1, 'Br.221', 'br', 'Casepacker - Transfer Counting', 'Teflon Piston Vertical', 'Casepacker - Transfer Counting - Teflon Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(236, 1, 'Br.222', 'br', 'Casepacker - Transfer Counting', 'Unit Solenoid Piston Vertical', 'Casepacker - Transfer Counting - Unit Solenoid Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(237, 1, 'Br.223', 'br', 'Casepacker - Transfer Counting', 'Hose & Conector Piston Vertical', 'Casepacker - Transfer Counting - Hose & Conector Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(238, 1, 'Br.224', 'br', 'Casepacker - Transfer Counting', 'Shaft Linier Piston Vertical', 'Casepacker - Transfer Counting - Shaft Linier Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(239, 1, 'Br.225', 'br', 'Casepacker - Stacker', 'Home Stacker', 'Casepacker - Stacker - Home Stacker', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(240, 1, 'Br.226', 'br', 'Casepacker - Stacker', 'Hand wheel', 'Casepacker - Stacker - Hand wheel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(241, 1, 'Br.227', 'br', 'Casepacker - Stacker', 'Piston Vertical', 'Casepacker - Stacker - Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(242, 1, 'Br.228', 'br', 'Casepacker - Stacker', 'Teflon Piston Vertical', 'Casepacker - Stacker - Teflon Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(243, 1, 'Br.229', 'br', 'Casepacker - Stacker', 'Unit Solenoid Piston Vertical', 'Casepacker - Stacker - Unit Solenoid Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(244, 1, 'Br.230', 'br', 'Casepacker - Stacker', 'Hose & Conector Piston Vertical', 'Casepacker - Stacker - Hose & Conector Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(245, 1, 'Br.231', 'br', 'Casepacker - Stacker', 'Shaft Linier Piston Vertical', 'Casepacker - Stacker - Shaft Linier Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(246, 1, 'Br.232', 'br', 'Casepacker - Stacker', 'Sensor Counting Vertical', 'Casepacker - Stacker - Sensor Counting Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(247, 1, 'Br.233', 'br', 'Casepacker - Stacker', 'Keeper', 'Casepacker - Stacker - Keeper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(248, 1, 'Br.234', 'br', 'Casepacker - Transfer Servo Actuator', 'Motor Servo', 'Casepacker - Transfer Servo Actuator - Motor Servo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(249, 1, 'Br.235', 'br', 'Casepacker - Transfer Servo Actuator', 'Chain & Sprocket', 'Casepacker - Transfer Servo Actuator - Chain & Sprocket', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(250, 1, 'Br.236', 'br', 'Casepacker - Transfer Servo Actuator', 'Sensor Homing', 'Casepacker - Transfer Servo Actuator - Sensor Homing', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(251, 1, 'Br.237', 'br', 'Casepacker - Transfer Servo Actuator', 'Piston', 'Casepacker - Transfer Servo Actuator - Piston', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(252, 1, 'Br.238', 'br', 'Casepacker - Transfer Servo Actuator', 'Unit Solenoid Piston Vertical', 'Casepacker - Transfer Servo Actuator - Unit Solenoid Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(253, 1, 'Br.239', 'br', 'Casepacker - Transfer Servo Actuator', 'Hose & Conector Piston Vertical', 'Casepacker - Transfer Servo Actuator - Hose & Conector Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(254, 1, 'Br.240', 'br', 'Casepacker - Transfer Servo Actuator', 'Linier Guide Horizontal', 'Casepacker - Transfer Servo Actuator - Linier Guide Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(255, 1, 'Br.241', 'br', 'Casepacker - Transfer Servo Actuator', 'Linier Guide Vertical', 'Casepacker - Transfer Servo Actuator - Linier Guide Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(256, 1, 'Br.242', 'br', 'Casepacker - Transfer Servo Actuator', 'Teflon Transfer', 'Casepacker - Transfer Servo Actuator - Teflon Transfer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(257, 1, 'Br.243', 'br', 'Casepacker - Transfer To Box', 'Plat Penahan Product', 'Casepacker - Transfer To Box - Plat Penahan Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(258, 1, 'Br.244', 'br', 'Casepacker - Transfer To Box', 'Meja insert box', 'Casepacker - Transfer To Box - Meja insert box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(259, 1, 'Br.245', 'br', 'Casepacker - Transfer To Box', 'Piston meja insert box', 'Casepacker - Transfer To Box - Piston meja insert box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(260, 1, 'Br.246', 'br', 'Casepacker - Transfer To Box', 'Unit Solenoid Piston meja insert box', 'Casepacker - Transfer To Box - Unit Solenoid Piston meja insert box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(261, 1, 'Br.247', 'br', 'Casepacker - Transfer To Box', 'Hose & Conector Piston meja insert box', 'Casepacker - Transfer To Box - Hose & Conector Piston meja insert box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(262, 1, 'Br.248', 'br', 'Casepacker - Transfer To Box', 'Linier guide piston meja insert box', 'Casepacker - Transfer To Box - Linier guide piston meja insert box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(263, 1, 'Br.249', 'br', 'Casepacker - Transfer To Box', 'Hand Wheel Meja Insert Box', 'Casepacker - Transfer To Box - Hand Wheel Meja Insert Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(264, 1, 'Br.250', 'br', 'Casepacker - Transfer To Box', 'Plat pusher insert Box', 'Casepacker - Transfer To Box - Plat pusher insert Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(265, 1, 'Br.251', 'br', 'Casepacker - Transfer To Box', 'Piston pusher insert Box', 'Casepacker - Transfer To Box - Piston pusher insert Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(266, 1, 'Br.252', 'br', 'Casepacker - Transfer To Box', 'Unit Solenoid Piston pusher insert Box', 'Casepacker - Transfer To Box - Unit Solenoid Piston pusher insert Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(267, 1, 'Br.253', 'br', 'Casepacker - Transfer To Box', 'Hose & Conector Piston pusher insert Box', 'Casepacker - Transfer To Box - Hose & Conector Piston pusher insert Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(268, 1, 'Br.254', 'br', 'Casepacker - Transfer To Box', 'Linier guide piston pusher insert box', 'Casepacker - Transfer To Box - Linier guide piston pusher insert box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(269, 1, 'Br.255', 'br', 'Casepacker - Transfer To Box', 'Piston Maker Row', 'Casepacker - Transfer To Box - Piston Maker Row', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(270, 1, 'Br.256', 'br', 'Casepacker - Transfer To Box', 'Unit Solenoid Piston Maker Row', 'Casepacker - Transfer To Box - Unit Solenoid Piston Maker Row', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(271, 1, 'Br.257', 'br', 'Casepacker - Transfer To Box', 'Hose & Conector Piston Maker Row', 'Casepacker - Transfer To Box - Hose & Conector Piston Maker Row', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(272, 1, 'Br.258', 'br', 'Casepacker - Transfer To Box', 'Linier guide piston Maker Row', 'Casepacker - Transfer To Box - Linier guide piston Maker Row', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(273, 1, 'Br.259', 'br', 'Casepacker - Transfer To Box', 'Hand Wheel Maker Row', 'Casepacker - Transfer To Box - Hand Wheel Maker Row', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(274, 1, 'Br.260', 'br', 'Casepacker - Transfer To Box', 'Side Open Plat', 'Casepacker - Transfer To Box - Side Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(275, 1, 'Br.261', 'br', 'Casepacker - Transfer To Box', 'Upper Open Plat', 'Casepacker - Transfer To Box - Upper Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(276, 1, 'Br.262', 'br', 'Casepacker - Transfer To Box', 'Piston Open Plat', 'Casepacker - Transfer To Box - Piston Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(277, 1, 'Br.263', 'br', 'Casepacker - Transfer To Box', 'Sensor Gagal Forming CB', 'Casepacker - Transfer To Box - Sensor Gagal Forming CB', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(278, 1, 'Br.264', 'br', 'Casepacker - Transfer To Box', 'Unit Solenoid Piston Open Plat', 'Casepacker - Transfer To Box - Unit Solenoid Piston Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(279, 1, 'Br.265', 'br', 'Casepacker - Transfer To Box', 'Hose & Conector Piston Open Plat', 'Casepacker - Transfer To Box - Hose & Conector Piston Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(280, 1, 'Br.266', 'br', 'Casepacker - Transfer To Box', 'Shaft Linier Open Plat', 'Casepacker - Transfer To Box - Shaft Linier Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(281, 1, 'Br.267', 'br', 'Casepacker - Transfer To Box', 'Hand wheel Open Plat', 'Casepacker - Transfer To Box - Hand wheel Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(282, 1, 'Br.268', 'br', 'Casepacker - Transfer To Box', 'Teflon Piston Penahan Product', 'Casepacker - Transfer To Box - Teflon Piston Penahan Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(283, 1, 'Br.269', 'br', 'Casepacker - Transfer To Box', 'Piston Penahan Product', 'Casepacker - Transfer To Box - Piston Penahan Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(284, 1, 'Br.270', 'br', 'Casepacker - Transfer To Box', 'Unit Solenoid Piston Penahan Product', 'Casepacker - Transfer To Box - Unit Solenoid Piston Penahan Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(285, 1, 'Br.271', 'br', 'Casepacker - Transfer To Box', 'Hose & Conector Piston Penahan Product', 'Casepacker - Transfer To Box - Hose & Conector Piston Penahan Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(286, 1, 'Br.272', 'br', 'Casepacker - Transfer To Box', 'Shaft Linier Piston Penahan Product', 'Casepacker - Transfer To Box - Shaft Linier Piston Penahan Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(287, 1, 'Br.273', 'br', 'Casepacker - Magazine', 'Belt Conveyor', 'Casepacker - Magazine - Belt Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(288, 1, 'Br.274', 'br', 'Casepacker - Magazine', 'Limit Switch', 'Casepacker - Magazine - Limit Switch', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(289, 1, 'Br.275', 'br', 'Casepacker - Magazine', 'Piston Upper', 'Casepacker - Magazine - Piston Upper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(290, 1, 'Br.276', 'br', 'Casepacker - Magazine', 'Adjuster Height', 'Casepacker - Magazine - Adjuster Height', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(291, 1, 'Br.277', 'br', 'Casepacker - Magazine', 'Adjuster Widht', 'Casepacker - Magazine - Adjuster Widht', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(292, 1, 'Br.278', 'br', 'Casepacker - Magazine', 'Motor Servo', 'Casepacker - Magazine - Motor Servo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(293, 1, 'Br.279', 'br', 'Casepacker - Magazine', 'Chain & Sprocket', 'Casepacker - Magazine - Chain & Sprocket', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(294, 1, 'Br.280', 'br', 'Casepacker - Magazine', 'Carton Guide', 'Casepacker - Magazine - Carton Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(295, 1, 'Br.281', 'br', 'Casepacker - Magazine', 'Adjuster Carton Guide', 'Casepacker - Magazine - Adjuster Carton Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(296, 1, 'Br.282', 'br', 'Casepacker - Magazine', 'Roller', 'Casepacker - Magazine - Roller', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(297, 1, 'Br.283', 'br', 'Casepacker - Magazine', 'Carton Open Guide', 'Casepacker - Magazine - Carton Open Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(298, 1, 'Br.284', 'br', 'Casepacker - Conveyor Box', 'Motor', 'Casepacker - Conveyor Box - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(299, 1, 'Br.285', 'br', 'Casepacker - Conveyor Box', 'Chain & Sprocket', 'Casepacker - Conveyor Box - Chain & Sprocket', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(300, 1, 'Br.286', 'br', 'Casepacker - Conveyor Box', 'Adjuster Finger In', 'Casepacker - Conveyor Box - Adjuster Finger In', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(301, 1, 'Br.287', 'br', 'Casepacker - Conveyor Box', 'Finger In', 'Casepacker - Conveyor Box - Finger In', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(302, 1, 'Br.288', 'br', 'Casepacker - Conveyor Box', 'Finger Out', 'Casepacker - Conveyor Box - Finger Out', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(303, 1, 'Br.289', 'br', 'Casepacker - Conveyor Box', 'Suction Cup', 'Casepacker - Conveyor Box - Suction Cup', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(304, 1, 'Br.290', 'br', 'Casepacker - Conveyor Box', 'Lengan Vacuum', 'Casepacker - Conveyor Box - Lengan Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(305, 1, 'Br.291', 'br', 'Casepacker - Conveyor Box', 'Shaft Vacuum', 'Casepacker - Conveyor Box - Shaft Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(306, 1, 'Br.292', 'br', 'Casepacker - Conveyor Box', 'Piston Vacuum', 'Casepacker - Conveyor Box - Piston Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(307, 1, 'Br.293', 'br', 'Casepacker - Conveyor Box', 'Unit Solenoid Piston Vacuum', 'Casepacker - Conveyor Box - Unit Solenoid Piston Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(308, 1, 'Br.294', 'br', 'Casepacker - Conveyor Box', 'Hose & Conector Piston Vacuum', 'Casepacker - Conveyor Box - Hose & Conector Piston Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(309, 1, 'Br.295', 'br', 'Casepacker - Conveyor Box', 'Solenoid Vacuum', 'Casepacker - Conveyor Box - Solenoid Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(310, 1, 'Br.296', 'br', 'Casepacker - Conveyor Box', 'Manifold Vacuum', 'Casepacker - Conveyor Box - Manifold Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(311, 1, 'Br.297', 'br', 'Casepacker - Conveyor Box', 'Side Guide', 'Casepacker - Conveyor Box - Side Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(312, 1, 'Br.298', 'br', 'Casepacker - Conveyor Box', 'Piston Side Guide', 'Casepacker - Conveyor Box - Piston Side Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(313, 1, 'Br.299', 'br', 'Casepacker - Conveyor Box', 'Unit Solenoid Piston Side Guide', 'Casepacker - Conveyor Box - Unit Solenoid Piston Side Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(314, 1, 'Br.300', 'br', 'Casepacker - Conveyor Box', 'Hose & Conector Piston Side Guide', 'Casepacker - Conveyor Box - Hose & Conector Piston Side Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(315, 1, 'Br.301', 'br', 'Casepacker - Conveyor Box', 'Hand Wheel', 'Casepacker - Conveyor Box - Hand Wheel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(316, 1, 'Br.302', 'br', 'Casepacker - Conveyor Box', 'Sensor Vacuum', 'Casepacker - Conveyor Box - Sensor Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(317, 1, 'Br.303', 'br', 'Casepacker - Conveyor Box', 'Sensor Stand By Carton', 'Casepacker - Conveyor Box - Sensor Stand By Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `mactivitycode` (`id`, `line_id`, `txtactivitycode`, `txtcategory`, `txtactivityname`, `txtactivityitem`, `txtdescription`, `created_at`, `updated_at`) VALUES
(318, 1, 'Br.304', 'br', 'Casepacker - Conveyor Box', 'Sensor Stopper Finger', 'Casepacker - Conveyor Box - Sensor Stopper Finger', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(319, 1, 'Br.305', 'br', 'Casepacker - Conveyor Box', 'Sensor Pusher Box', 'Casepacker - Conveyor Box - Sensor Pusher Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(320, 1, 'Br.306', 'br', 'Casepacker - Conveyor Box', 'Guide Lidah Bawah Carton Box', 'Casepacker - Conveyor Box - Guide Lidah Bawah Carton Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(321, 1, 'Br.307', 'br', 'Casepacker - Panel Electric', 'Panel', 'Casepacker - Panel Electric - Panel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(322, 1, 'Br.308', 'br', 'Casepacker - Panel Electric', 'Program & System', 'Casepacker - Panel Electric - Program & System', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(323, 1, 'Br.309', 'br', 'Casepacker - Panel Electric', 'Switch Safety door', 'Casepacker - Panel Electric - Switch Safety door', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(324, 1, 'Br.310', 'br', 'Casepacker - Panel Electric', 'Touch Screen', 'Casepacker - Panel Electric - Touch Screen', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(325, 1, 'Br.311', 'br', 'Casepacker - Panel Electric', 'Emergency Stop', 'Casepacker - Panel Electric - Emergency Stop', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(326, 1, 'Br.312', 'br', 'Casepacker - Conveyor Sealer', 'Pusher Box', 'Casepacker - Conveyor Sealer - Pusher Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(327, 1, 'Br.313', 'br', 'Casepacker - Conveyor Sealer', 'Piston Pusher Box', 'Casepacker - Conveyor Sealer - Piston Pusher Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(328, 1, 'Br.314', 'br', 'Casepacker - Conveyor Sealer', 'Unit Solenoid Piston Pusher Box', 'Casepacker - Conveyor Sealer - Unit Solenoid Piston Pusher Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(329, 1, 'Br.315', 'br', 'Casepacker - Conveyor Sealer', 'Hose & Conector Piston Pusher Box', 'Casepacker - Conveyor Sealer - Hose & Conector Piston Pusher Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(330, 1, 'Br.316', 'br', 'Casepacker - Conveyor Sealer', 'Tuck In', 'Casepacker - Conveyor Sealer - Tuck In', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(331, 1, 'Br.317', 'br', 'Casepacker - Conveyor Sealer', 'Piston Tuck In', 'Casepacker - Conveyor Sealer - Piston Tuck In', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(332, 1, 'Br.318', 'br', 'Casepacker - Conveyor Sealer', 'Unit Solenoid Piston Tuck In', 'Casepacker - Conveyor Sealer - Unit Solenoid Piston Tuck In', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(333, 1, 'Br.319', 'br', 'Casepacker - Conveyor Sealer', 'Hose & Conector Piston Tuck In', 'Casepacker - Conveyor Sealer - Hose & Conector Piston Tuck In', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(334, 1, 'Br.320', 'br', 'Casepacker - Conveyor Sealer', 'Guide Up', 'Casepacker - Conveyor Sealer - Guide Up', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(335, 1, 'Br.321', 'br', 'Casepacker - Conveyor Sealer', 'Piston Guide Up', 'Casepacker - Conveyor Sealer - Piston Guide Up', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(336, 1, 'Br.322', 'br', 'Casepacker - Conveyor Sealer', 'Unit Solenoid Piston Guide Up', 'Casepacker - Conveyor Sealer - Unit Solenoid Piston Guide Up', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(337, 1, 'Br.323', 'br', 'Casepacker - Conveyor Sealer', 'Hose & Conector Piston Guide Up', 'Casepacker - Conveyor Sealer - Hose & Conector Piston Guide Up', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(338, 1, 'Br.324', 'br', 'Casepacker - Conveyor Sealer', 'Linier Shaft Piston Guide Up', 'Casepacker - Conveyor Sealer - Linier Shaft Piston Guide Up', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(339, 1, 'Br.325', 'br', 'Casepacker - Conveyor Sealer', 'Guide Down', 'Casepacker - Conveyor Sealer - Guide Down', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(340, 1, 'Br.326', 'br', 'Casepacker - Conveyor Sealer', 'Piston Guide Down', 'Casepacker - Conveyor Sealer - Piston Guide Down', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(341, 1, 'Br.327', 'br', 'Casepacker - Conveyor Sealer', 'Unit Solenoid Piston Guide Down', 'Casepacker - Conveyor Sealer - Unit Solenoid Piston Guide Down', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(342, 1, 'Br.328', 'br', 'Casepacker - Conveyor Sealer', 'Hose & Conector Piston Guide Down', 'Casepacker - Conveyor Sealer - Hose & Conector Piston Guide Down', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(343, 1, 'Br.329', 'br', 'Casepacker - Conveyor Sealer', 'Linier Shaft Piston Guide Down', 'Casepacker - Conveyor Sealer - Linier Shaft Piston Guide Down', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(344, 1, 'Br.330', 'br', 'Casepacker - Conveyor Sealer', 'Stopper Carton', 'Casepacker - Conveyor Sealer - Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(345, 1, 'Br.331', 'br', 'Casepacker - Conveyor Sealer', 'Piston Stopper Carton', 'Casepacker - Conveyor Sealer - Piston Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(346, 1, 'Br.332', 'br', 'Casepacker - Conveyor Sealer', 'Unit Solenoid Piston Stopper Carton', 'Casepacker - Conveyor Sealer - Unit Solenoid Piston Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(347, 1, 'Br.333', 'br', 'Casepacker - Conveyor Sealer', 'Hose & Conector Piston Stopper Carton', 'Casepacker - Conveyor Sealer - Hose & Conector Piston Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(348, 1, 'Br.334', 'br', 'Casepacker - Conveyor Sealer', 'Sensor Sealer Carton', 'Casepacker - Conveyor Sealer - Sensor Sealer Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(349, 1, 'Br.335', 'br', 'Casepacker - Conveyor Sealer', 'Sensor Stopper Finger Sealer', 'Casepacker - Conveyor Sealer - Sensor Stopper Finger Sealer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(350, 1, 'Br.336', 'br', 'Casepacker - Conveyor Sealer', 'Guide 01', 'Casepacker - Conveyor Sealer - Guide 01', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(351, 1, 'Br.337', 'br', 'Casepacker - Conveyor Sealer', 'Guide 02', 'Casepacker - Conveyor Sealer - Guide 02', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(352, 1, 'Br.338', 'br', 'Casepacker - Conveyor Sealer', 'Guide 03', 'Casepacker - Conveyor Sealer - Guide 03', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(353, 1, 'Br.339', 'br', 'Casepacker - Conveyor Sealer', 'Guide 04', 'Casepacker - Conveyor Sealer - Guide 04', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(354, 1, 'Br.340', 'br', 'Casepacker - Conveyor Sealer', 'Guide 05', 'Casepacker - Conveyor Sealer - Guide 05', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(355, 1, 'Br.341', 'br', 'Casepacker - Conveyor Sealer', 'Guide 06', 'Casepacker - Conveyor Sealer - Guide 06', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(356, 1, 'Br.342', 'br', 'Casepacker - Conveyor Sealer', 'Guide 07', 'Casepacker - Conveyor Sealer - Guide 07', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(357, 1, 'Br.343', 'br', 'Casepacker - Conveyor Sealer', 'Guide 08', 'Casepacker - Conveyor Sealer - Guide 08', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(358, 1, 'Br.344', 'br', 'Casepacker - Conveyor Sealer', 'Guide 09', 'Casepacker - Conveyor Sealer - Guide 09', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(359, 1, 'Br.345', 'br', 'Casepacker - Conveyor Sealer', 'Guide 10', 'Casepacker - Conveyor Sealer - Guide 10', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(360, 1, 'Br.346', 'br', 'Casepacker - Conveyor Sealer', 'Sealer', 'Casepacker - Conveyor Sealer - Sealer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(361, 1, 'Br.347', 'br', 'Casepacker - Conveyor Sealer', 'Finger Conveyor Sealer Atas', 'Casepacker - Conveyor Sealer - Finger Conveyor Sealer Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(362, 1, 'Br.348', 'br', 'Casepacker - Conveyor Sealer', 'Finger Conveyor Sealer Bawah', 'Casepacker - Conveyor Sealer - Finger Conveyor Sealer Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(363, 1, 'Br.349', 'br', 'Casepacker - Conveyor Sealer', 'Motor', 'Casepacker - Conveyor Sealer - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(364, 1, 'Br.350', 'br', 'Casepacker - Conveyor Sealer', 'Hand Wheel Horizontal', 'Casepacker - Conveyor Sealer - Hand Wheel Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(365, 1, 'Br.351', 'br', 'Casepacker - Conveyor Sealer', 'Hand Wheel Vertical', 'Casepacker - Conveyor Sealer - Hand Wheel Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(366, 1, 'Br.352', 'br', 'Casepacker - Conveyor Sealer', 'Drive Mekanikal', 'Casepacker - Conveyor Sealer - Drive Mekanikal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(367, 1, 'Br.353', 'br', 'Casepacker - Conveyor Sealer', 'Bevel Gear', 'Casepacker - Conveyor Sealer - Bevel Gear', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(368, 1, 'Br.354', 'br', 'Conveyor Output Carton', 'Motor Pembalik Carton', 'Conveyor Output Carton - Motor Pembalik Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(369, 1, 'Br.355', 'br', 'Conveyor Output Carton', 'Chain & Sprocket Pembalik Carton', 'Conveyor Output Carton - Chain & Sprocket Pembalik Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(370, 1, 'Br.356', 'br', 'Conveyor Output Carton', 'Shaft Pembalik Carton', 'Conveyor Output Carton - Shaft Pembalik Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(371, 1, 'Br.357', 'br', 'Conveyor Output Carton', 'Handle Pembalik Carton', 'Conveyor Output Carton - Handle Pembalik Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(372, 1, 'Br.358', 'br', 'Conveyor Output Carton', 'Sensor Pembalik Carton', 'Conveyor Output Carton - Sensor Pembalik Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(373, 1, 'Br.359', 'br', 'Conveyor Output Carton', 'Sensor Detector Carton', 'Conveyor Output Carton - Sensor Detector Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(374, 1, 'Br.360', 'br', 'Conveyor Output Carton', 'Motor Roller Conveyor', 'Conveyor Output Carton - Motor Roller Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(375, 1, 'Br.361', 'br', 'Conveyor Output Carton', 'Roller', 'Conveyor Output Carton - Roller', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(376, 1, 'Br.362', 'br', 'Conveyor Output Carton', 'Chain & Sprocket Roller', 'Conveyor Output Carton - Chain & Sprocket Roller', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(377, 1, 'Br.363', 'br', 'Conveyor Output Carton', 'Stopper Carton', 'Conveyor Output Carton - Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(378, 1, 'Br.364', 'br', 'Conveyor Output Carton', 'Piston Stopper Carton', 'Conveyor Output Carton - Piston Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(379, 1, 'Br.365', 'br', 'Conveyor Output Carton', 'Unit Solenoid Piston Stopper Carton', 'Conveyor Output Carton - Unit Solenoid Piston Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(380, 1, 'Br.366', 'br', 'Conveyor Output Carton', 'Hose & Conector Piston Stopper Carton', 'Conveyor Output Carton - Hose & Conector Piston Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(381, 1, 'Br.367', 'br', 'Conveyor Output Carton', 'Conveyor Flat Belt Printing Carton', 'Conveyor Output Carton - Conveyor Flat Belt Printing Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(382, 1, 'Br.368', 'br', 'Printer Crayon', 'Sensor', 'Printer Crayon - Sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(383, 1, 'Br.369', 'br', 'Printer Crayon', 'Hose', 'Printer Crayon - Hose', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(384, 1, 'Br.370', 'br', 'Printer Crayon', 'Head Printer', 'Printer Crayon - Head Printer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(385, 1, 'Br.371', 'br', 'Printer Crayon', 'Printer Unit', 'Printer Crayon - Printer Unit', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(386, 1, 'Br.372', 'br', 'Printer Crayon', 'Pressure Pump', 'Printer Crayon - Pressure Pump', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(387, 1, 'Br.373', 'br', 'Printer Crayon', 'Filter Ink', 'Printer Crayon - Filter Ink', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(388, 1, 'Br.374', 'br', 'Tooth belt Conveyor', 'Motor', 'Tooth belt Conveyor - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(389, 1, 'Br.375', 'br', 'Tooth belt Conveyor', 'Conveyor', 'Tooth belt Conveyor - Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(390, 1, 'Br.376', 'br', 'Check Weigher', 'Monitor', 'Check Weigher - Monitor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(391, 1, 'Br.377', 'br', 'Check Weigher', 'Motor', 'Check Weigher - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(392, 1, 'Br.378', 'br', 'Check Weigher', 'Belt Conveyor', 'Check Weigher - Belt Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(393, 1, 'Br.379', 'br', 'Check Weigher', 'Roller', 'Check Weigher - Roller', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(394, 1, 'Br.380', 'br', 'Lifter', 'Belt Conveyor', 'Lifter - Belt Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(395, 1, 'Br.381', 'br', 'Lifter', 'Motor Conveyor', 'Lifter - Motor Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(396, 1, 'Br.382', 'br', 'Lifter', 'Sensor product', 'Lifter - Sensor product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(397, 1, 'Br.383', 'br', 'Lifter', 'Blade', 'Lifter - Blade', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(398, 1, 'Br.384', 'br', 'Lifter', 'Chain', 'Lifter - Chain', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(399, 1, 'Br.385', 'br', 'Lifter', 'Pusher Box', 'Lifter - Pusher Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(400, 1, 'Br.386', 'br', 'Lifter', 'Panel', 'Lifter - Panel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(401, 1, 'Br.387', 'br', 'Lifter', 'Sensor counting', 'Lifter - Sensor counting', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(402, 1, 'Br.388', 'br', 'Lifter', 'Motor', 'Lifter - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(403, 1, 'Br.389', 'br', 'Lifter', 'Stopper Carton Box', 'Lifter - Stopper Carton Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(404, 1, 'Br.390', 'br', 'Carry Line', '', 'Carry Line', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(405, 1, 'Br.391', 'br', 'Roller Conveyor', '', 'Roller Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(406, 1, 'Br.392', 'br', 'Pallet Magazine', '', 'Pallet Magazine', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(407, 1, 'Br.393', 'br', 'Robotic Pallet', '', 'Robotic Pallet', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(408, 1, 'Br.394', 'br', 'SACHET FILLING', 'Panel', 'SACHET FILLING - Panel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(409, 1, 'Br.395', 'br', 'Others Breakdown', 'Others ', 'Others Breakdown - Others ', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(410, 1, 'Se.1', 'se', 'Change over OKP ', 'dry cleaning  c/o', 'Change over OKP  - dry cleaning  c/o', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(411, 1, 'Se.2', 'se', 'Change over OKP ', 'Flushing c/o', 'Change over OKP  - Flushing c/o', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(412, 1, 'Se.3', 'se', 'Change over OKP ', 'persiapan alat/ruangan c/o', 'Change over OKP  - persiapan alat/ruangan c/o', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(413, 1, 'Se.4', 'se', 'Change over OKP ', 'Hitung jumlah FG/reject/return', 'Change over OKP  - Hitung jumlah FG/reject/return', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(414, 1, 'Se.5', 'se', 'Change Over Size', 'To 44 gr', 'Change Over Size - To 44 gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(415, 1, 'Se.6', 'se', 'Change Over Size', 'To 64 gr', 'Change Over Size - To 64 gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(416, 1, 'Se.7', 'se', 'Change Over Size', '200gr To 300gr', 'Change Over Size - 200gr To 300gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(417, 1, 'Se.8', 'se', 'Change Over Size', '200gr To 400gr', 'Change Over Size - 200gr To 400gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(418, 1, 'Se.9', 'se', 'Change Over Size', '200gr To 600gr', 'Change Over Size - 200gr To 600gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(419, 1, 'Se.10', 'se', 'Change Over Size', '200gr To 800gr', 'Change Over Size - 200gr To 800gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(420, 1, 'Se.11', 'se', 'Change Over Size', '300 gr To 200gr', 'Change Over Size - 300 gr To 200gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(421, 1, 'Se.12', 'se', 'Change Over Size', '300 gr To 600gr', 'Change Over Size - 300 gr To 600gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(422, 1, 'Se.13', 'se', 'Change Over Size', '300 gr To 800gr', 'Change Over Size - 300 gr To 800gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(423, 1, 'Se.14', 'se', 'Change Over Size', '400 gr To 200gr', 'Change Over Size - 400 gr To 200gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(424, 1, 'Se.15', 'se', 'Change Over Size', '400 gr To 600gr', 'Change Over Size - 400 gr To 600gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(425, 1, 'Se.16', 'se', 'Change Over Size', '400 gr To 800gr', 'Change Over Size - 400 gr To 800gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(426, 1, 'Se.17', 'se', 'Change Over Size', '600 gr To 200gr', 'Change Over Size - 600 gr To 200gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(427, 1, 'Se.18', 'se', 'Change Over Size', '600 gr To 300gr', 'Change Over Size - 600 gr To 300gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(428, 1, 'Se.19', 'se', 'Change Over Size', '600 gr To 400gr', 'Change Over Size - 600 gr To 400gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(429, 1, 'Se.20', 'se', 'Change Over Size', '600 gr To 800gr', 'Change Over Size - 600 gr To 800gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(430, 1, 'Se.21', 'se', 'Change Over Size', '800 gr To 200gr', 'Change Over Size - 800 gr To 200gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(431, 1, 'Se.22', 'se', 'Change Over Size', '800 gr To 300gr', 'Change Over Size - 800 gr To 300gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(432, 1, 'Se.23', 'se', 'Change Over Size', '800 gr To 400gr', 'Change Over Size - 800 gr To 400gr', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(433, 1, 'Se.24', 'se', 'Change Over Code', '', 'Change Over Code', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(434, 1, 'Se.25', 'se', 'Others', '', 'Others', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(435, 1, 'Ch.1', 'ch', 'Ganti Pita', '', 'Ganti Pita', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(436, 1, 'Ch.2', 'ch', 'Ganti Alufo', '', 'Ganti Alufo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(437, 1, 'Ch.3', 'ch', 'Ganti Lakban', '', 'Ganti Lakban', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(438, 1, 'Ch.4', 'ch', 'Ganti Suction Cup', '', 'Ganti Suction Cup', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(439, 1, 'Ch.5', 'ch', 'Others', '', 'Others', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(440, 1, 'St.1', 'st', 'Heating time seal', '', 'Heating time seal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(441, 1, 'St.2', 'st', 'Setting mesin awal start ', '', 'Setting mesin awal start ', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(442, 1, 'St.3', 'st', 'Persiapan Alat dan Bahan', 'persiapan alat/ruangan rutin', 'Persiapan Alat dan Bahan - persiapan alat/ruangan rutin', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(443, 1, 'St.4', 'st', 'Persiapan Alat dan Bahan', 'Flushing Awal Shift/Mulai Produksi', 'Persiapan Alat dan Bahan - Flushing Awal Shift/Mulai Produksi', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(444, 1, 'St.5', 'st', 'Heating glue', '', 'Heating glue', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(445, 1, 'St.6', 'st', 'Others', '', 'Others', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(446, 1, 'Ot.1', 'ot', 'Utility', 'Listrik', 'Utility-Listrik', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(447, 1, 'Ot.2', 'ot', 'Utility', 'RH', 'Utility-RH', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(448, 1, 'Ot.3', 'ot', 'Utility', 'Suhu', 'Utility-Suhu', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(449, 1, 'Ot.4', 'ot', 'Utility', 'Angin', 'Utility-Angin', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(450, 1, 'Ot.5', 'ot', 'Waiting for material', 'scoop', 'Waiting for material-scoop', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(451, 1, 'Ot.6', 'ot', 'Waiting for material', 'folding box', 'Waiting for material-folding box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(452, 1, 'Ot.7', 'ot', 'Waiting for material', 'carton box', 'Waiting for material-carton box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(453, 1, 'Ot.8', 'ot', 'Waiting for process blending', 'menunggu release powder blending', 'Waiting for process blending-menunggu release powder blending', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(454, 1, 'Ot.9', 'ot', 'waiting for quality to be checked Sample', '     ', 'waiting for quality to be checked Sample     ', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(455, 1, 'Ot.10', 'ot', 'Waiting for personel', ' ', 'Waiting for personel ', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(456, 1, 'Ot.11', 'ot', 'Waiting for personel', 'telat', 'Waiting for personel-telat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(457, 1, 'Ot.12', 'ot', '-Waiting for Instruction', 'briefing', '-Waiting for Instruction-briefing', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(458, 1, 'Ot.13', 'ot', '-Problem Quality Material ', 'Alufo', '-Problem Quality Material -Alufo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(459, 1, 'Ot.14', 'ot', '-Problem Quality Material ', 'folding box', '-Problem Quality Material -folding box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(460, 1, 'Ot.15', 'ot', '-Problem Quality Material ', 'scoop', '-Problem Quality Material -scoop', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(461, 1, 'Ot.16', 'ot', '-Problem Quality Material ', 'carton box', '-Problem Quality Material -carton box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(462, 1, 'Ot.17', 'ot', '-Problem Quality Material ', 'Plakban', '-Problem Quality Material -Plakban', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(463, 1, 'Ot.18', 'ot', 'Cleaning - checking ', 'Daily Cleaning', 'Cleaning - checking -Daily Cleaning', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(464, 1, 'Ot.19', 'ot', 'Cleaning - checking ', 'Others ', 'Cleaning - checking -Others ', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(465, 1, 'Ot.20', 'ot', 'Line Restrain', 'Waiting for quality to be checked (belum release)', 'Line Restrain-Waiting for quality to be checked (belum release)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(466, 1, 'Ot.21', 'ot', 'Line Restrain', 'Powder telat turun (Powdertank kosong)', 'Line Restrain-Powder telat turun (Powdertank kosong)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(467, 1, 'Ot.22', 'ot', 'Line Restrain', 'Others ', 'Line Restrain-Others ', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(468, 1, 'Ot.23', 'ot', 'Cek Cross Jaw, Teflon Tape, Closer', '', 'Cek Cross Jaw, Teflon Tape, Closer-', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(469, 1, 'Ot.24', 'ot', 'Repack product', '', 'Repack product-', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(470, 1, 'Ot.25', 'ot', 'Code', 'Re-Print', 'Code-Re-Print', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(471, 1, 'Ot.26', 'ot', 'Sample Mona', '', 'Sample Mona', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(472, 1, 'Ot.27', 'ot', 'Powder Browning', 'Rework Powder', 'Powder Browning-Rework Powder', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(473, 1, 'Ot.28', 'ot', 'Powder Browning', 'Powder Ngebuang', 'Powder Browning-Powder Ngebuang', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(474, 1, 'Ot.29', 'ot', 'Zak Powder', '', 'Zak Powder', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(475, 1, 'Ot.30', 'ot', 'Siever', 'Bandul', 'Siever-Bandul', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(476, 1, 'Ot.31', 'ot', 'Others', 'Others', 'Others-Others', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(477, 1, 'Id.1', 'id', 'Idle time', '', 'Idle time', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(478, 1, 'Id.2', 'id', 'Others', '', 'Others', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(479, 1, 'MI.1', 'mi', 'Problem forklift ', 'batere', 'Problem forklift  - batere', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(480, 1, 'MI.2', 'mi', 'Problem forklift ', 'hidrolik', 'Problem forklift  - hidrolik', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(481, 1, 'MI.3', 'mi', 'Problem Tipper ', 'vibrating motor', 'Problem Tipper  - vibrating motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(482, 1, 'MI.4', 'mi', 'Problem Tipper ', 'Piston Pneumatic', 'Problem Tipper  - Piston Pneumatic', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(483, 1, 'MI.5', 'mi', 'Problem Tipper ', 'Flexible Tipper to powder tank', 'Problem Tipper  - Flexible Tipper to powder tank', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(484, 1, 'MI.6', 'mi', 'Problem Alimentation', 'problem powder tank (sensor)', 'Problem Alimentation - problem powder tank (sensor)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(485, 1, 'MI.7', 'mi', 'Problem Alimentation', 'problem powder tank (motor)', 'Problem Alimentation - problem powder tank (motor)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(486, 1, 'MI.8', 'mi', 'Problem Alimentation', 'Flexible powder tank to vibrating conveyor', 'Problem Alimentation - Flexible powder tank to vibrating conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(487, 1, 'MI.9', 'mi', 'Problem Alimentation', 'problem (motor) vibrating conveyor', 'Problem Alimentation - problem (motor) vibrating conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(488, 1, 'MI.10', 'mi', 'Problem Alimentation', 'Flexible vibrating conveyor to siever', 'Problem Alimentation - Flexible vibrating conveyor to siever', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(489, 1, 'MI.11', 'mi', 'Problem Alimentation', 'problem (motor) Siever', 'Problem Alimentation - problem (motor) Siever', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(490, 1, 'MI.12', 'mi', 'Problem Alimentation', 'Limit Switch tailling cut', 'Problem Alimentation - Limit Switch tailling cut', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(491, 1, 'MI.13', 'mi', 'Problem Alimentation', 'Metal Catcher', 'Problem Alimentation - Metal Catcher', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(492, 1, 'MI.14', 'mi', 'Problem Alimentation', 'Flexible siever to Metal Catcher', 'Problem Alimentation - Flexible siever to Metal Catcher', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(493, 1, 'MI.15', 'mi', 'Problem Alimentation', 'Flexible metal catcher to buffer hopper', 'Problem Alimentation - Flexible metal catcher to buffer hopper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(494, 1, 'MI.16', 'mi', 'Problem Alimentation', 'problem Buffer hopper (sensor)', 'Problem Alimentation - problem Buffer hopper (sensor)', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(495, 1, 'MI.17', 'mi', 'Problem Alimentation', 'Flexible buffer hopper to vibrating conveyor', 'Problem Alimentation - Flexible buffer hopper to vibrating conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(496, 1, 'MI.18', 'mi', 'Problem Alimentation', 'problem (motor) vibrating conveyor mezzanin', 'Problem Alimentation - problem (motor) vibrating conveyor mezzanin', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(497, 1, 'MI.19', 'mi', 'Problem Alimentation', 'Flexible vibrating conveyor to hopper filling', 'Problem Alimentation - Flexible vibrating conveyor to hopper filling', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(498, 1, 'MI.20', 'mi', 'SACHET FILLING Alufo Line', 'alufo', 'SACHET FILLING Alufo Line - alufo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(499, 1, 'MI.21', 'mi', 'SACHET FILLING Alufo Line', 'code', 'SACHET FILLING Alufo Line - code', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(500, 1, 'MI.22', 'mi', 'SACHET FILLING Alufo Line', 'roll', 'SACHET FILLING Alufo Line - roll', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(501, 1, 'MI.23', 'mi', 'SACHET FILLING Alufo Line', 'Sensor Alufo', 'SACHET FILLING Alufo Line-Sensor Alufo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(502, 1, 'MI.24', 'mi', 'SACHET FILLING Alufo Line', 'Overload - Cross jaw', 'SACHET FILLING Alufo Line-Overload - Cross jaw', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(503, 1, 'MI.25', 'mi', 'SACHET FILLING Alufo Line', 'Overload - Vertical seal', 'SACHET FILLING Alufo Line-Overload - Vertical seal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(504, 1, 'MI.26', 'mi', 'Motor Agitator', '', 'Motor Agitator', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(505, 1, 'MI.27', 'mi', 'Motor Auger', '', 'Motor Auger', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(506, 1, 'MI.28', 'mi', 'SACHET FILLING Powder Line', 'hopper', 'SACHET FILLING Powder Line - hopper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(507, 1, 'MI.29', 'mi', 'SACHET FILLING Powder Line', 'agitator', 'SACHET FILLING Powder Line - agitator', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(508, 1, 'MI.30', 'mi', 'SACHET FILLING Powder Line', 'Auger', 'SACHET FILLING Powder Line - Auger', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(509, 1, 'MI.31', 'mi', 'SACHET FILLING Powder Line', 'forming Tube', 'SACHET FILLING Powder Line - forming Tube', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(510, 1, 'MI.32', 'mi', 'SACHET FILLING Powder Line', 'forming Collar', 'SACHET FILLING Powder Line - forming Collar', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(511, 1, 'MI.33', 'mi', 'SACHET FILLING Powder Line', 'closer', 'SACHET FILLING Powder Line - closer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(512, 1, 'MI.34', 'mi', 'SACHET FILLING Powder Line', 'transport Belt', 'SACHET FILLING Powder Line - transport Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(513, 1, 'MI.35', 'mi', 'SACHET FILLING Powder Line', 'supply Nitrogen', 'SACHET FILLING Powder Line - supply Nitrogen', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(514, 1, 'MI.36', 'mi', 'SACHET FILLING Powder Line', 'RO Online', 'SACHET FILLING Powder Line - RO Online', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(515, 1, 'MI.37', 'mi', 'SACHET FILLING Powder Line', 'Rotary Closer', 'SACHET FILLING Powder Line - Rotary Closer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(516, 1, 'MI.38', 'mi', 'SACHET FILLING Powder Line', 'Sensor Closer', 'SACHET FILLING Powder Line - Sensor Closer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(517, 1, 'MI.39', 'mi', 'SACHET FILLING Sealer', 'vertical', 'SACHET FILLING Sealer - vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(518, 1, 'MI.40', 'mi', 'SACHET FILLING Sealer', 'cross', 'SACHET FILLING Sealer - cross', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(519, 1, 'MI.41', 'mi', 'SACHET FILLING Sealer', 'Busa Cross jaw', 'SACHET FILLING Sealer - Busa Cross jaw', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(520, 1, 'MI.42', 'mi', 'SACHET FILLING Sealer', 'knife', 'SACHET FILLING Sealer - knife', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(521, 1, 'MI.43', 'mi', 'SACHET FILLING Vaccum Pump ', 'Vaccum Pump', 'SACHET FILLING Vaccum Pump  - Vaccum Pump', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(522, 1, 'MI.44', 'mi', 'SACHET FILLING ', 'Driver', 'SACHET FILLING  - Driver', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(523, 1, 'MI.45', 'mi', 'Discharge Belt Conveying', 'Discharge Belt Conveying', 'Discharge Belt Conveying - Discharge Belt Conveying', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(524, 1, 'MI.46', 'mi', 'CHECK WEIGHER Housing/Panel', 'motor', 'CHECK WEIGHER Housing/Panel - motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(525, 1, 'MI.47', 'mi', 'CHECK WEIGHER Housing/Panel', 'mechanical Parts', 'CHECK WEIGHER Housing/Panel - mechanical Parts', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(526, 1, 'MI.48', 'mi', 'CHECK WEIGHER Conveying', 'conveyor', 'CHECK WEIGHER Conveying - conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(527, 1, 'MI.49', 'mi', 'CHECK WEIGHER Conveying', 'operating Unit/Display', 'CHECK WEIGHER Conveying - operating Unit/Display', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(528, 1, 'MI.50', 'mi', 'CHECK WEIGHER Conveying', 'eject Unit', 'CHECK WEIGHER Conveying - eject Unit', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(529, 1, 'MI.51', 'mi', 'CHECK WEIGHER Panel Box ', 'Panel Box ', 'CHECK WEIGHER Panel Box  - Panel Box ', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(530, 1, 'MI.52', 'mi', 'Cartoner - Tooth belt', 'motor 1', 'Cartoner - Tooth belt - motor 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(531, 1, 'MI.53', 'mi', 'Cartoner - Tooth belt', 'conveyor 1', 'Cartoner - Tooth belt - conveyor 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(532, 1, 'MI.54', 'mi', 'Cartoner - Tooth belt', 'motor 2', 'Cartoner - Tooth belt - motor 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(533, 1, 'MI.55', 'mi', 'Cartoner - Tooth belt', 'conveyor 2', 'Cartoner - Tooth belt - conveyor 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(534, 1, 'MI.56', 'mi', 'Stacker ', 'Panel 1', 'Stacker  - Panel 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(535, 1, 'MI.57', 'mi', 'Stacker ', 'Panel 2', 'Stacker  - Panel 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(536, 1, 'MI.58', 'mi', 'Stacker ', 'Acceleration belt 1 - Motor', 'Stacker  - Acceleration belt 1 - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(537, 1, 'MI.59', 'mi', 'Stacker ', 'Acceleration belt 1 - Belt', 'Stacker  - Acceleration belt 1 - Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(538, 1, 'MI.60', 'mi', 'Stacker ', 'Acceleration belt 1 - Sensor', 'Stacker  - Acceleration belt 1 - Sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(539, 1, 'MI.61', 'mi', 'Stacker ', 'Acceleration belt 2 - Motor', 'Stacker  - Acceleration belt 2 - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(540, 1, 'MI.62', 'mi', 'Stacker ', 'Acceleration belt 2 - Belt', 'Stacker  - Acceleration belt 2 - Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(541, 1, 'MI.63', 'mi', 'Stacker ', 'Acceleration belt 2 - Sensor', 'Stacker  - Acceleration belt 2 - Sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(542, 1, 'MI.64', 'mi', 'Stacker ', 'Bag Loader 1, Atas', 'Stacker  - Bag Loader 1, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(543, 1, 'MI.65', 'mi', 'Stacker ', 'Bag Loader 1, Tengah', 'Stacker  - Bag Loader 1, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(544, 1, 'MI.66', 'mi', 'Stacker ', 'Bag Loader 1, Bawah', 'Stacker  - Bag Loader 1, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(545, 1, 'MI.67', 'mi', 'Stacker ', 'Belt Bag Loader 1, Atas', 'Stacker  - Belt Bag Loader 1, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(546, 1, 'MI.68', 'mi', 'Stacker ', 'Belt Bag Loader 1, Tengah', 'Stacker  - Belt Bag Loader 1, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(547, 1, 'MI.69', 'mi', 'Stacker ', 'Belt Bag Loader 1, Bawah', 'Stacker  - Belt Bag Loader 1, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(548, 1, 'MI.70', 'mi', 'Stacker ', 'Motor Bag Loader 1, Atas', 'Stacker  - Motor Bag Loader 1, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(549, 1, 'MI.71', 'mi', 'Stacker ', 'Motor Bag Loader 1, Tengah', 'Stacker  - Motor Bag Loader 1, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(550, 1, 'MI.72', 'mi', 'Stacker ', 'Motor Bag Loader 1, Bawah', 'Stacker  - Motor Bag Loader 1, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(551, 1, 'MI.73', 'mi', 'Stacker ', 'Sensor Bag Loader 1, Atas', 'Stacker  - Sensor Bag Loader 1, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(552, 1, 'MI.74', 'mi', 'Stacker ', 'Sensor Bag Loader 1, Tengah', 'Stacker  - Sensor Bag Loader 1, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(553, 1, 'MI.75', 'mi', 'Stacker ', 'Sensor Bag Loader 1, Bawah', 'Stacker  - Sensor Bag Loader 1, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(554, 1, 'MI.76', 'mi', 'Stacker ', 'Bag Loader 2, Atas', 'Stacker  - Bag Loader 2, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(555, 1, 'MI.77', 'mi', 'Stacker ', 'Bag Loader 2, Tengah', 'Stacker  - Bag Loader 2, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(556, 1, 'MI.78', 'mi', 'Stacker ', 'Bag Loader 2, Bawah', 'Stacker  - Bag Loader 2, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(557, 1, 'MI.79', 'mi', 'Stacker ', 'Belt Bag Loader 2, Atas', 'Stacker  - Belt Bag Loader 2, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(558, 1, 'MI.80', 'mi', 'Stacker ', 'Belt Bag Loader 2, Tengah', 'Stacker  - Belt Bag Loader 2, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(559, 1, 'MI.81', 'mi', 'Stacker ', 'Belt Bag Loader 2, Bawah', 'Stacker  - Belt Bag Loader 2, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(560, 1, 'MI.82', 'mi', 'Stacker ', 'Motor Bag Loader 2, Atas', 'Stacker  - Motor Bag Loader 2, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(561, 1, 'MI.83', 'mi', 'Stacker ', 'Motor Bag Loader 2, Tengah', 'Stacker  - Motor Bag Loader 2, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(562, 1, 'MI.84', 'mi', 'Stacker ', 'Motor Bag Loader 2, Bawah', 'Stacker  - Motor Bag Loader 2, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(563, 1, 'MI.85', 'mi', 'Stacker ', 'Sensor Bag Loader 2, Atas', 'Stacker  - Sensor Bag Loader 2, Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(564, 1, 'MI.86', 'mi', 'Stacker ', 'Sensor Bag Loader 2, Tengah', 'Stacker  - Sensor Bag Loader 2, Tengah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(565, 1, 'MI.87', 'mi', 'Stacker ', 'Sensor Bag Loader 2, Bawah', 'Stacker  - Sensor Bag Loader 2, Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(566, 1, 'MI.88', 'mi', 'Scoop Feeder', 'Panel', 'Scoop Feeder - Panel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(567, 1, 'MI.89', 'mi', 'Scoop Feeder', 'Sensor Bunker', 'Scoop Feeder - Sensor Bunker', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(568, 1, 'MI.90', 'mi', 'Scoop Feeder', 'Motor Bunker', 'Scoop Feeder - Motor Bunker', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(569, 1, 'MI.91', 'mi', 'Scoop Feeder', 'Conveyor bunker', 'Scoop Feeder - Conveyor bunker', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(570, 1, 'MI.92', 'mi', 'Scoop Feeder', 'Motor Lifter', 'Scoop Feeder - Motor Lifter', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(571, 1, 'MI.93', 'mi', 'Scoop Feeder', 'Conveyor Lifter', 'Scoop Feeder - Conveyor Lifter', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(572, 1, 'MI.94', 'mi', 'Scoop Feeder', 'Motor Sweeper', 'Scoop Feeder - Motor Sweeper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(573, 1, 'MI.95', 'mi', 'Scoop Feeder', 'Conveyor Sweeper', 'Scoop Feeder - Conveyor Sweeper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(574, 1, 'MI.96', 'mi', 'Scoop Feeder', 'Bowl 1', 'Scoop Feeder - Bowl 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(575, 1, 'MI.97', 'mi', 'Scoop Feeder', 'Air Nozzle Bowl 1', 'Scoop Feeder - Air Nozzle Bowl 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(576, 1, 'MI.98', 'mi', 'Scoop Feeder', 'Bowl 2', 'Scoop Feeder - Bowl 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(577, 1, 'MI.99', 'mi', 'Scoop Feeder', 'Air Nozzle Bowl 2', 'Scoop Feeder - Air Nozzle Bowl 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(578, 1, 'MI.100', 'mi', 'Scoop Feeder', 'Vibrating Motor 1', 'Scoop Feeder - Vibrating Motor 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(579, 1, 'MI.101', 'mi', 'Scoop Feeder', 'Vibrating Motor 2', 'Scoop Feeder - Vibrating Motor 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(580, 1, 'MI.102', 'mi', 'Scoop Feeder', 'Sensor Belt track Spoon 1', 'Scoop Feeder - Sensor Belt track Spoon 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(581, 1, 'MI.103', 'mi', 'Scoop Feeder', 'Belt track Spoon 1', 'Scoop Feeder - Belt track Spoon 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(582, 1, 'MI.104', 'mi', 'Scoop Feeder', 'Sensor Belt track Spoon 2', 'Scoop Feeder - Sensor Belt track Spoon 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(583, 1, 'MI.105', 'mi', 'Scoop Feeder', 'Belt track Spoon 2', 'Scoop Feeder - Belt track Spoon 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(584, 1, 'MI.106', 'mi', 'Scoop Feeder', 'Rotary Finger 1', 'Scoop Feeder - Rotary Finger 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(585, 1, 'MI.107', 'mi', 'Scoop Feeder', 'Rotary Finger 2', 'Scoop Feeder - Rotary Finger 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(586, 1, 'MI.108', 'mi', 'Scoop Feeder', 'Sensor Finger', 'Scoop Feeder - Sensor Finger', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(587, 1, 'MI.109', 'mi', 'Scoop Feeder', 'Star Wheel 1', 'Scoop Feeder - Star Wheel 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(588, 1, 'MI.110', 'mi', 'Scoop Feeder', 'Star Wheel 2', 'Scoop Feeder - Star Wheel 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(589, 1, 'MI.111', 'mi', 'Scoop Feeder', 'Sensor Star Wheel 1', 'Scoop Feeder - Sensor Star Wheel 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(590, 1, 'MI.112', 'mi', 'Scoop Feeder', 'Sensor Star Wheel 2', 'Scoop Feeder - Sensor Star Wheel 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(591, 1, 'MI.113', 'mi', 'Scoop Feeder', 'Motor Vacuum 1', 'Scoop Feeder - Motor Vacuum 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(592, 1, 'MI.114', 'mi', 'Scoop Feeder', 'Motor Vacuum 2', 'Scoop Feeder - Motor Vacuum 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(593, 1, 'MI.115', 'mi', 'Scoop Feeder', 'Kapasitor Spooner 1', 'Scoop Feeder - Kapasitor Spooner 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(594, 1, 'MI.116', 'mi', 'Scoop Feeder', 'Kapasitor Spooner 2', 'Scoop Feeder - Kapasitor Spooner 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(595, 1, 'MI.117', 'mi', 'Cartoner', 'Air Pressure', 'Cartoner - Air Pressure', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(596, 1, 'MI.118', 'mi', 'Cartoner', 'Magazine Conveyor - Belt', 'Cartoner - Magazine Conveyor - Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(597, 1, 'MI.119', 'mi', 'Cartoner', 'Magazine Conveyor - Motor Servo', 'Cartoner - Magazine Conveyor - Motor Servo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(598, 1, 'MI.120', 'mi', 'Cartoner', 'Magazine Conveyor - Sensor', 'Cartoner - Magazine Conveyor - Sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(599, 1, 'MI.121', 'mi', 'Cartoner', 'Magazine Guide Penahan Folding - Atas', 'Cartoner - Magazine Guide Penahan Folding - Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(600, 1, 'MI.122', 'mi', 'Cartoner', 'Magazine Guide Penahan Folding - Bawah', 'Cartoner - Magazine Guide Penahan Folding - Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(601, 1, 'MI.123', 'mi', 'Cartoner', 'Panel control FB', 'Cartoner - Panel control FB', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(602, 1, 'MI.124', 'mi', 'Cartoner', 'Panel Cooler 1', 'Cartoner - Panel Cooler 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(603, 1, 'MI.125', 'mi', 'Cartoner', 'Panel Cooler 2', 'Cartoner - Panel Cooler 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(604, 1, 'MI.126', 'mi', 'Cartoner', 'Panel Componen Sensor FB', 'Cartoner - Panel Componen Sensor FB', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(605, 1, 'MI.127', 'mi', 'Cartoner', 'Panel Lampu Indikator', 'Cartoner - Panel Lampu Indikator', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(606, 1, 'MI.128', 'mi', 'Cartoner', 'Rotary pick box - Suction cup', 'Cartoner - Rotary pick box - Suction cup', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(607, 1, 'MI.129', 'mi', 'Cartoner', 'Rotary pick box - Suction pipe', 'Cartoner - Rotary pick box - Suction pipe', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(608, 1, 'MI.130', 'mi', 'Cartoner', 'Rotary pick box - Belt Rotary', 'Cartoner - Rotary pick box - Belt Rotary', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(609, 1, 'MI.131', 'mi', 'Cartoner', 'Rotary pick box - Suction filter', 'Cartoner - Rotary pick box - Suction filter', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(610, 1, 'MI.132', 'mi', 'Cartoner', 'Rotary pick box - Air Vacuum', 'Cartoner - Rotary pick box - Air Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(611, 1, 'MI.133', 'mi', 'Cartoner', 'Piston Smoother', 'Cartoner - Piston Smoother', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(612, 1, 'MI.134', 'mi', 'Cartoner', 'Motor Smoother', 'Cartoner - Motor Smoother', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(613, 1, 'MI.135', 'mi', 'Cartoner', 'Conveyor Casette - Plat adjust', 'Cartoner - Conveyor Casette - Plat adjust', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(614, 1, 'MI.136', 'mi', 'Cartoner', 'Conveyor Casette - Plat Insertion', 'Cartoner - Conveyor Casette - Plat Insertion', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(615, 1, 'MI.137', 'mi', 'Cartoner', 'Conveyor Casette - Assistant Bucket', 'Cartoner - Conveyor Casette - Assistant Bucket', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(616, 1, 'MI.138', 'mi', 'Cartoner', 'Conveyor Casette - Teplon', 'Cartoner - Conveyor Casette - Teplon', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(617, 1, 'MI.139', 'mi', 'Cartoner', 'Conveyor Casette - Rantai Adjust', 'Cartoner - Conveyor Casette - Rantai Adjust', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(618, 1, 'MI.140', 'mi', 'Cartoner', 'Conveyor Casette - Rantai Insertion', 'Cartoner - Conveyor Casette - Rantai Insertion', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(619, 1, 'MI.141', 'mi', 'Cartoner', 'Conveyor Casette - Motor Rantai Adjust', 'Cartoner - Conveyor Casette - Motor Rantai Adjust', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(620, 1, 'MI.142', 'mi', 'Cartoner', 'Conveyor Casette - Motor Rantai Insertion', 'Cartoner - Conveyor Casette - Motor Rantai Insertion', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(621, 1, 'MI.143', 'mi', 'Cartoner', 'Folding Conveyor - Top Guide', 'Cartoner - Folding Conveyor - Top Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(622, 1, 'MI.144', 'mi', 'Cartoner', 'Folding Conveyor - Guide Inside', 'Cartoner - Folding Conveyor - Guide Inside', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(623, 1, 'MI.145', 'mi', 'Cartoner', 'Folding Conveyor - Guide Outside', 'Cartoner - Folding Conveyor - Guide Outside', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(624, 1, 'MI.146', 'mi', 'Cartoner', 'Folding Conveyor - Chain & Sprocket Inside', 'Cartoner - Folding Conveyor - Chain & Sprocket Inside', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(625, 1, 'MI.147', 'mi', 'Cartoner', 'Folding Conveyor - Chain & Sprocket Outside', 'Cartoner - Folding Conveyor - Chain & Sprocket Outside', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(626, 1, 'MI.148', 'mi', 'Cartoner', 'Folding Conveyor - Motor Chain Inside', 'Cartoner - Folding Conveyor - Motor Chain Inside', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(627, 1, 'MI.149', 'mi', 'Cartoner', 'Folding Conveyor - Motor Chain Outside', 'Cartoner - Folding Conveyor - Motor Chain Outside', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(628, 1, 'MI.150', 'mi', 'Cartoner', 'Sensor Diverter', 'Cartoner - Sensor Diverter', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(629, 1, 'MI.151', 'mi', 'Cartoner', 'Piston Diverter', 'Cartoner - Piston Diverter', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(630, 1, 'MI.152', 'mi', 'Cartoner', 'Selenoid Diverter', 'Cartoner - Selenoid Diverter', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(631, 1, 'MI.153', 'mi', 'Cartoner', 'Actuator', 'Cartoner - Actuator', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(632, 1, 'MI.154', 'mi', 'Cartoner', 'Bag Pusher - Chain', 'Cartoner - Bag Pusher - Chain', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(633, 1, 'MI.155', 'mi', 'Cartoner', 'Bag Pusher - Pusher Chip', 'Cartoner - Bag Pusher - Pusher Chip', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(634, 1, 'MI.156', 'mi', 'Cartoner', 'Bag Pusher - Shaft Pusher', 'Cartoner - Bag Pusher - Shaft Pusher', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(635, 1, 'MI.157', 'mi', 'Cartoner', 'Bag Pusher - Sensor Jamp Product', 'Cartoner - Bag Pusher - Sensor Jamp Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(636, 1, 'MI.158', 'mi', 'Cartoner', 'Bag Pusher - Ejector', 'Cartoner - Bag Pusher - Ejector', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(637, 1, 'MI.159', 'mi', 'Cartoner', 'Guide Pembuka Lidah - Atas', 'Cartoner - Guide Pembuka Lidah - Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(638, 1, 'MI.160', 'mi', 'Cartoner', 'Guide Pembuka Lidah - Bawah', 'Cartoner - Guide Pembuka Lidah - Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(639, 1, 'MI.161', 'mi', 'Cartoner', 'Flap Closured Atas', 'Cartoner - Flap Closured Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(640, 1, 'MI.162', 'mi', 'Cartoner', 'Flap Closured Bawah', 'Cartoner - Flap Closured Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(641, 1, 'MI.163', 'mi', 'Cartoner', 'Sensor Folding Box', 'Cartoner - Sensor Folding Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(642, 1, 'MI.164', 'mi', 'Cartoner', 'Sensor Spoon', 'Cartoner - Sensor Spoon', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(643, 1, 'MI.165', 'mi', 'Cartoner', 'Sensor Alufo', 'Cartoner - Sensor Alufo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(644, 1, 'MI.166', 'mi', 'Cartoner', 'Sensor Product corect in box', 'Cartoner - Sensor Product corect in box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(645, 1, 'MI.167', 'mi', 'Cartoner', 'Sensor Product available in box', 'Cartoner - Sensor Product available in box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(646, 1, 'MI.168', 'mi', 'Cartoner', 'Sensor Safety Door FB', 'Cartoner - Sensor Safety Door FB', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(647, 1, 'MI.169', 'mi', 'Cartoner', 'Printer FB - printer unit', 'Cartoner - Printer FB - printer unit', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(648, 1, 'MI.170', 'mi', 'Cartoner', 'Printer FB - Display', 'Cartoner - Printer FB - Display', '0000-00-00 00:00:00', '0000-00-00 00:00:00');
INSERT INTO `mactivitycode` (`id`, `line_id`, `txtactivitycode`, `txtcategory`, `txtactivityname`, `txtactivityitem`, `txtdescription`, `created_at`, `updated_at`) VALUES
(649, 1, 'MI.171', 'mi', 'Cartoner', 'Printer FB - hose', 'Cartoner - Printer FB - hose', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(650, 1, 'MI.172', 'mi', 'Cartoner', 'Printer FB - printer Head', 'Cartoner - Printer FB - printer Head', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(651, 1, 'MI.173', 'mi', 'Cartoner', 'Printer FB - sensor', 'Cartoner - Printer FB - sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(652, 1, 'MI.174', 'mi', 'Cartoner', 'Sensor Open Flap FB', 'Cartoner - Sensor Open Flap FB', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(653, 1, 'MI.175', 'mi', 'Cartoner', 'Glueing System - box Glue', 'Cartoner - Glueing System - box Glue', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(654, 1, 'MI.176', 'mi', 'Cartoner', 'Glueing System - Hose', 'Cartoner - Glueing System - Hose', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(655, 1, 'MI.177', 'mi', 'Cartoner', 'Glueing System - Nozzle', 'Cartoner - Glueing System - Nozzle', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(656, 1, 'MI.178', 'mi', 'Cartoner', 'Glueing System - Guide pelipat Bawah', 'Cartoner - Glueing System - Guide pelipat Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(657, 1, 'MI.179', 'mi', 'Cartoner', 'Glueing System - Guide pelipat Atas', 'Cartoner - Glueing System - Guide pelipat Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(658, 1, 'MI.180', 'mi', 'Cartoner', 'Barcode - Panel', 'Cartoner - Barcode - Panel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(659, 1, 'MI.181', 'mi', 'Cartoner', 'Barcode - sensor', 'Cartoner - Barcode - sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(660, 1, 'MI.182', 'mi', 'Cartoner', 'Discharge belt - belt', 'Cartoner - Discharge belt - belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(661, 1, 'MI.183', 'mi', 'Cartoner', 'Discharge belt - Motor', 'Cartoner - Discharge belt - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(662, 1, 'MI.184', 'mi', 'Cartoner', 'Discharge belt - teflon Ejector', 'Cartoner - Discharge belt - teflon Ejector', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(663, 1, 'MI.185', 'mi', 'Cartoner', 'Discharge belt - Sensor', 'Cartoner - Discharge belt - Sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(664, 1, 'MI.186', 'mi', 'Conveyor Output Folding Box', 'Belt', 'Conveyor Output Folding Box - Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(665, 1, 'MI.187', 'mi', 'Conveyor Output Folding Box', 'Bearing & Shaft', 'Conveyor Output Folding Box - Bearing & Shaft', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(666, 1, 'MI.188', 'mi', 'Conveyor Output Folding Box', 'Motor', 'Conveyor Output Folding Box - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(667, 1, 'MI.189', 'mi', 'Dalsa', 'Camera', 'Dalsa - Camera', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(668, 1, 'MI.190', 'mi', 'Dalsa', 'Display', 'Dalsa - Display', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(669, 1, 'MI.191', 'mi', 'Dalsa', 'Sensor', 'Dalsa - Sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(670, 1, 'MI.192', 'mi', 'Dalsa', 'UPS', 'Dalsa - UPS', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(671, 1, 'MI.193', 'mi', 'Dalsa', 'Power Supply', 'Dalsa - Power Supply', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(672, 1, 'MI.194', 'mi', 'X-ray', 'Motor', 'X-ray - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(673, 1, 'MI.195', 'mi', 'X-ray', 'Belt Conveyor', 'X-ray - Belt Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(674, 1, 'MI.196', 'mi', 'X-ray', 'Bearing & Shaft', 'X-ray - Bearing & Shaft', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(675, 1, 'MI.197', 'mi', 'X-ray', 'Sensor photocell & reflektor', 'X-ray - Sensor photocell & reflektor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(676, 1, 'MI.198', 'mi', 'X-ray', 'Screen', 'X-ray - Screen', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(677, 1, 'MI.199', 'mi', 'X-ray', 'Panel', 'X-ray - Panel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(678, 1, 'MI.200', 'mi', 'Casepacker', 'Air Pressure', 'Casepacker - Air Pressure', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(679, 1, 'MI.201', 'mi', 'Casepacker - Infeed Conveyor', 'Guide', 'Casepacker - Infeed Conveyor - Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(680, 1, 'MI.202', 'mi', 'Casepacker - Infeed Conveyor', 'Belt', 'Casepacker - Infeed Conveyor - Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(681, 1, 'MI.203', 'mi', 'Casepacker - Infeed Conveyor', 'Motor', 'Casepacker - Infeed Conveyor - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(682, 1, 'MI.204', 'mi', 'Casepacker - Infeed Conveyor', 'Chain & Sprocket', 'Casepacker - Infeed Conveyor - Chain & Sprocket', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(683, 1, 'MI.205', 'mi', 'Casepacker - Infeed Conveyor', 'Potensio speed', 'Casepacker - Infeed Conveyor - Potensio speed', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(684, 1, 'MI.206', 'mi', 'Casepacker - Conveyor Product', 'Piston Stopper', 'Casepacker - Conveyor Product - Piston Stopper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(685, 1, 'MI.207', 'mi', 'Casepacker - Conveyor Product', 'Teflon Piston Stopper', 'Casepacker - Conveyor Product - Teflon Piston Stopper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(686, 1, 'MI.208', 'mi', 'Casepacker - Conveyor Product', 'Unit Solenoid Piston Stopper', 'Casepacker - Conveyor Product - Unit Solenoid Piston Stopper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(687, 1, 'MI.209', 'mi', 'Casepacker - Conveyor Product', 'Hose & Conector Piston Stopper', 'Casepacker - Conveyor Product - Hose & Conector Piston Stopper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(688, 1, 'MI.210', 'mi', 'Casepacker - Conveyor Product', 'Sensor Counting Product 1', 'Casepacker - Conveyor Product - Sensor Counting Product 1', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(689, 1, 'MI.211', 'mi', 'Casepacker - Conveyor Product', 'Sensor Counting Product 2', 'Casepacker - Conveyor Product - Sensor Counting Product 2', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(690, 1, 'MI.212', 'mi', 'Casepacker - Conveyor Product', 'Motor', 'Casepacker - Conveyor Product - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(691, 1, 'MI.213', 'mi', 'Casepacker - Conveyor Product', 'Belt', 'Casepacker - Conveyor Product - Belt', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(692, 1, 'MI.214', 'mi', 'Casepacker - Conveyor Product', 'Chain & Sprocket', 'Casepacker - Conveyor Product - Chain & Sprocket', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(693, 1, 'MI.215', 'mi', 'Casepacker - Transfer Counting', 'Piston Horizontal', 'Casepacker - Transfer Counting - Piston Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(694, 1, 'MI.216', 'mi', 'Casepacker - Transfer Counting', 'Teflon Piston Horizontal', 'Casepacker - Transfer Counting - Teflon Piston Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(695, 1, 'MI.217', 'mi', 'Casepacker - Transfer Counting', 'Unit Solenoid Piston Horizontal', 'Casepacker - Transfer Counting - Unit Solenoid Piston Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(696, 1, 'MI.218', 'mi', 'Casepacker - Transfer Counting', 'Hose & Conector Piston Horizontal', 'Casepacker - Transfer Counting - Hose & Conector Piston Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(697, 1, 'MI.219', 'mi', 'Casepacker - Transfer Counting', 'Shaft Linier Piston Horizontal', 'Casepacker - Transfer Counting - Shaft Linier Piston Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(698, 1, 'MI.220', 'mi', 'Casepacker - Transfer Counting', 'Piston Vertical', 'Casepacker - Transfer Counting - Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(699, 1, 'MI.221', 'mi', 'Casepacker - Transfer Counting', 'Teflon Piston Vertical', 'Casepacker - Transfer Counting - Teflon Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(700, 1, 'MI.222', 'mi', 'Casepacker - Transfer Counting', 'Unit Solenoid Piston Vertical', 'Casepacker - Transfer Counting - Unit Solenoid Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(701, 1, 'MI.223', 'mi', 'Casepacker - Transfer Counting', 'Hose & Conector Piston Vertical', 'Casepacker - Transfer Counting - Hose & Conector Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(702, 1, 'MI.224', 'mi', 'Casepacker - Transfer Counting', 'Shaft Linier Piston Vertical', 'Casepacker - Transfer Counting - Shaft Linier Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(703, 1, 'MI.225', 'mi', 'Casepacker - Stacker', 'Home Stacker', 'Casepacker - Stacker - Home Stacker', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(704, 1, 'MI.226', 'mi', 'Casepacker - Stacker', 'Hand wheel', 'Casepacker - Stacker - Hand wheel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(705, 1, 'MI.227', 'mi', 'Casepacker - Stacker', 'Piston Vertical', 'Casepacker - Stacker - Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(706, 1, 'MI.228', 'mi', 'Casepacker - Stacker', 'Teflon Piston Vertical', 'Casepacker - Stacker - Teflon Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(707, 1, 'MI.229', 'mi', 'Casepacker - Stacker', 'Unit Solenoid Piston Vertical', 'Casepacker - Stacker - Unit Solenoid Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(708, 1, 'MI.230', 'mi', 'Casepacker - Stacker', 'Hose & Conector Piston Vertical', 'Casepacker - Stacker - Hose & Conector Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(709, 1, 'MI.231', 'mi', 'Casepacker - Stacker', 'Shaft Linier Piston Vertical', 'Casepacker - Stacker - Shaft Linier Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(710, 1, 'MI.232', 'mi', 'Casepacker - Stacker', 'Sensor Counting Vertical', 'Casepacker - Stacker - Sensor Counting Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(711, 1, 'MI.233', 'mi', 'Casepacker - Stacker', 'Keeper', 'Casepacker - Stacker - Keeper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(712, 1, 'MI.234', 'mi', 'Casepacker - Transfer Servo Actuator', 'Motor Servo', 'Casepacker - Transfer Servo Actuator - Motor Servo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(713, 1, 'MI.235', 'mi', 'Casepacker - Transfer Servo Actuator', 'Chain & Sprocket', 'Casepacker - Transfer Servo Actuator - Chain & Sprocket', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(714, 1, 'MI.236', 'mi', 'Casepacker - Transfer Servo Actuator', 'Sensor Homing', 'Casepacker - Transfer Servo Actuator - Sensor Homing', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(715, 1, 'MI.237', 'mi', 'Casepacker - Transfer Servo Actuator', 'Piston', 'Casepacker - Transfer Servo Actuator - Piston', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(716, 1, 'MI.238', 'mi', 'Casepacker - Transfer Servo Actuator', 'Unit Solenoid Piston Vertical', 'Casepacker - Transfer Servo Actuator - Unit Solenoid Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(717, 1, 'MI.239', 'mi', 'Casepacker - Transfer Servo Actuator', 'Hose & Conector Piston Vertical', 'Casepacker - Transfer Servo Actuator - Hose & Conector Piston Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(718, 1, 'MI.240', 'mi', 'Casepacker - Transfer Servo Actuator', 'Linier Guide Horizontal', 'Casepacker - Transfer Servo Actuator - Linier Guide Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(719, 1, 'MI.241', 'mi', 'Casepacker - Transfer Servo Actuator', 'Linier Guide Vertical', 'Casepacker - Transfer Servo Actuator - Linier Guide Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(720, 1, 'MI.242', 'mi', 'Casepacker - Transfer Servo Actuator', 'Teflon Transfer', 'Casepacker - Transfer Servo Actuator - Teflon Transfer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(721, 1, 'MI.243', 'mi', 'Casepacker - Transfer To Box', 'Plat Penahan Product', 'Casepacker - Transfer To Box - Plat Penahan Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(722, 1, 'MI.244', 'mi', 'Casepacker - Transfer To Box', 'Meja insert box', 'Casepacker - Transfer To Box - Meja insert box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(723, 1, 'MI.245', 'mi', 'Casepacker - Transfer To Box', 'Piston meja insert box', 'Casepacker - Transfer To Box - Piston meja insert box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(724, 1, 'MI.246', 'mi', 'Casepacker - Transfer To Box', 'Unit Solenoid Piston meja insert box', 'Casepacker - Transfer To Box - Unit Solenoid Piston meja insert box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(725, 1, 'MI.247', 'mi', 'Casepacker - Transfer To Box', 'Hose & Conector Piston meja insert box', 'Casepacker - Transfer To Box - Hose & Conector Piston meja insert box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(726, 1, 'MI.248', 'mi', 'Casepacker - Transfer To Box', 'Linier guide piston meja insert box', 'Casepacker - Transfer To Box - Linier guide piston meja insert box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(727, 1, 'MI.249', 'mi', 'Casepacker - Transfer To Box', 'Hand Wheel Meja Insert Box', 'Casepacker - Transfer To Box - Hand Wheel Meja Insert Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(728, 1, 'MI.250', 'mi', 'Casepacker - Transfer To Box', 'Plat pusher insert Box', 'Casepacker - Transfer To Box - Plat pusher insert Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(729, 1, 'MI.251', 'mi', 'Casepacker - Transfer To Box', 'Piston pusher insert Box', 'Casepacker - Transfer To Box - Piston pusher insert Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(730, 1, 'MI.252', 'mi', 'Casepacker - Transfer To Box', 'Unit Solenoid Piston pusher insert Box', 'Casepacker - Transfer To Box - Unit Solenoid Piston pusher insert Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(731, 1, 'MI.253', 'mi', 'Casepacker - Transfer To Box', 'Hose & Conector Piston pusher insert Box', 'Casepacker - Transfer To Box - Hose & Conector Piston pusher insert Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(732, 1, 'MI.254', 'mi', 'Casepacker - Transfer To Box', 'Linier guide piston pusher insert box', 'Casepacker - Transfer To Box - Linier guide piston pusher insert box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(733, 1, 'MI.255', 'mi', 'Casepacker - Transfer To Box', 'Piston Maker Row', 'Casepacker - Transfer To Box - Piston Maker Row', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(734, 1, 'MI.256', 'mi', 'Casepacker - Transfer To Box', 'Unit Solenoid Piston Maker Row', 'Casepacker - Transfer To Box - Unit Solenoid Piston Maker Row', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(735, 1, 'MI.257', 'mi', 'Casepacker - Transfer To Box', 'Hose & Conector Piston Maker Row', 'Casepacker - Transfer To Box - Hose & Conector Piston Maker Row', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(736, 1, 'MI.258', 'mi', 'Casepacker - Transfer To Box', 'Linier guide piston Maker Row', 'Casepacker - Transfer To Box - Linier guide piston Maker Row', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(737, 1, 'MI.259', 'mi', 'Casepacker - Transfer To Box', 'Hand Wheel Maker Row', 'Casepacker - Transfer To Box - Hand Wheel Maker Row', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(738, 1, 'MI.260', 'mi', 'Casepacker - Transfer To Box', 'Side Open Plat', 'Casepacker - Transfer To Box - Side Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(739, 1, 'MI.261', 'mi', 'Casepacker - Transfer To Box', 'Upper Open Plat', 'Casepacker - Transfer To Box - Upper Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(740, 1, 'MI.262', 'mi', 'Casepacker - Transfer To Box', 'Piston Open Plat', 'Casepacker - Transfer To Box - Piston Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(741, 1, 'MI.263', 'mi', 'Casepacker - Transfer To Box', 'Sensor Gagal Forming CB', 'Casepacker - Transfer To Box - Sensor Gagal Forming CB', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(742, 1, 'MI.264', 'mi', 'Casepacker - Transfer To Box', 'Unit Solenoid Piston Open Plat', 'Casepacker - Transfer To Box - Unit Solenoid Piston Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(743, 1, 'MI.265', 'mi', 'Casepacker - Transfer To Box', 'Hose & Conector Piston Open Plat', 'Casepacker - Transfer To Box - Hose & Conector Piston Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(744, 1, 'MI.266', 'mi', 'Casepacker - Transfer To Box', 'Shaft Linier Open Plat', 'Casepacker - Transfer To Box - Shaft Linier Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(745, 1, 'MI.267', 'mi', 'Casepacker - Transfer To Box', 'Hand wheel Open Plat', 'Casepacker - Transfer To Box - Hand wheel Open Plat', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(746, 1, 'MI.268', 'mi', 'Casepacker - Transfer To Box', 'Teflon Piston Penahan Product', 'Casepacker - Transfer To Box - Teflon Piston Penahan Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(747, 1, 'MI.269', 'mi', 'Casepacker - Transfer To Box', 'Piston Penahan Product', 'Casepacker - Transfer To Box - Piston Penahan Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(748, 1, 'MI.270', 'mi', 'Casepacker - Transfer To Box', 'Unit Solenoid Piston Penahan Product', 'Casepacker - Transfer To Box - Unit Solenoid Piston Penahan Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(749, 1, 'MI.271', 'mi', 'Casepacker - Transfer To Box', 'Hose & Conector Piston Penahan Product', 'Casepacker - Transfer To Box - Hose & Conector Piston Penahan Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(750, 1, 'MI.272', 'mi', 'Casepacker - Transfer To Box', 'Shaft Linier Piston Penahan Product', 'Casepacker - Transfer To Box - Shaft Linier Piston Penahan Product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(751, 1, 'MI.273', 'mi', 'Casepacker - Magazine', 'Belt Conveyor', 'Casepacker - Magazine - Belt Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(752, 1, 'MI.274', 'mi', 'Casepacker - Magazine', 'Limit Switch', 'Casepacker - Magazine - Limit Switch', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(753, 1, 'MI.275', 'mi', 'Casepacker - Magazine', 'Piston Upper', 'Casepacker - Magazine - Piston Upper', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(754, 1, 'MI.276', 'mi', 'Casepacker - Magazine', 'Adjuster Height', 'Casepacker - Magazine - Adjuster Height', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(755, 1, 'MI.277', 'mi', 'Casepacker - Magazine', 'Adjuster Widht', 'Casepacker - Magazine - Adjuster Widht', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(756, 1, 'MI.278', 'mi', 'Casepacker - Magazine', 'Motor Servo', 'Casepacker - Magazine - Motor Servo', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(757, 1, 'MI.279', 'mi', 'Casepacker - Magazine', 'Chain & Sprocket', 'Casepacker - Magazine - Chain & Sprocket', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(758, 1, 'MI.280', 'mi', 'Casepacker - Magazine', 'Carton Guide', 'Casepacker - Magazine - Carton Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(759, 1, 'MI.281', 'mi', 'Casepacker - Magazine', 'Adjuster Carton Guide', 'Casepacker - Magazine - Adjuster Carton Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(760, 1, 'MI.282', 'mi', 'Casepacker - Magazine', 'Roller', 'Casepacker - Magazine - Roller', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(761, 1, 'MI.283', 'mi', 'Casepacker - Magazine', 'Carton Open Guide', 'Casepacker - Magazine - Carton Open Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(762, 1, 'MI.284', 'mi', 'Casepacker - Conveyor Box', 'Motor', 'Casepacker - Conveyor Box - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(763, 1, 'MI.285', 'mi', 'Casepacker - Conveyor Box', 'Chain & Sprocket', 'Casepacker - Conveyor Box - Chain & Sprocket', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(764, 1, 'MI.286', 'mi', 'Casepacker - Conveyor Box', 'Adjuster Finger In', 'Casepacker - Conveyor Box - Adjuster Finger In', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(765, 1, 'MI.287', 'mi', 'Casepacker - Conveyor Box', 'Finger In', 'Casepacker - Conveyor Box - Finger In', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(766, 1, 'MI.288', 'mi', 'Casepacker - Conveyor Box', 'Finger Out', 'Casepacker - Conveyor Box - Finger Out', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(767, 1, 'MI.289', 'mi', 'Casepacker - Conveyor Box', 'Suction Cup', 'Casepacker - Conveyor Box - Suction Cup', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(768, 1, 'MI.290', 'mi', 'Casepacker - Conveyor Box', 'Lengan Vacuum', 'Casepacker - Conveyor Box - Lengan Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(769, 1, 'MI.291', 'mi', 'Casepacker - Conveyor Box', 'Shaft Vacuum', 'Casepacker - Conveyor Box - Shaft Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(770, 1, 'MI.292', 'mi', 'Casepacker - Conveyor Box', 'Piston Vacuum', 'Casepacker - Conveyor Box - Piston Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(771, 1, 'MI.293', 'mi', 'Casepacker - Conveyor Box', 'Unit Solenoid Piston Vacuum', 'Casepacker - Conveyor Box - Unit Solenoid Piston Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(772, 1, 'MI.294', 'mi', 'Casepacker - Conveyor Box', 'Hose & Conector Piston Vacuum', 'Casepacker - Conveyor Box - Hose & Conector Piston Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(773, 1, 'MI.295', 'mi', 'Casepacker - Conveyor Box', 'Solenoid Vacuum', 'Casepacker - Conveyor Box - Solenoid Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(774, 1, 'MI.296', 'mi', 'Casepacker - Conveyor Box', 'Manifold Vacuum', 'Casepacker - Conveyor Box - Manifold Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(775, 1, 'MI.297', 'mi', 'Casepacker - Conveyor Box', 'Side Guide', 'Casepacker - Conveyor Box - Side Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(776, 1, 'MI.298', 'mi', 'Casepacker - Conveyor Box', 'Piston Side Guide', 'Casepacker - Conveyor Box - Piston Side Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(777, 1, 'MI.299', 'mi', 'Casepacker - Conveyor Box', 'Unit Solenoid Piston Side Guide', 'Casepacker - Conveyor Box - Unit Solenoid Piston Side Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(778, 1, 'MI.300', 'mi', 'Casepacker - Conveyor Box', 'Hose & Conector Piston Side Guide', 'Casepacker - Conveyor Box - Hose & Conector Piston Side Guide', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(779, 1, 'MI.301', 'mi', 'Casepacker - Conveyor Box', 'Hand Wheel', 'Casepacker - Conveyor Box - Hand Wheel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(780, 1, 'MI.302', 'mi', 'Casepacker - Conveyor Box', 'Sensor Vacuum', 'Casepacker - Conveyor Box - Sensor Vacuum', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(781, 1, 'MI.303', 'mi', 'Casepacker - Conveyor Box', 'Sensor Stand By Carton', 'Casepacker - Conveyor Box - Sensor Stand By Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(782, 1, 'MI.304', 'mi', 'Casepacker - Conveyor Box', 'Sensor Stopper Finger', 'Casepacker - Conveyor Box - Sensor Stopper Finger', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(783, 1, 'MI.305', 'mi', 'Casepacker - Conveyor Box', 'Sensor Pusher Box', 'Casepacker - Conveyor Box - Sensor Pusher Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(784, 1, 'MI.306', 'mi', 'Casepacker - Conveyor Box', 'Guide Lidah Bawah Carton Box', 'Casepacker - Conveyor Box - Guide Lidah Bawah Carton Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(785, 1, 'MI.307', 'mi', 'Casepacker - Panel Electric', 'Panel', 'Casepacker - Panel Electric - Panel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(786, 1, 'MI.308', 'mi', 'Casepacker - Panel Electric', 'Program & System', 'Casepacker - Panel Electric - Program & System', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(787, 1, 'MI.309', 'mi', 'Casepacker - Panel Electric', 'Switch Safety door', 'Casepacker - Panel Electric - Switch Safety door', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(788, 1, 'MI.310', 'mi', 'Casepacker - Panel Electric', 'Touch Screen', 'Casepacker - Panel Electric - Touch Screen', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(789, 1, 'MI.311', 'mi', 'Casepacker - Panel Electric', 'Emergency Stop', 'Casepacker - Panel Electric - Emergency Stop', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(790, 1, 'MI.312', 'mi', 'Casepacker - Conveyor Sealer', 'Pusher Box', 'Casepacker - Conveyor Sealer - Pusher Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(791, 1, 'MI.313', 'mi', 'Casepacker - Conveyor Sealer', 'Piston Pusher Box', 'Casepacker - Conveyor Sealer - Piston Pusher Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(792, 1, 'MI.314', 'mi', 'Casepacker - Conveyor Sealer', 'Unit Solenoid Piston Pusher Box', 'Casepacker - Conveyor Sealer - Unit Solenoid Piston Pusher Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(793, 1, 'MI.315', 'mi', 'Casepacker - Conveyor Sealer', 'Hose & Conector Piston Pusher Box', 'Casepacker - Conveyor Sealer - Hose & Conector Piston Pusher Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(794, 1, 'MI.316', 'mi', 'Casepacker - Conveyor Sealer', 'Tuck In', 'Casepacker - Conveyor Sealer - Tuck In', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(795, 1, 'MI.317', 'mi', 'Casepacker - Conveyor Sealer', 'Piston Tuck In', 'Casepacker - Conveyor Sealer - Piston Tuck In', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(796, 1, 'MI.318', 'mi', 'Casepacker - Conveyor Sealer', 'Unit Solenoid Piston Tuck In', 'Casepacker - Conveyor Sealer - Unit Solenoid Piston Tuck In', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(797, 1, 'MI.319', 'mi', 'Casepacker - Conveyor Sealer', 'Hose & Conector Piston Tuck In', 'Casepacker - Conveyor Sealer - Hose & Conector Piston Tuck In', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(798, 1, 'MI.320', 'mi', 'Casepacker - Conveyor Sealer', 'Guide Up', 'Casepacker - Conveyor Sealer - Guide Up', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(799, 1, 'MI.321', 'mi', 'Casepacker - Conveyor Sealer', 'Piston Guide Up', 'Casepacker - Conveyor Sealer - Piston Guide Up', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(800, 1, 'MI.322', 'mi', 'Casepacker - Conveyor Sealer', 'Unit Solenoid Piston Guide Up', 'Casepacker - Conveyor Sealer - Unit Solenoid Piston Guide Up', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(801, 1, 'MI.323', 'mi', 'Casepacker - Conveyor Sealer', 'Hose & Conector Piston Guide Up', 'Casepacker - Conveyor Sealer - Hose & Conector Piston Guide Up', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(802, 1, 'MI.324', 'mi', 'Casepacker - Conveyor Sealer', 'Linier Shaft Piston Guide Up', 'Casepacker - Conveyor Sealer - Linier Shaft Piston Guide Up', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(803, 1, 'MI.325', 'mi', 'Casepacker - Conveyor Sealer', 'Guide Down', 'Casepacker - Conveyor Sealer - Guide Down', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(804, 1, 'MI.326', 'mi', 'Casepacker - Conveyor Sealer', 'Piston Guide Down', 'Casepacker - Conveyor Sealer - Piston Guide Down', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(805, 1, 'MI.327', 'mi', 'Casepacker - Conveyor Sealer', 'Unit Solenoid Piston Guide Down', 'Casepacker - Conveyor Sealer - Unit Solenoid Piston Guide Down', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(806, 1, 'MI.328', 'mi', 'Casepacker - Conveyor Sealer', 'Hose & Conector Piston Guide Down', 'Casepacker - Conveyor Sealer - Hose & Conector Piston Guide Down', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(807, 1, 'MI.329', 'mi', 'Casepacker - Conveyor Sealer', 'Linier Shaft Piston Guide Down', 'Casepacker - Conveyor Sealer - Linier Shaft Piston Guide Down', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(808, 1, 'MI.330', 'mi', 'Casepacker - Conveyor Sealer', 'Stopper Carton', 'Casepacker - Conveyor Sealer - Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(809, 1, 'MI.331', 'mi', 'Casepacker - Conveyor Sealer', 'Piston Stopper Carton', 'Casepacker - Conveyor Sealer - Piston Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(810, 1, 'MI.332', 'mi', 'Casepacker - Conveyor Sealer', 'Unit Solenoid Piston Stopper Carton', 'Casepacker - Conveyor Sealer - Unit Solenoid Piston Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(811, 1, 'MI.333', 'mi', 'Casepacker - Conveyor Sealer', 'Hose & Conector Piston Stopper Carton', 'Casepacker - Conveyor Sealer - Hose & Conector Piston Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(812, 1, 'MI.334', 'mi', 'Casepacker - Conveyor Sealer', 'Sensor Sealer Carton', 'Casepacker - Conveyor Sealer - Sensor Sealer Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(813, 1, 'MI.335', 'mi', 'Casepacker - Conveyor Sealer', 'Sensor Stopper Finger Sealer', 'Casepacker - Conveyor Sealer - Sensor Stopper Finger Sealer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(814, 1, 'MI.336', 'mi', 'Casepacker - Conveyor Sealer', 'Guide 01', 'Casepacker - Conveyor Sealer - Guide 01', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(815, 1, 'MI.337', 'mi', 'Casepacker - Conveyor Sealer', 'Guide 02', 'Casepacker - Conveyor Sealer - Guide 02', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(816, 1, 'MI.338', 'mi', 'Casepacker - Conveyor Sealer', 'Guide 03', 'Casepacker - Conveyor Sealer - Guide 03', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(817, 1, 'MI.339', 'mi', 'Casepacker - Conveyor Sealer', 'Guide 04', 'Casepacker - Conveyor Sealer - Guide 04', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(818, 1, 'MI.340', 'mi', 'Casepacker - Conveyor Sealer', 'Guide 05', 'Casepacker - Conveyor Sealer - Guide 05', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(819, 1, 'MI.341', 'mi', 'Casepacker - Conveyor Sealer', 'Guide 06', 'Casepacker - Conveyor Sealer - Guide 06', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(820, 1, 'MI.342', 'mi', 'Casepacker - Conveyor Sealer', 'Guide 07', 'Casepacker - Conveyor Sealer - Guide 07', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(821, 1, 'MI.343', 'mi', 'Casepacker - Conveyor Sealer', 'Guide 08', 'Casepacker - Conveyor Sealer - Guide 08', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(822, 1, 'MI.344', 'mi', 'Casepacker - Conveyor Sealer', 'Guide 09', 'Casepacker - Conveyor Sealer - Guide 09', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(823, 1, 'MI.345', 'mi', 'Casepacker - Conveyor Sealer', 'Guide 10', 'Casepacker - Conveyor Sealer - Guide 10', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(824, 1, 'MI.346', 'mi', 'Casepacker - Conveyor Sealer', 'Sealer', 'Casepacker - Conveyor Sealer - Sealer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(825, 1, 'MI.347', 'mi', 'Casepacker - Conveyor Sealer', 'Finger Conveyor Sealer Atas', 'Casepacker - Conveyor Sealer - Finger Conveyor Sealer Atas', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(826, 1, 'MI.348', 'mi', 'Casepacker - Conveyor Sealer', 'Finger Conveyor Sealer Bawah', 'Casepacker - Conveyor Sealer - Finger Conveyor Sealer Bawah', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(827, 1, 'MI.349', 'mi', 'Casepacker - Conveyor Sealer', 'Motor', 'Casepacker - Conveyor Sealer - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(828, 1, 'MI.350', 'mi', 'Casepacker - Conveyor Sealer', 'Hand Wheel Horizontal', 'Casepacker - Conveyor Sealer - Hand Wheel Horizontal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(829, 1, 'MI.351', 'mi', 'Casepacker - Conveyor Sealer', 'Hand Wheel Vertical', 'Casepacker - Conveyor Sealer - Hand Wheel Vertical', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(830, 1, 'MI.352', 'mi', 'Casepacker - Conveyor Sealer', 'Drive Mekanikal', 'Casepacker - Conveyor Sealer - Drive Mekanikal', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(831, 1, 'MI.353', 'mi', 'Casepacker - Conveyor Sealer', 'Bevel Gear', 'Casepacker - Conveyor Sealer - Bevel Gear', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(832, 1, 'MI.354', 'mi', 'Conveyor Output Carton', 'Motor Pembalik Carton', 'Conveyor Output Carton - Motor Pembalik Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(833, 1, 'MI.355', 'mi', 'Conveyor Output Carton', 'Chain & Sprocket Pembalik Carton', 'Conveyor Output Carton - Chain & Sprocket Pembalik Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(834, 1, 'MI.356', 'mi', 'Conveyor Output Carton', 'Shaft Pembalik Carton', 'Conveyor Output Carton - Shaft Pembalik Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(835, 1, 'MI.357', 'mi', 'Conveyor Output Carton', 'Handle Pembalik Carton', 'Conveyor Output Carton - Handle Pembalik Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(836, 1, 'MI.358', 'mi', 'Conveyor Output Carton', 'Sensor Pembalik Carton', 'Conveyor Output Carton - Sensor Pembalik Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(837, 1, 'MI.359', 'mi', 'Conveyor Output Carton', 'Sensor Detector Carton', 'Conveyor Output Carton - Sensor Detector Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(838, 1, 'MI.360', 'mi', 'Conveyor Output Carton', 'Motor Roller Conveyor', 'Conveyor Output Carton - Motor Roller Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(839, 1, 'MI.361', 'mi', 'Conveyor Output Carton', 'Roller', 'Conveyor Output Carton - Roller', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(840, 1, 'MI.362', 'mi', 'Conveyor Output Carton', 'Chain & Sprocket Roller', 'Conveyor Output Carton - Chain & Sprocket Roller', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(841, 1, 'MI.363', 'mi', 'Conveyor Output Carton', 'Stopper Carton', 'Conveyor Output Carton - Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(842, 1, 'MI.364', 'mi', 'Conveyor Output Carton', 'Piston Stopper Carton', 'Conveyor Output Carton - Piston Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(843, 1, 'MI.365', 'mi', 'Conveyor Output Carton', 'Unit Solenoid Piston Stopper Carton', 'Conveyor Output Carton - Unit Solenoid Piston Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(844, 1, 'MI.366', 'mi', 'Conveyor Output Carton', 'Hose & Conector Piston Stopper Carton', 'Conveyor Output Carton - Hose & Conector Piston Stopper Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(845, 1, 'MI.367', 'mi', 'Conveyor Output Carton', 'Conveyor Flat Belt Printing Carton', 'Conveyor Output Carton - Conveyor Flat Belt Printing Carton', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(846, 1, 'MI.368', 'mi', 'Printer Crayon', 'Sensor', 'Printer Crayon - Sensor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(847, 1, 'MI.369', 'mi', 'Printer Crayon', 'Hose', 'Printer Crayon - Hose', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(848, 1, 'MI.370', 'mi', 'Printer Crayon', 'Head Printer', 'Printer Crayon - Head Printer', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(849, 1, 'MI.371', 'mi', 'Printer Crayon', 'Printer Unit', 'Printer Crayon - Printer Unit', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(850, 1, 'MI.372', 'mi', 'Printer Crayon', 'Pressure Pump', 'Printer Crayon - Pressure Pump', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(851, 1, 'MI.373', 'mi', 'Printer Crayon', 'Filter Ink', 'Printer Crayon - Filter Ink', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(852, 1, 'MI.374', 'mi', 'Tooth belt Conveyor', 'Motor', 'Tooth belt Conveyor - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(853, 1, 'MI.375', 'mi', 'Tooth belt Conveyor', 'Conveyor', 'Tooth belt Conveyor - Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(854, 1, 'MI.376', 'mi', 'Check Weigher', 'Monitor', 'Check Weigher - Monitor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(855, 1, 'MI.377', 'mi', 'Check Weigher', 'Motor', 'Check Weigher - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(856, 1, 'MI.378', 'mi', 'Check Weigher', 'Belt Conveyor', 'Check Weigher - Belt Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(857, 1, 'MI.379', 'mi', 'Check Weigher', 'Roller', 'Check Weigher - Roller', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(858, 1, 'MI.380', 'mi', 'Lifter', 'Belt Conveyor', 'Lifter - Belt Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(859, 1, 'MI.381', 'mi', 'Lifter', 'Motor Conveyor', 'Lifter - Motor Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(860, 1, 'MI.382', 'mi', 'Lifter', 'Sensor product', 'Lifter - Sensor product', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(861, 1, 'MI.383', 'mi', 'Lifter', 'Blade', 'Lifter - Blade', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(862, 1, 'MI.384', 'mi', 'Lifter', 'Chain', 'Lifter - Chain', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(863, 1, 'MI.385', 'mi', 'Lifter', 'Pusher Box', 'Lifter - Pusher Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(864, 1, 'MI.386', 'mi', 'Lifter', 'Panel', 'Lifter - Panel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(865, 1, 'MI.387', 'mi', 'Lifter', 'Sensor counting', 'Lifter - Sensor counting', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(866, 1, 'MI.388', 'mi', 'Lifter', 'Motor', 'Lifter - Motor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(867, 1, 'MI.389', 'mi', 'Lifter', 'Stopper Carton Box', 'Lifter - Stopper Carton Box', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(868, 1, 'MI.390', 'mi', 'Carry Line', '', 'Carry Line', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(869, 1, 'MI.391', 'mi', 'Roller Conveyor', '', 'Roller Conveyor', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(870, 1, 'MI.392', 'mi', 'Pallet Magazine', '', 'Pallet Magazine', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(871, 1, 'MI.393', 'mi', 'Robotic Pallet', '', 'Robotic Pallet', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(872, 1, 'MI.394', 'mi', 'SACHET FILLING', 'Panel', 'SACHET FILLING - Panel', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(873, 1, 'MI.395', 'mi', 'Others Minorstop', 'Others ', 'Others Minorstop - Others ', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `mbroker`
--

CREATE TABLE `mbroker` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `txthost` varchar(64) NOT NULL,
  `intport` int(11) NOT NULL,
  `intwsport` int(11) DEFAULT NULL,
  `txtusername` varchar(128) DEFAULT NULL,
  `txtpassword` varchar(128) DEFAULT NULL,
  `txtclientid` varchar(128) NOT NULL,
  `intactive` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mbroker`
--

INSERT INTO `mbroker` (`id`, `txthost`, `intport`, `intwsport`, `txtusername`, `txtpassword`, `txtclientid`, `intactive`, `created_at`, `updated_at`) VALUES
(2, 'broker.mqttdashboard.com', 1883, NULL, NULL, NULL, 'Client_id-39q084738q498q604q3', 0, '2022-10-29 01:04:55', '2022-11-01 07:45:00'),
(3, 'broker.mqttdashboard.com', 8000, NULL, NULL, NULL, 'claiekanda', 0, '2022-10-29 01:22:22', '2022-11-22 13:14:36'),
(4, '127.0.0.1', 1883, 9001, NULL, NULL, 'ClientID-89682yhjbd6598qecascd', 1, '2022-11-01 07:45:32', '2022-11-22 13:14:36');

-- --------------------------------------------------------

--
-- Table structure for table `mdailyactivities`
--

CREATE TABLE `mdailyactivities` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `line_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `txticon` varchar(64) NOT NULL,
  `txttitle` varchar(64) NOT NULL,
  `txturl` varchar(64) DEFAULT NULL,
  `txtroute` varchar(64) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `txticon`, `txttitle`, `txturl`, `txtroute`, `created_at`, `updated_at`) VALUES
(1, 'ion-md-speedometer bg-gradient-success', 'Dashboard', '/dashboard', 'dashboard.index', '2022-09-30 09:11:09', '2022-09-30 09:11:09'),
(2, 'ion-md-cog bg-gradient-primary', 'Master Data', 'javascript:;', NULL, '2022-09-30 09:11:37', '2022-09-30 09:11:37'),
(3, 'ion-md-time bg-gradient-primary', 'Management Working Time', 'javascript:;', NULL, '2022-09-30 11:05:50', '2022-09-30 11:05:50'),
(4, 'ion-md-calendar bg-gradient-white text-dark', 'Production Planning', 'javascript:;', NULL, '2022-09-30 14:05:47', '2022-10-01 09:25:03'),
(5, 'ion-md-paper bg-gradient-yellow-red', 'Achievement POE', '/admin/viewpoe', 'achievement.poe.index', '2022-09-30 11:17:10', '2022-10-03 20:48:01'),
(6, 'ion-md-key bg-gradient-yellow-red', 'Management KPI', '/admin/kpi', 'manage.kpi.index', '2022-09-30 11:18:25', '2022-09-30 11:18:25'),
(7, 'ion-md-filing bg-gradient-purple-indigo', 'Yield Production', '/admin/yield', 'manage.yield.index', '2022-09-30 14:03:58', '2022-09-30 14:04:30'),
(8, 'ion-md-infinite bg-gradient-pink', 'Activity Code', '/admin/activity', 'manage.activity.index', '2022-09-30 14:05:18', '2022-09-30 14:05:18'),
(9, 'ion-md-cube bg-gradient-blue-green', 'DB OEE', '/admin/viewoee', 'view.oee.index', '2022-09-30 11:17:45', '2022-10-01 09:24:26'),
(10, 'ion-md-clipboard bg-gradient-yellow', 'Input OEE', '/operator/month', 'operator.month', '2022-09-30 14:08:03', '2022-09-30 14:08:03'),
(11, 'ion-md-clipboard bg-gradient-purple', 'Input OEE Drier', '/operator/month-drier', 'operator.drier.month', '2022-09-30 14:08:25', '2022-09-30 14:08:25'),
(12, 'ion-md-podium bg-gradient-lime text-black', 'Manajemen OEE', '/admin/oeemanagement', 'management.oee.month', '2022-09-30 14:08:50', '2022-09-30 14:08:50'),
(13, 'ion-md-analytics bg-gradient-gray', 'Management Report', '/admin/report', 'admin.report.index', '2022-09-30 14:09:27', '2022-09-30 14:09:27'),
(14, 'ion-ios-grid bg-green', 'Achievement', 'javascript:;', NULL, '2022-10-09 11:40:13', '2022-10-09 11:40:13'),
(15, 'ion-md-clipboard bg-gradient-yellow', 'Input OEE', '/leader/month', 'leader.month', '2022-10-09 22:26:51', '2022-10-09 22:26:51'),
(16, 'ion-md-cube bg-gradient-blue-green', 'DB OEE', '/leader/viewoee', 'leader.view.dboee', '2022-10-09 23:01:43', '2022-10-09 23:01:43'),
(17, 'ion-md-alarm bg-pink', 'Downtime Analysis', '/admin/viewdowntime', 'admin.view.downtime', '2022-10-10 15:41:08', '2022-10-10 15:41:08'),
(18, 'ion-md-clipboard bg-gradient-yellow', 'Input OEE', '/admin-cg/month', 'admin-cg.month', '2022-10-23 09:46:26', '2022-10-23 09:46:26'),
(19, 'ion-md-clipboard bg-gradient-purple', 'Input OEE Drier', '/leader-drier/month', 'leaderDrier.month', '2022-10-24 00:14:22', '2022-10-24 00:14:22'),
(20, 'ion-md-clipboard bg-gradient-yellow', 'Input OEE', '/leader-cg/month', 'leaderCg.month', '2022-10-24 00:16:27', '2022-10-24 00:16:37'),
(21, 'ion-md-cube bg-gradient-blue-green', 'DB OEE', '/admin-cg/viewoee', 'adminCg.view.dboee', '2022-10-24 00:17:40', '2022-10-24 00:19:11'),
(22, 'ion-md-alarm bg-pink', 'Downtime Analysis', '/admin-cg/viewdowntime', 'adminCg.view.downtime', '2022-10-24 00:18:25', '2022-10-24 00:18:25'),
(23, 'ion-md-cube bg-gradient-blue-green', 'DB OEE', '/leader-cg/viewoee', 'leaderCg.view.dboee', '2022-10-24 00:18:43', '2022-10-24 00:19:20'),
(24, 'ion-md-alarm bg-pink', 'Downtime Analysis', '/leader-cg/viewdowntime', 'leaderCg.view.downtime', '2022-10-24 00:19:38', '2022-10-24 00:19:54'),
(25, 'ion-md-alarm bg-pink', 'Downtime Analysis', '/leader/viewdowntime', 'leader.view.downtime', '2022-10-24 00:22:44', '2022-10-24 00:22:44'),
(26, 'ion-md-clipboard bg-gradient-purple', 'Input OEE Drier', '/leader-cg/month-drier', 'leader-cg.drier.month', '2022-10-24 07:07:41', '2022-10-24 07:07:41'),
(27, 'ion-md-clipboard bg-gradient-purple', 'Input OEE Drier', '/admin-cg/month-drier', 'admin-cg.drier.month', '2022-10-24 14:42:02', '2022-10-24 14:42:02'),
(28, 'ion-md-sync bg-gradient-green', 'Settings', 'Javascript:;', NULL, '2022-10-29 06:50:45', '2022-10-29 06:51:21');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2022_10_15_120152_create_jobs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mkpi`
--

CREATE TABLE `mkpi` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `txtyear` char(6) NOT NULL,
  `poe` float NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mkpi`
--

INSERT INTO `mkpi` (`id`, `txtyear`, `poe`, `created_at`, `updated_at`) VALUES
(5, '2022', 86.5, '2022-10-05 11:40:05', '2022-10-05 12:36:28'),
(6, '2023', 87, '2022-10-05 11:50:01', '2022-10-05 11:50:40');

-- --------------------------------------------------------

--
-- Table structure for table `mlevels`
--

CREATE TABLE `mlevels` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `txtlevelname` varchar(32) NOT NULL,
  `intsessline` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mlevels`
--

INSERT INTO `mlevels` (`id`, `txtlevelname`, `intsessline`, `created_at`, `updated_at`) VALUES
(1, 'ADMIN', 0, '2022-08-26 19:24:19', '2022-08-26 19:24:19'),
(2, 'SUPERVISOR', 0, '2022-08-26 19:25:34', '2022-08-26 19:25:34'),
(3, 'ADMIN CG PACKING', 0, '2022-08-26 19:25:38', '2022-10-23 22:39:21'),
(4, 'QC', 0, '2022-08-26 19:25:41', '2022-08-26 19:25:41'),
(5, 'PPIC', 0, '2022-08-26 19:25:43', '2022-08-26 19:25:43'),
(6, 'LEADER', 1, '2022-09-07 04:12:37', '2022-10-23 07:40:06'),
(7, 'OPERATOR', 1, '2022-08-26 19:25:48', '2022-10-23 07:40:06'),
(8, 'OPERATOR DRIER', 1, '2022-10-01 05:27:25', '2022-10-23 07:40:07'),
(9, 'LEADER CG', 0, '2022-10-22 08:08:30', '2022-10-23 07:40:18'),
(10, 'LEADER DRIER', 1, '2022-10-22 13:00:58', '2022-10-23 07:40:13'),
(15, 'ADMIN CG DRIER', 0, '2022-10-23 22:39:51', '2022-10-23 22:39:51'),
(16, 'LEADER CG DRIER', 0, '2022-10-24 00:08:39', '2022-10-24 00:08:39');

-- --------------------------------------------------------

--
-- Table structure for table `mline`
--

CREATE TABLE `mline` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `txtlinename` varchar(128) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mline`
--

INSERT INTO `mline` (`id`, `txtlinename`, `created_at`, `updated_at`) VALUES
(1, 'SUSPENSION', '2022-09-05 18:15:35', '2022-11-19 00:46:03'),
(2, 'PP MEMBER D03', '2022-11-19 00:19:47', '2022-11-19 00:46:21'),
(3, 'PP MEMBER D74', '2022-11-19 00:19:53', '2022-11-19 00:46:44'),
(4, 'UNGGUL', '2022-11-22 14:24:29', '2022-11-22 14:24:29');

--
-- Triggers `mline`
--
DELIMITER $$
CREATE TRIGGER `trigger_line` BEFORE INSERT ON `mline` FOR EACH ROW BEGIN
	SET @jumlah = (SELECT id FROM mline ORDER BY id DESC LIMIT 1);
	IF(@jumlah) THEN
		SET new.id = @jumlah+1;
	ELSE
		SET new.id = 1;
	END IF;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `mmachines`
--

CREATE TABLE `mmachines` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `line_id` bigint(20) UNSIGNED NOT NULL,
  `txtmachinename` varchar(128) NOT NULL,
  `txtpicture` varchar(128) DEFAULT 'default.png',
  `intbottleneck` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mmachines`
--

INSERT INTO `mmachines` (`id`, `line_id`, `txtmachinename`, `txtpicture`, `intbottleneck`, `created_at`, `updated_at`) VALUES
(6, 1, 'SUSPENSION MACHINE 1', 'default.png', 1, '2022-11-22 12:44:59', '2022-11-22 12:51:27'),
(7, 2, 'D03 MACHINE 1', 'default.png', 1, '2022-11-22 12:46:10', '2022-11-22 12:53:54'),
(8, 3, 'D74 MACHINE 1', '2022112219540924-243890_e3-2016-xbox-one-s-microsoft-xbox-one.png', 1, '2022-11-22 12:54:09', '2022-11-22 12:54:13');

-- --------------------------------------------------------

--
-- Table structure for table `mplanorder`
--

CREATE TABLE `mplanorder` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `line_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `txtbatchcode` varchar(64) DEFAULT NULL,
  `inttarget` int(11) DEFAULT NULL,
  `intstatus` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mplanorder`
--

INSERT INTO `mplanorder` (`id`, `line_id`, `product_id`, `txtbatchcode`, `inttarget`, `intstatus`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'DPM-ORDER-221121001', 1000, 0, '2022-11-21 07:05:03', '2022-11-21 07:05:03');

--
-- Triggers `mplanorder`
--
DELIMITER $$
CREATE TRIGGER `trigger_planorder` BEFORE INSERT ON `mplanorder` FOR EACH ROW BEGIN
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
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `mproduct`
--

CREATE TABLE `mproduct` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `line_id` bigint(20) UNSIGNED NOT NULL,
  `txtartcode` varchar(64) NOT NULL,
  `txtproductname` varchar(128) NOT NULL,
  `txtproductcode` varchar(32) DEFAULT NULL COMMENT '/*OPTIONAL',
  `txtlinecode` varchar(32) DEFAULT NULL,
  `floatbatchsize` float DEFAULT NULL,
  `floatstdspeed` float DEFAULT NULL COMMENT 'CYCLE TIME PCS/MENIT',
  `intpcskarton` int(11) DEFAULT NULL,
  `intnetfill` int(11) DEFAULT NULL,
  `txtpartimage` varchar(128) DEFAULT 'default.png' COMMENT 'PRODUCT IMAGE UPLOAD',
  `txtcategory` varchar(50) DEFAULT NULL,
  `txtfocuscategory` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mproduct`
--

INSERT INTO `mproduct` (`id`, `line_id`, `txtartcode`, `txtproductname`, `txtproductcode`, `txtlinecode`, `floatbatchsize`, `floatstdspeed`, `intpcskarton`, `intnetfill`, `txtpartimage`, `txtcategory`, `txtfocuscategory`, `created_at`, `updated_at`) VALUES
(1, 1, 'ABC863', 'AKBDk', 'awdawda', NULL, NULL, 3, 10, NULL, 'default.png', NULL, NULL, '2022-11-21 07:02:06', '2022-11-21 07:02:06');

-- --------------------------------------------------------

--
-- Table structure for table `mtopic`
--

CREATE TABLE `mtopic` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `broker_id` bigint(20) UNSIGNED NOT NULL,
  `machine_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mtopic`
--

INSERT INTO `mtopic` (`id`, `broker_id`, `machine_id`, `created_at`, `updated_at`) VALUES
(13, 4, 6, '2022-11-22 13:01:38', '2022-11-22 13:01:38'),
(14, 4, 7, '2022-11-22 13:12:04', '2022-11-22 13:12:04');

-- --------------------------------------------------------

--
-- Table structure for table `musers`
--

CREATE TABLE `musers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `line_id` bigint(20) UNSIGNED NOT NULL DEFAULT '0',
  `txtname` varchar(128) CHARACTER SET latin1 NOT NULL,
  `txtusername` varchar(128) CHARACTER SET latin1 NOT NULL,
  `level_id` bigint(20) UNSIGNED NOT NULL,
  `password` varchar(128) CHARACTER SET latin1 NOT NULL,
  `txtinitial` char(6) DEFAULT NULL,
  `txtphoto` varchar(128) CHARACTER SET latin1 DEFAULT 'default.jpg',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `musers`
--

INSERT INTO `musers` (`id`, `line_id`, `txtname`, `txtusername`, `level_id`, `password`, `txtinitial`, `txtphoto`, `created_at`, `updated_at`) VALUES
(1, 1, 'Irpan Hidayat Pamil', 'admin.apps', 1, '$2a$12$KimvCjgqdof863pNNHpiKuRZ8F2wVGRoAQg1tNZFxXJXpDf0qHTeu', 'IHP', 'user-14.jpg', '2022-08-29 03:44:44', '2022-11-01 18:55:00'),
(5, 0, 'Alit Pradana', 'alit.pradana', 2, '$2y$10$6nr3fGZzVaJ2VbonC3h6wueyXG6VzE3udXpmZD9MvjQFKsLJ2Md76', 'APA', 'user-14.jpg', '2022-09-30 15:20:21', '2022-11-01 18:55:00'),
(7, 0, 'Mahmud Fauji Tanjung', 'mahmud.tanjung', 9, '$2y$10$RZsYK0XbNLEEZ3fIr1jU/OYjnt9l5pq82klyzPtVJlS37n6Wt2tOG', 'MFT', 'user-14.jpg', '2022-09-30 15:22:04', '2022-11-01 18:55:00'),
(8, 0, 'Zaenuddin', 'zaenuddin', 7, '$2y$10$aP22C1VyT8PmHc3q1iGLt.FaMJZaMDOH01whGwK918R7LepZOxbPu', 'ZDN', 'user-14.jpg', '2022-09-30 15:23:26', '2022-11-01 18:55:00'),
(9, 0, 'Pebi', 'pebi', 7, '$2y$10$QqlDkoMBMs4q1GB9roGLaeFOu2.aK.uuul3euplod4BaXDGXqSth6', 'PBI', '20221027064531dummy_profile.png', '2022-09-30 15:24:05', '2022-10-26 23:56:04'),
(10, 0, 'Abdul Mujib', 'abdul.mujib', 7, '$2y$10$ju8noueCaqIDJj4lxghpbu.mlhWqLyEptF6eqG2VM1evTKYgK/dSK', 'AMB', 'user-14.jpg', '2022-09-30 15:25:06', '2022-11-01 18:55:00'),
(11, 0, 'Edi Saputra', 'edi.saputra', 7, '$2y$10$uXv8qceAcZ8G52GBUI8o2.2.5tOv4edW5VBHS9zeLPPqDjfdVOgii', 'ESA', 'user-14.jpg', '2022-09-30 15:25:54', '2022-11-01 18:55:00'),
(12, 0, 'Dede Dodi Ginanjar', 'dede.ginanjar', 1, '$2y$10$PDj753GU0SoXGVWwbaolveack3vObBLPpIUPZHMwIj5gqOwNSwtjy', 'DDG', 'user-14.jpg', '2022-10-12 19:34:26', '2022-11-01 18:55:00'),
(13, 0, 'Ahmad Sahroni', 'ahmad.sahroni', 1, '$2y$10$7aoUsX2HEnIkMup9OS03keh7Cmom1fpoQyc9lrtCbRQig3w2K5bXS', 'ASR', 'user-14.jpg', '2022-10-12 20:10:35', '2022-11-01 18:55:00'),
(14, 0, 'Bugi Novriyanto', 'bugi.novriyanto', 2, '$2y$10$ovAk3ElvgI1caiKsmxI72elhxmp1PAHPEnr/vT88VmP3Y8J0VbqgG', 'BNO', 'user-14.jpg', '2022-10-12 20:45:45', '2022-11-01 18:55:00'),
(15, 0, 'Zaini', 'zaini', 2, '$2y$10$Lt8YcVjbfiXhEv9BC7I25.KxyAx0nI7hIE8s8OIZ9Kp/z4rJmXPhq', 'ZAI', 'user-14.jpg', '2022-10-12 20:46:41', '2022-11-01 18:55:00'),
(16, 0, 'Munadih', 'munadih', 9, '$2y$10$r7JzweRkC/ibWSN6FBv6nOnQuKJftLoFqXJ0BxaW2jFGvEkfD/z7G', 'MND', 'user-14.jpg', '2022-10-12 21:06:06', '2022-11-01 18:55:00'),
(17, 0, 'Yayat Hidayat', 'yayat.hidayat', 9, '$2y$10$DTOrCXtJ72QtjVpU4X5Jrulz5CCm8O48E9DaY.iyxxEMyf47lsl5i', 'YHT', 'user-14.jpg', '2022-10-12 21:07:15', '2022-11-01 18:55:00'),
(18, 0, 'Yunus John Biloro', 'yunus.biloro', 9, '$2y$10$7Ox76CcjsA51Z5/O.VCnlOqqAnIEhy6uiDhZhKm9IO72kWpswNa9K', 'YJB', 'user-14.jpg', '2022-10-12 21:08:08', '2022-11-01 18:55:00'),
(19, 0, 'Khonsa', 'khonsa', 3, '$2y$10$6cvGi0nkPAeY4sHOV1StOuFq42vli2P5c5cDgQ1Hr3ufOsytnkGE6', 'KHA', 'user-14.jpg', '2022-10-12 21:10:01', '2022-11-01 18:55:00'),
(20, 0, 'Mazmur', 'mazmur', 3, '$2y$10$XqwjTc.IqkcehpAgaflDLuHFsNLAi6zHio2eynPBC0jSUTA4pTXTy', 'MZR', 'user-14.jpg', '2022-10-12 21:21:39', '2022-11-01 18:55:00'),
(21, 0, 'Wulan Nur Fatimah', 'wulan.fatimah', 3, '$2y$10$RPZNnCqzXSrV23jlWhWeM.1yAMMlT1gT/IalajSraIEoFaajuyiyO', 'WNF', 'user-14.jpg', '2022-10-12 21:24:13', '2022-11-01 18:55:00'),
(22, 0, 'Ade Humaini', 'ade.humaini', 6, '$2y$10$O2ybZFssH5xMQz/2j7duPOOwZLGH9A5PSYxrzW2nAKjHJqswkabRO', 'ADH', 'user-14.jpg', '2022-10-12 21:42:30', '2022-11-01 18:55:00'),
(23, 0, 'Ade Nandar', 'ade.nandar', 6, '$2y$10$0pW9KFWtWkFxO7qybKTIjepFh0zpZcVIl38Tqlwc5e8kL17DAlwd.', 'ANR', 'user-14.jpg', '2022-10-12 21:43:02', '2022-11-01 18:55:00'),
(24, 0, 'Linda Labora', 'linda.labora', 6, '$2y$10$.D5IRSYkvfU1S04s.SKDrOkg5sRWxnBU2TjCb.7FyAnIh/ElJXRH2', 'LLA', 'user-14.jpg', '2022-10-12 21:43:47', '2022-11-01 18:55:00'),
(25, 0, 'Rahmat Kurniawan', 'rahmat.kurniawan', 6, '$2y$10$qp9pToL7ZpkDp1HH09gTEODLbn0qK6uTsMV0YTfuevVJZPVeD6oJ.', 'RKN', 'user-14.jpg', '2022-10-12 21:46:28', '2022-11-01 18:55:00'),
(26, 0, 'Solehudin', 'solehudin', 6, '$2y$10$EPCtBsbuUh3PMLKi4yWTwuJ13/Vke.Z89t4qya8l9jLkneHTIeJQa', 'SLN', 'user-14.jpg', '2022-10-12 21:47:13', '2022-11-01 18:55:00'),
(27, 0, 'Suhatman', 'suhatman', 6, '$2y$10$J0cvDC5W2Q.IJ8ujLq212.Fc/8UlNLvmQE4aAscL/L4I3VS9ZHIxK', 'SHM', 'user-14.jpg', '2022-10-12 21:47:55', '2022-11-01 18:55:00'),
(28, 0, 'Aris Suparli', 'aris.suparli', 7, '$2y$10$dezx9ttMjyyC7a8DnPIsduvg3GxCCbQAuIFcErXj8r4NNEtSjc6w2', 'ARS', 'user-14.jpg', '2022-10-12 21:51:00', '2022-11-01 18:55:00'),
(29, 0, 'Darma Ardhi', 'darma.ardhi', 7, '$2y$10$.BMlGu/dgcKwvZzjsY793OtW3r9ansU0G5p0HHJcv1LrdNw5eQ9IC', 'DAI', 'user-14.jpg', '2022-10-12 21:52:16', '2022-11-01 18:55:00'),
(30, 0, 'Robi Supriadi', 'robi.supriadi', 7, '$2y$10$HGl5P2DVuWDhB.Dyqt9X3O.kpVKq2OtqO5NOZaS3U2DpD/HAPRipW', 'RSI', 'user-14.jpg', '2022-10-12 21:55:20', '2022-11-01 18:55:00'),
(31, 0, 'Beni Setiawan', 'beni.setiawan', 7, '$2y$10$P5pZ6vRWJ/CROb9/OHoQ5e3P42zJtTw7d4IYq4kk9AZDqsPlMFYSy', 'BSN', 'user-14.jpg', '2022-10-12 21:55:56', '2022-11-01 18:55:00'),
(32, 0, 'Ariyanto', 'ariyanto', 7, '$2y$10$r8iT14SwVpkezgB9CZnbZOiBjxTqzUSarDXz8es0sK6PG7ktbLt0a', 'AYO', 'user-14.jpg', '2022-10-12 21:57:28', '2022-11-01 18:55:00'),
(33, 0, 'Syahrul Hidayat', 'syahrul.hidayat', 7, '$2y$10$4LbnNn/bfJzk6FtCp0xFdel7s.n17tP1E1jfRtsFFLKw8xDbj/2Ve', 'SHT', 'user-14.jpg', '2022-10-12 21:58:03', '2022-11-01 18:55:00'),
(34, 0, 'Sudarwanto', 'sudarwanto', 7, '$2y$10$c6X9gVCrhRxrG.kLhXhwC.W97Lj2HOlQwgGm2zmsI42CWXhphwsCa', 'SDW', 'user-14.jpg', '2022-10-12 21:58:36', '2022-11-01 18:55:00'),
(35, 0, 'Amrih Panuntun', 'amrih.panuntun', 7, '$2y$10$sF1wjBVqpYIdj0l.eBcIEO3EtSkndlzA8qr4TfhFHhfTDgxCJr0Nq', 'APN', 'user-14.jpg', '2022-10-12 21:59:13', '2022-11-01 18:55:00'),
(36, 0, 'Muhammad Muslih', 'muhammad.muslih', 7, '$2y$10$qwjDSKGH9XO5upauiCrW4uZCL/fYW5Q7v.uDFcb3Z83DSSlfSjIi2', 'MMH', 'user-14.jpg', '2022-10-12 22:00:01', '2022-11-01 18:55:00'),
(37, 0, 'Heru Haerudin', 'heru.haerudin', 7, '$2y$10$vrMDGn8h1dF4dpUDLCPyhe2JHI64v8FB20R75M6Nx6d.2ikhQq/xm', 'HHN', 'user-14.jpg', '2022-10-12 22:00:41', '2022-11-01 18:55:00'),
(38, 0, 'Agus Turanto', 'agus.turanto', 2, '$2y$10$ftjfPQk4PKxRXVbbPHtFIebOcieIJM/hZzI4tNnX5TaJ/9I6OdxcG', 'ATO', 'user-14.jpg', '2022-10-12 22:02:18', '2022-11-01 18:55:00'),
(39, 0, 'Sungatno', 'sungatno', 2, '$2y$10$O67zeQvml8jXyxiUBsaQK.57BLRdPNVrIpHJSs9u5WveP2jUapA9G', 'SGO', 'user-14.jpg', '2022-10-12 22:02:39', '2022-11-01 18:55:00'),
(40, 0, 'Samidi', 'samidi', 6, '$2y$10$QBRL0frrW9V6kcwaYQgqGeOKwRBYKPqrw01.HQEzv7pirgWs7AWiG', 'SMI', 'user-14.jpg', '2022-10-12 22:03:14', '2022-11-01 18:55:00'),
(41, 0, 'Ridwan', 'ridwan', 15, '$2y$10$S.fNWJgIShxqTrvCK5X2gOgSGmThHbAKLIKwfdHH5MkbGr0GinFJe', 'RDN', 'user-14.jpg', '2022-10-12 22:03:40', '2022-11-01 18:55:00'),
(42, 0, 'Nandang Sutisna', 'nandang.sutisna', 16, '$2y$10$LiI1FQa8EFSkBc89e7k40ONrUEG2fzkpbjF9SUQ6CwkQA6pTXp8dW', 'NSA', 'user-14.jpg', '2022-10-12 22:04:58', '2022-11-01 18:55:00'),
(43, 0, 'Nurhasan', 'nurhasan', 6, '$2y$10$x3yBeZZCa5xQmZLWwAaD..d.2IPG1GLlaaNzjqS4iCzWM6aXA9uMK', 'NHS', 'user-14.jpg', '2022-10-12 22:05:29', '2022-11-01 18:55:00'),
(44, 0, 'Yusup Hamdani', 'yusup.hamdani', 10, '$2y$10$UK10tvpMmE97ZICb6ZxRXeX8SVX7ufz1grF.dP4bKscRlQDcjucxy', 'YHI', 'user-14.jpg', '2022-10-12 22:06:06', '2022-11-01 18:55:00'),
(45, 0, 'Asep Haedar', 'asep.haedar', 8, '$2y$10$e4OhRgAPsVdx/INdl5v8mey7aWPK/5rtBb7mUQ6cBl3lgYEn6i4RC', 'AHR', 'user-14.jpg', '2022-10-12 22:06:47', '2022-11-01 18:55:00'),
(46, 0, 'Jakaria CK', 'jakaria.ck', 8, '$2y$10$ejwYEpYo/yRDYv19hSNh3uBylPiNfq93uDA65BPDDPcZEkJeJpJ0K', 'JCK', 'user-14.jpg', '2022-10-12 22:07:14', '2022-11-01 18:55:00'),
(47, 0, 'Rahmat Nur Hidayat', 'rahmat.hidayat', 8, '$2y$10$iCztO4ntopghsK2RiKtqzue17HZqi.KZKhhHVbakiaU7gPM6ybdRm', 'RNH', 'user-14.jpg', '2022-10-12 22:07:57', '2022-11-01 18:55:00');

-- --------------------------------------------------------

--
-- Table structure for table `mworkingtime`
--

CREATE TABLE `mworkingtime` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `txtshiftname` varchar(32) NOT NULL,
  `tmstart` time NOT NULL,
  `tmfinish` time NOT NULL,
  `intinterval` tinyint(4) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mworkingtime`
--

INSERT INTO `mworkingtime` (`id`, `txtshiftname`, `tmstart`, `tmfinish`, `intinterval`, `created_at`, `updated_at`) VALUES
(1, 'SHIFT 1', '07:00:00', '15:00:00', 0, '2022-11-22 14:21:54', '2022-11-22 14:32:48'),
(2, 'SHIFT 2', '15:00:00', '22:00:00', 0, '2022-11-22 14:22:15', '2022-11-22 14:32:55'),
(3, 'SHIFT 3', '22:00:00', '07:00:00', 1, '2022-11-22 14:23:11', '2022-11-22 14:33:07');

--
-- Triggers `mworkingtime`
--
DELIMITER $$
CREATE TRIGGER `trigger_shift_code` BEFORE INSERT ON `mworkingtime` FOR EACH ROW BEGIN
	set @jumlah = (SELECT id from mworkingtime order by id desc limit 1);
	if(@jumlah) then
		set new.id = @jumlah+1;
	else
		set new.id = 1;
	end if;
    END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `oee`
--

CREATE TABLE `oee` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `line_id` bigint(20) UNSIGNED DEFAULT NULL,
  `shift_id` bigint(20) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `start` time DEFAULT NULL,
  `finish` time DEFAULT NULL,
  `lamakejadian` int(11) DEFAULT '0',
  `activity_id` bigint(20) UNSIGNED DEFAULT NULL,
  `remark` text,
  `operator` varchar(128) DEFAULT NULL,
  `produk_code` varchar(128) DEFAULT NULL,
  `produk` varchar(128) DEFAULT NULL,
  `okp_packing` varchar(128) DEFAULT NULL,
  `production_code` varchar(128) DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `finish_good` int(11) DEFAULT '0',
  `qc_sample` int(11) DEFAULT NULL,
  `category_rework` varchar(64) DEFAULT NULL,
  `rework` int(11) DEFAULT NULL,
  `reject` int(11) DEFAULT '0',
  `reject_pcs` int(11) DEFAULT NULL,
  `category_reject` varchar(64) DEFAULT NULL,
  `waiting_tech` int(11) DEFAULT NULL COMMENT 'Menit',
  `repair_problem` int(11) DEFAULT NULL COMMENT 'Menit',
  `trial_time` int(11) DEFAULT NULL COMMENT 'Menit',
  `tech_name` varchar(128) DEFAULT NULL,
  `bas_com` varchar(32) DEFAULT NULL,
  `category_br` varchar(32) DEFAULT NULL,
  `category_ampm` varchar(16) DEFAULT NULL,
  `jumlah_manpower` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `oee_drier`
--

CREATE TABLE `oee_drier` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `line_id` bigint(20) UNSIGNED DEFAULT NULL,
  `shift_id` bigint(20) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `start` time DEFAULT NULL,
  `finish` time DEFAULT NULL,
  `lamakejadian` int(11) DEFAULT '0',
  `activity_id` bigint(20) UNSIGNED DEFAULT NULL,
  `remark` text,
  `operator` varchar(128) DEFAULT NULL,
  `produk_code` varchar(128) DEFAULT NULL,
  `produk` varchar(128) DEFAULT NULL,
  `okp_drier` varchar(128) DEFAULT NULL,
  `output_bin` int(11) DEFAULT NULL,
  `output_kg` int(11) DEFAULT NULL,
  `rework` int(11) DEFAULT NULL,
  `category_rework` varchar(64) DEFAULT NULL,
  `reject` int(11) DEFAULT NULL,
  `waiting_tech` int(11) DEFAULT NULL COMMENT 'Menit',
  `tech_name` varchar(128) DEFAULT NULL,
  `repair_problem` int(11) DEFAULT NULL COMMENT 'Menit',
  `trial_time` int(11) DEFAULT NULL COMMENT 'Menit',
  `bas_com` varchar(32) DEFAULT NULL,
  `category_br` varchar(32) DEFAULT NULL,
  `category_ampm` varchar(16) DEFAULT NULL,
  `jumlah_manpower` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `oee_drier`
--

INSERT INTO `oee_drier` (`id`, `line_id`, `shift_id`, `tanggal`, `start`, `finish`, `lamakejadian`, `activity_id`, `remark`, `operator`, `produk_code`, `produk`, `okp_drier`, `output_bin`, `output_kg`, `rework`, `category_rework`, `reject`, `waiting_tech`, `tech_name`, `repair_problem`, `trial_time`, `bas_com`, `category_br`, `category_ampm`, `jumlah_manpower`) VALUES
(1, 5, 1, '2022-01-01', '07:00:00', '12:53:00', 353, 3434, 'Lancar', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4007', 18, 12033, 325, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2, 5, 1, '2022-01-01', '12:53:00', '13:03:00', 10, 3629, NULL, 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4007', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(3, 5, 1, '2022-01-01', '13:03:00', '14:22:00', 79, 3625, NULL, 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4007', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(4, 5, 1, '2022-01-01', '14:22:00', '14:30:00', 8, 3642, NULL, 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4008', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(5, 5, 1, '2022-01-01', '14:30:00', '14:34:00', 4, 3641, NULL, 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4008', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(6, 5, 1, '2022-01-01', '14:34:00', '14:44:00', 10, 3630, NULL, 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4008', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(7, 5, 1, '2022-01-01', '14:44:00', '15:00:00', 16, 3434, 'Lancar', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4008', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(8, 5, 2, '2022-01-01', '15:00:00', '23:00:00', 480, 3434, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4008', 19, 13306, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(9, 5, 3, '2022-01-01', '23:00:00', '07:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4008', 21, 14712, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(10, 5, 1, '2022-01-02', '07:00:00', '13:00:00', 360, 3434, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4008', 21, 14583, 430, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(11, 5, 1, '2022-01-02', '13:00:00', '13:10:00', 10, 3629, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4008', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(12, 5, 1, '2022-01-02', '13:10:00', '14:29:00', 79, 3625, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4008', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(13, 5, 1, '2022-01-02', '14:29:00', '14:37:00', 8, 3642, NULL, 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4009', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(14, 5, 1, '2022-01-02', '14:37:00', '14:41:00', 4, 3641, NULL, 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4009', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(15, 5, 1, '2022-01-02', '14:41:00', '14:51:00', 10, 3630, NULL, 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4009', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(16, 5, 1, '2022-01-02', '14:51:00', '15:00:00', 9, 3434, 'Aman Jaya', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4009', 1, 651, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(17, 5, 2, '2022-01-02', '15:00:00', '23:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4009', 19, 12357, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(18, 5, 3, '2022-01-02', '23:00:00', '07:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4009', 25, 16279, 570, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(19, 5, 1, '2022-01-03', '07:00:00', '07:07:00', 7, 3434, NULL, 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4009', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(20, 5, 1, '2022-01-03', '07:07:00', '07:17:00', 10, 3629, NULL, 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4009', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(21, 5, 1, '2022-01-03', '07:17:00', '08:36:00', 79, 3625, NULL, 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4009', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(22, 5, 1, '2022-01-03', '08:36:00', '08:44:00', 8, 3642, NULL, 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4010', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(23, 5, 1, '2022-01-03', '08:44:00', '08:48:00', 4, 3641, NULL, 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4010', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(24, 5, 1, '2022-01-03', '08:48:00', '08:58:00', 10, 3630, NULL, 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4010', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(25, 5, 1, '2022-01-03', '08:58:00', '15:00:00', 362, 3434, NULL, 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4010', 16, 10712, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(26, 5, 2, '2022-01-03', '15:00:00', '23:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4010', 25, 17522, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(27, 5, 3, '2022-01-03', '23:00:00', '04:16:00', 316, 3434, NULL, 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4010', 17, 11936, 540, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(28, 5, 3, '2022-01-03', '04:16:00', '04:26:00', 10, 3629, NULL, 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4010', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(29, 5, 3, '2022-01-03', '04:26:00', '05:45:00', 79, 3625, NULL, 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4010', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(30, 5, 3, '2022-01-03', '05:45:00', '06:15:00', 30, 3624, 'Batching tim WP telat', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4010', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(31, 5, 3, '2022-01-03', '06:15:00', '06:23:00', 8, 3642, NULL, 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(32, 5, 3, '2022-01-03', '06:23:00', '06:27:00', 4, 3641, NULL, 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(33, 5, 3, '2022-01-03', '06:27:00', '06:37:00', 10, 3630, NULL, 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(34, 5, 3, '2022-01-03', '06:37:00', '07:00:00', 23, 3434, NULL, 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(35, 5, 1, '2022-01-04', '07:00:00', '15:00:00', 480, 3434, NULL, 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 22, 15410, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(36, 5, 2, '2022-01-04', '15:00:00', '15:20:00', 20, 3631, NULL, 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(37, 5, 2, '2022-01-04', '15:20:00', '23:00:00', 460, 3627, NULL, 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(38, 5, 3, '2022-01-04', '23:00:00', '07:00:00', 480, 3627, NULL, 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(39, 5, 1, '2022-01-05', '07:00:00', '09:00:00', 120, 3646, 'Drying out awal ahad', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(40, 5, 1, '2022-01-05', '09:00:00', '10:57:00', 117, 3641, NULL, 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(41, 5, 1, '2022-01-05', '10:57:00', '15:00:00', 243, 3434, NULL, 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 9, 6304, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(42, 5, 2, '2022-01-05', '15:00:00', '17:57:00', 177, 3434, NULL, 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 10, 6755, 615, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(43, 5, 2, '2022-01-05', '17:57:00', '18:07:00', 10, 3629, NULL, 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(44, 5, 2, '2022-01-05', '18:07:00', '19:26:00', 79, 3625, NULL, 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4011', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(45, 5, 2, '2022-01-05', '19:26:00', '19:34:00', 8, 3642, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4012', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(46, 5, 2, '2022-01-05', '19:34:00', '19:38:00', 4, 3641, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4012', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(47, 5, 2, '2022-01-05', '19:38:00', '19:48:00', 10, 3630, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4012', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(48, 5, 2, '2022-01-05', '19:48:00', '23:00:00', 192, 3434, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4012', 6, 4203, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(49, 5, 3, '2022-01-05', '23:00:00', '07:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4012', 21, 14743, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(50, 5, 1, '2022-01-06', '07:00:00', '15:00:00', 480, 3434, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4012', 20, 14008, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(51, 5, 2, '2022-01-06', '15:00:00', '19:15:00', 255, 3434, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4012', 14, 9209, 492, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(52, 5, 2, '2022-01-06', '19:15:00', '19:25:00', 10, 3629, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4012', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(53, 5, 2, '2022-01-06', '19:25:00', '20:44:00', 79, 3625, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4012', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(54, 5, 2, '2022-01-06', '20:44:00', '20:52:00', 8, 3642, NULL, 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4013', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(55, 5, 2, '2022-01-06', '20:52:00', '21:08:00', 16, 3641, 'Start up drier lama ada tambahan 12 menit karena nipple sealing piston water HPP pecah/rapuh harus di ganti.sealing tidak ngocor', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4013', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(56, 5, 2, '2022-01-06', '21:08:00', '21:18:00', 10, 3630, NULL, 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4013', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(57, 5, 2, '2022-01-06', '21:18:00', '23:00:00', 102, 3434, NULL, 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4013', 3, 2101, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(58, 5, 3, '2022-01-06', '23:00:00', '07:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4013', 21, 14721, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(59, 5, 1, '2022-01-07', '07:00:00', '15:00:00', 480, 3434, NULL, 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4013', 21, 14707, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(60, 5, 2, '2022-01-07', '15:00:00', '16:58:00', 118, 3434, NULL, 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4013', 7, 4901, 650, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(61, 5, 2, '2022-01-07', '16:58:00', '17:08:00', 10, 3629, NULL, 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4013', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(62, 5, 2, '2022-01-07', '17:08:00', '18:27:00', 79, 3625, NULL, 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4013', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(63, 5, 2, '2022-01-07', '18:27:00', '18:35:00', 8, 3642, NULL, 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4014', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(64, 5, 2, '2022-01-07', '18:35:00', '18:39:00', 4, 3641, NULL, 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4014', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(65, 5, 2, '2022-01-07', '18:39:00', '18:49:00', 10, 3630, NULL, 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4014', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(66, 5, 2, '2022-01-07', '18:49:00', '23:00:00', 251, 3434, NULL, 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4014', 10, 6061, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(67, 5, 3, '2022-01-07', '23:00:00', '07:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4014', 23, 14986, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(68, 5, 1, '2022-01-08', '07:00:00', '10:10:00', 190, 3434, NULL, 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4014', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(69, 5, 1, '2022-01-08', '10:10:00', '10:57:00', 47, 3499, 'problem flowfeed drier', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4014', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(70, 5, 1, '2022-01-08', '10:57:00', '15:00:00', 243, 3434, NULL, 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4014', 19, 12358, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(71, 5, 2, '2022-01-08', '15:00:00', '23:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4014', 22, 14302, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(72, 5, 3, '2022-01-08', '23:00:00', '02:02:00', 182, 3434, NULL, 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4014', 8, 5179, 740, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(73, 5, 3, '2022-01-08', '02:02:00', '02:12:00', 10, 3629, NULL, 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4014', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(74, 5, 3, '2022-01-08', '02:12:00', '03:31:00', 79, 3625, NULL, 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4014', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(75, 5, 3, '2022-01-08', '03:31:00', '03:39:00', 8, 3642, NULL, 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4015', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(76, 5, 3, '2022-01-08', '03:39:00', '03:43:00', 4, 3641, NULL, 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4015', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(77, 5, 3, '2022-01-08', '03:43:00', '03:53:00', 10, 3630, NULL, 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4015', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(78, 5, 3, '2022-01-08', '03:53:00', '07:00:00', 187, 3434, NULL, 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4015', 6, 4210, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(79, 5, 1, '2022-01-09', '07:00:00', '15:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4015', 20, 14005, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(80, 5, 2, '2022-01-09', '15:00:00', '23:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4015', 21, 14727, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(81, 5, 3, '2022-01-09', '23:00:00', '03:35:00', 275, 3434, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4015', 13, 8811, 950, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(82, 5, 3, '2022-01-09', '03:35:00', '03:45:00', 10, 3629, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4015', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(83, 5, 3, '2022-01-09', '03:45:00', '05:04:00', 79, 3625, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4015', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(84, 5, 3, '2022-01-09', '05:04:00', '05:12:00', 8, 3642, NULL, 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4016', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(85, 5, 3, '2022-01-09', '05:12:00', '05:16:00', 4, 3641, NULL, 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4016', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(86, 5, 3, '2022-01-09', '05:16:00', '05:26:00', 10, 3630, NULL, 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4016', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(87, 5, 3, '2022-01-09', '05:26:00', '07:00:00', 94, 3434, NULL, 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4016', 3, 2101, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(88, 5, 1, '2022-01-10', '07:00:00', '08:15:00', 75, 3434, NULL, 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4016', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(89, 5, 1, '2022-01-10', '08:15:00', '10:03:00', 108, 3530, NULL, 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4016', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(90, 5, 1, '2022-01-10', '10:03:00', '15:00:00', 297, 3434, NULL, 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4016', 18, 12113, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(91, 5, 2, '2022-01-10', '15:00:00', '22:02:00', 422, 3434, NULL, 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4016', 22, 15196, 1125, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(92, 5, 2, '2022-01-10', '22:02:00', '22:12:00', 10, 3629, NULL, 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4016', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(93, 5, 2, '2022-01-10', '22:12:00', '23:00:00', 48, 3625, NULL, 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4016', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(94, 5, 3, '2022-01-10', '23:00:00', '23:31:00', 31, 3625, NULL, 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4016', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(95, 5, 3, '2022-01-10', '23:31:00', '23:39:00', 8, 3642, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4017', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(96, 5, 3, '2022-01-10', '23:39:00', '23:43:00', 4, 3641, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4017', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(97, 5, 3, '2022-01-10', '23:43:00', '23:53:00', 10, 3630, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4017', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(98, 5, 3, '2022-01-10', '23:53:00', '07:00:00', 427, 3434, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4017', 17, 11907, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(99, 5, 1, '2022-01-11', '07:00:00', '07:45:00', 45, 3434, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4017', 4, 2367, 330, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(100, 5, 1, '2022-01-11', '07:45:00', '08:05:00', 20, 3631, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4017', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(101, 5, 1, '2022-01-11', '08:05:00', '15:00:00', 415, 3441, 'CIP Chamber lama karena sempat di stop untuk pengecekan krek chamber oleh vendor meco dan Modifikasi agitator mineral tank belum beres dan Modifikasi agitator mineral tank belum beres', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4017', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(102, 5, 2, '2022-01-11', '15:00:00', '23:00:00', 480, 3442, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4017', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(103, 5, 3, '2022-01-11', '23:00:00', '07:00:00', 480, 3441, NULL, 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4017', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(104, 5, 1, '2022-01-12', '07:00:00', '15:00:00', 480, 3441, NULL, 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4017', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(105, 5, 2, '2022-01-12', '15:00:00', '17:00:00', 120, 3646, NULL, 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4018', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(106, 5, 2, '2022-01-12', '17:00:00', '21:20:00', 260, 3652, 'Problem supply ice water dari utility sampai 7.85\'c', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4018', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(107, 5, 2, '2022-01-12', '21:20:00', '23:00:00', 100, 3641, NULL, 'SMI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4018', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(108, 5, 3, '2022-01-12', '23:00:00', '23:21:00', 21, 3641, NULL, 'NSA', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4018', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(109, 5, 3, '2022-01-12', '23:21:00', '23:31:00', 10, 3630, NULL, 'NSA', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4018', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(110, 5, 3, '2022-01-12', '23:31:00', '07:00:00', 449, 3434, NULL, 'NSA', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4018', 22, 11009, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(111, 5, 1, '2022-01-13', '07:00:00', '14:14:00', 434, 3434, NULL, 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4018', 30, 14721, 390, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(112, 5, 1, '2022-01-13', '14:14:00', '14:24:00', 10, 3629, NULL, 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4018', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(113, 5, 1, '2022-01-13', '14:24:00', '15:00:00', 36, 3625, NULL, 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4018', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(114, 5, 2, '2022-01-13', '15:00:00', '15:43:00', 43, 3625, NULL, 'SMI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4018', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(115, 5, 2, '2022-01-13', '15:43:00', '15:47:00', 4, 3641, NULL, 'SMI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4019', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(116, 5, 2, '2022-01-13', '15:47:00', '15:57:00', 10, 3630, NULL, 'SMI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4019', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(117, 5, 2, '2022-01-13', '15:57:00', '23:00:00', 423, 3434, NULL, 'SMI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4019', 23, 11245, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(118, 5, 3, '2022-01-13', '23:00:00', '03:24:00', 264, 3434, NULL, 'NSA', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4019', 18, 8731, 355, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(119, 5, 3, '2022-01-13', '03:24:00', '03:34:00', 10, 3629, NULL, 'NSA', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4019', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(120, 5, 3, '2022-01-13', '03:34:00', '04:53:00', 79, 3625, NULL, 'NSA', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4019', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(121, 5, 3, '2022-01-13', '04:53:00', '05:11:00', 18, 3641, 'Start up drier lama karena ada problem komputer guerin ngehang', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4020', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(122, 5, 3, '2022-01-13', '05:11:00', '05:21:00', 10, 3630, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4020', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(123, 5, 3, '2022-01-13', '05:21:00', '07:00:00', 99, 3434, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4020', 3, 1502, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(124, 5, 1, '2022-01-14', '07:00:00', '15:00:00', 480, 3434, NULL, 'YHI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4020', 28, 14012, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(125, 5, 2, '2022-01-14', '15:00:00', '23:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4020', 29, 14518, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(126, 5, 3, '2022-01-14', '23:00:00', '02:43:00', 223, 3434, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4020', 15, 7507, 250, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(127, 5, 3, '2022-01-14', '02:43:00', '02:53:00', 10, 3629, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4020', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(128, 5, 3, '2022-01-14', '02:53:00', '04:12:00', 79, 3625, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4020', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(129, 5, 3, '2022-01-14', '04:12:00', '04:16:00', 4, 3641, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4021', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(130, 5, 3, '2022-01-14', '04:16:00', '04:26:00', 10, 3630, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4021', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(131, 5, 3, '2022-01-14', '04:26:00', '07:00:00', 154, 3434, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4021', 7, 3503, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(132, 5, 1, '2022-01-15', '07:00:00', '15:00:00', 480, 3434, NULL, 'YHI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4021', 29, 14513, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(133, 5, 2, '2022-01-15', '15:00:00', '23:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4021', 28, 14028, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(134, 5, 3, '2022-01-15', '23:00:00', '02:50:00', 230, 3434, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4021', 12, 6006, 165, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(135, 5, 3, '2022-01-15', '02:50:00', '03:00:00', 10, 3629, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4021', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(136, 5, 3, '2022-01-15', '03:00:00', '04:19:00', 79, 3625, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4021', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(137, 5, 3, '2022-01-15', '04:19:00', '04:23:00', 4, 3641, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4022', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(138, 5, 3, '2022-01-15', '04:23:00', '04:33:00', 10, 3630, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4022', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(139, 5, 3, '2022-01-15', '04:33:00', '07:00:00', 147, 3434, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4022', 9, 4504, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(140, 5, 1, '2022-01-16', '07:00:00', '15:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4022', 30, 15010, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(141, 5, 2, '2022-01-16', '15:00:00', '23:00:00', 480, 3434, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4022', 29, 14504, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(142, 5, 3, '2022-01-16', '23:00:00', '00:43:00', 103, 3434, NULL, 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4022', 7, 3501, 265, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(143, 5, 3, '2022-01-16', '00:43:00', '00:53:00', 10, 3629, NULL, 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4022', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(144, 5, 3, '2022-01-16', '00:53:00', '02:12:00', 79, 3625, NULL, 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4022', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(145, 5, 3, '2022-01-16', '02:12:00', '02:16:00', 4, 3641, NULL, 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4023', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(146, 5, 3, '2022-01-16', '02:16:00', '02:26:00', 10, 3630, NULL, 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4023', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(147, 5, 3, '2022-01-16', '02:26:00', '07:00:00', 274, 3434, NULL, 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4023', 15, 7504, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(148, 5, 1, '2022-01-17', '07:00:00', '15:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4023', 28, 14004, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(149, 5, 2, '2022-01-17', '15:00:00', '23:00:00', 480, 3434, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4023', 30, 14998, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(150, 5, 3, '2022-01-17', '23:00:00', '23:32:00', 32, 3434, NULL, 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4023', 3, 1502, 220, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(151, 5, 3, '2022-01-17', '23:32:00', '23:42:00', 10, 3629, NULL, 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4023', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(152, 5, 3, '2022-01-17', '23:42:00', '01:01:00', 79, 3625, NULL, 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4023', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(153, 5, 3, '2022-01-17', '01:01:00', '07:00:00', 359, 3659, NULL, 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4024', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(154, 5, 1, '2022-01-18', '07:00:00', '12:00:00', 300, 3659, NULL, 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-TR 111', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(155, 5, 1, '2022-01-18', '12:00:00', '15:00:00', 180, 3437, NULL, 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-TR 111', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(156, 5, 2, '2022-01-18', '15:00:00', '19:02:00', 242, 3437, NULL, 'NSA', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-TR 111', 5, 2427, 450, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(157, 5, 2, '2022-01-18', '19:02:00', '19:06:00', 4, 3641, NULL, 'NSA', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4024', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(158, 5, 2, '2022-01-18', '19:06:00', '19:16:00', 10, 3630, NULL, 'NSA', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4024', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(159, 5, 2, '2022-01-18', '19:16:00', '23:00:00', 224, 3434, NULL, 'NSA', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4024', 10, 5005, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(160, 5, 3, '2022-01-18', '23:00:00', '07:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4024', 30, 14999, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(161, 5, 1, '2022-01-19', '07:00:00', '09:52:00', 172, 3434, NULL, 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4024', 12, 5861, 380, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(162, 5, 1, '2022-01-19', '09:52:00', '10:02:00', 10, 3629, NULL, 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4024', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(163, 5, 1, '2022-01-19', '10:02:00', '11:21:00', 79, 3625, NULL, 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4024', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(164, 5, 1, '2022-01-19', '11:21:00', '15:00:00', 219, 3659, NULL, 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4024', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(165, 5, 2, '2022-01-19', '15:00:00', '23:00:00', 480, 3659, NULL, 'NSA', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4024', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(166, 5, 3, '2022-01-19', '23:00:00', '03:24:00', 264, 3659, NULL, 'NSA', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4024', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(167, 5, 3, '2022-01-19', '03:24:00', '07:00:00', 216, 3434, NULL, 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4025', 9, 4504, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(168, 5, 1, '2022-01-20', '07:00:00', '15:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4025', 30, 15027, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(169, 5, 2, '2022-01-20', '15:00:00', '18:18:00', 198, 3434, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4025', 14, 6524, 365, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(170, 5, 2, '2022-01-20', '18:18:00', '18:28:00', 10, 3629, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4025', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(171, 5, 2, '2022-01-20', '18:28:00', '19:47:00', 79, 3625, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4025', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(172, 5, 2, '2022-01-20', '19:47:00', '19:51:00', 4, 3641, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4026', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(173, 5, 2, '2022-01-20', '19:51:00', '20:01:00', 10, 3630, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4026', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(174, 5, 2, '2022-01-20', '20:01:00', '23:00:00', 179, 3434, NULL, 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4026', 8, 4003, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(175, 5, 3, '2022-01-20', '23:00:00', '07:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4026', 29, 14508, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(176, 5, 1, '2022-01-21', '07:00:00', '15:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4026', 31, 15243, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(177, 5, 2, '2022-01-21', '15:00:00', '17:00:00', 120, 3434, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4026', 9, 4503, 225, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(178, 5, 2, '2022-01-21', '17:00:00', '17:10:00', 10, 3629, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4026', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(179, 5, 2, '2022-01-21', '17:10:00', '18:29:00', 79, 3625, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4026', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(180, 5, 2, '2022-01-21', '18:29:00', '19:09:00', 40, 3641, 'startup lama meununggu bin bersih', 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4027', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(181, 5, 2, '2022-01-21', '19:09:00', '19:19:00', 10, 3630, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4027', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(182, 5, 2, '2022-01-21', '19:19:00', '23:00:00', 221, 3434, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4027', 9, 4503, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(183, 5, 3, '2022-01-21', '23:00:00', '02:00:00', 180, 3434, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4027', 14, 6973, 145, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(184, 5, 3, '2022-01-21', '02:00:00', '02:20:00', 20, 3631, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4027', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(185, 5, 3, '2022-01-21', '02:20:00', '07:00:00', 280, 3441, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4027', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(186, 5, 1, '2022-01-22', '07:00:00', '15:00:00', 480, 3441, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4027', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(187, 5, 2, '2022-01-22', '15:00:00', '23:00:00', 480, 3435, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4027', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(188, 5, 3, '2022-01-22', '23:00:00', '07:00:00', 480, 3435, NULL, 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4027', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(189, 5, 1, '2022-01-23', '07:00:00', '09:00:00', 120, 3646, 'drying out awal ahad', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4028', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(190, 5, 1, '2022-01-23', '09:00:00', '11:21:00', 141, 3641, 'startup lama karena dumping robot lama', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4028', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(191, 5, 1, '2022-01-23', '11:21:00', '11:31:00', 10, 3630, NULL, 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4028', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(192, 5, 1, '2022-01-23', '11:31:00', '15:00:00', 209, 3434, NULL, 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4028', 10, 6056, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(193, 5, 2, '2022-01-23', '15:00:00', '23:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4028', 27, 17565, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(194, 5, 3, '2022-01-23', '23:00:00', '07:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4028', 29, 18869, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(195, 5, 1, '2022-01-24', '07:00:00', '08:30:00', 90, 3434, NULL, 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4028', 6, 3902, 300, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(196, 5, 1, '2022-01-24', '08:30:00', '08:40:00', 10, 3629, NULL, 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4028', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(197, 5, 1, '2022-01-24', '08:40:00', '09:59:00', 79, 3625, NULL, 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4028', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(198, 5, 1, '2022-01-24', '09:59:00', '11:13:00', 74, 3624, 'CIP wet proses keteter', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4028', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(199, 5, 1, '2022-01-24', '11:13:00', '11:44:00', 31, 3437, 'Trial feed pump baru', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4029', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(200, 5, 1, '2022-01-24', '11:44:00', '11:52:00', 8, 3642, NULL, 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4029', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(201, 5, 1, '2022-01-24', '11:52:00', '11:56:00', 4, 3641, NULL, 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4029', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(202, 5, 1, '2022-01-24', '11:56:00', '12:06:00', 10, 3630, NULL, 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4029', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(203, 5, 1, '2022-01-24', '12:06:00', '15:00:00', 174, 3434, NULL, 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4029', 6, 4203, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(204, 5, 2, '2022-01-24', '15:00:00', '23:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4029', 24, 16309, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(205, 5, 3, '2022-01-24', '23:00:00', '23:44:00', 44, 3434, NULL, 'SMI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4029', 4, 2672, 320, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(206, 5, 3, '2022-01-24', '23:44:00', '23:54:00', 10, 3629, NULL, 'SMI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4029', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(207, 5, 3, '2022-01-24', '23:54:00', '01:16:00', 82, 3625, NULL, 'SMI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4029', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(208, 5, 3, '2022-01-24', '01:16:00', '01:24:00', 8, 3642, NULL, 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4030', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(209, 5, 3, '2022-01-24', '01:24:00', '01:28:00', 4, 3641, NULL, 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4030', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(210, 5, 3, '2022-01-24', '01:28:00', '01:38:00', 10, 3630, NULL, 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4030', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(211, 5, 3, '2022-01-24', '01:38:00', '07:00:00', 322, 3434, NULL, 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4030', 16, 10429, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(212, 5, 1, '2022-01-25', '07:00:00', '08:20:00', 80, 3434, NULL, 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4030', 7, 4320, 300, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(213, 5, 1, '2022-01-25', '08:20:00', '08:40:00', 20, 3631, NULL, 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4030', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(214, 5, 1, '2022-01-25', '08:40:00', '15:00:00', 380, 3441, NULL, 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4030', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(215, 5, 2, '2022-01-25', '15:00:00', '23:00:00', 480, 3441, NULL, 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4030', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(216, 5, 3, '2022-01-25', '23:00:00', '00:00:00', 60, 3442, NULL, 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4030', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(217, 5, 3, '2022-01-25', '00:00:00', '06:00:00', 360, 3442, NULL, 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4030', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(218, 5, 3, '2022-01-25', '06:00:00', '07:00:00', 60, 3646, 'Drying out ke powder tank', 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4031', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(219, 5, 1, '2022-01-26', '07:00:00', '09:00:00', 120, 3646, 'Drying out awal ahad', 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4031', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(220, 5, 1, '2022-01-26', '09:00:00', '10:00:00', 60, 3641, NULL, 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4031', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(221, 5, 1, '2022-01-26', '10:00:00', '10:10:00', 10, 3630, NULL, 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4031', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(222, 5, 1, '2022-01-26', '10:10:00', '15:00:00', 290, 3434, NULL, 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4031', 3, 1801, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(223, 5, 2, '2022-01-26', '15:00:00', '23:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4031', 22, 13210, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(224, 5, 3, '2022-01-26', '23:00:00', '07:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4031', 24, 14432, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(225, 5, 1, '2022-01-27', '07:00:00', '07:34:00', 34, 3434, NULL, 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4031', 3, 1803, 290, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(226, 5, 1, '2022-01-27', '07:34:00', '07:44:00', 10, 3629, NULL, 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4031', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(227, 5, 1, '2022-01-27', '07:44:00', '09:03:00', 79, 3625, NULL, 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4031', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(228, 5, 1, '2022-01-27', '09:03:00', '09:07:00', 4, 3641, NULL, 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4032', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(229, 5, 1, '2022-01-27', '09:07:00', '09:17:00', 10, 3630, NULL, 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4032', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(230, 5, 1, '2022-01-27', '09:17:00', '15:00:00', 343, 3434, NULL, 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4032', 15, 9007, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(231, 5, 2, '2022-01-27', '15:00:00', '23:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4032', 24, 14408, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(232, 5, 3, '2022-01-27', '23:00:00', '23:32:00', 32, 3434, NULL, 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4032', 4, 2142, 262, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(233, 5, 3, '2022-01-27', '23:32:00', '23:42:00', 10, 3629, NULL, 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4032', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(234, 5, 3, '2022-01-27', '23:42:00', '01:01:00', 79, 3625, NULL, 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4032', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(235, 5, 3, '2022-01-27', '01:01:00', '01:05:00', 4, 3641, NULL, 'SMI', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4033', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(236, 5, 3, '2022-01-27', '01:05:00', '01:15:00', 10, 3630, NULL, 'SMI', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4033', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(237, 5, 3, '2022-01-27', '01:15:00', '07:00:00', 345, 3434, NULL, 'SMI', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4033', 16, 9226, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(238, 5, 1, '2022-01-28', '07:00:00', '15:00:00', 480, 3434, NULL, 'NSA', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4033', 24, 14410, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(239, 5, 2, '2022-01-28', '15:00:00', '15:36:00', 36, 3434, NULL, 'NHS', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4033', 3, 1800, 240, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `oee_drier` (`id`, `line_id`, `shift_id`, `tanggal`, `start`, `finish`, `lamakejadian`, `activity_id`, `remark`, `operator`, `produk_code`, `produk`, `okp_drier`, `output_bin`, `output_kg`, `rework`, `category_rework`, `reject`, `waiting_tech`, `tech_name`, `repair_problem`, `trial_time`, `bas_com`, `category_br`, `category_ampm`, `jumlah_manpower`) VALUES
(240, 5, 2, '2022-01-28', '15:36:00', '15:46:00', 10, 3629, NULL, 'NHS', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4033', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(241, 5, 2, '2022-01-28', '15:46:00', '17:05:00', 79, 3625, NULL, 'NHS', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4033', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(242, 5, 2, '2022-01-28', '17:05:00', '17:09:00', 4, 3641, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-TR-112', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(243, 5, 2, '2022-01-28', '17:09:00', '17:19:00', 10, 3630, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-TR-112', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(244, 5, 2, '2022-01-28', '17:19:00', '18:57:00', 98, 3434, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-TR-112', 4, 2401, 195, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(245, 5, 2, '2022-01-28', '18:57:00', '19:07:00', 10, 3629, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-TR-112', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(246, 5, 2, '2022-01-28', '19:07:00', '19:44:00', 37, 3625, 'Cip hot rinse dan chlorine', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-TR-112', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(247, 5, 2, '2022-01-28', '19:44:00', '19:48:00', 4, 3641, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4034', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(248, 5, 2, '2022-01-28', '19:48:00', '19:58:00', 10, 3630, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4034', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(249, 5, 2, '2022-01-28', '19:58:00', '23:00:00', 182, 3434, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4034', 7, 4204, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(250, 5, 3, '2022-01-28', '23:00:00', '04:26:00', 326, 3434, NULL, 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4034', 16, 9631, 385, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(251, 5, 3, '2022-01-28', '04:26:00', '04:36:00', 10, 3629, NULL, 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4034', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(252, 5, 3, '2022-01-28', '04:36:00', '05:55:00', 79, 3625, NULL, 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4034', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(253, 5, 3, '2022-01-28', '05:55:00', '05:59:00', 4, 3641, NULL, 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4035', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(254, 5, 3, '2022-01-28', '05:59:00', '06:09:00', 10, 3630, NULL, 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4035', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(255, 5, 3, '2022-01-28', '06:09:00', '07:00:00', 51, 3434, NULL, 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4035', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(256, 5, 1, '2022-01-29', '07:00:00', '14:47:00', 467, 3434, NULL, 'NSA', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4035', 20, 12010, 370, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(257, 5, 1, '2022-01-29', '14:47:00', '14:57:00', 10, 3434, NULL, 'NSA', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4035', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(258, 5, 1, '2022-01-29', '14:57:00', '15:00:00', 3, 3625, NULL, 'NSA', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4035', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(259, 5, 2, '2022-01-29', '15:00:00', '16:16:00', 76, 3625, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4035', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(260, 5, 2, '2022-01-29', '16:16:00', '16:22:00', 6, 3641, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4036', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(261, 5, 2, '2022-01-29', '16:22:00', '16:32:00', 10, 3630, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4036', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(262, 5, 2, '2022-01-29', '16:32:00', '21:40:00', 308, 3434, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4036', 17, 10050, 302, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(263, 5, 2, '2022-01-29', '21:40:00', '22:00:00', 20, 3631, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4036', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(264, 5, 2, '2022-01-29', '22:00:00', '23:00:00', 60, 3441, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4036', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(265, 5, 3, '2022-01-29', '23:00:00', '07:00:00', 480, 3441, NULL, 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4036', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(266, 5, 1, '2022-01-30', '07:00:00', '15:00:00', 480, 3441, NULL, 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4036', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(267, 5, 2, '2022-01-30', '15:00:00', '17:00:00', 120, 3646, NULL, 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4037', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(268, 5, 2, '2022-01-30', '17:00:00', '20:03:00', 183, 3641, 'Startup lama karena menunggu perbaikan flowmeter mineraltank', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4037', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(269, 5, 2, '2022-01-30', '20:03:00', '20:13:00', 10, 3630, NULL, 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4037', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(270, 5, 2, '2022-01-30', '20:13:00', '23:00:00', 167, 3434, NULL, 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4037', 6, 3906, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(271, 5, 3, '2022-01-30', '23:00:00', '07:00:00', 480, 3434, NULL, 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4037', 25, 15820, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(272, 5, 1, '2022-01-31', '07:00:00', '15:00:00', 480, 3434, NULL, 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4037', 21, 13665, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(273, 5, 2, '2022-01-31', '15:00:00', '23:00:00', 480, 3434, NULL, 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4037', 25, 16290, 650, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(274, 5, 3, '2022-01-31', '23:00:00', '00:12:00', 72, 3434, NULL, 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4037', 5, 2979, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(275, 5, 3, '2022-01-31', '00:12:00', '00:22:00', 10, 3629, NULL, 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4037', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(276, 5, 3, '2022-01-31', '00:22:00', '01:41:00', 79, 3625, NULL, 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4037', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(277, 5, 3, '2022-01-31', '01:41:00', '01:49:00', 8, 3642, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4038', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(278, 5, 3, '2022-01-31', '01:49:00', '01:53:00', 4, 3641, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4038', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(279, 5, 3, '2022-01-31', '01:53:00', '02:03:00', 10, 3630, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4038', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(280, 5, 3, '2022-01-31', '02:03:00', '07:00:00', 297, 3434, NULL, 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4038', 11, 7707, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(281, 5, 1, '2022-02-01', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4038', 21, 14709, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(282, 5, 2, '2022-02-01', '15:00:00', '19:00:00', 240, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4038', 12, 7926, 830, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(283, 5, 2, '2022-02-01', '19:00:00', '19:10:00', 10, 3629, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4038', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(284, 5, 2, '2022-02-01', '19:10:00', '20:29:00', 79, 3625, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4038', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(285, 5, 2, '2022-02-01', '20:29:00', '20:37:00', 8, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4039', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(286, 5, 2, '2022-02-01', '20:37:00', '20:41:00', 4, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4039', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(287, 5, 2, '2022-02-01', '20:41:00', '20:51:00', 10, 3630, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4039', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(288, 5, 2, '2022-02-01', '20:51:00', '23:00:00', 129, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4039', 4, 2605, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(289, 5, 3, '2022-02-01', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4039', 24, 15615, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(290, 5, 1, '2022-02-02', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4039', 25, 16256, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(291, 5, 2, '2022-02-02', '15:00:00', '21:02:00', 362, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4039', 19, 12387, 510, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(292, 5, 2, '2022-02-02', '21:02:00', '21:12:00', 10, 3629, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4039', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(293, 5, 2, '2022-02-02', '21:12:00', '22:31:00', 79, 3625, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4039', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(294, 5, 2, '2022-02-02', '22:31:00', '22:39:00', 8, 3642, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(295, 5, 2, '2022-02-02', '22:39:00', '22:43:00', 4, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(296, 5, 2, '2022-02-02', '22:43:00', '22:53:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(297, 5, 2, '2022-02-02', '22:53:00', '23:00:00', 7, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(298, 5, 3, '2022-02-02', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 22, 14315, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(299, 5, 1, '2022-02-03', '07:00:00', '15:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 24, 15604, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(300, 5, 2, '2022-02-03', '15:00:00', '15:41:00', 41, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 3, 1950, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(301, 5, 2, '2022-02-03', '15:41:00', '16:01:00', 20, 3631, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(302, 5, 2, '2022-02-03', '16:01:00', '23:00:00', 419, 3627, 'Bloking cyclone 530', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(303, 5, 3, '2022-02-03', '23:00:00', '07:00:00', 480, 3627, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(304, 5, 1, '2022-02-04', '07:00:00', '11:00:00', 240, 3627, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(305, 5, 1, '2022-02-04', '11:00:00', '12:30:00', 90, 3646, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(306, 5, 1, '2022-02-04', '12:30:00', '13:29:00', 59, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(307, 5, 1, '2022-02-04', '13:29:00', '13:33:00', 4, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(308, 5, 1, '2022-02-04', '13:33:00', '13:43:00', 10, 3630, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(309, 5, 1, '2022-02-04', '13:43:00', '15:00:00', 77, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 2, 1301, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(310, 5, 2, '2022-02-04', '15:00:00', '21:19:00', 379, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 20, 13003, 428, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(311, 5, 2, '2022-02-04', '21:19:00', '21:29:00', 10, 3629, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(312, 5, 2, '2022-02-04', '21:29:00', '22:48:00', 79, 3625, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4040', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(313, 5, 2, '2022-02-04', '22:48:00', '22:56:00', 8, 3642, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4041', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(314, 5, 2, '2022-02-04', '22:56:00', '23:00:00', 4, 3641, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4041', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(315, 5, 3, '2022-02-04', '23:00:00', '23:10:00', 10, 3630, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4041', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(316, 5, 3, '2022-02-04', '23:10:00', '07:00:00', 470, 3434, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4041', 18, 12608, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(317, 5, 1, '2022-02-05', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4041', 22, 15406, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(318, 5, 2, '2022-02-05', '15:00:00', '16:52:00', 112, 3434, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4041', 7, 4356, 790, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(319, 5, 2, '2022-02-05', '16:52:00', '17:02:00', 10, 3629, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4041', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(320, 5, 2, '2022-02-05', '17:02:00', '18:21:00', 79, 3625, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4041', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(321, 5, 2, '2022-02-05', '18:21:00', '18:29:00', 8, 3642, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4042', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(322, 5, 2, '2022-02-05', '18:29:00', '18:33:00', 4, 3641, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4042', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(323, 5, 2, '2022-02-05', '18:33:00', '18:43:00', 10, 3630, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4042', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(324, 5, 2, '2022-02-05', '18:43:00', '23:00:00', 257, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4042', 11, 7161, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(325, 5, 3, '2022-02-05', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4042', 25, 16265, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(326, 5, 1, '2022-02-06', '07:00:00', '15:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4042', 26, 16931, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(327, 5, 2, '2022-02-06', '15:00:00', '16:25:00', 85, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4042', 5, 3252, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(328, 5, 2, '2022-02-06', '16:25:00', '23:00:00', 395, 3512, 'Cyclone 530 bloking', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4042', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(329, 5, 3, '2022-02-06', '23:00:00', '23:55:00', 55, 3512, 'Cyclone 530 bloking', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4042', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(330, 5, 3, '2022-02-06', '23:55:00', '01:10:00', 75, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4042', 4, 2601, 480, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(331, 5, 3, '2022-02-06', '01:10:00', '01:20:00', 10, 3629, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4042', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(332, 5, 3, '2022-02-06', '01:20:00', '02:39:00', 79, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4042', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(333, 5, 3, '2022-02-06', '02:39:00', '02:47:00', 8, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(334, 5, 3, '2022-02-06', '02:47:00', '02:51:00', 4, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(335, 5, 3, '2022-02-06', '02:51:00', '03:01:00', 10, 3630, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(336, 5, 3, '2022-02-06', '03:01:00', '07:00:00', 239, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 16, 10407, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(337, 5, 1, '2022-02-07', '07:00:00', '15:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 26, 16959, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(338, 5, 2, '2022-02-07', '15:00:00', '15:50:00', 50, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 4, 2462, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(339, 5, 2, '2022-02-07', '15:50:00', '20:00:00', 250, 3512, 'Cyclone 530 bloking', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(340, 5, 2, '2022-02-07', '20:00:00', '23:00:00', 180, 3627, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(341, 5, 3, '2022-02-07', '23:00:00', '07:00:00', 480, 3627, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(342, 5, 1, '2022-02-08', '07:00:00', '15:00:00', 480, 3627, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(343, 5, 2, '2022-02-08', '15:00:00', '17:00:00', 120, 3627, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(344, 5, 2, '2022-02-08', '17:00:00', '18:30:00', 90, 3646, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(345, 5, 2, '2022-02-08', '18:30:00', '19:34:00', 64, 3642, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(346, 5, 2, '2022-02-08', '19:34:00', '19:38:00', 4, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(347, 5, 2, '2022-02-08', '19:38:00', '19:48:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(348, 5, 2, '2022-02-08', '19:48:00', '23:00:00', 192, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 8, 5201, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(349, 5, 3, '2022-02-08', '23:00:00', '04:22:00', 322, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 17, 11057, 533, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(350, 5, 3, '2022-02-08', '04:22:00', '04:32:00', 10, 3629, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(351, 5, 3, '2022-02-08', '04:32:00', '05:51:00', 79, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4043', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(352, 5, 3, '2022-02-08', '05:51:00', '05:59:00', 8, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4044', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(353, 5, 3, '2022-02-08', '05:59:00', '06:03:00', 4, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4044', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(354, 5, 3, '2022-02-08', '06:03:00', '06:13:00', 10, 3630, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4044', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(355, 5, 3, '2022-02-08', '06:13:00', '07:00:00', 47, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4044', 1, 650, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(356, 5, 1, '2022-02-09', '07:00:00', '15:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4044', 25, 15831, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(357, 5, 2, '2022-02-09', '15:00:00', '16:30:00', 90, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4044', 6, 3782, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(358, 5, 2, '2022-02-09', '16:30:00', '21:51:00', 321, 3509, 'Drier emergency stop', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4044', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(359, 5, 2, '2022-02-09', '21:51:00', '23:00:00', 69, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4044', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(360, 5, 3, '2022-02-09', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4044', 25, 16265, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(361, 5, 1, '2022-02-10', '07:00:00', '11:13:00', 253, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4044', 15, 9777, 1080, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(362, 5, 1, '2022-02-10', '11:13:00', '11:23:00', 10, 3629, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4044', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(363, 5, 1, '2022-02-10', '11:23:00', '12:42:00', 79, 3625, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4044', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(364, 5, 1, '2022-02-10', '12:42:00', '12:50:00', 8, 3642, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4045', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(365, 5, 1, '2022-02-10', '12:50:00', '12:54:00', 4, 3641, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4045', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(366, 5, 1, '2022-02-10', '12:54:00', '13:04:00', 10, 3630, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4045', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(367, 5, 1, '2022-02-10', '13:04:00', '15:00:00', 116, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4045', 3, 2105, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(368, 5, 2, '2022-02-10', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4045', 21, 14121, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(369, 5, 3, '2022-02-10', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4045', 21, 14729, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(370, 5, 1, '2022-02-11', '07:00:00', '13:10:00', 370, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4045', 17, 11663, 560, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(371, 5, 1, '2022-02-11', '13:10:00', '13:20:00', 10, 3629, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4045', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(372, 5, 1, '2022-02-11', '13:20:00', '14:39:00', 79, 3625, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4045', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(373, 5, 1, '2022-02-11', '14:39:00', '14:47:00', 8, 3642, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4045', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(374, 5, 1, '2022-02-11', '14:47:00', '14:51:00', 4, 3641, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4046', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(375, 5, 1, '2022-02-11', '14:51:00', '15:00:00', 9, 3630, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4046', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(376, 5, 2, '2022-02-11', '15:00:00', '15:01:00', 1, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4046', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(377, 5, 2, '2022-02-11', '15:01:00', '23:00:00', 479, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4046', 23, 14066, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(378, 5, 3, '2022-02-11', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4046', 26, 16910, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(379, 5, 1, '2022-02-12', '07:00:00', '12:12:00', 312, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4046', 18, 11296, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(380, 5, 1, '2022-02-12', '12:12:00', '15:00:00', 168, 3512, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4046', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(381, 5, 2, '2022-02-12', '15:00:00', '16:34:00', 94, 3512, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4046', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(382, 5, 2, '2022-02-12', '16:34:00', '19:16:00', 162, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4046', 8, 4748, 790, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(383, 5, 2, '2022-02-12', '19:16:00', '19:26:00', 10, 3629, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4046', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(384, 5, 2, '2022-02-12', '19:26:00', '20:45:00', 79, 3625, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4046', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(385, 5, 2, '2022-02-12', '20:45:00', '20:53:00', 8, 3642, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4047', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(386, 5, 2, '2022-02-12', '20:53:00', '20:57:00', 4, 3641, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4047', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(387, 5, 2, '2022-02-12', '20:57:00', '21:07:00', 10, 3630, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4047', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(388, 5, 2, '2022-02-12', '21:07:00', '23:00:00', 113, 3434, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4047', 4, 2802, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(389, 5, 3, '2022-02-12', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4047', 24, 16804, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(390, 5, 1, '2022-02-13', '07:00:00', '07:12:00', 12, 3434, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4047', 2, 1113, 330, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(391, 5, 1, '2022-02-13', '07:12:00', '07:22:00', 10, 3629, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4047', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(392, 5, 1, '2022-02-13', '07:22:00', '08:41:00', 79, 3625, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4047', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(393, 5, 1, '2022-02-13', '08:41:00', '08:49:00', 8, 3642, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(394, 5, 1, '2022-02-13', '08:49:00', '08:53:00', 4, 3641, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(395, 5, 1, '2022-02-13', '08:53:00', '09:03:00', 10, 3630, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(396, 5, 1, '2022-02-13', '09:03:00', '15:00:00', 357, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 15, 10511, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(397, 5, 2, '2022-02-13', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 23, 16101, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(398, 5, 3, '2022-02-13', '23:00:00', '05:33:00', 393, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 23, 15749, 300, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(399, 5, 3, '2022-02-13', '05:33:00', '05:53:00', 20, 3631, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(400, 5, 3, '2022-02-13', '05:53:00', '07:00:00', 67, 3441, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(401, 5, 1, '2022-02-14', '07:00:00', '15:00:00', 480, 3441, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(402, 5, 2, '2022-02-14', '15:00:00', '20:00:00', 300, 3441, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(403, 5, 2, '2022-02-14', '20:00:00', '23:00:00', 180, 3435, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(404, 5, 3, '2022-02-14', '23:00:00', '07:00:00', 480, 3435, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(405, 5, 1, '2022-02-15', '07:00:00', '15:00:00', 480, 3435, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(406, 5, 2, '2022-02-15', '15:00:00', '23:00:00', 480, 3435, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4048', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(407, 5, 3, '2022-02-15', '23:00:00', '02:07:00', 187, 3642, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4049', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(408, 5, 3, '2022-02-15', '02:07:00', '02:11:00', 4, 3641, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4049', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(409, 5, 3, '2022-02-15', '02:11:00', '02:21:00', 10, 3630, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4049', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(410, 5, 3, '2022-02-15', '02:21:00', '07:00:00', 279, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4049', 12, 7829, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(411, 5, 1, '2022-02-16', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4049', 25, 16266, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(412, 5, 2, '2022-02-16', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4049', 26, 16920, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(413, 5, 3, '2022-02-16', '23:00:00', '01:36:00', 156, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4049', 10, 6148, 440, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(414, 5, 3, '2022-02-16', '01:36:00', '01:46:00', 10, 3629, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4049', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(415, 5, 3, '2022-02-16', '01:46:00', '03:05:00', 79, 3625, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4049', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(416, 5, 3, '2022-02-16', '03:05:00', '03:13:00', 8, 3642, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4050', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(417, 5, 3, '2022-02-16', '03:13:00', '03:17:00', 4, 3641, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4050', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(418, 5, 3, '2022-02-16', '03:17:00', '03:27:00', 10, 3630, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4050', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(419, 5, 3, '2022-02-16', '03:27:00', '07:00:00', 213, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4050', 7, 4915, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(420, 5, 1, '2022-02-17', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4050', 20, 14011, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(421, 5, 2, '2022-02-17', '15:00:00', '23:00:00', 480, 3434, '', 'NSA/SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4050', 22, 15413, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(422, 5, 3, '2022-02-17', '23:00:00', '02:58:00', 238, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4050', 11, 7721, 700, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(423, 5, 3, '2022-02-17', '02:58:00', '03:08:00', 10, 3629, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4050', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(424, 5, 3, '2022-02-17', '03:08:00', '04:27:00', 79, 3625, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4050', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(425, 5, 3, '2022-02-17', '04:27:00', '04:35:00', 8, 3642, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(426, 5, 3, '2022-02-17', '04:35:00', '04:39:00', 4, 3641, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(427, 5, 3, '2022-02-17', '04:39:00', '04:49:00', 10, 3630, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(428, 5, 3, '2022-02-17', '04:49:00', '07:00:00', 131, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 4, 2808, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(429, 5, 1, '2022-02-18', '07:00:00', '08:30:00', 90, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 5, 3503, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(430, 5, 1, '2022-02-18', '08:30:00', '15:00:00', 390, 3509, 'Drier emergency stop', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(431, 5, 2, '2022-02-18', '15:00:00', '22:41:00', 461, 3509, 'Drier emergency stop', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(432, 5, 2, '2022-02-18', '22:41:00', '23:00:00', 19, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(433, 5, 3, '2022-02-18', '23:00:00', '23:28:00', 28, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(434, 5, 3, '2022-02-18', '23:28:00', '03:19:00', 231, 3509, 'Drier emergency stop', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(435, 5, 3, '2022-02-18', '03:19:00', '07:00:00', 221, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 9, 6313, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(436, 5, 1, '2022-02-19', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 24, 16814, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(437, 5, 2, '2022-02-19', '15:00:00', '19:15:00', 255, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 15, 9978, 1485, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(438, 5, 2, '2022-02-19', '19:15:00', '19:25:00', 10, 3629, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(439, 5, 2, '2022-02-19', '19:25:00', '20:44:00', 79, 3625, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4051', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(440, 5, 2, '2022-02-19', '20:44:00', '20:52:00', 8, 3642, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(441, 5, 2, '2022-02-19', '20:52:00', '20:56:00', 4, 3641, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(442, 5, 2, '2022-02-19', '20:56:00', '21:06:00', 10, 3630, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(443, 5, 2, '2022-02-19', '21:06:00', '23:00:00', 114, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 3, 2102, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(444, 5, 3, '2022-02-19', '23:00:00', '02:15:00', 195, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 9, 6317, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(445, 5, 3, '2022-02-19', '02:15:00', '07:00:00', 285, 3509, 'Drier emergency stop', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(446, 5, 1, '2022-02-20', '07:00:00', '12:18:00', 318, 3509, 'Drier emergency stop', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(447, 5, 1, '2022-02-20', '12:18:00', '15:00:00', 162, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 5, 3502, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(448, 5, 2, '2022-02-20', '15:00:00', '23:00:00', 480, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 21, 14725, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(449, 5, 3, '2022-02-20', '23:00:00', '06:13:00', 433, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 21, 14159, 565, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(450, 5, 3, '2022-02-20', '06:13:00', '06:23:00', 10, 3629, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(451, 5, 3, '2022-02-20', '06:23:00', '07:00:00', 37, 3625, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(452, 5, 1, '2022-02-21', '07:00:00', '07:42:00', 42, 3625, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4052', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(453, 5, 1, '2022-02-21', '07:42:00', '07:50:00', 8, 3642, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(454, 5, 1, '2022-02-21', '07:50:00', '07:54:00', 4, 3641, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(455, 5, 1, '2022-02-21', '07:54:00', '08:04:00', 10, 3630, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(456, 5, 1, '2022-02-21', '08:04:00', '15:00:00', 416, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 22, 14313, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(457, 5, 2, '2022-02-21', '15:00:00', '16:46:00', 106, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 10, 6504, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(458, 5, 2, '2022-02-21', '16:46:00', '21:43:00', 297, 3658, 'Problem material tertinggal(alfa lactabummin)', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(459, 5, 2, '2022-02-21', '21:43:00', '23:00:00', 77, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(460, 5, 3, '2022-02-21', '23:00:00', '01:34:00', 154, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(461, 5, 3, '2022-02-21', '01:34:00', '02:32:00', 58, 3624, 'Bt 01 habis karena menunggu cip mineral tank', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(462, 5, 3, '2022-02-21', '02:32:00', '07:00:00', 268, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 22, 14196, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(463, 5, 1, '2022-02-22', '07:00:00', '13:30:00', 390, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 25, 15913, 300, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(464, 5, 1, '2022-02-22', '13:30:00', '13:40:00', 10, 3629, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(465, 5, 1, '2022-02-22', '13:40:00', '14:00:00', 20, 3624, 'CIP wet proses keteter', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(466, 5, 1, '2022-02-22', '14:00:00', '15:00:00', 60, 3625, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(467, 5, 2, '2022-02-22', '15:00:00', '15:19:00', 19, 3625, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4053', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(468, 5, 2, '2022-02-22', '15:19:00', '15:27:00', 8, 3642, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4054', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(469, 5, 2, '2022-02-22', '15:27:00', '15:31:00', 4, 3641, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4054', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(470, 5, 2, '2022-02-22', '15:31:00', '15:41:00', 10, 3630, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4054', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(471, 5, 2, '2022-02-22', '15:41:00', '23:00:00', 439, 3434, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4054', 18, 12618, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(472, 5, 3, '2022-02-22', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4054', 21, 14731, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(473, 5, 1, '2022-02-23', '07:00:00', '14:03:00', 423, 3434, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4054', 21, 14108, 430, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(474, 5, 1, '2022-02-23', '14:03:00', '14:13:00', 10, 3629, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4054', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(475, 5, 1, '2022-02-23', '14:13:00', '15:00:00', 47, 3625, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4054', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(476, 5, 2, '2022-02-23', '15:00:00', '15:32:00', 32, 3625, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4054', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(477, 5, 2, '2022-02-23', '15:32:00', '19:53:00', 261, 3652, 'Problem supply ice water dari utility sampai 7.25\'c', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4055', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(478, 5, 2, '2022-02-23', '19:53:00', '20:01:00', 8, 3642, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4055', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(479, 5, 2, '2022-02-23', '20:01:00', '20:05:00', 4, 3641, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4055', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `oee_drier` (`id`, `line_id`, `shift_id`, `tanggal`, `start`, `finish`, `lamakejadian`, `activity_id`, `remark`, `operator`, `produk_code`, `produk`, `okp_drier`, `output_bin`, `output_kg`, `rework`, `category_rework`, `reject`, `waiting_tech`, `tech_name`, `repair_problem`, `trial_time`, `bas_com`, `category_br`, `category_ampm`, `jumlah_manpower`) VALUES
(480, 5, 2, '2022-02-23', '20:05:00', '20:15:00', 10, 3630, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4055', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(481, 5, 2, '2022-02-23', '20:15:00', '23:00:00', 165, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4055', 7, 4908, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(482, 5, 3, '2022-02-23', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4055', 23, 16114, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(483, 5, 1, '2022-02-24', '07:00:00', '14:29:00', 449, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4055', 23, 16113, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(484, 5, 1, '2022-02-24', '14:29:00', '15:00:00', 31, 3648, 'Listrik dari PLN kedip', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4055', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(485, 5, 2, '2022-02-24', '15:00:00', '16:25:00', 85, 3648, 'Listrik dari PLN kedip', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4055', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(486, 5, 2, '2022-02-24', '16:25:00', '17:49:00', 84, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4055', 5, 3280, 1140, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(487, 5, 2, '2022-02-24', '17:49:00', '17:59:00', 10, 3629, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4055', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(488, 5, 2, '2022-02-24', '17:59:00', '19:18:00', 79, 3625, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4055', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(489, 5, 2, '2022-02-24', '19:18:00', '19:26:00', 8, 3642, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(490, 5, 2, '2022-02-24', '19:26:00', '19:30:00', 4, 3641, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(491, 5, 2, '2022-02-24', '19:30:00', '19:40:00', 10, 3630, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(492, 5, 2, '2022-02-24', '19:40:00', '23:00:00', 200, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 8, 5205, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(493, 5, 3, '2022-02-24', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 28, 18218, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(494, 5, 1, '2022-02-25', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 28, 18216, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(495, 5, 2, '2022-02-25', '15:00:00', '18:15:00', 195, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 13, 8272, 200, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(496, 5, 2, '2022-02-25', '18:15:00', '18:35:00', 20, 3631, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(497, 5, 2, '2022-02-25', '18:35:00', '20:15:00', 100, 3437, 'Trial motor feed pump baru (bypass)', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(498, 5, 2, '2022-02-25', '20:15:00', '23:00:00', 165, 3441, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(499, 5, 3, '2022-02-25', '23:00:00', '07:00:00', 480, 3441, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(500, 5, 1, '2022-02-26', '07:00:00', '15:00:00', 480, 3441, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(501, 5, 2, '2022-02-26', '15:00:00', '23:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(502, 5, 3, '2022-02-26', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(503, 5, 1, '2022-02-27', '07:00:00', '15:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(504, 5, 2, '2022-02-27', '15:00:00', '23:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(505, 5, 3, '2022-02-27', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(506, 5, 1, '2022-02-28', '07:00:00', '15:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(507, 5, 2, '2022-02-28', '15:00:00', '23:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(508, 5, 3, '2022-02-28', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4056', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(509, 5, 1, '2022-03-01', '07:00:00', '08:00:00', 60, 3647, 'Cek n ricek all before start produksi', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4057', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(510, 5, 1, '2022-03-01', '08:00:00', '09:30:00', 90, 3646, 'Dry out awal pekan', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4057', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(511, 5, 1, '2022-03-01', '09:30:00', '10:00:00', 30, 3645, 'Pasang rubber connection siever', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4057', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(512, 5, 1, '2022-03-01', '10:00:00', '11:37:00', 97, 3641, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4057', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(513, 5, 1, '2022-03-01', '11:37:00', '11:47:00', 10, 3630, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4057', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(514, 5, 1, '2022-03-01', '11:47:00', '15:00:00', 193, 3434, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4057', 4, 2801, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(515, 5, 2, '2022-03-01', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4057', 23, 15613, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(516, 5, 3, '2022-03-01', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4057', 22, 15413, 1130, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(517, 5, 1, '2022-03-02', '07:00:00', '07:55:00', 55, 3434, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4057', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(518, 5, 1, '2022-03-02', '07:55:00', '08:05:00', 10, 3629, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4057', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(519, 5, 1, '2022-03-02', '08:05:00', '09:24:00', 79, 3625, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4057', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(520, 5, 1, '2022-03-02', '09:24:00', '15:00:00', 336, 3437, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-TR-113', 1, 700, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(521, 5, 2, '2022-03-02', '15:00:00', '15:35:00', 35, 3437, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-TR-113', 3, 1912, 300, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(522, 5, 2, '2022-03-02', '15:35:00', '15:45:00', 10, 3437, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-TR-113', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(523, 5, 2, '2022-03-02', '15:45:00', '16:30:00', 45, 3437, 'Feed line hot rince+chlorine', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-TR-113', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(524, 5, 2, '2022-03-02', '16:30:00', '16:38:00', 8, 3642, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4058', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(525, 5, 2, '2022-03-02', '16:38:00', '16:42:00', 4, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4058', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(526, 5, 2, '2022-03-02', '16:42:00', '16:52:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4058', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(527, 5, 2, '2022-03-02', '16:52:00', '23:00:00', 368, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4058', 16, 10409, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(528, 5, 3, '2022-03-02', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4058', 26, 16907, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(529, 5, 1, '2022-03-03', '07:00:00', '15:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4058', 27, 17582, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(530, 5, 2, '2022-03-03', '15:00:00', '16:54:00', 114, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4058', 8, 4906, 500, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(531, 5, 2, '2022-03-03', '16:54:00', '17:04:00', 10, 3629, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4058', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(532, 5, 2, '2022-03-03', '17:04:00', '18:23:00', 79, 3625, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4058', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(533, 5, 2, '2022-03-03', '18:23:00', '18:31:00', 8, 3642, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4059', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(534, 5, 2, '2022-03-03', '18:31:00', '18:35:00', 4, 3641, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4059', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(535, 5, 2, '2022-03-03', '18:35:00', '18:45:00', 10, 3630, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4059', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(536, 5, 2, '2022-03-03', '18:45:00', '23:00:00', 255, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4059', 10, 7006, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(537, 5, 3, '2022-03-03', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4059', 24, 16806, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(538, 5, 1, '2022-03-04', '07:00:00', '14:35:00', 455, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4059', 26, 17890, 700, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(539, 5, 1, '2022-03-04', '14:35:00', '14:45:00', 10, 3629, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4059', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(540, 5, 2, '2022-03-04', '14:45:00', '16:04:00', 79, 3625, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4059', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(541, 5, 2, '2022-03-04', '16:04:00', '17:22:00', 78, 3437, 'Pengechekan calandria before trial', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-TR-114', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(542, 5, 2, '2022-03-04', '17:22:00', '17:26:00', 4, 3437, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-TR-114', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(543, 5, 2, '2022-03-04', '17:26:00', '18:55:00', 89, 3437, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-TR-114', 4, 2402, 490, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(544, 5, 2, '2022-03-04', '18:55:00', '19:05:00', 10, 3437, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-TR-114', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(545, 5, 2, '2022-03-04', '19:05:00', '19:37:00', 32, 3437, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-TR-114', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(546, 5, 2, '2022-03-04', '19:37:00', '20:43:00', 66, 3642, 'Menunggu batching dan pengechekan calandria after trial', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(547, 5, 2, '2022-03-04', '20:43:00', '20:51:00', 8, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(548, 5, 2, '2022-03-04', '20:51:00', '21:01:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(549, 5, 2, '2022-03-04', '21:01:00', '23:00:00', 119, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 4, 2602, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(550, 5, 3, '2022-03-04', '23:00:00', '04:10:00', 310, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 19, 12075, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(551, 5, 3, '2022-03-04', '04:10:00', '04:30:00', 20, 3631, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(552, 5, 3, '2022-03-04', '04:30:00', '07:00:00', 150, 3441, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(553, 5, 1, '2022-03-05', '07:00:00', '15:00:00', 480, 3441, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(554, 5, 2, '2022-03-05', '15:00:00', '21:00:00', 360, 3441, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(555, 5, 2, '2022-03-05', '21:00:00', '23:00:00', 120, 3435, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(556, 5, 3, '2022-03-05', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(557, 5, 1, '2022-03-06', '07:00:00', '15:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(558, 5, 2, '2022-03-06', '15:00:00', '23:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(559, 5, 3, '2022-03-06', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(560, 5, 1, '2022-03-07', '07:00:00', '15:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(561, 5, 2, '2022-03-07', '15:00:00', '23:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(562, 5, 3, '2022-03-07', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4060', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(563, 5, 1, '2022-03-08', '07:00:00', '09:00:00', 120, 3646, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4061', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(564, 5, 1, '2022-03-08', '09:00:00', '11:12:00', 132, 3641, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4061', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(565, 5, 1, '2022-03-08', '11:12:00', '11:22:00', 10, 3630, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4061', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(566, 5, 1, '2022-03-08', '11:22:00', '15:00:00', 218, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4061', 8, 5605, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(567, 5, 2, '2022-03-08', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4061', 22, 15414, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(568, 5, 3, '2022-03-08', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4061', 22, 15433, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(569, 5, 1, '2022-03-09', '07:00:00', '09:05:00', 125, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4061', 7, 4875, 240, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(570, 5, 1, '2022-03-09', '09:05:00', '09:15:00', 10, 3629, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4061', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(571, 5, 1, '2022-03-09', '09:15:00', '10:34:00', 79, 3625, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4061', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(572, 5, 1, '2022-03-09', '10:34:00', '10:42:00', 8, 3642, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4062', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(573, 5, 1, '2022-03-09', '10:42:00', '10:46:00', 4, 3641, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4062', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(574, 5, 1, '2022-03-09', '10:46:00', '10:56:00', 10, 3630, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4062', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(575, 5, 1, '2022-03-09', '10:56:00', '15:00:00', 244, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4062', 8, 5603, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(576, 5, 2, '2022-03-09', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4062', 21, 14710, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(577, 5, 3, '2022-03-09', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4062', 21, 14723, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(578, 5, 1, '2022-03-10', '07:00:00', '10:24:00', 204, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4062', 10, 6723, 650, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(579, 5, 1, '2022-03-10', '10:24:00', '10:34:00', 10, 3629, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4062', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(580, 5, 1, '2022-03-10', '10:34:00', '11:53:00', 79, 3625, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4062', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(581, 5, 1, '2022-03-10', '11:53:00', '12:01:00', 8, 3642, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4063', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(582, 5, 1, '2022-03-10', '12:01:00', '12:05:00', 4, 3641, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4063', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(583, 5, 1, '2022-03-10', '12:05:00', '12:15:00', 10, 3630, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4063', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(584, 5, 1, '2022-03-10', '12:15:00', '15:00:00', 165, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4063', 6, 4204, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(585, 5, 2, '2022-03-10', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4063', 24, 16816, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(586, 5, 3, '2022-03-10', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4063', 24, 16857, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(587, 5, 1, '2022-03-11', '07:00:00', '08:40:00', 100, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4063', 7, 4786, 990, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(588, 5, 1, '2022-03-11', '08:40:00', '08:50:00', 10, 3629, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4063', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(589, 5, 1, '2022-03-11', '08:50:00', '10:09:00', 79, 3625, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4063', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(590, 5, 1, '2022-03-11', '10:09:00', '10:35:00', 26, 3642, 'Start up evap lama karena menunggu blowdown high press utility', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4064', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(591, 5, 1, '2022-03-11', '10:35:00', '10:39:00', 4, 3641, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4064', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(592, 5, 1, '2022-03-11', '10:39:00', '10:49:00', 10, 3630, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4064', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(593, 5, 1, '2022-03-11', '10:49:00', '15:00:00', 251, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4064', 9, 6303, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(594, 5, 2, '2022-03-11', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4064', 21, 14711, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(595, 5, 3, '2022-03-11', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4064', 20, 14018, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(596, 5, 1, '2022-03-12', '07:00:00', '10:00:00', 180, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4064', 12, 8022, 840, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(597, 5, 1, '2022-03-12', '10:00:00', '10:10:00', 10, 3629, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4064', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(598, 5, 1, '2022-03-12', '10:10:00', '11:29:00', 79, 3625, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4064', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(599, 5, 1, '2022-03-12', '11:29:00', '11:37:00', 8, 3642, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4065', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(600, 5, 1, '2022-03-12', '11:37:00', '11:41:00', 4, 3641, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4065', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(601, 5, 1, '2022-03-12', '11:41:00', '11:51:00', 10, 3630, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4065', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(602, 5, 1, '2022-03-12', '11:51:00', '15:00:00', 189, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4065', 4, 2802, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(603, 5, 2, '2022-03-12', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4065', 24, 16812, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(604, 5, 3, '2022-03-12', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4065', 24, 16861, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(605, 5, 1, '2022-03-13', '07:00:00', '09:19:00', 139, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4065', 8, 5605, 510, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(606, 5, 1, '2022-03-13', '09:19:00', '09:29:00', 10, 3629, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4065', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(607, 5, 1, '2022-03-13', '09:29:00', '10:48:00', 79, 3625, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4065', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(608, 5, 1, '2022-03-13', '10:48:00', '10:56:00', 8, 3642, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4066', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(609, 5, 1, '2022-03-13', '10:56:00', '11:00:00', 4, 3641, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4066', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(610, 5, 1, '2022-03-13', '11:00:00', '11:10:00', 10, 3630, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4066', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(611, 5, 1, '2022-03-13', '11:10:00', '15:00:00', 230, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4066', 10, 7007, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(612, 5, 2, '2022-03-13', '15:00:00', '21:30:00', 390, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4066', 20, 13944, 720, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(613, 5, 2, '2022-03-13', '21:30:00', '21:40:00', 10, 3629, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4066', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(614, 5, 2, '2022-03-13', '21:40:00', '22:59:00', 79, 3625, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4066', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(615, 5, 2, '2022-03-13', '22:59:00', '23:00:00', 1, 3652, 'IW temp tinggi terus karena amoniak bocor', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(616, 5, 3, '2022-03-13', '23:00:00', '03:09:00', 249, 3652, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(617, 5, 3, '2022-03-13', '03:09:00', '03:17:00', 8, 3642, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(618, 5, 3, '2022-03-13', '03:17:00', '03:21:00', 4, 3641, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(619, 5, 3, '2022-03-13', '03:21:00', '03:31:00', 10, 3630, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(620, 5, 3, '2022-03-13', '03:31:00', '07:00:00', 209, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 8, 5604, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(621, 5, 1, '2022-03-14', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 20, 14016, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(622, 5, 2, '2022-03-14', '15:00:00', '23:00:00', 480, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 21, 14736, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(623, 5, 3, '2022-03-14', '23:00:00', '03:41:00', 281, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 13, 9108, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(624, 5, 3, '2022-03-14', '03:41:00', '04:01:00', 20, 3631, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(625, 5, 3, '2022-03-14', '04:01:00', '07:00:00', 179, 3441, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(626, 5, 1, '2022-03-15', '07:00:00', '15:00:00', 480, 3441, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(627, 5, 2, '2022-03-15', '15:00:00', '21:00:00', 360, 3441, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4067', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(628, 5, 2, '2022-03-15', '21:00:00', '23:00:00', 120, 3646, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4068', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(629, 5, 3, '2022-03-15', '23:00:00', '00:02:00', 62, 3641, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4068', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(630, 5, 3, '2022-03-15', '00:02:00', '00:12:00', 10, 3630, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4068', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(631, 5, 3, '2022-03-15', '00:12:00', '05:58:00', 346, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4068', 18, 11513, 300, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(632, 5, 3, '2022-03-15', '05:58:00', '06:08:00', 10, 3629, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4068', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(633, 5, 3, '2022-03-15', '06:08:00', '07:00:00', 52, 3625, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4068', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(634, 5, 1, '2022-03-16', '07:00:00', '07:27:00', 27, 3625, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4068', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(635, 5, 1, '2022-03-16', '07:27:00', '07:50:00', 23, 3642, 'Start up evap lama karena ganti supply air samping buffer tank yg bloking', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4069', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(636, 5, 1, '2022-03-16', '07:50:00', '07:54:00', 4, 3641, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4069', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(637, 5, 1, '2022-03-16', '07:54:00', '08:04:00', 10, 3630, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4069', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(638, 5, 1, '2022-03-16', '08:04:00', '15:00:00', 416, 3434, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4069', 21, 14713, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(639, 5, 2, '2022-03-16', '15:00:00', '23:00:00', 480, 3434, '', 'SMI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4069', 21, 14721, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(640, 5, 3, '2022-03-16', '23:00:00', '04:06:00', 306, 3434, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4069', 17, 11509, 370, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(641, 5, 3, '2022-03-16', '04:06:00', '04:16:00', 10, 3629, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4069', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(642, 5, 3, '2022-03-16', '04:16:00', '05:35:00', 79, 3625, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4069', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(643, 5, 3, '2022-03-16', '05:35:00', '05:43:00', 8, 3642, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4070', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(644, 5, 3, '2022-03-16', '05:43:00', '05:47:00', 4, 3641, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4070', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(645, 5, 3, '2022-03-16', '05:47:00', '05:57:00', 10, 3630, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4070', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(646, 5, 3, '2022-03-16', '05:57:00', '07:00:00', 63, 3434, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4070', 1, 700, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(647, 5, 1, '2022-03-17', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4070', 21, 14311, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(648, 5, 2, '2022-03-17', '15:00:00', '22:33:00', 453, 3434, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4070', 22, 15153, 580, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(649, 5, 2, '2022-03-17', '22:33:00', '22:43:00', 10, 3629, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4070', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(650, 5, 2, '2022-03-17', '22:43:00', '23:00:00', 17, 3625, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4070', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(651, 5, 3, '2022-03-17', '23:00:00', '00:02:00', 62, 3625, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4070', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(652, 5, 3, '2022-03-17', '00:02:00', '01:19:00', 77, 3642, 'Problem feedpump DW D 101230Y macet saat startup evap', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4071', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(653, 5, 3, '2022-03-17', '01:19:00', '01:23:00', 4, 3641, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4071', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(654, 5, 3, '2022-03-17', '01:23:00', '01:33:00', 10, 3630, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4071', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(655, 5, 3, '2022-03-17', '01:33:00', '07:00:00', 327, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4071', 13, 9107, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(656, 5, 1, '2022-03-18', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4071', 24, 16814, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(657, 5, 2, '2022-03-18', '15:00:00', '22:28:00', 448, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4071', 16, 16567, 510, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(658, 5, 2, '2022-03-18', '22:28:00', '22:38:00', 10, 3629, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4071', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(659, 5, 2, '2022-03-18', '22:38:00', '23:00:00', 22, 3625, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4071', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(660, 5, 3, '2022-03-18', '23:00:00', '23:57:00', 57, 3625, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4071', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(661, 5, 3, '2022-03-18', '23:57:00', '00:05:00', 8, 3642, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4072', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(662, 5, 3, '2022-03-18', '00:05:00', '00:09:00', 4, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4072', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(663, 5, 3, '2022-03-18', '00:09:00', '00:19:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4072', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(664, 5, 3, '2022-03-18', '00:19:00', '07:00:00', 401, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4072', 18, 11711, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(665, 5, 1, '2022-03-19', '07:00:00', '15:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4072', 26, 16912, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(666, 5, 2, '2022-03-19', '15:00:00', '15:38:00', 38, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4072', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(667, 5, 2, '2022-03-19', '15:38:00', '19:14:00', 216, 3512, 'CYCLONE 530 bloking', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4072', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(668, 5, 2, '2022-03-19', '19:14:00', '23:00:00', 226, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4072', 12, 7814, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(669, 5, 3, '2022-03-19', '23:00:00', '04:39:00', 339, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4072', 19, 12362, 960, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(670, 5, 3, '2022-03-19', '04:39:00', '04:49:00', 10, 3629, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4072', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(671, 5, 3, '2022-03-19', '04:49:00', '06:08:00', 79, 3625, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4072', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(672, 5, 3, '2022-03-19', '06:08:00', '06:16:00', 8, 3642, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(673, 5, 3, '2022-03-19', '06:16:00', '06:20:00', 4, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(674, 5, 3, '2022-03-19', '06:20:00', '06:30:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(675, 5, 3, '2022-03-19', '06:30:00', '07:00:00', 30, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(676, 5, 1, '2022-03-20', '07:00:00', '15:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 23, 14998, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(677, 5, 2, '2022-03-20', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 25, 16268, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(678, 5, 3, '2022-03-20', '23:00:00', '23:02:00', 2, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(679, 5, 3, '2022-03-20', '23:02:00', '02:04:00', 182, 3512, 'CYCLONE 530 bloking', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(680, 5, 3, '2022-03-20', '02:04:00', '07:00:00', 296, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 14, 9110, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(681, 5, 1, '2022-03-21', '07:00:00', '08:02:00', 62, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 5, 3258, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(682, 5, 1, '2022-03-21', '08:02:00', '10:21:00', 139, 3512, 'CYCLONE 530 bloking', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(683, 5, 1, '2022-03-21', '10:21:00', '10:50:00', 29, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(684, 5, 1, '2022-03-21', '10:50:00', '11:10:00', 20, 3631, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(685, 5, 1, '2022-03-21', '11:10:00', '15:00:00', 230, 3627, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(686, 5, 2, '2022-03-21', '15:00:00', '23:00:00', 480, 3627, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(687, 5, 3, '2022-03-21', '23:00:00', '02:00:00', 180, 3627, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(688, 5, 3, '2022-03-21', '02:00:00', '03:30:00', 90, 3646, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(689, 5, 3, '2022-03-21', '03:30:00', '04:14:00', 44, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(690, 5, 3, '2022-03-21', '04:14:00', '04:18:00', 4, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(691, 5, 3, '2022-03-21', '04:18:00', '04:28:00', 10, 3630, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(692, 5, 3, '2022-03-21', '04:28:00', '07:00:00', 152, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 5, 3254, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(693, 5, 1, '2022-03-22', '07:00:00', '07:30:00', 30, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4073', 3, 1952, 690, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(694, 5, 1, '2022-03-22', '07:30:00', '15:00:00', 450, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4074', 23, 14537, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(695, 5, 2, '2022-03-22', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4074', 26, 16932, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(696, 5, 3, '2022-03-22', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4074', 25, 16270, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(697, 5, 1, '2022-03-23', '07:00:00', '07:23:00', 23, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4074', 2, 1303, 465, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(698, 5, 1, '2022-03-23', '07:23:00', '07:33:00', 10, 3629, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4074', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(699, 5, 1, '2022-03-23', '07:33:00', '08:52:00', 79, 3625, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4074', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(700, 5, 1, '2022-03-23', '08:52:00', '09:00:00', 8, 3642, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(701, 5, 1, '2022-03-23', '09:00:00', '09:04:00', 4, 3641, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(702, 5, 1, '2022-03-23', '09:04:00', '09:14:00', 10, 3630, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(703, 5, 1, '2022-03-23', '09:14:00', '15:00:00', 346, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 16, 10422, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(704, 5, 2, '2022-03-23', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 25, 16264, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(705, 5, 3, '2022-03-23', '23:00:00', '02:05:00', 185, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(706, 5, 3, '2022-03-23', '02:05:00', '05:04:00', 179, 3512, 'CYCLONE 530 bloking', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(707, 5, 3, '2022-03-23', '05:04:00', '07:00:00', 116, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 15, 9760, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(708, 5, 1, '2022-03-24', '07:00:00', '10:08:00', 188, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 13, 8453, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(709, 5, 1, '2022-03-24', '10:08:00', '13:30:00', 202, 3512, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(710, 5, 1, '2022-03-24', '13:30:00', '14:40:00', 70, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(711, 5, 2, '2022-03-24', '14:40:00', '17:26:00', 166, 3512, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(712, 5, 2, '2022-03-24', '17:26:00', '19:30:00', 124, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4075', 6, 3906, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(713, 5, 2, '2022-03-24', '19:30:00', '23:00:00', 210, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 8, 5207, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(714, 5, 3, '2022-03-24', '23:00:00', '02:02:00', 182, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(715, 5, 3, '2022-03-24', '02:02:00', '04:15:00', 133, 3512, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(716, 5, 3, '2022-03-24', '04:15:00', '07:00:00', 165, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 18, 10811, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(717, 5, 1, '2022-03-25', '07:00:00', '08:43:00', 103, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 9, 5865, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(718, 5, 1, '2022-03-25', '08:43:00', '13:09:00', 266, 3512, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `oee_drier` (`id`, `line_id`, `shift_id`, `tanggal`, `start`, `finish`, `lamakejadian`, `activity_id`, `remark`, `operator`, `produk_code`, `produk`, `okp_drier`, `output_bin`, `output_kg`, `rework`, `category_rework`, `reject`, `waiting_tech`, `tech_name`, `repair_problem`, `trial_time`, `bas_com`, `category_br`, `category_ampm`, `jumlah_manpower`) VALUES
(719, 5, 2, '2022-03-25', '13:09:00', '16:21:00', 192, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 24, 15614, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(720, 5, 2, '2022-03-25', '16:21:00', '19:49:00', 208, 3512, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(721, 5, 2, '2022-03-25', '19:49:00', '22:40:00', 171, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(722, 5, 2, '2022-03-25', '22:40:00', '23:00:00', 20, 3631, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(723, 5, 3, '2022-03-25', '23:00:00', '07:00:00', 480, 3627, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(724, 5, 1, '2022-03-26', '07:00:00', '15:00:00', 480, 3627, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(725, 5, 2, '2022-03-26', '15:00:00', '16:45:00', 105, 3646, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(726, 5, 2, '2022-03-26', '16:45:00', '17:45:00', 60, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(727, 5, 2, '2022-03-26', '17:45:00', '17:55:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(728, 5, 2, '2022-03-26', '17:55:00', '23:00:00', 305, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 24, 15614, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(729, 5, 3, '2022-03-26', '23:00:00', '05:24:00', 384, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 17, 10562, 975, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(730, 5, 3, '2022-03-26', '05:24:00', '05:34:00', 10, 3629, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(731, 5, 3, '2022-03-26', '05:34:00', '06:53:00', 79, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4076', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(732, 5, 3, '2022-03-26', '06:53:00', '07:00:00', 7, 3642, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4077', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(733, 5, 1, '2022-03-27', '07:00:00', '07:01:00', 1, 3642, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4077', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(734, 5, 1, '2022-03-27', '07:01:00', '07:05:00', 4, 3641, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4077', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(735, 5, 1, '2022-03-27', '07:05:00', '07:15:00', 10, 3630, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4077', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(736, 5, 1, '2022-03-27', '07:15:00', '15:00:00', 465, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4077', 18, 12603, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(737, 5, 2, '2022-03-27', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4077', 20, 14017, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(738, 5, 3, '2022-03-27', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4077', 20, 14001, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(739, 5, 1, '2022-03-28', '07:00:00', '07:26:00', 26, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4077', 2, 1402, 820, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(740, 5, 1, '2022-03-28', '07:26:00', '07:36:00', 10, 3629, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4077', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(741, 5, 1, '2022-03-28', '07:36:00', '08:55:00', 79, 3625, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4077', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(742, 5, 1, '2022-03-28', '08:55:00', '09:52:00', 57, 3662, 'Nunggu ct blm jalan karena ada miscom info dgn driever wh.', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4078', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(743, 5, 1, '2022-03-28', '09:52:00', '10:00:00', 8, 3642, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4078', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(744, 5, 1, '2022-03-28', '10:00:00', '10:04:00', 4, 3641, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4078', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(745, 5, 1, '2022-03-28', '10:04:00', '10:14:00', 10, 3630, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4078', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(746, 5, 1, '2022-03-28', '10:14:00', '15:00:00', 286, 3434, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4078', 12, 8403, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(747, 5, 2, '2022-03-28', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4078', 23, 16115, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(748, 5, 3, '2022-03-28', '23:00:00', '06:34:00', 454, 3434, '', 'SMI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4078', 24, 16550, 480, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(749, 5, 3, '2022-03-28', '06:34:00', '06:44:00', 10, 3629, '', 'SMI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4078', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(750, 5, 3, '2022-03-28', '06:44:00', '07:00:00', 16, 3625, '', 'SMI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4078', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(751, 5, 1, '2022-03-29', '07:00:00', '08:03:00', 63, 3625, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4078', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(752, 5, 1, '2022-03-29', '08:03:00', '08:11:00', 8, 3642, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4079', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(753, 5, 1, '2022-03-29', '08:11:00', '08:15:00', 4, 3641, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4079', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(754, 5, 1, '2022-03-29', '08:15:00', '08:25:00', 10, 3630, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4079', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(755, 5, 1, '2022-03-29', '08:25:00', '15:00:00', 395, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4079', 16, 10606, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(756, 5, 2, '2022-03-29', '15:00:00', '15:18:00', 18, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4079', 3, 1617, 470, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(757, 5, 2, '2022-03-29', '15:18:00', '21:58:00', 400, 3437, 'TRIAL   BMR  R-21  Base  2 MIX (PD-TR-115)', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-TR-115', 8, 5202, 580, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(758, 5, 2, '2022-03-29', '21:58:00', '23:00:00', 62, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4080', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(759, 5, 3, '2022-03-29', '23:00:00', '05:23:00', 383, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4080', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(760, 5, 3, '2022-03-29', '05:23:00', '06:37:00', 74, 3632, 'pengecekan rotary dan cyclone', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4080', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(761, 5, 3, '2022-03-29', '06:37:00', '07:00:00', 23, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4080', 24, 11736, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(762, 5, 1, '2022-03-30', '07:00:00', '12:30:00', 330, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4080', 19, 11838, 225, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(763, 5, 1, '2022-03-30', '12:30:00', '12:50:00', 20, 3631, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4080', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(764, 5, 1, '2022-03-30', '12:50:00', '15:00:00', 130, 3627, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4080', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(765, 5, 2, '2022-03-30', '15:00:00', '23:00:00', 480, 3627, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4080', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(766, 5, 3, '2022-03-30', '23:00:00', '07:00:00', 480, 3627, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4080', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(767, 5, 1, '2022-03-31', '07:00:00', '09:00:00', 120, 3646, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4081', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(768, 5, 1, '2022-03-31', '09:00:00', '10:00:00', 60, 3641, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4081', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(769, 5, 1, '2022-03-31', '10:00:00', '10:10:00', 10, 3630, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4081', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(770, 5, 1, '2022-03-31', '10:10:00', '15:00:00', 290, 3434, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4081', 10, 6504, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(771, 5, 2, '2022-03-31', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4081', 22, 15411, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(772, 5, 3, '2022-03-31', '23:00:00', '06:20:00', 440, 3434, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4081', 22, 15419, 650, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(773, 5, 3, '2022-03-31', '06:20:00', '06:30:00', 10, 3629, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4081', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(774, 5, 3, '2022-03-31', '06:30:00', '07:00:00', 30, 3625, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4081', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(775, 5, 1, '2022-04-01', '07:00:00', '07:51:00', 51, 3625, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4081', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(776, 5, 1, '2022-04-01', '07:51:00', '07:55:00', 4, 3641, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4082', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(777, 5, 1, '2022-04-01', '07:55:00', '08:05:00', 10, 3630, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4082', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(778, 5, 1, '2022-04-01', '08:05:00', '15:00:00', 415, 3434, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4082', 15, 10505, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(779, 5, 2, '2022-04-01', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4082', 22, 15419, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(780, 5, 3, '2022-04-01', '23:00:00', '04:29:00', 329, 3434, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4082', 17, 11920, 300, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(781, 5, 3, '2022-04-01', '04:29:00', '04:39:00', 10, 3629, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4082', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(782, 5, 3, '2022-04-01', '04:39:00', '05:58:00', 79, 3625, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4082', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(783, 5, 3, '2022-04-01', '05:58:00', '06:02:00', 4, 3641, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4083', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(784, 5, 3, '2022-04-01', '06:02:00', '06:12:00', 10, 3630, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4083', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(785, 5, 3, '2022-04-01', '06:12:00', '07:00:00', 48, 3434, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4083', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(786, 5, 1, '2022-04-02', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4083', 21, 14710, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(787, 5, 2, '2022-04-02', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4083', 23, 16106, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(788, 5, 3, '2022-04-02', '23:00:00', '02:02:00', 182, 3434, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4083', 10, 6973, 325, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(789, 5, 3, '2022-04-02', '02:02:00', '02:12:00', 10, 3629, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4083', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(790, 5, 3, '2022-04-02', '02:12:00', '03:31:00', 79, 3625, '', 'SMI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4083', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(791, 5, 3, '2022-04-02', '03:31:00', '03:39:00', 8, 3642, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4084', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(792, 5, 3, '2022-04-02', '03:39:00', '03:43:00', 4, 3641, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4084', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(793, 5, 3, '2022-04-02', '03:43:00', '03:53:00', 10, 3630, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4084', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(794, 5, 3, '2022-04-02', '03:53:00', '07:00:00', 187, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4084', 7, 4555, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(795, 5, 1, '2022-04-03', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4084', 22, 14313, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(796, 5, 2, '2022-04-03', '15:00:00', '23:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4084', 16, 10428, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(797, 5, 3, '2022-04-03', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4084', 23, 14965, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(798, 5, 1, '2022-04-04', '07:00:00', '09:36:00', 156, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4084', 8, 5203, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(799, 5, 1, '2022-04-04', '09:36:00', '09:46:00', 10, 3629, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4084', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(800, 5, 1, '2022-04-04', '09:46:00', '11:05:00', 79, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4084', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(801, 5, 1, '2022-04-04', '11:05:00', '11:13:00', 8, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(802, 5, 1, '2022-04-04', '11:13:00', '11:17:00', 4, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(803, 5, 1, '2022-04-04', '11:17:00', '11:27:00', 10, 3630, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(804, 5, 1, '2022-04-04', '11:27:00', '13:07:00', 100, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(805, 5, 1, '2022-04-04', '13:07:00', '14:56:00', 109, 3512, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(806, 5, 1, '2022-04-04', '14:56:00', '15:00:00', 4, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 4, 2604, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(807, 5, 2, '2022-04-04', '15:00:00', '23:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 21, 13693, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(808, 5, 3, '2022-04-04', '23:00:00', '03:07:00', 247, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(809, 5, 3, '2022-04-04', '03:07:00', '05:41:00', 154, 3632, 'Cleaning dan checking rotary valve 530', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(810, 5, 3, '2022-04-04', '05:41:00', '07:00:00', 79, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 15, 9756, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(811, 5, 1, '2022-04-05', '07:00:00', '11:09:00', 249, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(812, 5, 1, '2022-04-05', '11:09:00', '12:56:00', 107, 3512, 'Cyclone 530 bloking', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(813, 5, 1, '2022-04-05', '12:56:00', '15:00:00', 124, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 17, 11061, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(814, 5, 2, '2022-04-05', '15:00:00', '16:12:00', 72, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(815, 5, 2, '2022-04-05', '16:12:00', '18:58:00', 166, 3512, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(816, 5, 2, '2022-04-05', '18:58:00', '20:25:00', 87, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 8, 5206, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(817, 5, 2, '2022-04-05', '20:25:00', '22:45:00', 140, 3512, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(818, 5, 3, '2022-04-05', '22:45:00', '02:10:00', 205, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 9, 5856, 450, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(819, 5, 3, '2022-04-05', '02:10:00', '02:30:00', 20, 3631, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(820, 5, 3, '2022-04-05', '02:30:00', '07:00:00', 270, 3441, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(821, 5, 1, '2022-04-06', '07:00:00', '15:00:00', 480, 3441, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(822, 5, 2, '2022-04-06', '15:00:00', '19:45:00', 285, 3441, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4085', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(823, 5, 2, '2022-04-06', '19:45:00', '21:30:00', 105, 3646, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4087', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(824, 5, 2, '2022-04-06', '21:30:00', '22:11:00', 41, 3609, 'cooling water belum dingin', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4087', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(825, 5, 2, '2022-04-06', '22:11:00', '23:00:00', 49, 3641, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4087', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(826, 5, 3, '2022-04-06', '23:00:00', '23:11:00', 11, 3641, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4087', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(827, 5, 3, '2022-04-06', '23:11:00', '23:21:00', 10, 3630, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4087', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(828, 5, 3, '2022-04-06', '23:21:00', '07:00:00', 459, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4087', 25, 14913, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(829, 5, 1, '2022-04-07', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4087', 30, 19522, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(830, 5, 2, '2022-04-07', '15:00:00', '16:30:00', 90, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4087', 6, 3916, 180, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(831, 5, 2, '2022-04-07', '16:30:00', '16:40:00', 10, 3629, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4087', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(832, 5, 2, '2022-04-07', '16:40:00', '17:59:00', 79, 3625, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4087', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(833, 5, 2, '2022-04-07', '17:59:00', '18:40:00', 41, 3624, 'CIP wet proses keteter', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4086', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(834, 5, 2, '2022-04-07', '18:40:00', '18:48:00', 8, 3642, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4086', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(835, 5, 2, '2022-04-07', '18:48:00', '18:52:00', 4, 3641, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4086', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(836, 5, 2, '2022-04-07', '18:52:00', '19:02:00', 10, 3630, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4086', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(837, 5, 2, '2022-04-07', '19:02:00', '23:00:00', 238, 3434, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4086', 8, 5616, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(838, 5, 3, '2022-04-07', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4086', 20, 14014, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(839, 5, 1, '2022-04-08', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4086', 21, 14714, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(840, 5, 2, '2022-04-08', '15:00:00', '17:55:00', 175, 3434, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4086', 10, 6844, 840, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(841, 5, 2, '2022-04-08', '17:55:00', '18:05:00', 10, 3629, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4086', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(842, 5, 2, '2022-04-08', '18:05:00', '19:24:00', 79, 3625, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4086', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(843, 5, 2, '2022-04-08', '19:24:00', '19:32:00', 8, 3642, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4088', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(844, 5, 2, '2022-04-08', '19:32:00', '19:36:00', 4, 3641, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4088', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(845, 5, 2, '2022-04-08', '19:36:00', '19:46:00', 10, 3630, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4088', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(846, 5, 2, '2022-04-08', '19:46:00', '23:00:00', 194, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4088', 9, 5862, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(847, 5, 3, '2022-04-08', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4088', 27, 17567, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(848, 5, 1, '2022-04-09', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4088', 30, 19521, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(849, 5, 2, '2022-04-09', '15:00:00', '17:55:00', 175, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4088', 12, 7812, 300, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(850, 5, 2, '2022-04-09', '17:55:00', '18:05:00', 10, 3629, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4088', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(851, 5, 2, '2022-04-09', '18:05:00', '19:24:00', 79, 3625, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4088', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(852, 5, 2, '2022-04-09', '19:24:00', '19:32:00', 8, 3642, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4089', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(853, 5, 2, '2022-04-09', '19:32:00', '19:36:00', 4, 3641, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4089', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(854, 5, 2, '2022-04-09', '19:36:00', '19:46:00', 10, 3630, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4089', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(855, 5, 2, '2022-04-09', '19:46:00', '23:00:00', 194, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4089', 7, 4557, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(856, 5, 3, '2022-04-09', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4089', 22, 14314, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(857, 5, 1, '2022-04-10', '07:00:00', '15:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4089', 18, 11731, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(858, 5, 2, '2022-04-10', '15:00:00', '23:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4089', 22, 14313, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(859, 5, 3, '2022-04-10', '23:00:00', '00:35:00', 95, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4089', 6, 3779, 260, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(860, 5, 3, '2022-04-10', '00:35:00', '00:45:00', 10, 3629, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4089', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(861, 5, 3, '2022-04-10', '00:45:00', '02:04:00', 79, 3625, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4089', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(862, 5, 3, '2022-04-10', '02:04:00', '02:12:00', 8, 3642, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4090', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(863, 5, 3, '2022-04-10', '02:12:00', '02:16:00', 4, 3641, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4090', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(864, 5, 3, '2022-04-10', '02:16:00', '02:26:00', 10, 3630, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4090', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(865, 5, 3, '2022-04-10', '02:26:00', '06:54:00', 268, 3434, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4090', 13, 8772, 330, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(866, 5, 3, '2022-04-10', '06:54:00', '07:00:00', 6, 3629, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4090', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(867, 5, 1, '2022-04-11', '07:00:00', '07:04:00', 4, 3629, '', 'SMI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4090', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(868, 5, 1, '2022-04-11', '07:04:00', '08:23:00', 79, 3625, '', 'SMI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4090', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(869, 5, 1, '2022-04-11', '08:23:00', '08:31:00', 8, 3642, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4091', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(870, 5, 1, '2022-04-11', '08:31:00', '08:35:00', 4, 3641, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4091', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(871, 5, 1, '2022-04-11', '08:35:00', '08:45:00', 10, 3630, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4091', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(872, 5, 1, '2022-04-11', '08:45:00', '15:00:00', 375, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4091', 19, 11926, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(873, 5, 2, '2022-04-11', '15:00:00', '15:34:00', 34, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4091', 4, 2251, 480, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(874, 5, 2, '2022-04-11', '15:34:00', '15:44:00', 10, 3629, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4091', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(875, 5, 2, '2022-04-11', '15:44:00', '17:03:00', 79, 3625, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4091', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(876, 5, 2, '2022-04-11', '17:03:00', '17:11:00', 8, 3642, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4092', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(877, 5, 2, '2022-04-11', '17:11:00', '17:15:00', 4, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4092', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(878, 5, 2, '2022-04-11', '17:15:00', '17:25:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4092', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(879, 5, 2, '2022-04-11', '17:25:00', '23:00:00', 335, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4092', 12, 7807, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(880, 5, 3, '2022-04-11', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4092', 22, 14308, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(881, 5, 1, '2022-04-12', '07:00:00', '07:11:00', 11, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4092', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(882, 5, 1, '2022-04-12', '07:11:00', '08:11:00', 60, 3632, 'Cleaning dan checking rotary valve 530', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4092', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(883, 5, 1, '2022-04-12', '08:11:00', '15:00:00', 409, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4092', 18, 11708, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(884, 5, 2, '2022-04-12', '15:00:00', '22:27:00', 447, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4092', 22, 14207, 330, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(885, 5, 2, '2022-04-12', '22:27:00', '22:37:00', 10, 3629, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4092', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(886, 5, 2, '2022-04-12', '22:37:00', '23:00:00', 23, 3625, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4092', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(887, 5, 3, '2022-04-12', '23:00:00', '23:56:00', 56, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4092', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(888, 5, 3, '2022-04-12', '23:56:00', '00:04:00', 8, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4093', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(889, 5, 3, '2022-04-12', '00:04:00', '00:08:00', 4, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4093', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(890, 5, 3, '2022-04-12', '00:08:00', '00:18:00', 10, 3630, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4093', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(891, 5, 3, '2022-04-12', '00:18:00', '07:00:00', 402, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4093', 21, 13665, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(892, 5, 1, '2022-04-13', '07:00:00', '15:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4093', 30, 19549, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(893, 5, 2, '2022-04-13', '15:00:00', '20:40:00', 340, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4093', 23, 14463, 150, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(894, 5, 2, '2022-04-13', '20:40:00', '20:50:00', 10, 3629, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4093', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(895, 5, 2, '2022-04-13', '20:50:00', '22:09:00', 79, 3625, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4093', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(896, 5, 2, '2022-04-13', '22:09:00', '22:17:00', 8, 3642, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(897, 5, 2, '2022-04-13', '22:17:00', '22:21:00', 4, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(898, 5, 2, '2022-04-13', '22:21:00', '22:31:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(899, 5, 2, '2022-04-13', '22:31:00', '23:00:00', 29, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(900, 5, 3, '2022-04-13', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 21, 13664, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(901, 5, 1, '2022-04-14', '07:00:00', '11:35:00', 275, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 16, 10415, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(902, 5, 1, '2022-04-14', '11:35:00', '13:44:00', 129, 3512, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(903, 5, 1, '2022-04-14', '13:44:00', '15:00:00', 76, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(904, 5, 2, '2022-04-14', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 21, 13664, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(905, 5, 3, '2022-04-14', '23:00:00', '04:30:00', 330, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 16, 10361, 60, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(906, 5, 3, '2022-04-14', '04:30:00', '04:50:00', 20, 3631, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(907, 5, 3, '2022-04-14', '04:50:00', '07:00:00', 130, 3441, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(908, 5, 1, '2022-04-15', '07:00:00', '15:00:00', 480, 3441, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(909, 5, 2, '2022-04-15', '15:00:00', '22:00:00', 420, 3441, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(910, 5, 2, '2022-04-15', '22:00:00', '23:00:00', 60, 3442, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(911, 5, 3, '2022-04-15', '23:00:00', '07:00:00', 480, 3442, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4094', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(912, 5, 1, '2022-04-16', '07:00:00', '08:30:00', 90, 3646, 'Dry out awal pekan', 'SMI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4095', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(913, 5, 1, '2022-04-16', '08:30:00', '09:55:00', 85, 3641, '', 'SMI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4095', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(914, 5, 1, '2022-04-16', '09:55:00', '10:05:00', 10, 3630, '', 'SMI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4095', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(915, 5, 1, '2022-04-16', '10:05:00', '15:00:00', 295, 3434, '', 'SMI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4095', 15, 7212, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(916, 5, 2, '2022-04-16', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4095', 30, 15018, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(917, 5, 3, '2022-04-16', '23:00:00', '06:53:00', 473, 3434, '', 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4095', 31, 15516, 305, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(918, 5, 3, '2022-04-16', '06:53:00', '07:00:00', 7, 3629, '', 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4095', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(919, 5, 1, '2022-04-17', '07:00:00', '07:03:00', 3, 3629, '', 'NSA', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4095', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(920, 5, 1, '2022-04-17', '07:03:00', '08:22:00', 79, 3625, '', 'NSA', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4096', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(921, 5, 1, '2022-04-17', '08:22:00', '08:26:00', 4, 3641, '', 'NSA', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4096', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(922, 5, 1, '2022-04-17', '08:26:00', '08:36:00', 10, 3630, '', 'NSA', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4096', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(923, 5, 1, '2022-04-17', '08:36:00', '15:00:00', 384, 3434, '', 'NSA', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4096', 22, 11013, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(924, 5, 2, '2022-04-17', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4096', 31, 15506, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(925, 5, 3, '2022-04-17', '23:00:00', '04:59:00', 359, 3434, '', 'SMI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4096', 23, 11507, 135, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(926, 5, 3, '2022-04-17', '04:59:00', '05:09:00', 10, 3629, '', 'SMI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4096', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(927, 5, 3, '2022-04-17', '05:09:00', '06:28:00', 79, 3625, '', 'SMI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4096', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(928, 5, 3, '2022-04-17', '06:28:00', '06:32:00', 4, 3641, '', 'SMI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4097', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(929, 5, 3, '2022-04-17', '06:32:00', '06:42:00', 10, 3630, '', 'SMI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4097', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(930, 5, 3, '2022-04-17', '06:42:00', '07:00:00', 18, 3434, '', 'SMI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4097', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(931, 5, 1, '2022-04-18', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4097', 27, 13211, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(932, 5, 2, '2022-04-18', '15:00:00', '15:20:00', 20, 3434, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4097', 3, 1490, 200, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(933, 5, 2, '2022-04-18', '15:20:00', '15:30:00', 10, 3629, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4097', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(934, 5, 2, '2022-04-18', '15:30:00', '16:49:00', 79, 3625, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4097', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(935, 5, 2, '2022-04-18', '16:49:00', '16:53:00', 4, 3641, '', 'YHI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4098', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(936, 5, 2, '2022-04-18', '16:53:00', '17:03:00', 10, 3630, '', 'YHI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4098', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(937, 5, 2, '2022-04-18', '17:03:00', '23:00:00', 357, 3434, '', 'YHI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4098', 19, 9201, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(938, 5, 3, '2022-04-18', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4098', 30, 15068, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(939, 5, 1, '2022-04-19', '07:00:00', '09:10:00', 130, 3434, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4098', 8, 4004, 240, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(940, 5, 1, '2022-04-19', '09:10:00', '09:20:00', 10, 3629, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4098', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(941, 5, 1, '2022-04-19', '09:20:00', '10:39:00', 79, 3625, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4098', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(942, 5, 1, '2022-04-19', '10:39:00', '10:43:00', 4, 3641, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4099', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(943, 5, 1, '2022-04-19', '10:43:00', '10:53:00', 10, 3630, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4099', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(944, 5, 1, '2022-04-19', '10:53:00', '15:00:00', 247, 3434, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4099', 13, 6509, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(945, 5, 2, '2022-04-19', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4099', 30, 15012, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(946, 5, 3, '2022-04-19', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4099', 29, 14548, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(947, 5, 1, '2022-04-20', '07:00:00', '09:23:00', 143, 3434, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4099', 11, 5265, 150, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(948, 5, 1, '2022-04-20', '09:23:00', '09:33:00', 10, 3629, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4099', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(949, 5, 1, '2022-04-20', '09:33:00', '10:52:00', 79, 3625, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4099', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(950, 5, 1, '2022-04-20', '10:52:00', '10:56:00', 4, 3641, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4100', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(951, 5, 1, '2022-04-20', '10:56:00', '11:06:00', 10, 3630, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4100', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(952, 5, 1, '2022-04-20', '11:06:00', '15:00:00', 234, 3434, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4100', 12, 5707, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(953, 5, 2, '2022-04-20', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4100', 29, 14509, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(954, 5, 3, '2022-04-20', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4100', 29, 14532, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(955, 5, 1, '2022-04-21', '07:00:00', '08:06:00', 66, 3434, '', 'NSA', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4100', 6, 3003, 205, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(956, 5, 1, '2022-04-21', '08:06:00', '08:16:00', 10, 3629, '', 'NSA', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4100', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(957, 5, 1, '2022-04-21', '08:16:00', '09:35:00', 79, 3625, '', 'NSA', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4100', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(958, 5, 1, '2022-04-21', '09:35:00', '09:39:00', 4, 3641, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4101', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(959, 5, 1, '2022-04-21', '09:39:00', '09:49:00', 10, 3630, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4101', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `oee_drier` (`id`, `line_id`, `shift_id`, `tanggal`, `start`, `finish`, `lamakejadian`, `activity_id`, `remark`, `operator`, `produk_code`, `produk`, `okp_drier`, `output_bin`, `output_kg`, `rework`, `category_rework`, `reject`, `waiting_tech`, `tech_name`, `repair_problem`, `trial_time`, `bas_com`, `category_br`, `category_ampm`, `jumlah_manpower`) VALUES
(960, 5, 1, '2022-04-21', '09:49:00', '15:00:00', 311, 3434, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4101', 17, 8208, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(961, 5, 2, '2022-04-21', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4101', 29, 14515, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(962, 5, 3, '2022-04-21', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4101', 30, 15048, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(963, 5, 1, '2022-04-22', '07:00:00', '08:10:00', 70, 3434, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4101', 6, 3002, 185, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(964, 5, 1, '2022-04-22', '08:10:00', '08:20:00', 10, 3629, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4101', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(965, 5, 1, '2022-04-22', '08:20:00', '09:39:00', 79, 3625, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4101', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(966, 5, 1, '2022-04-22', '09:39:00', '09:43:00', 4, 3632, '', 'NSA', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4102', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(967, 5, 1, '2022-04-22', '09:43:00', '09:47:00', 4, 3641, '', 'NSA', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4102', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(968, 5, 1, '2022-04-22', '09:47:00', '09:57:00', 10, 3630, '', 'NSA', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4102', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(969, 5, 1, '2022-04-22', '09:57:00', '14:14:00', 257, 3434, '', 'NSA', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4102', 13, 6507, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(970, 5, 1, '2022-04-22', '14:14:00', '15:00:00', 46, 3648, '', 'NSA', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4102', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(971, 5, 2, '2022-04-22', '15:00:00', '16:25:00', 85, 3648, '', 'YHI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4102', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(972, 5, 2, '2022-04-22', '16:25:00', '19:05:00', 160, 3434, '', 'YHI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4102', 9, 4304, 550, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(973, 5, 2, '2022-04-22', '19:05:00', '19:15:00', 10, 3629, '', 'YHI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4102', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(974, 5, 2, '2022-04-22', '19:15:00', '20:34:00', 79, 3625, '', 'YHI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4102', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(975, 5, 2, '2022-04-22', '20:34:00', '20:44:00', 10, 3632, '', 'YHI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4102', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(976, 5, 2, '2022-04-22', '20:44:00', '20:48:00', 4, 3641, '', 'YHI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4103', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(977, 5, 2, '2022-04-22', '20:48:00', '20:58:00', 10, 3630, '', 'YHI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4103', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(978, 5, 2, '2022-04-22', '20:58:00', '23:00:00', 122, 3434, '', 'YHI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4103', 4, 2001, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(979, 5, 3, '2022-04-22', '23:00:00', '05:13:00', 373, 3434, '', 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4103', 25, 12287, 345, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(980, 5, 3, '2022-04-22', '05:13:00', '05:23:00', 10, 3629, '', 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4103', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(981, 5, 3, '2022-04-22', '05:23:00', '06:42:00', 79, 3625, '', 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4103', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(982, 5, 3, '2022-04-22', '06:42:00', '06:46:00', 4, 3641, '', 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4104', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(983, 5, 3, '2022-04-22', '06:46:00', '06:56:00', 10, 3630, '', 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4104', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(984, 5, 3, '2022-04-22', '06:56:00', '07:00:00', 4, 3434, '', 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4104', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(985, 5, 1, '2022-04-23', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4104', 27, 13212, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(986, 5, 2, '2022-04-23', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4104', 29, 14512, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(987, 5, 3, '2022-04-23', '23:00:00', '02:41:00', 221, 3434, '', 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4104', 15, 7412, 138, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(988, 5, 3, '2022-04-23', '02:41:00', '03:01:00', 20, 3631, '', 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4104', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(989, 5, 3, '2022-04-23', '03:01:00', '07:00:00', 239, 3441, '', 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4104', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(990, 5, 1, '2022-04-24', '07:00:00', '15:00:00', 480, 3441, '', 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4104', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(991, 5, 2, '2022-04-24', '15:00:00', '18:15:00', 195, 3441, '', 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4104', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(992, 5, 2, '2022-04-24', '18:15:00', '19:45:00', 90, 3646, '', 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4105', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(993, 5, 2, '2022-04-24', '19:45:00', '20:48:00', 63, 3642, '', 'SMI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4105', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(994, 5, 2, '2022-04-24', '20:48:00', '20:52:00', 4, 3641, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4105', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(995, 5, 2, '2022-04-24', '20:52:00', '21:02:00', 10, 3630, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4105', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(996, 5, 2, '2022-04-24', '21:02:00', '23:00:00', 118, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4105', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(997, 5, 3, '2022-04-24', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4105', 23, 16112, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(998, 5, 1, '2022-04-25', '07:00:00', '08:04:00', 64, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4105', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(999, 5, 1, '2022-04-25', '08:04:00', '10:10:00', 126, 3663, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4105', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1000, 5, 1, '2022-04-25', '10:10:00', '15:00:00', 290, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4105', 15, 10196, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1001, 5, 2, '2022-04-25', '15:00:00', '20:30:00', 330, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4105', 19, 12029, 910, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1002, 5, 2, '2022-04-25', '20:30:00', '20:40:00', 10, 3629, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4105', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1003, 5, 2, '2022-04-25', '20:40:00', '21:59:00', 79, 3625, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4105', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1004, 5, 2, '2022-04-25', '21:59:00', '22:03:00', 4, 3641, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4106', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1005, 5, 2, '2022-04-25', '22:03:00', '22:13:00', 10, 3630, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4106', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1006, 5, 2, '2022-04-25', '22:13:00', '23:00:00', 47, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4106', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1007, 5, 3, '2022-04-25', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4106', 19, 13312, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1008, 5, 1, '2022-04-26', '07:00:00', '11:17:00', 257, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4106', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1009, 5, 1, '2022-04-26', '11:17:00', '12:29:00', 72, 3663, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4106', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1010, 5, 1, '2022-04-26', '12:29:00', '15:00:00', 151, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4106', 17, 11688, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1011, 5, 2, '2022-04-26', '15:00:00', '20:34:00', 334, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4106', 16, 11035, 1210, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1012, 5, 2, '2022-04-26', '20:34:00', '20:44:00', 10, 3629, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4106', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1013, 5, 2, '2022-04-26', '20:44:00', '22:03:00', 79, 3625, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4106', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1014, 5, 2, '2022-04-26', '22:03:00', '22:07:00', 4, 3641, '', 'YHI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4107', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1015, 5, 2, '2022-04-26', '22:07:00', '22:17:00', 10, 3630, '', 'YHI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4107', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1016, 5, 2, '2022-04-26', '22:17:00', '23:00:00', 43, 3434, '', 'YHI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4107', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1017, 5, 3, '2022-04-26', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4107', 22, 14917, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1018, 5, 1, '2022-04-27', '07:00:00', '12:20:00', 320, 3434, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4107', 16, 11211, 455, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1019, 5, 1, '2022-04-27', '12:20:00', '12:30:00', 10, 3629, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4107', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1020, 5, 1, '2022-04-27', '12:30:00', '13:49:00', 79, 3625, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4107', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1021, 5, 1, '2022-04-27', '13:49:00', '13:53:00', 4, 3641, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1022, 5, 1, '2022-04-27', '13:53:00', '14:03:00', 10, 3630, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1023, 5, 1, '2022-04-27', '14:03:00', '15:00:00', 57, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1024, 5, 2, '2022-04-27', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 20, 14006, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1025, 5, 3, '2022-04-27', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 20, 14013, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1026, 5, 1, '2022-04-28', '07:00:00', '13:30:00', 390, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 18, 12264, 300, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1027, 5, 1, '2022-04-28', '13:30:00', '13:50:00', 20, 3631, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1028, 5, 1, '2022-04-28', '13:50:00', '15:00:00', 70, 3441, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1029, 5, 2, '2022-04-28', '15:00:00', '23:00:00', 480, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1030, 5, 3, '2022-04-28', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1031, 5, 1, '2022-04-29', '07:00:00', '15:00:00', 480, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1032, 5, 2, '2022-04-29', '15:00:00', '23:00:00', 480, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1033, 5, 3, '2022-04-29', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1034, 5, 1, '2022-04-30', '07:00:00', '15:00:00', 480, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1035, 5, 2, '2022-04-30', '15:00:00', '23:00:00', 480, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1036, 5, 3, '2022-04-30', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1037, 5, 1, '2022-05-01', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1038, 5, 1, '2022-05-02', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1039, 5, 1, '2022-05-03', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1040, 5, 1, '2022-05-04', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1041, 5, 1, '2022-05-05', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1042, 5, 1, '2022-05-06', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1043, 5, 1, '2022-05-07', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1044, 5, 1, '2022-05-08', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1045, 5, 1, '2022-05-09', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1046, 5, 1, '2022-05-10', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1047, 5, 1, '2022-05-11', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1048, 5, 1, '2022-05-12', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1049, 5, 1, '2022-05-13', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1050, 5, 1, '2022-05-14', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1051, 5, 1, '2022-05-15', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1052, 5, 1, '2022-05-16', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1053, 5, 1, '2022-05-17', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1054, 5, 1, '2022-05-18', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1055, 5, 1, '2022-05-19', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1056, 5, 1, '2022-05-20', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1057, 5, 1, '2022-05-21', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1058, 5, 1, '2022-05-22', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1059, 5, 1, '2022-05-23', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1060, 5, 1, '2022-05-24', '07:00:00', '07:00:00', 1440, 3435, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4108', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1061, 5, 1, '2022-05-25', '07:00:00', '09:00:00', 120, 3646, 'dryingout awal ahad', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4109', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1062, 5, 1, '2022-05-25', '09:00:00', '09:51:00', 51, 3641, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4109', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1063, 5, 1, '2022-05-25', '09:51:00', '10:01:00', 10, 3630, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4109', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1064, 5, 1, '2022-05-25', '10:01:00', '15:00:00', 299, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4109', 11, 7169, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1065, 5, 2, '2022-05-25', '15:00:00', '22:13:00', 433, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4109', 21, 13664, 790, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1066, 5, 2, '2022-05-25', '22:13:00', '22:23:00', 10, 3629, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4109', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1067, 5, 3, '2022-05-25', '22:23:00', '23:02:00', 39, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4109', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1068, 5, 3, '2022-05-25', '23:02:00', '23:40:00', 38, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4109', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1069, 5, 3, '2022-05-25', '23:40:00', '23:48:00', 8, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4110', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1070, 5, 3, '2022-05-25', '23:48:00', '23:52:00', 4, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4110', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1071, 5, 3, '2022-05-25', '23:52:00', '00:02:00', 10, 3630, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4110', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1072, 5, 3, '2022-05-25', '00:02:00', '07:00:00', 418, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4110', 18, 11709, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1073, 5, 1, '2022-05-26', '07:00:00', '11:52:00', 292, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4110', 15, 9690, 230, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1074, 5, 1, '2022-05-26', '11:52:00', '12:02:00', 10, 3629, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4110', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1075, 5, 1, '2022-05-26', '12:02:00', '13:21:00', 79, 3625, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4110', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1076, 5, 1, '2022-05-26', '13:21:00', '13:29:00', 8, 3642, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4111', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1077, 5, 1, '2022-05-26', '13:29:00', '13:33:00', 4, 3641, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4111', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1078, 5, 1, '2022-05-26', '13:33:00', '13:43:00', 10, 3630, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4111', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1079, 5, 1, '2022-05-26', '13:43:00', '15:00:00', 77, 3434, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4111', 2, 1402, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1080, 5, 2, '2022-05-26', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4111', 23, 15615, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1081, 5, 3, '2022-05-26', '23:00:00', '01:40:00', 160, 3434, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4111', 10, 6680, 270, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1082, 5, 3, '2022-05-26', '01:40:00', '01:50:00', 10, 3629, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4111', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1083, 5, 3, '2022-05-26', '01:50:00', '03:09:00', 79, 3625, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4111', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1084, 5, 3, '2022-05-26', '03:09:00', '03:17:00', 8, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4112', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1085, 5, 3, '2022-05-26', '03:17:00', '03:21:00', 4, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4112', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1086, 5, 3, '2022-05-26', '03:21:00', '03:31:00', 10, 3630, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4112', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1087, 5, 3, '2022-05-26', '03:31:00', '07:00:00', 209, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4112', 8, 5202, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1088, 5, 1, '2022-05-27', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4112', 22, 14343, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1089, 5, 2, '2022-05-27', '15:00:00', '15:28:00', 28, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4112', 3, 1952, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1090, 5, 2, '2022-05-27', '15:28:00', '15:38:00', 10, 3629, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4112', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1091, 5, 2, '2022-05-27', '15:38:00', '16:57:00', 79, 3625, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4112', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1092, 5, 2, '2022-05-27', '16:57:00', '17:05:00', 8, 3642, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4113', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1093, 5, 2, '2022-05-27', '17:05:00', '17:09:00', 4, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4113', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1094, 5, 2, '2022-05-27', '17:09:00', '17:19:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4113', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1095, 5, 2, '2022-05-27', '17:19:00', '23:00:00', 341, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4113', 14, 9111, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1096, 5, 3, '2022-05-27', '23:00:00', '05:20:00', 380, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4113', 19, 12115, 190, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1097, 5, 3, '2022-05-27', '05:20:00', '05:30:00', 10, 3629, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4113', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1098, 5, 3, '2022-05-27', '05:30:00', '06:49:00', 79, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4113', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1099, 5, 3, '2022-05-27', '06:49:00', '06:57:00', 8, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-TR-116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1100, 5, 3, '2022-05-27', '06:57:00', '07:00:00', 3, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-TR-116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1101, 5, 1, '2022-05-28', '07:00:00', '07:01:00', 1, 3641, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-TR-116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1102, 5, 1, '2022-05-28', '07:01:00', '07:11:00', 10, 3630, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-TR-116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1103, 5, 1, '2022-05-28', '07:11:00', '08:32:00', 81, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-TR-116', 5, 2668, 210, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1104, 5, 1, '2022-05-28', '08:32:00', '08:42:00', 10, 3629, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-TR-116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1105, 5, 1, '2022-05-28', '08:42:00', '09:41:00', 59, 3607, 'v-7201 bocor', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-TR-116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1106, 5, 1, '2022-05-28', '09:41:00', '11:00:00', 79, 3625, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-TR-116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1107, 5, 1, '2022-05-28', '11:00:00', '11:08:00', 8, 3642, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4114', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1108, 5, 1, '2022-05-28', '11:08:00', '11:12:00', 4, 3641, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4114', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1109, 5, 1, '2022-05-28', '11:12:00', '11:22:00', 10, 3630, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4114', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1110, 5, 1, '2022-05-28', '11:22:00', '15:00:00', 218, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4114', 7, 4910, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1111, 5, 2, '2022-05-28', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4114', 21, 14712, 360, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1112, 5, 3, '2022-05-28', '23:00:00', '23:12:00', 12, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4114', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1113, 5, 3, '2022-05-28', '23:12:00', '23:22:00', 10, 3629, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4114', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1114, 5, 3, '2022-05-28', '23:22:00', '00:41:00', 79, 3625, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4114', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1115, 5, 3, '2022-05-28', '00:41:00', '00:49:00', 8, 3642, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4115', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1116, 5, 3, '2022-05-28', '00:49:00', '00:53:00', 4, 3641, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4115', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1117, 5, 3, '2022-05-28', '00:53:00', '01:03:00', 10, 3630, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4115', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1118, 5, 3, '2022-05-28', '01:03:00', '07:00:00', 357, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4115', 14, 9803, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1119, 5, 1, '2022-05-29', '07:00:00', '07:33:00', 33, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4115', 3, 2102, 530, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1120, 5, 1, '2022-05-29', '07:33:00', '07:43:00', 10, 3629, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4115', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1121, 5, 1, '2022-05-29', '07:43:00', '09:02:00', 79, 3625, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4115', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1122, 5, 1, '2022-05-29', '09:02:00', '09:10:00', 8, 3642, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1123, 5, 1, '2022-05-29', '09:10:00', '09:14:00', 4, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1124, 5, 1, '2022-05-29', '09:14:00', '09:24:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1125, 5, 1, '2022-05-29', '09:24:00', '15:00:00', 336, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4116', 14, 9110, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1126, 5, 2, '2022-05-29', '15:00:00', '21:37:00', 397, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4116', 19, 12359, 270, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1127, 5, 2, '2022-05-29', '21:37:00', '21:47:00', 10, 3629, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1128, 5, 2, '2022-05-29', '21:47:00', '23:00:00', 73, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1129, 5, 3, '2022-05-29', '23:00:00', '23:06:00', 6, 3625, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4116', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1130, 5, 3, '2022-05-29', '23:06:00', '23:14:00', 8, 3642, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4117', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1131, 5, 3, '2022-05-29', '23:14:00', '23:18:00', 4, 3641, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4117', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1132, 5, 3, '2022-05-29', '23:18:00', '23:28:00', 10, 3630, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4117', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1133, 5, 3, '2022-05-29', '23:28:00', '07:00:00', 452, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4117', 20, 12386, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1134, 5, 1, '2022-05-30', '07:00:00', '11:35:00', 275, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4117', 14, 8756, 230, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1135, 5, 1, '2022-05-30', '11:35:00', '11:45:00', 10, 3629, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4117', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1136, 5, 1, '2022-05-30', '11:45:00', '13:04:00', 79, 3625, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4117', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1137, 5, 1, '2022-05-30', '13:04:00', '13:12:00', 8, 3642, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4118', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1138, 5, 1, '2022-05-30', '13:12:00', '13:16:00', 4, 3641, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4118', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1139, 5, 1, '2022-05-30', '13:16:00', '13:26:00', 10, 3630, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4118', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1140, 5, 1, '2022-05-30', '13:26:00', '15:00:00', 94, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4118', 3, 1952, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1141, 5, 2, '2022-05-30', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4118', 28, 18219, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1142, 5, 3, '2022-05-30', '23:00:00', '00:16:00', 76, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4118', 6, 3913, 260, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1143, 5, 3, '2022-05-30', '00:16:00', '00:26:00', 10, 3629, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4118', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1144, 5, 3, '2022-05-30', '00:26:00', '03:00:00', 154, 3625, 'Valve 5629 blinking karena magnetnya lepas (DT 14 menit) dan valve 4202 bocor karena seal valve bagian bawah rusak 2pcs dan stoper patah (DT 61 menit)', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4118', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1145, 5, 3, '2022-05-30', '03:00:00', '03:08:00', 8, 3642, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4119', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1146, 5, 3, '2022-05-30', '03:08:00', '03:12:00', 4, 3641, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4119', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1147, 5, 3, '2022-05-30', '03:12:00', '03:22:00', 10, 3630, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4119', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1148, 5, 3, '2022-05-30', '03:22:00', '07:00:00', 218, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4119', 11, 7166, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1149, 5, 1, '2022-05-31', '07:00:00', '12:51:00', 351, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4119', 22, 14170, 50, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1150, 5, 1, '2022-05-31', '12:51:00', '13:01:00', 10, 3629, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4119', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1151, 5, 1, '2022-05-31', '13:01:00', '13:31:00', 30, 3625, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4119', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1152, 5, 1, '2022-05-31', '13:31:00', '13:39:00', 8, 3642, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-TR-117', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1153, 5, 1, '2022-05-31', '13:39:00', '13:43:00', 4, 3641, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-TR-117', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1154, 5, 1, '2022-05-31', '13:43:00', '13:53:00', 10, 3630, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-TR-117', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1155, 5, 1, '2022-05-31', '13:53:00', '15:00:00', 67, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-TR-117', 2, 1301, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1156, 5, 2, '2022-05-31', '15:00:00', '15:35:00', 35, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-TR-117', 3, 1411, 125, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1157, 5, 2, '2022-05-31', '15:35:00', '15:55:00', 20, 3631, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-TR-117', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1158, 5, 2, '2022-05-31', '15:55:00', '23:00:00', 425, 3442, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-TR-117', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1159, 5, 3, '2022-05-31', '23:00:00', '07:00:00', 480, 3441, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-TR-117', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1160, 5, 1, '2022-06-01', '07:00:00', '15:00:00', 480, 3441, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4119', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1161, 5, 2, '2022-06-01', '15:00:00', '19:30:00', 270, 3441, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4119', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1162, 5, 2, '2022-06-01', '19:30:00', '21:00:00', 90, 3646, '', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4120', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1163, 5, 2, '2022-06-01', '21:00:00', '23:00:00', 120, 3641, 'Start up drier lama karena hasil TS Compounding tank Mix 2 ketinggian', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4120', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1164, 5, 3, '2022-06-01', '23:00:00', '00:17:00', 77, 3641, 'Start up drier lama karena hasil TS Compounding tank Mix 2 ketinggian', 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4120', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1165, 5, 3, '2022-06-01', '00:17:00', '00:27:00', 10, 3630, '', 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4120', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1166, 5, 3, '2022-06-01', '00:27:00', '07:00:00', 393, 3434, '', 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4120', 18, 10420, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1167, 5, 1, '2022-06-02', '07:00:00', '15:00:00', 480, 3434, '', 'NSA/YHI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4120', 23, 13817, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1168, 5, 2, '2022-06-02', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4120', 25, 15010, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1169, 5, 3, '2022-06-02', '23:00:00', '23:07:00', 7, 3434, '', 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4120', 2, 913, 243, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1170, 5, 3, '2022-06-02', '23:07:00', '23:17:00', 10, 3629, '', 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4120', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1171, 5, 3, '2022-06-02', '23:17:00', '00:36:00', 79, 3625, '', 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4120', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1172, 5, 3, '2022-06-02', '00:36:00', '00:47:00', 11, 3643, 'Hasil TS mixing tinggi dan rasio fat dibawah standart', 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1173, 5, 3, '2022-06-02', '00:47:00', '00:51:00', 4, 3641, '', 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1174, 5, 3, '2022-06-02', '00:51:00', '01:01:00', 10, 3630, '', 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1175, 5, 3, '2022-06-02', '01:01:00', '07:00:00', 359, 3434, '', 'SMI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4121', 16, 9626, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1176, 5, 1, '2022-06-03', '07:00:00', '10:38:00', 218, 3434, '', 'NSA/YHI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4121', 13, 7473, 120, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1177, 5, 1, '2022-06-03', '10:38:00', '10:48:00', 10, 3629, '', 'NSA/YHI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1178, 5, 1, '2022-06-03', '10:48:00', '12:07:00', 79, 3625, '', 'NSA/YHI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1179, 5, 1, '2022-06-03', '12:07:00', '12:39:00', 32, 3641, 'Sholat Jum\'at', 'NSA/YHI', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4122', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1180, 5, 1, '2022-06-03', '12:39:00', '12:49:00', 10, 3630, '', 'NSA/YHI', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4122', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1181, 5, 1, '2022-06-03', '12:49:00', '15:00:00', 131, 3434, '', 'NSA/YHI', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4122', 4, 2404, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1182, 5, 2, '2022-06-03', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4122', 24, 14015, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1183, 5, 3, '2022-06-03', '23:00:00', '03:29:00', 269, 3434, '', 'SMI', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4122', 15, 8960, 240, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1184, 5, 3, '2022-06-03', '03:29:00', '03:39:00', 10, 3629, '', 'SMI', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4122', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1185, 5, 3, '2022-06-03', '03:39:00', '04:58:00', 79, 3625, '', 'SMI', 'KSD2-IACMH002', 'CHIL MIL PHP-RVT 17 BASE POWDER (KMI)', 'PD-4122', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1186, 5, 3, '2022-06-03', '04:58:00', '05:02:00', 4, 3641, '', 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4123', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1187, 5, 3, '2022-06-03', '05:02:00', '05:12:00', 10, 3630, '', 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4123', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1188, 5, 3, '2022-06-03', '05:12:00', '07:00:00', 108, 3434, '', 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4123', 3, 1801, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1189, 5, 1, '2022-06-04', '07:00:00', '13:35:00', 395, 3434, '', 'YHI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4123', 19, 11410, 375, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1190, 5, 1, '2022-06-04', '13:35:00', '13:45:00', 10, 3629, '', 'YHI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4123', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1191, 5, 1, '2022-06-04', '13:45:00', '15:00:00', 75, 3625, '', 'YHI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4123', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1192, 5, 2, '2022-06-04', '15:00:00', '15:04:00', 4, 3625, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4123', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1193, 5, 2, '2022-06-04', '15:04:00', '15:08:00', 4, 3641, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4124', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1194, 5, 2, '2022-06-04', '15:08:00', '15:18:00', 10, 3630, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4124', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1195, 5, 2, '2022-06-04', '15:18:00', '23:00:00', 462, 3434, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4124', 19, 11408, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1196, 5, 3, '2022-06-04', '23:00:00', '00:05:00', 65, 3434, '', 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4124', 5, 2738, 195, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1197, 5, 3, '2022-06-04', '00:05:00', '00:25:00', 20, 3631, '', 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4124', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1198, 5, 3, '2022-06-04', '00:25:00', '07:00:00', 395, 3441, '', 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4124', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1199, 5, 1, '2022-06-05', '07:00:00', '15:00:00', 480, 3441, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4124', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1200, 5, 2, '2022-06-05', '15:00:00', '16:25:00', 85, 3441, '', 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4124', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1201, 5, 2, '2022-06-05', '16:25:00', '21:00:00', 275, 3632, 'Cleaning area', 'SMI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4124', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `oee_drier` (`id`, `line_id`, `shift_id`, `tanggal`, `start`, `finish`, `lamakejadian`, `activity_id`, `remark`, `operator`, `produk_code`, `produk`, `okp_drier`, `output_bin`, `output_kg`, `rework`, `category_rework`, `reject`, `waiting_tech`, `tech_name`, `repair_problem`, `trial_time`, `bas_com`, `category_br`, `category_ampm`, `jumlah_manpower`) VALUES
(1202, 5, 2, '2022-06-05', '21:00:00', '23:00:00', 120, 3646, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4125', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1203, 5, 3, '2022-06-05', '23:00:00', '00:23:00', 83, 3632, 'Check-check mesin drier', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4125', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1204, 5, 3, '2022-06-05', '00:23:00', '01:23:00', 60, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4125', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1205, 5, 3, '2022-06-05', '01:23:00', '01:33:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4125', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1206, 5, 3, '2022-06-05', '01:33:00', '07:00:00', 327, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4125', 14, 9108, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1207, 5, 1, '2022-06-06', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4125', 24, 15163, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1208, 5, 2, '2022-06-06', '15:00:00', '23:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4125', 24, 15638, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1209, 5, 3, '2022-06-06', '23:00:00', '03:14:00', 254, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4125', 14, 8758, 270, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1210, 5, 3, '2022-06-06', '03:14:00', '03:24:00', 10, 3629, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4125', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1211, 5, 3, '2022-06-06', '03:24:00', '04:43:00', 79, 3625, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4125', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1212, 5, 3, '2022-06-06', '04:43:00', '04:51:00', 8, 3642, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4126', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1213, 5, 3, '2022-06-06', '04:51:00', '04:55:00', 4, 3641, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4126', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1214, 5, 3, '2022-06-06', '04:55:00', '05:05:00', 10, 3630, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4126', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1215, 5, 3, '2022-06-06', '05:05:00', '07:00:00', 115, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4126', 3, 2102, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1216, 5, 1, '2022-06-07', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4126', 21, 14713, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1217, 5, 2, '2022-06-07', '15:00:00', '23:00:00', 480, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4126', 21, 14733, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1218, 5, 3, '2022-06-07', '23:00:00', '04:11:00', 311, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4126', 15, 10011, 320, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1219, 5, 3, '2022-06-07', '04:11:00', '04:21:00', 10, 3629, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4126', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1220, 5, 3, '2022-06-07', '04:21:00', '05:40:00', 79, 3625, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4126', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1221, 5, 3, '2022-06-07', '05:40:00', '05:48:00', 8, 3642, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4127', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1222, 5, 3, '2022-06-07', '05:48:00', '05:52:00', 4, 3641, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4127', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1223, 5, 3, '2022-06-07', '05:52:00', '06:02:00', 10, 3630, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4127', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1224, 5, 3, '2022-06-07', '06:02:00', '07:00:00', 58, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4127', 1, 701, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1225, 5, 1, '2022-06-08', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4127', 24, 16813, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1226, 5, 2, '2022-06-08', '15:00:00', '16:27:00', 87, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4127', 15, 10518, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1227, 5, 2, '2022-06-08', '16:27:00', '18:39:00', 132, 3548, 'EFB NGEBLOK', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4127', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1228, 5, 2, '2022-06-08', '18:39:00', '23:00:00', 261, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4127', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1229, 5, 3, '2022-06-08', '23:00:00', '05:22:00', 382, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4127', 20, 13969, 955, NULL, 25, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1230, 5, 3, '2022-06-08', '05:22:00', '05:32:00', 10, 3629, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4127', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1231, 5, 3, '2022-06-08', '05:32:00', '06:51:00', 79, 3625, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4127', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1232, 5, 3, '2022-06-08', '06:51:00', '06:59:00', 8, 3642, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4128', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1233, 5, 3, '2022-06-08', '06:59:00', '07:00:00', 1, 3641, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4128', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1234, 5, 1, '2022-06-09', '07:00:00', '07:03:00', 3, 3641, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4128', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1235, 5, 1, '2022-06-09', '07:03:00', '07:13:00', 10, 3630, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4128', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1236, 5, 1, '2022-06-09', '07:13:00', '15:00:00', 467, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4128', 24, 15164, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1237, 5, 2, '2022-06-09', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4128', 30, 18641, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1238, 5, 3, '2022-06-09', '23:00:00', '00:51:00', 111, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4128', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1239, 5, 3, '2022-06-09', '00:51:00', '02:21:00', 90, 3493, 'problem safety valve', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4128', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1240, 5, 3, '2022-06-09', '02:21:00', '06:15:00', 234, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4128', 21, 13004, 330, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1241, 5, 3, '2022-06-09', '06:15:00', '06:25:00', 10, 3629, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4128', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1242, 5, 3, '2022-06-09', '06:25:00', '07:00:00', 35, 3625, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4128', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1243, 5, 1, '2022-06-10', '07:00:00', '07:42:00', 42, 3625, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4128', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1244, 5, 1, '2022-06-10', '07:42:00', '07:50:00', 8, 3642, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4129', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1245, 5, 1, '2022-06-10', '07:50:00', '07:54:00', 4, 3641, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4129', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1246, 5, 1, '2022-06-10', '07:54:00', '08:04:00', 10, 3630, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4129', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1247, 5, 1, '2022-06-10', '08:04:00', '15:00:00', 416, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4129', 16, 10809, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1248, 5, 2, '2022-06-10', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4129', 20, 14029, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1249, 5, 3, '2022-06-10', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4129', 20, 14011, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1250, 5, 1, '2022-06-11', '07:00:00', '07:36:00', 36, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4129', 3, 2115, 470, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1251, 5, 1, '2022-06-11', '07:36:00', '07:46:00', 10, 3629, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4129', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1252, 5, 1, '2022-06-11', '07:46:00', '09:05:00', 79, 3625, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4129', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1253, 5, 1, '2022-06-11', '09:05:00', '10:25:00', 80, 3642, 'Perbaikan ganti seal HPP no 3, ngerok baling2 exhaust lt 5, perbaikan wear EFB inlet patah', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4130', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1254, 5, 1, '2022-06-11', '10:25:00', '10:29:00', 4, 3641, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4130', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1255, 5, 1, '2022-06-11', '10:29:00', '10:39:00', 10, 3630, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4130', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1256, 5, 1, '2022-06-11', '10:39:00', '15:00:00', 261, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4130', 11, 7158, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1257, 5, 2, '2022-06-11', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4130', 23, 14985, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1258, 5, 3, '2022-06-11', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4130', 21, 13666, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1259, 5, 1, '2022-06-12', '07:00:00', '14:13:00', 433, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4130', 19, 12369, 220, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1260, 5, 1, '2022-06-12', '14:13:00', '14:23:00', 10, 3629, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4130', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1261, 5, 1, '2022-06-12', '14:23:00', '15:00:00', 37, 3625, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4130', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1262, 5, 2, '2022-06-12', '15:00:00', '15:42:00', 42, 3625, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4130', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1263, 5, 2, '2022-06-12', '15:42:00', '15:50:00', 8, 3642, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4131', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1264, 5, 2, '2022-06-12', '15:50:00', '15:54:00', 4, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4131', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1265, 5, 2, '2022-06-12', '15:54:00', '16:04:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4131', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1266, 5, 2, '2022-06-12', '16:04:00', '23:00:00', 416, 3434, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4131', 17, 11511, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1267, 5, 3, '2022-06-12', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4131', 22, 15413, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1268, 5, 1, '2022-06-13', '07:00:00', '14:16:00', 436, 3434, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4131', 22, 14877, 130, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1269, 5, 1, '2022-06-13', '14:16:00', '14:36:00', 20, 3631, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4131', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1270, 5, 1, '2022-06-13', '14:36:00', '15:00:00', 24, 3441, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4131', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1271, 5, 2, '2022-06-13', '15:00:00', '23:00:00', 480, 3441, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4131', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1272, 5, 3, '2022-06-13', '23:00:00', '07:00:00', 480, 3441, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4131', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1273, 5, 1, '2022-06-14', '07:00:00', '07:20:00', 20, 3441, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4131', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1274, 5, 1, '2022-06-14', '07:20:00', '09:20:00', 120, 3646, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4132', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1275, 5, 1, '2022-06-14', '09:20:00', '10:48:00', 88, 3641, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4132', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1276, 5, 1, '2022-06-14', '10:48:00', '15:00:00', 252, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4132', 10, 6517, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1277, 5, 2, '2022-06-14', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4132', 23, 14963, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1278, 5, 3, '2022-06-14', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4132', 23, 14966, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1279, 5, 1, '2022-06-15', '07:00:00', '13:35:00', 395, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4132', 19, 12092, 150, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1280, 5, 1, '2022-06-15', '13:35:00', '13:45:00', 10, 3629, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4132', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1281, 5, 1, '2022-06-15', '13:45:00', '15:00:00', 75, 3625, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4132', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1282, 5, 2, '2022-06-15', '15:00:00', '15:04:00', 4, 3625, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4132', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1283, 5, 2, '2022-06-15', '15:04:00', '15:12:00', 8, 3642, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4133', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1284, 5, 2, '2022-06-15', '15:12:00', '15:16:00', 4, 3641, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4133', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1285, 5, 2, '2022-06-15', '15:16:00', '15:26:00', 10, 3630, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4133', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1286, 5, 2, '2022-06-15', '15:26:00', '23:00:00', 454, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4133', 21, 14724, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1287, 5, 3, '2022-06-15', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4133', 24, 16834, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1288, 5, 1, '2022-06-16', '07:00:00', '11:32:00', 272, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4133', 16, 11230, 90, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1289, 5, 1, '2022-06-16', '11:32:00', '11:42:00', 10, 3629, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4133', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1290, 5, 1, '2022-06-16', '11:42:00', '13:01:00', 79, 3625, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4133', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1291, 5, 1, '2022-06-16', '13:01:00', '13:09:00', 8, 3642, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4134', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1292, 5, 1, '2022-06-16', '13:09:00', '13:13:00', 4, 3641, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4134', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1293, 5, 1, '2022-06-16', '13:13:00', '13:23:00', 10, 3630, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4134', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1294, 5, 1, '2022-06-16', '13:23:00', '15:00:00', 97, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4134', 3, 1953, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1295, 5, 2, '2022-06-16', '15:00:00', '20:43:00', 343, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4134', 20, 12401, 330, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1296, 5, 2, '2022-06-16', '20:43:00', '20:53:00', 10, 3629, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4134', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1297, 5, 2, '2022-06-16', '20:53:00', '22:46:00', 113, 3593, 'Valve V.5629 blinking/tidak bisa buka tutup.di bongkar ternyata seal nya melejit', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4134', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1298, 5, 2, '2022-06-16', '22:46:00', '23:00:00', 14, 3625, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4134', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1299, 5, 3, '2022-06-16', '23:00:00', '00:05:00', 65, 3625, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4134', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1300, 5, 3, '2022-06-16', '00:05:00', '00:13:00', 8, 3642, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4135', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1301, 5, 3, '2022-06-16', '00:13:00', '00:17:00', 4, 3641, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4135', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1302, 5, 3, '2022-06-16', '00:17:00', '00:27:00', 10, 3630, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4135', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1303, 5, 3, '2022-06-16', '00:27:00', '07:00:00', 393, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4135', 18, 12108, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1304, 5, 1, '2022-06-17', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4135', 25, 17532, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1305, 5, 2, '2022-06-17', '15:00:00', '17:30:00', 150, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4135', 9, 6095, 150, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1306, 5, 2, '2022-06-17', '17:30:00', '17:40:00', 10, 3629, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4135', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1307, 5, 2, '2022-06-17', '17:40:00', '18:59:00', 79, 3625, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4135', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1308, 5, 2, '2022-06-17', '18:59:00', '19:07:00', 8, 3642, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4136', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1309, 5, 2, '2022-06-17', '19:07:00', '19:11:00', 4, 3641, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4136', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1310, 5, 2, '2022-06-17', '19:11:00', '19:21:00', 10, 3630, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4136', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1311, 5, 2, '2022-06-17', '19:21:00', '23:00:00', 219, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4136', 8, 5605, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1312, 5, 3, '2022-06-17', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4136', 18, 12611, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1313, 5, 1, '2022-06-18', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4136', 20, 14017, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1314, 5, 2, '2022-06-18', '15:00:00', '19:03:00', 243, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4136', 12, 8408, 550, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1315, 5, 2, '2022-06-18', '19:03:00', '19:13:00', 10, 3629, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4136', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1316, 5, 2, '2022-06-18', '19:13:00', '20:32:00', 79, 3625, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4136', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1317, 5, 2, '2022-06-18', '20:32:00', '20:40:00', 8, 3642, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4137', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1318, 5, 2, '2022-06-18', '20:40:00', '20:44:00', 4, 3641, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4137', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1319, 5, 2, '2022-06-18', '20:44:00', '20:54:00', 10, 3630, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4137', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1320, 5, 2, '2022-06-18', '20:54:00', '23:00:00', 126, 3434, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4137', 4, 2802, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1321, 5, 3, '2022-06-18', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4137', 23, 16109, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1322, 5, 1, '2022-06-19', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4137', 23, 16111, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1323, 5, 2, '2022-06-19', '15:00:00', '16:08:00', 68, 3434, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4137', 5, 3369, 270, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1324, 5, 2, '2022-06-19', '16:08:00', '16:18:00', 10, 3629, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4137', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1325, 5, 2, '2022-06-19', '16:18:00', '17:37:00', 79, 3625, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4137', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1326, 5, 2, '2022-06-19', '17:37:00', '17:45:00', 8, 3642, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4138', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1327, 5, 2, '2022-06-19', '17:45:00', '17:49:00', 4, 3641, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4138', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1328, 5, 2, '2022-06-19', '17:49:00', '17:59:00', 10, 3630, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4138', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1329, 5, 2, '2022-06-19', '17:59:00', '23:00:00', 301, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4138', 12, 8407, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1330, 5, 3, '2022-06-19', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4138', 24, 16837, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1331, 5, 1, '2022-06-20', '07:00:00', '14:30:00', 450, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4138', 24, 16313, 320, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1332, 5, 1, '2022-06-20', '14:30:00', '14:40:00', 10, 3629, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4138', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1333, 5, 1, '2022-06-20', '14:40:00', '15:00:00', 20, 3625, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4138', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1334, 5, 2, '2022-06-20', '15:00:00', '15:59:00', 59, 3625, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4138', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1335, 5, 2, '2022-06-20', '15:59:00', '16:07:00', 8, 3642, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4139', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1336, 5, 2, '2022-06-20', '16:07:00', '16:11:00', 4, 3641, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4139', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1337, 5, 2, '2022-06-20', '16:11:00', '16:21:00', 10, 3630, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4139', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1338, 5, 2, '2022-06-20', '16:21:00', '23:00:00', 399, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4139', 20, 13007, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1339, 5, 3, '2022-06-20', '23:00:00', '03:34:00', 274, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4139', 17, 11052, 265, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1340, 5, 3, '2022-06-20', '03:34:00', '03:44:00', 10, 3629, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4139', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1341, 5, 3, '2022-06-20', '03:44:00', '05:03:00', 79, 3625, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4139', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1342, 5, 3, '2022-06-20', '05:03:00', '05:11:00', 8, 3642, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1343, 5, 3, '2022-06-20', '05:11:00', '05:15:00', 4, 3641, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1344, 5, 3, '2022-06-20', '05:15:00', '05:25:00', 10, 3630, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1345, 5, 3, '2022-06-20', '05:25:00', '07:00:00', 95, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 3, 2102, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1346, 5, 1, '2022-06-21', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 23, 16110, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1347, 5, 2, '2022-06-21', '15:00:00', '17:25:00', 145, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 9, 5962, 120, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1348, 5, 2, '2022-06-21', '17:25:00', '17:45:00', 20, 3631, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1349, 5, 2, '2022-06-21', '17:45:00', '23:00:00', 315, 3441, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1350, 5, 3, '2022-06-21', '23:00:00', '07:00:00', 480, 3441, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1351, 5, 1, '2022-06-22', '07:00:00', '15:00:00', 480, 3442, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1352, 5, 2, '2022-06-22', '15:00:00', '23:00:00', 480, 3442, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1353, 5, 3, '2022-06-22', '23:00:00', '07:00:00', 480, 3441, 'Project support hammer lt 2 dan 3 drier', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1354, 5, 1, '2022-06-23', '07:00:00', '13:30:00', 390, 3441, 'Cleaning after Project support hammer lt 2 dan 3 drier', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1355, 5, 1, '2022-06-23', '13:30:00', '15:00:00', 90, 3646, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4140', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1356, 5, 2, '2022-06-23', '15:00:00', '16:49:00', 109, 3641, 'Drying out awal minggu', 'NHS', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4141', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1357, 5, 2, '2022-06-23', '16:49:00', '16:59:00', 10, 3630, 'Start up lama karena ada pengelasan dulu steam trap EFB cooling sebelum jalan', 'NHS', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4141', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1358, 5, 2, '2022-06-23', '16:59:00', '23:00:00', 361, 3434, '', 'NHS', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4141', 19, 9209, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1359, 5, 3, '2022-06-23', '23:00:00', '07:00:00', 480, 3434, '', 'SMI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4141', 29, 14558, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1360, 5, 1, '2022-06-24', '07:00:00', '07:35:00', 35, 3434, '', 'SMI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4141', 4, 1820, 505, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1361, 5, 1, '2022-06-24', '07:35:00', '07:45:00', 10, 3629, '', 'SMI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4141', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1362, 5, 1, '2022-06-24', '07:45:00', '09:04:00', 79, 3625, '', 'SMI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4141', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1363, 5, 1, '2022-06-24', '09:04:00', '09:08:00', 4, 3641, '', 'YHI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4142', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1364, 5, 1, '2022-06-24', '09:08:00', '09:18:00', 10, 3630, '', 'YHI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4142', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1365, 5, 1, '2022-06-24', '09:18:00', '15:00:00', 342, 3434, '', 'YHI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4142', 17, 8508, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1366, 5, 2, '2022-06-24', '15:00:00', '22:42:00', 462, 3434, '', 'NHS', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4142', 29, 14512, 210, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1367, 5, 2, '2022-06-24', '22:42:00', '22:52:00', 10, 3629, '', 'NHS', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4142', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1368, 5, 2, '2022-06-24', '22:52:00', '23:00:00', 8, 3625, '', 'NHS', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4142', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1369, 5, 3, '2022-06-24', '23:00:00', '00:11:00', 71, 3625, '', 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4142', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1370, 5, 3, '2022-06-24', '00:11:00', '00:15:00', 4, 3641, '', 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4143', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1371, 5, 3, '2022-06-24', '00:15:00', '00:25:00', 10, 3630, '', 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4143', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1372, 5, 3, '2022-06-24', '00:25:00', '07:00:00', 395, 3434, '', 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4143', 20, 10043, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1373, 5, 1, '2022-06-25', '07:00:00', '07:18:00', 18, 3434, '', 'YHI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4143', 3, 1246, 240, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1374, 5, 1, '2022-06-25', '07:18:00', '15:00:00', 462, 3441, '', 'YHI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4143', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1375, 5, 2, '2022-06-25', '15:00:00', '23:00:00', 480, 3441, 'Project support hammer lt 2 dan 3 drier oeh team mecco', 'NHS', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4143', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1376, 5, 3, '2022-06-25', '23:00:00', '07:00:00', 480, 3441, '', 'SMI', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4143', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1377, 5, 1, '2022-06-26', '07:00:00', '15:00:00', 480, 3441, '', 'NHS', 'KSD2-IABSO001-R1', 'BMT SOYA BASE POWDER (KMI)', 'PD-4143', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1378, 5, 2, '2022-06-26', '15:00:00', '16:30:00', 90, 3646, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4144', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1379, 5, 2, '2022-06-26', '16:30:00', '17:48:00', 78, 3642, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4144', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1380, 5, 2, '2022-06-26', '17:48:00', '17:52:00', 4, 3641, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4144', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1381, 5, 2, '2022-06-26', '17:52:00', '18:02:00', 10, 3630, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4144', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1382, 5, 2, '2022-06-26', '18:02:00', '23:00:00', 298, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4144', 12, 7820, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1383, 5, 3, '2022-06-26', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4144', 25, 16265, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1384, 5, 1, '2022-06-27', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4144', 23, 14965, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1385, 5, 2, '2022-06-27', '15:00:00', '16:38:00', 98, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4144', 6, 3821, 200, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1386, 5, 2, '2022-06-27', '16:38:00', '16:48:00', 10, 3629, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4144', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1387, 5, 2, '2022-06-27', '16:48:00', '18:07:00', 79, 3625, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4144', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1388, 5, 2, '2022-06-27', '18:07:00', '18:24:00', 17, 3662, '2 mix awal full porses robot, transfer nunggu 2 mix selesai', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4145', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1389, 5, 2, '2022-06-27', '18:24:00', '18:32:00', 8, 3642, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4145', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1390, 5, 2, '2022-06-27', '18:32:00', '18:36:00', 4, 3641, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4145', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1391, 5, 2, '2022-06-27', '18:36:00', '18:46:00', 10, 3630, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4145', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1392, 5, 2, '2022-06-27', '18:46:00', '23:00:00', 254, 3434, '', 'SMI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4145', 9, 6308, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1393, 5, 3, '2022-06-27', '23:00:00', '06:01:00', 421, 3434, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4145', 21, 14403, 315, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1394, 5, 3, '2022-06-27', '06:01:00', '06:11:00', 10, 3629, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4145', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1395, 5, 3, '2022-06-27', '06:11:00', '07:00:00', 49, 3625, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4145', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1396, 5, 1, '2022-06-28', '07:00:00', '07:30:00', 30, 3625, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4145', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1397, 5, 1, '2022-06-28', '07:30:00', '09:25:00', 115, 3642, 'Problem valve (V7106) Conc.tank evap tidak mau buka (seret) ', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4146', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1398, 5, 1, '2022-06-28', '09:25:00', '09:29:00', 4, 3641, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4146', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1399, 5, 1, '2022-06-28', '09:29:00', '09:39:00', 10, 3630, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4146', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1400, 5, 1, '2022-06-28', '09:39:00', '14:12:00', 273, 3434, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4146', 13, 8595, 550, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1401, 5, 1, '2022-06-28', '14:12:00', '14:22:00', 10, 3629, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4146', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1402, 5, 1, '2022-06-28', '14:22:00', '15:00:00', 38, 3625, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4146', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1403, 5, 2, '2022-06-28', '15:00:00', '15:41:00', 41, 3625, '', 'SMI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4146', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1404, 5, 2, '2022-06-28', '15:41:00', '15:49:00', 8, 3642, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4147', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1405, 5, 2, '2022-06-28', '15:49:00', '15:53:00', 4, 3641, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4147', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1406, 5, 2, '2022-06-28', '15:53:00', '16:03:00', 10, 3630, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4147', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1407, 5, 2, '2022-06-28', '16:03:00', '23:00:00', 417, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4147', 18, 12625, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1408, 5, 3, '2022-06-28', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4147', 24, 16812, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1409, 5, 1, '2022-06-29', '07:00:00', '12:17:00', 317, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4147', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1410, 5, 1, '2022-06-29', '12:17:00', '12:27:00', 10, 3629, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4147', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1411, 5, 1, '2022-06-29', '12:27:00', '13:46:00', 79, 3625, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4147', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1412, 5, 1, '2022-06-29', '13:46:00', '14:11:00', 25, 3642, 'Problem valve (V7206) Conc.tank evap tidak mau buka (seret) ', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4148', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1413, 5, 1, '2022-06-29', '14:11:00', '14:15:00', 4, 3641, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4148', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1414, 5, 1, '2022-06-29', '14:15:00', '14:25:00', 10, 3630, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4148', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1415, 5, 1, '2022-06-29', '14:25:00', '15:00:00', 35, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4148', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1416, 5, 2, '2022-06-29', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4148', 23, 16138, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1417, 5, 3, '2022-06-29', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4148', 23, 16111, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1418, 5, 1, '2022-06-30', '07:00:00', '10:56:00', 236, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4148', 14, 9679, 240, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1419, 5, 1, '2022-06-30', '10:56:00', '11:06:00', 10, 3629, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4148', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1420, 5, 1, '2022-06-30', '11:06:00', '12:25:00', 79, 3625, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4148', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1421, 5, 1, '2022-06-30', '12:25:00', '12:33:00', 8, 3642, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4149', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1422, 5, 1, '2022-06-30', '12:33:00', '12:37:00', 4, 3641, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4149', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1423, 5, 1, '2022-06-30', '12:37:00', '12:47:00', 10, 3630, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4149', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1424, 5, 1, '2022-06-30', '12:47:00', '15:00:00', 133, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4149', 4, 2802, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1425, 5, 2, '2022-06-30', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4149', 22, 14839, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1426, 5, 3, '2022-06-30', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4149', 21, 14714, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1427, 5, 1, '2022-07-01', '07:00:00', '12:05:00', 305, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4149', 14, 9801, 480, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1428, 5, 1, '2022-07-01', '12:05:00', '12:15:00', 10, 3629, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4149', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1429, 5, 1, '2022-07-01', '12:15:00', '13:34:00', 79, 3625, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4149', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1430, 5, 1, '2022-07-01', '13:34:00', '13:42:00', 8, 3642, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4150', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1431, 5, 1, '2022-07-01', '13:42:00', '13:46:00', 4, 3641, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4150', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1432, 5, 1, '2022-07-01', '13:46:00', '13:56:00', 10, 3630, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4150', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1433, 5, 1, '2022-07-01', '13:56:00', '15:00:00', 64, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4150', 1, 650, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1434, 5, 2, '2022-07-01', '15:00:00', '23:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4150', 23, 14990, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1435, 5, 3, '2022-07-01', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4150', 23, 14965, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1436, 5, 1, '2022-07-02', '07:00:00', '12:48:00', 348, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4150', 18, 11714, 125, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1437, 5, 1, '2022-07-02', '12:48:00', '13:08:00', 20, 3631, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4150', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1438, 5, 1, '2022-07-02', '13:08:00', '15:00:00', 112, 3441, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4150', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1439, 5, 2, '2022-07-02', '15:00:00', '23:00:00', 480, 3441, '', 'SMI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4150', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `oee_drier` (`id`, `line_id`, `shift_id`, `tanggal`, `start`, `finish`, `lamakejadian`, `activity_id`, `remark`, `operator`, `produk_code`, `produk`, `okp_drier`, `output_bin`, `output_kg`, `rework`, `category_rework`, `reject`, `waiting_tech`, `tech_name`, `repair_problem`, `trial_time`, `bas_com`, `category_br`, `category_ampm`, `jumlah_manpower`) VALUES
(1440, 5, 3, '2022-07-02', '23:00:00', '06:00:00', 420, 3441, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4150', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1441, 5, 3, '2022-07-02', '06:00:00', '07:00:00', 60, 3646, 'Dryingout awal pekan', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4151', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1442, 5, 1, '2022-07-03', '07:00:00', '08:00:00', 60, 3646, 'Dryingout awal pekan', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4151', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1443, 5, 1, '2022-07-03', '08:00:00', '09:40:00', 100, 3642, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4151', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1444, 5, 1, '2022-07-03', '09:40:00', '09:44:00', 4, 3641, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4151', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1445, 5, 1, '2022-07-03', '09:44:00', '09:54:00', 10, 3630, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4151', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1446, 5, 1, '2022-07-03', '09:54:00', '15:00:00', 306, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4151', 14, 9122, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1447, 5, 2, '2022-07-03', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4151', 27, 17574, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1448, 5, 3, '2022-07-03', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4151', 27, 17572, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1449, 5, 1, '2022-07-04', '07:00:00', '09:12:00', 132, 3434, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4151', 9, 5614, 230, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1450, 5, 1, '2022-07-04', '09:12:00', '09:22:00', 10, 3629, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4151', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1451, 5, 1, '2022-07-04', '09:22:00', '10:41:00', 79, 3625, '', 'SMI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4151', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1452, 5, 1, '2022-07-04', '10:41:00', '10:56:00', 15, 3662, 'Start batching telat', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4152', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1453, 5, 1, '2022-07-04', '10:56:00', '11:04:00', 8, 3642, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4152', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1454, 5, 1, '2022-07-04', '11:04:00', '11:08:00', 4, 3641, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4152', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1455, 5, 1, '2022-07-04', '11:08:00', '11:18:00', 10, 3630, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4152', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1456, 5, 1, '2022-07-04', '11:18:00', '15:00:00', 222, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4152', 8, 5615, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1457, 5, 2, '2022-07-04', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4152', 20, 14010, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1458, 5, 3, '2022-07-04', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4152', 20, 14012, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1459, 5, 1, '2022-07-05', '07:00:00', '09:54:00', 174, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4152', 10, 6517, 295, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1460, 5, 1, '2022-07-05', '09:54:00', '10:04:00', 10, 3629, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4152', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1461, 5, 1, '2022-07-05', '10:04:00', '11:23:00', 79, 3625, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4152', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1462, 5, 1, '2022-07-05', '11:23:00', '11:31:00', 8, 3642, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4153', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1463, 5, 1, '2022-07-05', '11:31:00', '11:35:00', 4, 3641, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4153', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1464, 5, 1, '2022-07-05', '11:35:00', '11:45:00', 10, 3630, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4153', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1465, 5, 1, '2022-07-05', '11:45:00', '15:00:00', 195, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4153', 7, 4920, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1466, 5, 2, '2022-07-05', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4153', 23, 16113, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1467, 5, 3, '2022-07-05', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4153', 24, 16820, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1468, 5, 1, '2022-07-06', '07:00:00', '08:24:00', 84, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4153', 5, 3510, 330, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1469, 5, 1, '2022-07-06', '08:24:00', '08:34:00', 10, 3629, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4153', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1470, 5, 1, '2022-07-06', '08:34:00', '09:53:00', 79, 3625, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4153', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1471, 5, 1, '2022-07-06', '09:53:00', '10:01:00', 8, 3642, '', 'SMI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4154', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1472, 5, 1, '2022-07-06', '10:01:00', '10:05:00', 4, 3641, '', 'SMI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4154', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1473, 5, 1, '2022-07-06', '10:05:00', '10:15:00', 10, 3630, '', 'SMI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4154', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1474, 5, 1, '2022-07-06', '10:15:00', '15:00:00', 285, 3434, '', 'SMI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4154', 12, 8024, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1475, 5, 2, '2022-07-06', '15:00:00', '22:34:00', 454, 3434, '', 'NSA', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4154', 22, 15118, 490, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1476, 5, 2, '2022-07-06', '22:34:00', '22:44:00', 10, 3629, '', 'NSA', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4154', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1477, 5, 2, '2022-07-06', '22:44:00', '23:00:00', 16, 3625, '', 'NSA', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4154', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1478, 5, 3, '2022-07-06', '23:00:00', '00:03:00', 63, 3625, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4154', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1479, 5, 3, '2022-07-06', '00:03:00', '00:11:00', 8, 3642, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4155', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1480, 5, 3, '2022-07-06', '00:11:00', '00:15:00', 4, 3641, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4155', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1481, 5, 3, '2022-07-06', '00:15:00', '00:25:00', 10, 3630, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4155', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1482, 5, 3, '2022-07-06', '00:25:00', '07:00:00', 395, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4155', 20, 12567, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1483, 5, 1, '2022-07-07', '07:00:00', '10:27:00', 207, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4155', 13, 8382, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1484, 5, 1, '2022-07-07', '10:27:00', '10:37:00', 10, 3629, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4155', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1485, 5, 1, '2022-07-07', '10:37:00', '11:56:00', 79, 3625, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4155', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1486, 5, 1, '2022-07-07', '11:56:00', '12:04:00', 8, 3642, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4156', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1487, 5, 1, '2022-07-07', '12:04:00', '12:08:00', 4, 3641, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4156', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1488, 5, 1, '2022-07-07', '12:08:00', '12:18:00', 10, 3630, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4156', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1489, 5, 1, '2022-07-07', '12:18:00', '13:00:00', 42, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4156', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1490, 5, 1, '2022-07-07', '13:00:00', '14:37:00', 97, 3652, 'Suhu ice water tinggi, problem elektrikal motor alarm', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4156', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1491, 5, 1, '2022-07-07', '14:37:00', '15:00:00', 23, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4156', 6, 490, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1492, 5, 2, '2022-07-07', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4156', 19, 13310, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1493, 5, 3, '2022-07-07', '23:00:00', '00:10:00', 70, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4156', 5, 3351, 385, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1494, 5, 3, '2022-07-07', '00:10:00', '00:20:00', 10, 3629, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4156', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1495, 5, 3, '2022-07-07', '00:20:00', '01:39:00', 79, 3625, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4156', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1496, 5, 3, '2022-07-07', '01:39:00', '01:47:00', 8, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4157', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1497, 5, 3, '2022-07-07', '01:47:00', '01:51:00', 4, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4157', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1498, 5, 3, '2022-07-07', '01:51:00', '02:01:00', 10, 3630, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4157', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1499, 5, 3, '2022-07-07', '02:01:00', '07:00:00', 299, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4157', 13, 8453, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1500, 5, 1, '2022-07-08', '07:00:00', '14:14:00', 434, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4157', 24, 15626, 210, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1501, 5, 1, '2022-07-08', '14:14:00', '14:24:00', 10, 3629, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4157', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1502, 5, 1, '2022-07-08', '14:24:00', '15:00:00', 36, 3625, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4157', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1503, 5, 2, '2022-07-08', '15:00:00', '15:43:00', 43, 3625, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4157', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1504, 5, 2, '2022-07-08', '15:43:00', '15:58:00', 15, 3642, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4158', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1505, 5, 2, '2022-07-08', '15:58:00', '16:02:00', 4, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4158', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1506, 5, 2, '2022-07-08', '16:02:00', '16:12:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4158', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1507, 5, 2, '2022-07-08', '16:12:00', '23:00:00', 408, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4158', 18, 11710, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1508, 5, 3, '2022-07-08', '23:00:00', '06:08:00', 428, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4158', 25, 15756, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1509, 5, 3, '2022-07-08', '06:08:00', '06:18:00', 10, 3629, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4158', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1510, 5, 3, '2022-07-08', '06:18:00', '07:00:00', 42, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4158', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1511, 5, 1, '2022-07-09', '07:00:00', '07:37:00', 37, 3625, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4158', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1512, 5, 1, '2022-07-09', '07:37:00', '07:45:00', 8, 3642, '', 'YHI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4159', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1513, 5, 1, '2022-07-09', '07:45:00', '07:49:00', 4, 3641, '', 'YHI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4159', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1514, 5, 1, '2022-07-09', '07:49:00', '07:59:00', 10, 3630, '', 'YHI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4159', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1515, 5, 1, '2022-07-09', '07:59:00', '15:00:00', 421, 3434, '', 'YHI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4159', 17, 11897, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1516, 5, 2, '2022-07-09', '15:00:00', '20:22:00', 322, 3434, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4159', 16, 11207, 355, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1517, 5, 2, '2022-07-09', '20:22:00', '20:32:00', 10, 3629, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4159', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1518, 5, 2, '2022-07-09', '20:32:00', '21:51:00', 79, 3625, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4159', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1519, 5, 2, '2022-07-09', '21:51:00', '23:00:00', 69, 3435, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4159', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1520, 5, 3, '2022-07-09', '23:00:00', '07:00:00', 480, 3435, 'ganti filter air intake', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4159', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1521, 5, 1, '2022-07-10', '07:00:00', '15:00:00', 480, 3435, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4159', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1522, 5, 2, '2022-07-10', '15:00:00', '23:00:00', 480, 3441, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4159', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1523, 5, 3, '2022-07-10', '23:00:00', '07:00:00', 480, 3441, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4159', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1524, 5, 1, '2022-07-11', '07:00:00', '09:00:00', 120, 3646, '', 'YHI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4160', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1525, 5, 1, '2022-07-11', '09:00:00', '10:22:00', 82, 3641, '', 'YHI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4160', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1526, 5, 1, '2022-07-11', '10:22:00', '10:32:00', 10, 3630, '', 'YHI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4160', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1527, 5, 1, '2022-07-11', '10:32:00', '15:00:00', 268, 3434, '', 'YHI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4160', 9, 5107, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1528, 5, 2, '2022-07-11', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4160', 22, 15412, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1529, 5, 3, '2022-07-11', '23:00:00', '06:44:00', 464, 3434, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4160', 23, 16098, 730, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1530, 5, 3, '2022-07-11', '06:44:00', '06:54:00', 10, 3629, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4160', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1531, 5, 3, '2022-07-11', '06:54:00', '07:00:00', 6, 3625, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4160', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1532, 5, 1, '2022-07-12', '07:00:00', '08:13:00', 73, 3625, '', 'YHI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4160', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1533, 5, 1, '2022-07-12', '08:13:00', '08:17:00', 4, 3641, '', 'YHI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4161', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1534, 5, 1, '2022-07-12', '08:17:00', '08:27:00', 10, 3630, '', 'YHI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4161', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1535, 5, 1, '2022-07-12', '08:27:00', '15:00:00', 393, 3434, '', 'YHI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4161', 15, 10503, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1536, 5, 2, '2022-07-12', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4161', 21, 14712, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1537, 5, 3, '2022-07-12', '23:00:00', '05:01:00', 361, 3434, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4161', 18, 12599, 206, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1538, 5, 3, '2022-07-12', '05:01:00', '05:11:00', 10, 3629, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4161', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1539, 5, 3, '2022-07-12', '05:11:00', '06:30:00', 79, 3625, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4161', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1540, 5, 3, '2022-07-12', '06:30:00', '06:33:00', 3, 3641, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4162', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1541, 5, 3, '2022-07-12', '06:33:00', '06:43:00', 10, 3630, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4162', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1542, 5, 3, '2022-07-12', '06:43:00', '07:00:00', 17, 3434, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4162', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1543, 5, 1, '2022-07-13', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4162', 20, 14006, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1544, 5, 2, '2022-07-13', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4162', 22, 15405, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1545, 5, 3, '2022-07-13', '23:00:00', '03:02:00', 242, 3434, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4162', 12, 8208, 180, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1546, 5, 3, '2022-07-13', '03:02:00', '03:12:00', 10, 3629, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4162', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1547, 5, 3, '2022-07-13', '03:12:00', '04:31:00', 79, 3625, '', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-4162', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1548, 5, 3, '2022-07-13', '04:31:00', '07:00:00', 149, 3437, 'Trial new product morigro', 'NHS', 'KSD2-IANL3004', 'NL33 BASE POWDER (KMI) (R14)', 'PD-TR-118', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1549, 5, 1, '2022-07-14', '07:00:00', '07:39:00', 39, 3437, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-TR-118', 4, 2559, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1550, 5, 1, '2022-07-14', '07:39:00', '13:20:00', 341, 3437, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-TR-119', 5, 2760, 130, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1551, 5, 1, '2022-07-14', '13:20:00', '13:28:00', 8, 3642, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4163', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1552, 5, 1, '2022-07-14', '13:28:00', '13:32:00', 4, 3641, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4163', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1553, 5, 1, '2022-07-14', '13:32:00', '13:42:00', 10, 3630, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4163', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1554, 5, 1, '2022-07-14', '13:42:00', '15:00:00', 78, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4163', 2, 1401, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1555, 5, 2, '2022-07-14', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4163', 20, 14013, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1556, 5, 3, '2022-07-14', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4163', 21, 14705, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1557, 5, 1, '2022-07-15', '07:00:00', '12:45:00', 345, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4163', 16, 10853, 100, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1558, 5, 1, '2022-07-15', '12:45:00', '12:55:00', 10, 3629, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4163', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1559, 5, 1, '2022-07-15', '12:55:00', '14:14:00', 79, 3625, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4163', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1560, 5, 1, '2022-07-15', '14:14:00', '14:22:00', 8, 3642, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4164', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1561, 5, 1, '2022-07-15', '14:22:00', '14:26:00', 4, 3641, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4164', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1562, 5, 1, '2022-07-15', '14:26:00', '14:36:00', 10, 3630, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4164', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1563, 5, 1, '2022-07-15', '14:36:00', '15:00:00', 24, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4164', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1564, 5, 2, '2022-07-15', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4164', 22, 15423, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1565, 5, 3, '2022-07-15', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4164', 24, 16806, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1566, 5, 1, '2022-07-16', '07:00:00', '11:02:00', 242, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4164', 12, 8408, 250, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1567, 5, 1, '2022-07-16', '11:02:00', '11:12:00', 10, 3629, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4164', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1568, 5, 1, '2022-07-16', '11:12:00', '12:31:00', 79, 3625, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4164', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1569, 5, 1, '2022-07-16', '12:31:00', '15:00:00', 149, 3662, 'problem impeller motor tpm', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4165', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1570, 5, 2, '2022-07-16', '15:00:00', '18:46:00', 226, 3662, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4165', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1571, 5, 2, '2022-07-16', '18:46:00', '18:54:00', 8, 3642, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4165', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1572, 5, 2, '2022-07-16', '18:54:00', '18:58:00', 4, 3641, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4165', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1573, 5, 2, '2022-07-16', '18:58:00', '19:08:00', 10, 3630, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4165', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1574, 5, 2, '2022-07-16', '19:08:00', '23:00:00', 232, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4165', 9, 5803, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1575, 5, 3, '2022-07-16', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4165', 21, 14126, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1576, 5, 1, '2022-07-17', '07:00:00', '08:01:00', 61, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4165', 5, 3275, 435, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1577, 5, 1, '2022-07-17', '08:01:00', '08:11:00', 10, 3629, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4165', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1578, 5, 1, '2022-07-17', '08:11:00', '09:30:00', 79, 3625, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4165', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1579, 5, 1, '2022-07-17', '09:30:00', '09:38:00', 8, 3642, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4166', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1580, 5, 1, '2022-07-17', '09:38:00', '09:42:00', 4, 3641, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4166', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1581, 5, 1, '2022-07-17', '09:42:00', '09:52:00', 10, 3630, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4166', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1582, 5, 1, '2022-07-17', '09:52:00', '15:00:00', 308, 3434, '', 'SMI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4166', 13, 9106, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1583, 5, 2, '2022-07-17', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4166', 24, 16808, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1584, 5, 3, '2022-07-17', '23:00:00', '06:38:00', 458, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4166', 23, 16112, 220, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1585, 5, 3, '2022-07-17', '06:38:00', '06:48:00', 10, 3629, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4166', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1586, 5, 3, '2022-07-17', '06:48:00', '07:00:00', 12, 3625, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4166', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1587, 5, 1, '2022-07-18', '07:00:00', '08:07:00', 67, 3625, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4166', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1588, 5, 1, '2022-07-18', '08:07:00', '09:49:00', 102, 3632, 'menunggu bin bersih', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4166', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1589, 5, 1, '2022-07-18', '09:49:00', '09:57:00', 8, 3642, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1590, 5, 1, '2022-07-18', '09:57:00', '10:01:00', 4, 3641, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1591, 5, 1, '2022-07-18', '10:01:00', '10:11:00', 10, 3630, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1592, 5, 1, '2022-07-18', '10:11:00', '15:00:00', 289, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 12, 7804, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1593, 5, 2, '2022-07-18', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 25, 16257, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1594, 5, 3, '2022-07-18', '23:00:00', '02:36:00', 216, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 13, 7932, 55, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1595, 5, 3, '2022-07-18', '02:36:00', '02:56:00', 20, 3631, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1596, 5, 3, '2022-07-18', '02:56:00', '07:00:00', 244, 3441, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1597, 5, 1, '2022-07-19', '07:00:00', '15:00:00', 480, 3441, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1598, 5, 2, '2022-07-19', '15:00:00', '23:00:00', 480, 3435, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1599, 5, 3, '2022-07-19', '23:00:00', '07:00:00', 480, 3435, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1600, 5, 1, '2022-07-20', '07:00:00', '07:00:00', 1440, 3435, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1601, 5, 1, '2022-07-21', '07:00:00', '07:00:00', 1440, 3435, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1602, 5, 1, '2022-07-22', '07:00:00', '07:00:00', 1440, 3435, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1603, 5, 1, '2022-07-23', '07:00:00', '07:00:00', 1440, 3435, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1604, 5, 1, '2022-07-24', '07:00:00', '07:00:00', 1440, 3435, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1605, 5, 1, '2022-07-25', '07:00:00', '07:00:00', 1440, 3435, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1606, 5, 1, '2022-07-26', '07:00:00', '07:00:00', 1440, 3435, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1607, 5, 1, '2022-07-27', '07:00:00', '07:00:00', 1440, 3435, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1608, 5, 1, '2022-07-28', '07:00:00', '10:00:00', 180, 3441, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1609, 5, 1, '2022-07-28', '10:00:00', '13:00:00', 180, 3646, 'dryingout powder tank', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1610, 5, 1, '2022-07-28', '13:00:00', '15:00:00', 120, 3646, 'dryingout awal ahad', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4167', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1611, 5, 2, '2022-07-28', '15:00:00', '16:48:00', 108, 3641, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4168', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1612, 5, 2, '2022-07-28', '16:48:00', '16:58:00', 10, 3630, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4168', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1613, 5, 2, '2022-07-28', '16:58:00', '23:00:00', 362, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4168', 16, 10410, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1614, 5, 3, '2022-07-28', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4168', 27, 17579, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1615, 5, 1, '2022-07-29', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4168', 28, 18225, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1616, 5, 2, '2022-07-29', '15:00:00', '16:16:00', 76, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4168', 6, 3570, 455, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1617, 5, 2, '2022-07-29', '16:16:00', '16:26:00', 10, 3629, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4168', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1618, 5, 2, '2022-07-29', '16:26:00', '17:45:00', 79, 3625, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4168', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1619, 5, 2, '2022-07-29', '17:45:00', '17:53:00', 8, 3642, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4169', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1620, 5, 2, '2022-07-29', '17:53:00', '17:57:00', 4, 3641, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4169', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1621, 5, 2, '2022-07-29', '17:57:00', '18:07:00', 10, 3630, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4169', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1622, 5, 2, '2022-07-29', '18:07:00', '23:00:00', 293, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4169', 10, 7004, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1623, 5, 3, '2022-07-29', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4169', 21, 14712, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1624, 5, 1, '2022-07-30', '07:00:00', '15:00:00', 480, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4169', 21, 14012, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1625, 5, 2, '2022-07-30', '15:00:00', '17:25:00', 145, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4169', 8, 5097, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1626, 5, 2, '2022-07-30', '17:25:00', '17:35:00', 10, 3629, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4169', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1627, 5, 2, '2022-07-30', '17:35:00', '18:54:00', 79, 3625, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4169', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1628, 5, 2, '2022-07-30', '18:54:00', '19:02:00', 8, 3642, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4170', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1629, 5, 2, '2022-07-30', '19:02:00', '19:06:00', 4, 3641, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4170', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1630, 5, 2, '2022-07-30', '19:06:00', '19:16:00', 10, 3630, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4170', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1631, 5, 2, '2022-07-30', '19:16:00', '23:00:00', 224, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4170', 9, 6305, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1632, 5, 3, '2022-07-30', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4170', 24, 16813, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1633, 5, 1, '2022-07-31', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4170', 24, 16806, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1634, 5, 2, '2022-07-31', '15:00:00', '15:17:00', 17, 3434, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4170', 2, 1402, 360, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1635, 5, 2, '2022-07-31', '15:17:00', '15:27:00', 10, 3629, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4170', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1636, 5, 2, '2022-07-31', '15:27:00', '16:46:00', 79, 3625, '', 'YHI', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4170', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1637, 5, 2, '2022-07-31', '16:46:00', '16:54:00', 8, 3642, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4171', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1638, 5, 2, '2022-07-31', '16:54:00', '16:58:00', 4, 3641, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4171', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1639, 5, 2, '2022-07-31', '16:58:00', '17:08:00', 10, 3630, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4171', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1640, 5, 2, '2022-07-31', '17:08:00', '23:00:00', 352, 3434, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4171', 15, 10511, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1641, 5, 3, '2022-07-31', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4171', 24, 16812, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1642, 5, 1, '2022-08-01', '07:00:00', '13:15:00', 375, 3434, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4171', 21, 14376, 60, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1643, 5, 1, '2022-08-01', '13:15:00', '13:25:00', 10, 3629, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4171', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1644, 5, 1, '2022-08-01', '13:25:00', '14:44:00', 79, 3625, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4171', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1645, 5, 1, '2022-08-01', '14:44:00', '14:52:00', 8, 3642, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4172', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1646, 5, 1, '2022-08-01', '14:52:00', '14:56:00', 4, 3641, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4172', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1647, 5, 1, '2022-08-01', '14:56:00', '15:00:00', 4, 3630, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4172', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1648, 5, 2, '2022-08-01', '15:00:00', '15:06:00', 6, 3630, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4172', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1649, 5, 2, '2022-08-01', '15:06:00', '23:00:00', 474, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4172', 18, 12608, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1650, 5, 3, '2022-08-01', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4172', 21, 14726, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1651, 5, 1, '2022-08-02', '07:00:00', '13:52:00', 412, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4172', 19, 13197, 370, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1652, 5, 1, '2022-08-02', '13:52:00', '14:02:00', 10, 3629, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4172', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1653, 5, 1, '2022-08-02', '14:02:00', '15:00:00', 58, 3625, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4172', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1654, 5, 2, '2022-08-02', '15:00:00', '15:21:00', 21, 3625, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4172', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1655, 5, 2, '2022-08-02', '15:21:00', '15:29:00', 8, 3642, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4173', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1656, 5, 2, '2022-08-02', '15:29:00', '15:33:00', 4, 3641, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4173', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1657, 5, 2, '2022-08-02', '15:33:00', '15:43:00', 10, 3630, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4173', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1658, 5, 2, '2022-08-02', '15:43:00', '23:00:00', 437, 3434, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4173', 19, 13311, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1659, 5, 3, '2022-08-02', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4173', 24, 16812, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1660, 5, 1, '2022-08-03', '07:00:00', '11:47:00', 287, 3434, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4173', 16, 11210, 295, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1661, 5, 1, '2022-08-03', '11:47:00', '11:57:00', 10, 3629, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4173', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1662, 5, 1, '2022-08-03', '11:57:00', '13:39:00', 102, 3625, 'Seal piston no 1 bocor liquid susu, ganti seal', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4173', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1663, 5, 1, '2022-08-03', '13:39:00', '13:47:00', 8, 3642, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4174', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1664, 5, 1, '2022-08-03', '13:47:00', '13:51:00', 4, 3641, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4174', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1665, 5, 1, '2022-08-03', '13:51:00', '14:01:00', 10, 3630, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4174', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1666, 5, 1, '2022-08-03', '14:01:00', '15:00:00', 59, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4174', 1, 651, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1667, 5, 2, '2022-08-03', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4174', 26, 16916, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1668, 5, 3, '2022-08-03', '23:00:00', '01:23:00', 143, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4174', 10, 6386, 170, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1669, 5, 3, '2022-08-03', '01:23:00', '01:33:00', 10, 3629, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4174', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1670, 5, 3, '2022-08-03', '01:33:00', '02:52:00', 79, 3625, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4174', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1671, 5, 3, '2022-08-03', '02:52:00', '03:00:00', 8, 3642, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4175', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1672, 5, 3, '2022-08-03', '03:00:00', '03:04:00', 4, 3641, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4175', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1673, 5, 3, '2022-08-03', '03:04:00', '03:14:00', 10, 3630, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4175', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1674, 5, 3, '2022-08-03', '03:14:00', '07:00:00', 226, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4175', 10, 6506, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1675, 5, 1, '2022-08-04', '07:00:00', '14:36:00', 456, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4175', 27, 17319, 90, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1676, 5, 1, '2022-08-04', '14:36:00', '14:56:00', 20, 3631, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4175', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1677, 5, 1, '2022-08-04', '14:56:00', '15:00:00', 4, 3441, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4175', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1678, 5, 2, '2022-08-04', '15:00:00', '23:00:00', 480, 3441, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4175', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1679, 5, 3, '2022-08-04', '23:00:00', '07:00:00', 480, 3441, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4175', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1680, 5, 1, '2022-08-05', '07:00:00', '08:30:00', 90, 3441, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4175', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `oee_drier` (`id`, `line_id`, `shift_id`, `tanggal`, `start`, `finish`, `lamakejadian`, `activity_id`, `remark`, `operator`, `produk_code`, `produk`, `okp_drier`, `output_bin`, `output_kg`, `rework`, `category_rework`, `reject`, `waiting_tech`, `tech_name`, `repair_problem`, `trial_time`, `bas_com`, `category_br`, `category_ampm`, `jumlah_manpower`) VALUES
(1681, 5, 1, '2022-08-05', '08:30:00', '10:30:00', 120, 3646, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4176', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1682, 5, 1, '2022-08-05', '10:30:00', '11:30:00', 60, 3641, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4176', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1683, 5, 1, '2022-08-05', '11:30:00', '11:40:00', 10, 3630, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4176', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1684, 5, 1, '2022-08-05', '11:40:00', '15:00:00', 200, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4176', 8, 5205, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1685, 5, 2, '2022-08-05', '15:00:00', '21:35:00', 395, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4176', 24, 15358, 80, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1686, 5, 2, '2022-08-05', '21:35:00', '21:45:00', 10, 3629, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4176', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1687, 5, 2, '2022-08-05', '21:45:00', '23:00:00', 75, 3625, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4176', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1688, 5, 3, '2022-08-05', '23:00:00', '23:04:00', 4, 3625, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4176', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1689, 5, 3, '2022-08-05', '23:04:00', '23:12:00', 8, 3642, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4177', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1690, 5, 3, '2022-08-05', '23:12:00', '23:16:00', 4, 3641, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4177', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1691, 5, 3, '2022-08-05', '23:16:00', '23:26:00', 10, 3630, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4177', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1692, 5, 3, '2022-08-05', '23:26:00', '07:00:00', 454, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4177', 18, 12609, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1693, 5, 1, '2022-08-06', '07:00:00', '15:00:00', 480, 3434, '', 'SMI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4177', 20, 14011, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1694, 5, 2, '2022-08-06', '15:00:00', '22:16:00', 436, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4177', 21, 14243, 350, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1695, 5, 2, '2022-08-06', '22:16:00', '22:26:00', 10, 3629, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4177', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1696, 5, 2, '2022-08-06', '22:26:00', '23:00:00', 34, 3625, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4177', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1697, 5, 3, '2022-08-06', '23:00:00', '23:45:00', 45, 3625, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4177', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1698, 5, 3, '2022-08-06', '23:45:00', '23:53:00', 8, 3642, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4178', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1699, 5, 3, '2022-08-06', '23:53:00', '23:57:00', 4, 3641, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4178', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1700, 5, 3, '2022-08-06', '23:57:00', '00:07:00', 10, 3630, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4178', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1701, 5, 3, '2022-08-06', '00:07:00', '07:00:00', 413, 3434, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4178', 18, 12610, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1702, 5, 1, '2022-08-07', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4178', 24, 16810, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1703, 5, 2, '2022-08-07', '15:00:00', '20:06:00', 306, 3434, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4178', 17, 11745, 360, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1704, 5, 2, '2022-08-07', '20:06:00', '20:16:00', 10, 3629, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4178', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1705, 5, 2, '2022-08-07', '20:16:00', '21:35:00', 79, 3625, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4178', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1706, 5, 2, '2022-08-07', '21:35:00', '21:43:00', 8, 3642, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4179', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1707, 5, 2, '2022-08-07', '21:43:00', '21:47:00', 4, 3641, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4179', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1708, 5, 2, '2022-08-07', '21:47:00', '21:57:00', 10, 3630, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4179', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1709, 5, 2, '2022-08-07', '21:57:00', '23:00:00', 63, 3434, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4179', 1, 700, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1710, 5, 3, '2022-08-07', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4179', 21, 14712, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1711, 5, 1, '2022-08-08', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4179', 21, 14712, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1712, 5, 2, '2022-08-08', '15:00:00', '20:07:00', 307, 3434, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4179', 17, 10939, 370, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1713, 5, 2, '2022-08-08', '20:07:00', '20:17:00', 10, 3629, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4179', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1714, 5, 2, '2022-08-08', '20:17:00', '21:36:00', 79, 3625, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4179', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1715, 5, 2, '2022-08-08', '21:36:00', '21:44:00', 8, 3642, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4180', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1716, 5, 2, '2022-08-08', '21:44:00', '21:48:00', 4, 3641, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4180', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1717, 5, 2, '2022-08-08', '21:48:00', '21:58:00', 10, 3630, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4180', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1718, 5, 2, '2022-08-08', '21:58:00', '23:00:00', 62, 3434, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4180', 1, 700, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1719, 5, 3, '2022-08-08', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4180', 23, 16112, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1720, 5, 1, '2022-08-09', '07:00:00', '12:18:00', 318, 3434, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4180', 18, 12448, 290, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1721, 5, 1, '2022-08-09', '12:18:00', '12:28:00', 10, 3629, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4180', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1722, 5, 1, '2022-08-09', '12:28:00', '13:47:00', 79, 3625, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4180', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1723, 5, 1, '2022-08-09', '13:47:00', '13:55:00', 8, 3642, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4181', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1724, 5, 1, '2022-08-09', '13:55:00', '13:59:00', 4, 3641, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4181', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1725, 5, 1, '2022-08-09', '13:59:00', '14:09:00', 10, 3630, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4181', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1726, 5, 1, '2022-08-09', '14:09:00', '15:00:00', 51, 3434, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4181', 1, 650, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1727, 5, 2, '2022-08-09', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4181', 26, 16465, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1728, 5, 3, '2022-08-09', '23:00:00', '00:12:00', 72, 3434, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4181', 6, 3423, 70, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1729, 5, 3, '2022-08-09', '00:12:00', '00:22:00', 10, 3629, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4181', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1730, 5, 3, '2022-08-09', '00:22:00', '01:41:00', 79, 3625, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4181', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1731, 5, 3, '2022-08-09', '01:41:00', '01:49:00', 8, 3642, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4182', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1732, 5, 3, '2022-08-09', '01:49:00', '01:53:00', 4, 3641, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4182', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1733, 5, 3, '2022-08-09', '01:53:00', '02:03:00', 10, 3630, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4182', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1734, 5, 3, '2022-08-09', '02:03:00', '07:00:00', 297, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4182', 10, 7005, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1735, 5, 1, '2022-08-10', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4182', 21, 14709, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1736, 5, 2, '2022-08-10', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4182', 21, 14716, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1737, 5, 3, '2022-08-10', '23:00:00', '00:57:00', 117, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4182', 10, 7005, 435, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1738, 5, 3, '2022-08-10', '00:57:00', '01:07:00', 10, 3629, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4182', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1739, 5, 3, '2022-08-10', '01:07:00', '02:26:00', 79, 3625, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4182', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1740, 5, 3, '2022-08-10', '02:26:00', '02:34:00', 8, 3642, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4183', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1741, 5, 3, '2022-08-10', '02:34:00', '02:38:00', 4, 3641, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4183', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1742, 5, 3, '2022-08-10', '02:38:00', '02:48:00', 10, 3630, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4183', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1743, 5, 3, '2022-08-10', '02:48:00', '07:00:00', 252, 3434, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4183', 9, 6305, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1744, 5, 1, '2022-08-11', '07:00:00', '14:30:00', 450, 3434, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4183', 25, 17253, 375, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1745, 5, 1, '2022-08-11', '14:30:00', '14:40:00', 10, 3629, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4183', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1746, 5, 1, '2022-08-11', '14:40:00', '15:00:00', 20, 3625, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4183', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1747, 5, 2, '2022-08-11', '15:00:00', '15:59:00', 59, 3625, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4183', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1748, 5, 2, '2022-08-11', '15:59:00', '16:07:00', 8, 3642, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1749, 5, 2, '2022-08-11', '16:07:00', '16:11:00', 4, 3641, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1750, 5, 2, '2022-08-11', '16:11:00', '16:21:00', 10, 3630, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1751, 5, 2, '2022-08-11', '16:21:00', '23:00:00', 399, 3434, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 16, 11218, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1752, 5, 3, '2022-08-11', '23:00:00', '00:08:00', 68, 3434, '', 'YHI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 5, 3278, 330, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1753, 5, 3, '2022-08-11', '00:08:00', '00:28:00', 20, 3631, '', 'YHI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1754, 5, 3, '2022-08-11', '00:28:00', '07:00:00', 392, 3441, '', 'YHI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1755, 5, 1, '2022-08-12', '07:00:00', '15:00:00', 480, 3441, '', 'NSA', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1756, 5, 2, '2022-08-12', '15:00:00', '16:34:00', 94, 3441, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1757, 5, 2, '2022-08-12', '16:34:00', '18:34:00', 120, 3646, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1758, 5, 2, '2022-08-12', '18:34:00', '23:00:00', 266, 3435, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1759, 5, 3, '2022-08-12', '23:00:00', '07:00:00', 480, 3435, '', 'YHI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1760, 5, 1, '2022-08-13', '07:00:00', '15:00:00', 480, 3435, '', 'NSA', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1761, 5, 2, '2022-08-13', '15:00:00', '23:00:00', 480, 3435, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1762, 5, 3, '2022-08-13', '23:00:00', '07:00:00', 480, 3435, '', 'YHI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1763, 5, 1, '2022-08-14', '07:00:00', '15:00:00', 480, 3435, '', 'NHS', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1764, 5, 2, '2022-08-14', '15:00:00', '23:00:00', 480, 3435, '', 'YHI', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1765, 5, 3, '2022-08-14', '23:00:00', '07:00:00', 480, 3435, '', 'NSA', 'KSD2-IABFP001', 'BFP BASE POWDER KMI', 'PD-4184', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1766, 5, 1, '2022-08-15', '07:00:00', '11:29:00', 269, 3435, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4185', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1767, 5, 1, '2022-08-15', '11:29:00', '13:29:00', 120, 3646, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4185', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1768, 5, 1, '2022-08-15', '13:29:00', '14:29:00', 60, 3641, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4185', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1769, 5, 1, '2022-08-15', '14:29:00', '14:39:00', 10, 3630, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4185', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1770, 5, 1, '2022-08-15', '14:39:00', '15:00:00', 21, 3434, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4185', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1771, 5, 2, '2022-08-15', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4185', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1772, 5, 3, '2022-08-15', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4185', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1773, 5, 1, '2022-08-16', '07:00:00', '10:59:00', 239, 3434, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4185', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1774, 5, 1, '2022-08-16', '10:59:00', '11:09:00', 10, 3629, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4185', 21, 14711, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1775, 5, 1, '2022-08-16', '11:09:00', '12:28:00', 79, 3625, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4185', 24, 16811, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1776, 5, 1, '2022-08-16', '12:28:00', '12:36:00', 8, 3642, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4186', 14, 9756, 220, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1777, 5, 1, '2022-08-16', '12:36:00', '12:40:00', 4, 3641, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4186', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1778, 5, 1, '2022-08-16', '12:40:00', '12:50:00', 10, 3630, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4186', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1779, 5, 1, '2022-08-16', '12:50:00', '15:00:00', 130, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4186', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1780, 5, 2, '2022-08-16', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4186', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1781, 5, 3, '2022-08-16', '23:00:00', '06:42:00', 462, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4186', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1782, 5, 3, '2022-08-16', '06:42:00', '06:52:00', 10, 3629, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4186', 4, 2802, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1783, 5, 3, '2022-08-16', '06:52:00', '07:00:00', 8, 3625, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4186', 20, 14009, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1784, 5, 1, '2022-08-17', '07:00:00', '08:11:00', 71, 3625, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4186', 21, 14480, 370, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1785, 5, 1, '2022-08-17', '08:11:00', '08:19:00', 8, 3642, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4187', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1786, 5, 1, '2022-08-17', '08:19:00', '08:23:00', 4, 3641, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4187', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1787, 5, 1, '2022-08-17', '08:23:00', '08:33:00', 10, 3630, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4187', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1788, 5, 1, '2022-08-17', '08:33:00', '15:00:00', 387, 3434, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4187', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1789, 5, 2, '2022-08-17', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4187', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1790, 5, 3, '2022-08-17', '23:00:00', '04:35:00', 335, 3434, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4187', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1791, 5, 3, '2022-08-17', '04:35:00', '04:45:00', 10, 3629, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4187', 17, 11920, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1792, 5, 3, '2022-08-17', '04:45:00', '06:05:00', 80, 3625, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4187', 23, 16108, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1793, 5, 3, '2022-08-17', '06:05:00', '06:14:00', 9, 3642, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4188', 18, 12609, 360, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1794, 5, 3, '2022-08-17', '06:14:00', '06:18:00', 4, 3641, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4188', 4, 2524, 375, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1795, 5, 3, '2022-08-17', '06:18:00', '06:28:00', 10, 3630, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4188', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1796, 5, 3, '2022-08-17', '06:28:00', '07:00:00', 32, 3434, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4188', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1797, 5, 1, '2022-08-18', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4188', 24, 16824, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1798, 5, 2, '2022-08-18', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4188', 23, 16103, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1799, 5, 3, '2022-08-18', '23:00:00', '02:18:00', 198, 3434, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4188', 12, 8408, 190, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1800, 5, 3, '2022-08-18', '02:18:00', '04:57:00', 159, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-TR-120', 4, 2524, 375, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1801, 5, 3, '2022-08-18', '04:57:00', '07:00:00', 123, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121-R', 1, 651, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1802, 5, 1, '2022-08-19', '07:00:00', '07:40:00', 40, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 4, 2118, 125, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1803, 5, 1, '2022-08-19', '07:40:00', '07:50:00', 10, 3631, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1804, 5, 1, '2022-08-19', '07:50:00', '15:00:00', 430, 3441, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1805, 5, 2, '2022-08-19', '15:00:00', '23:00:00', 480, 3441, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1806, 5, 3, '2022-08-19', '23:00:00', '00:00:00', 60, 3441, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1807, 5, 3, '2022-08-19', '00:00:00', '07:00:00', 420, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1808, 5, 1, '2022-08-20', '07:00:00', '15:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1809, 5, 2, '2022-08-20', '15:00:00', '23:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1810, 5, 3, '2022-08-20', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1811, 5, 1, '2022-08-21', '07:00:00', '15:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1812, 5, 2, '2022-08-21', '15:00:00', '23:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1813, 5, 3, '2022-08-21', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1814, 5, 1, '2022-08-22', '07:00:00', '15:00:00', 480, 3435, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1815, 5, 2, '2022-08-22', '15:00:00', '23:00:00', 480, 3435, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-TR-121', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1816, 5, 3, '2022-08-22', '23:00:00', '03:02:00', 242, 3641, 'Start up lama karena ada problem steam low press lt.3 bocor', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4189', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1817, 5, 3, '2022-08-22', '03:02:00', '03:12:00', 10, 3630, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4189', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1818, 5, 3, '2022-08-22', '03:12:00', '07:00:00', 228, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4189', 10, 6507, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1819, 5, 1, '2022-08-23', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4189', 26, 16916, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1820, 5, 2, '2022-08-23', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4189', 27, 17563, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1821, 5, 3, '2022-08-23', '23:00:00', '02:44:00', 224, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4189', 14, 9118, 330, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1822, 5, 3, '2022-08-23', '02:44:00', '02:54:00', 10, 3629, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4189', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1823, 5, 3, '2022-08-23', '02:54:00', '04:13:00', 79, 3625, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4189', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1824, 5, 3, '2022-08-23', '04:13:00', '05:04:00', 51, 3624, 'CIP keteter ', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4189', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1825, 5, 3, '2022-08-23', '05:04:00', '05:12:00', 8, 3642, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4190', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1826, 5, 3, '2022-08-23', '05:12:00', '05:16:00', 4, 3641, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4190', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1827, 5, 3, '2022-08-23', '05:16:00', '05:26:00', 10, 3630, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4190', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1828, 5, 3, '2022-08-23', '05:26:00', '07:00:00', 94, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4190', 3, 1952, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1829, 5, 1, '2022-08-24', '07:00:00', '15:00:00', 480, 3434, '', 'JCK', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4190', 27, 17118, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1830, 5, 2, '2022-08-24', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4190', 27, 17566, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1831, 5, 3, '2022-08-24', '23:00:00', '04:46:00', 346, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4190', 20, 13030, 80, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1832, 5, 3, '2022-08-24', '04:46:00', '04:56:00', 10, 3629, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4190', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1833, 5, 3, '2022-08-24', '04:56:00', '06:15:00', 79, 3625, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4190', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1834, 5, 3, '2022-08-24', '06:15:00', '06:23:00', 8, 3642, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4191', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1835, 5, 3, '2022-08-24', '06:23:00', '06:27:00', 4, 3641, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4191', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1836, 5, 3, '2022-08-24', '06:27:00', '06:37:00', 10, 3630, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4191', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1837, 5, 3, '2022-08-24', '06:37:00', '07:00:00', 23, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4191', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1838, 5, 1, '2022-08-25', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4191', 24, 15151, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1839, 5, 2, '2022-08-25', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4191', 24, 15609, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1840, 5, 3, '2022-08-25', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4191', 24, 15628, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1841, 5, 1, '2022-08-26', '07:00:00', '08:08:00', 68, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4191', 4, 1953, 180, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1842, 5, 1, '2022-08-26', '08:08:00', '08:18:00', 10, 3629, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4191', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1843, 5, 1, '2022-08-26', '08:18:00', '09:37:00', 79, 3625, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4191', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1844, 5, 1, '2022-08-26', '09:37:00', '09:45:00', 8, 3642, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4192', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1845, 5, 1, '2022-08-26', '09:45:00', '09:49:00', 4, 3641, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4192', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1846, 5, 1, '2022-08-26', '09:49:00', '09:59:00', 10, 3630, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4192', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1847, 5, 1, '2022-08-26', '09:59:00', '15:00:00', 301, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4192', 13, 7806, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1848, 5, 2, '2022-08-26', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4192', 24, 15609, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1849, 5, 3, '2022-08-26', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4192', 24, 15633, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1850, 5, 1, '2022-08-27', '07:00:00', '11:20:00', 260, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4192', 14, 9109, 220, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1851, 5, 1, '2022-08-27', '11:20:00', '11:30:00', 10, 3629, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4192', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1852, 5, 1, '2022-08-27', '11:30:00', '12:49:00', 79, 3625, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4192', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1853, 5, 1, '2022-08-27', '12:49:00', '12:57:00', 8, 3642, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4193', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1854, 5, 1, '2022-08-27', '12:57:00', '13:01:00', 4, 3641, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4193', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1855, 5, 1, '2022-08-27', '13:01:00', '13:11:00', 10, 3630, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4193', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1856, 5, 1, '2022-08-27', '13:11:00', '15:00:00', 109, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4193', 2, 1301, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1857, 5, 2, '2022-08-27', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4193', 25, 15813, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1858, 5, 3, '2022-08-27', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4193', 25, 16272, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1859, 5, 1, '2022-08-28', '07:00:00', '14:27:00', 447, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4193', 21, 12359, 330, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1860, 5, 1, '2022-08-28', '14:27:00', '14:37:00', 10, 3629, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4193', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1861, 5, 1, '2022-08-28', '14:37:00', '15:00:00', 23, 3625, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4193', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1862, 5, 2, '2022-08-28', '15:00:00', '15:56:00', 56, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4193', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1863, 5, 2, '2022-08-28', '15:56:00', '16:04:00', 8, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4194', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1864, 5, 2, '2022-08-28', '16:04:00', '16:08:00', 4, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4194', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1865, 5, 2, '2022-08-28', '16:08:00', '16:18:00', 10, 3630, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4194', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1866, 5, 2, '2022-08-28', '16:18:00', '23:00:00', 402, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4194', 19, 12373, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1867, 5, 3, '2022-08-28', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4194', 24, 15616, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1868, 5, 1, '2022-08-29', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4194', 24, 15171, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1869, 5, 2, '2022-08-29', '15:00:00', '17:33:00', 153, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4194', 8, 5210, 200, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1870, 5, 2, '2022-08-29', '17:33:00', '17:43:00', 10, 3629, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4194', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1871, 5, 2, '2022-08-29', '17:43:00', '19:02:00', 79, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4194', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1872, 5, 2, '2022-08-29', '19:02:00', '19:10:00', 8, 3642, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4195', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1873, 5, 2, '2022-08-29', '19:10:00', '19:14:00', 4, 3641, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4195', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1874, 5, 2, '2022-08-29', '19:14:00', '19:24:00', 10, 3630, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4195', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1875, 5, 2, '2022-08-29', '19:24:00', '23:00:00', 216, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4195', 10, 6509, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1876, 5, 3, '2022-08-29', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4195', 24, 15615, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1877, 5, 1, '2022-08-30', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4195', 24, 15610, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1878, 5, 2, '2022-08-30', '15:00:00', '20:14:00', 314, 3434, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4195', 18, 11547, 140, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1879, 5, 2, '2022-08-30', '20:14:00', '20:24:00', 10, 3629, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4195', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1880, 5, 2, '2022-08-30', '20:24:00', '21:43:00', 79, 3625, '', 'NHS', 'KSD2-IACKR023', 'CHIL KID REGULER  BASE POWDER (R 21) KMI', 'PD-4195', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1881, 5, 2, '2022-08-30', '21:43:00', '21:51:00', 8, 3642, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4196', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1882, 5, 2, '2022-08-30', '21:51:00', '21:55:00', 4, 3641, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4196', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1883, 5, 2, '2022-08-30', '21:55:00', '22:05:00', 10, 3630, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4196', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1884, 5, 2, '2022-08-30', '22:05:00', '23:00:00', 55, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4196', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1885, 5, 3, '2022-08-30', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4196', 22, 14015, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1886, 5, 1, '2022-08-31', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4196', 20, 14011, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1887, 5, 2, '2022-08-31', '15:00:00', '21:36:00', 396, 3434, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4196', 18, 11219, 355, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1888, 5, 2, '2022-08-31', '21:36:00', '21:46:00', 10, 3629, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4196', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1889, 5, 2, '2022-08-31', '21:46:00', '23:00:00', 74, 3625, '', 'NHS', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4196', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1890, 5, 3, '2022-08-31', '23:00:00', '23:05:00', 5, 3625, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4196', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1891, 5, 3, '2022-08-31', '23:05:00', '23:13:00', 8, 3642, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1892, 5, 3, '2022-08-31', '23:13:00', '23:17:00', 4, 3641, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1893, 5, 3, '2022-08-31', '23:17:00', '23:27:00', 10, 3630, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1894, 5, 3, '2022-08-31', '23:27:00', '07:00:00', 453, 3434, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 20, 14008, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1895, 5, 3, '2022-08-31', '07:00:00', '07:05:00', 5, 3625, '', 'YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4196', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1896, 5, 3, '2022-08-31', '07:05:00', '07:13:00', 8, 3642, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1897, 5, 3, '2022-08-31', '07:13:00', '07:17:00', 4, 3641, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1898, 5, 3, '2022-08-31', '07:17:00', '07:27:00', 10, 3630, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1899, 5, 3, '2022-08-31', '07:27:00', '15:00:00', 453, 3434, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 20, 14008, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1900, 5, 1, '2022-09-01', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 24, 16813, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1901, 5, 2, '2022-09-01', '15:00:00', '18:58:00', 238, 3434, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1902, 5, 2, '2022-09-01', '18:58:00', '20:04:00', 66, 3649, 'Steam ngdrop', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1903, 5, 2, '2022-09-01', '20:04:00', '23:00:00', 176, 3434, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 18, 12617, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1904, 5, 3, '2022-09-01', '23:00:00', '23:43:00', 43, 3434, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 7, 4906, 510, NULL, 130, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1905, 5, 3, '2022-09-01', '23:43:00', '23:53:00', 10, 3629, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1906, 5, 3, '2022-09-01', '23:53:00', '01:12:00', 79, 3625, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4197', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1907, 5, 3, '2022-09-01', '01:12:00', '01:38:00', 26, 3642, 'PH evap jelek', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4198', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1908, 5, 3, '2022-09-01', '01:38:00', '01:42:00', 4, 3641, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4198', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1909, 5, 3, '2022-09-01', '01:42:00', '01:52:00', 10, 3630, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4198', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1910, 5, 3, '2022-09-01', '01:52:00', '07:00:00', 308, 3434, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4198', 10, 7006, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1911, 5, 1, '2022-09-02', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4198', 24, 16817, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1912, 5, 2, '2022-09-02', '15:00:00', '15:02:00', 2, 3434, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4198', 3, 2102, 480, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1913, 5, 2, '2022-09-02', '15:02:00', '15:12:00', 10, 3629, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4198', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1914, 5, 2, '2022-09-02', '15:12:00', '16:31:00', 79, 3625, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4198', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1915, 5, 2, '2022-09-02', '16:31:00', '16:39:00', 8, 3642, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4199', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1916, 5, 2, '2022-09-02', '16:39:00', '16:43:00', 4, 3641, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4199', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1917, 5, 2, '2022-09-02', '16:43:00', '16:53:00', 10, 3630, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4199', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1918, 5, 2, '2022-09-02', '16:53:00', '23:00:00', 367, 3434, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4199', 13, 9111, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1919, 5, 3, '2022-09-02', '23:00:00', '03:06:00', 246, 3434, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4199', 14, 9744, 300, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1920, 5, 3, '2022-09-02', '03:06:00', '03:26:00', 20, 3631, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4199', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1921, 5, 3, '2022-09-02', '03:26:00', '07:00:00', 214, 3441, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4199', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0);
INSERT INTO `oee_drier` (`id`, `line_id`, `shift_id`, `tanggal`, `start`, `finish`, `lamakejadian`, `activity_id`, `remark`, `operator`, `produk_code`, `produk`, `okp_drier`, `output_bin`, `output_kg`, `rework`, `category_rework`, `reject`, `waiting_tech`, `tech_name`, `repair_problem`, `trial_time`, `bas_com`, `category_br`, `category_ampm`, `jumlah_manpower`) VALUES
(1922, 5, 1, '2022-09-03', '07:00:00', '15:00:00', 480, 3441, '', 'NSA', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4199', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1923, 5, 2, '2022-09-03', '15:00:00', '23:00:00', 480, 3441, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4199', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1924, 5, 3, '2022-09-03', '23:00:00', '07:00:00', 480, 3442, '', 'YHI', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4199', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1925, 5, 1, '2022-09-04', '07:00:00', '10:00:00', 180, 3442, '', 'NHS', 'KSD2-IACMr009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4199', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1926, 5, 1, '2022-09-04', '10:00:00', '12:00:00', 120, 3646, '', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4200', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1927, 5, 1, '2022-09-04', '12:00:00', '13:23:00', 83, 3641, '', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4200', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1928, 5, 1, '2022-09-04', '13:23:00', '13:33:00', 10, 3630, '', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4200', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1929, 5, 1, '2022-09-04', '13:33:00', '15:00:00', 87, 3434, '', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4200', 2, 1203, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1930, 5, 2, '2022-09-04', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4200', 23, 13817, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1931, 5, 3, '2022-09-04', '23:00:00', '05:50:00', 410, 3434, '', 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4200', 23, 13357, 250, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1932, 5, 3, '2022-09-04', '05:50:00', '06:00:00', 10, 3629, '', 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4200', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1933, 5, 3, '2022-09-04', '06:00:00', '07:00:00', 60, 3625, '', 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4200', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1934, 5, 1, '2022-09-05', '07:00:00', '07:19:00', 19, 3625, '', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4200', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1935, 5, 1, '2022-09-05', '07:19:00', '08:58:00', 99, 3641, 'Start-up lama karena valve buffer tank no.2 tidak mau buka', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4201', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1936, 5, 1, '2022-09-05', '08:58:00', '09:08:00', 10, 3630, '', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4201', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1937, 5, 1, '2022-09-05', '09:08:00', '15:00:00', 352, 3434, '', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4201', 15, 9007, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1938, 5, 2, '2022-09-05', '15:00:00', '21:45:00', 405, 3434, '', 'YHI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4201', 22, 12011, 233, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1939, 5, 2, '2022-09-05', '21:45:00', '21:55:00', 10, 3629, '', 'YHI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4201', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1940, 5, 2, '2022-09-05', '21:55:00', '23:00:00', 65, 3625, '', 'YHI', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4201', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1941, 5, 3, '2022-09-05', '23:00:00', '23:14:00', 14, 3625, '', 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4202', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1942, 5, 3, '2022-09-05', '23:14:00', '23:18:00', 4, 3641, '', 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4202', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1943, 5, 3, '2022-09-05', '23:18:00', '23:28:00', 10, 3630, '', 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4202', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1944, 5, 3, '2022-09-05', '23:28:00', '07:00:00', 452, 3434, '', 'NSA', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4202', 21, 12611, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1945, 5, 1, '2022-09-06', '07:00:00', '10:28:00', 208, 3434, '', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4202', 12, 7210, 285, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1946, 5, 1, '2022-09-06', '10:28:00', '10:38:00', 10, 3629, '', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4202', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1947, 5, 1, '2022-09-06', '10:38:00', '11:57:00', 79, 3625, '', 'NHS', 'KSD2-IACKH002', 'CHIL KID PHP-RVT-17 BASE POWDER (KMI)', 'PD-4202', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1948, 5, 1, '2022-09-06', '11:57:00', '12:14:00', 17, 3641, '', 'NHS', 'KSD2-IACKH003', 'CHIL KID PHP-RVT-22 BASE (KMI)', 'PD-4203', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1949, 5, 1, '2022-09-06', '12:14:00', '12:24:00', 10, 3630, 'Trial pihak IDC minta hasil T.S masuk standar baru spray', 'NHS', 'KSD2-IACKH003', 'CHIL KID PHP-RVT-22 BASE (KMI)', 'PD-4203', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1950, 5, 1, '2022-09-06', '12:24:00', '15:00:00', 156, 3434, '', 'NHS', 'KSD2-IACKH003', 'CHIL KID PHP-RVT-22 BASE (KMI)', 'PD-4203', 6, 3604, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1951, 5, 2, '2022-09-06', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKH003', 'CHIL KID PHP-RVT-22 BASE (KMI)', 'PD-4203', 23, 13813, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1952, 5, 3, '2022-09-06', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKH003', 'CHIL KID PHP-RVT-22 BASE (KMI)', 'PD-4203', 24, 14411, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1953, 5, 1, '2022-09-07', '07:00:00', '10:49:00', 229, 3434, '', 'NHS', 'KSD2-IACKH003', 'CHIL KID PHP-RVT-22 BASE (KMI)', 'PD-4203', 13, 7719, 150, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1954, 5, 1, '2022-09-07', '10:49:00', '10:59:00', 10, 3629, '', 'NHS', 'KSD2-IACKH003', 'CHIL KID PHP-RVT-22 BASE (KMI)', 'PD-4203', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1955, 5, 1, '2022-09-07', '10:59:00', '12:18:00', 79, 3625, '', 'NHS', 'KSD2-IACKH003', 'CHIL KID PHP-RVT-22 BASE (KMI)', 'PD-4203', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1956, 5, 1, '2022-09-07', '12:18:00', '12:22:00', 4, 3641, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4204', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1957, 5, 1, '2022-09-07', '12:22:00', '12:32:00', 10, 3630, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4204', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1958, 5, 1, '2022-09-07', '12:32:00', '15:00:00', 148, 3434, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4204', 5, 3007, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1959, 5, 2, '2022-09-07', '15:00:00', '21:07:00', 367, 3434, '', 'YHI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4204', 18, 10812, 315, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1960, 5, 2, '2022-09-07', '21:07:00', '21:17:00', 10, 3629, '', 'YHI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4204', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1961, 5, 2, '2022-09-07', '21:17:00', '22:36:00', 79, 3625, '', 'YHI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4204', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1962, 5, 2, '2022-09-07', '22:36:00', '22:40:00', 4, 3641, '', 'YHI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4205', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1963, 5, 2, '2022-09-07', '22:40:00', '22:50:00', 10, 3630, '', 'YHI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4205', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1964, 5, 2, '2022-09-07', '22:50:00', '23:00:00', 10, 3434, '', 'YHI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4205', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1965, 5, 3, '2022-09-07', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4205', 20, 12005, 120, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1966, 5, 1, '2022-09-08', '07:00:00', '07:17:00', 17, 3434, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4205', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1967, 5, 1, '2022-09-08', '07:17:00', '07:37:00', 20, 3631, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4205', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1968, 5, 1, '2022-09-08', '07:37:00', '15:00:00', 443, 3441, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4205', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1969, 5, 2, '2022-09-08', '15:00:00', '23:00:00', 480, 3441, '', 'YHI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4205', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1970, 5, 3, '2022-09-08', '23:00:00', '07:00:00', 480, 3442, '', 'NSA', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4205', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1971, 5, 1, '2022-09-09', '07:00:00', '13:14:00', 374, 3442, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4205', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1972, 5, 1, '2022-09-09', '13:14:00', '15:00:00', 106, 3646, '', 'NHS', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4206', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1973, 5, 2, '2022-09-09', '15:00:00', '15:14:00', 14, 3646, '', 'YHI', 'KSD2-IABPH002', 'BMT PHP-RVT 17 BASE POWDER (KMI)', 'PD-4206', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1974, 5, 2, '2022-09-09', '15:14:00', '15:30:00', 16, 3641, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4206', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1975, 5, 2, '2022-09-09', '15:30:00', '15:40:00', 10, 3630, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4206', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1976, 5, 2, '2022-09-09', '15:40:00', '23:00:00', 440, 3434, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4206', 24, 11712, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1977, 5, 3, '2022-09-09', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4206', 27, 13526, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1978, 5, 1, '2022-09-10', '07:00:00', '14:47:00', 467, 3434, '', 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4206', 32, 16022, 215, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1979, 5, 1, '2022-09-10', '14:47:00', '14:57:00', 10, 3629, '', 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4206', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1980, 5, 1, '2022-09-10', '14:57:00', '15:00:00', 3, 3625, '', 'NHS', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4206', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1981, 5, 2, '2022-09-10', '15:00:00', '16:16:00', 76, 3625, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4206', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1982, 5, 2, '2022-09-10', '16:16:00', '16:20:00', 4, 3641, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4207', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1983, 5, 2, '2022-09-10', '16:20:00', '16:30:00', 10, 3630, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4207', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1984, 5, 2, '2022-09-10', '16:30:00', '22:45:00', 375, 3434, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4207', 22, 10762, 180, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1985, 5, 2, '2022-09-10', '22:45:00', '22:55:00', 10, 3629, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4207', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1986, 5, 2, '2022-09-10', '22:55:00', '23:00:00', 5, 3625, '', 'YHI', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4207', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1987, 5, 3, '2022-09-10', '23:00:00', '00:14:00', 74, 3625, '', 'NSA', 'KSD2-IACSS001-R1', 'CHIL SCHOOL SOYA BASE POWDER (KMI)', 'PD-4207', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1988, 5, 3, '2022-09-10', '00:14:00', '00:18:00', 4, 3641, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4208', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1989, 5, 3, '2022-09-10', '00:18:00', '00:28:00', 10, 3630, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4208', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1990, 5, 3, '2022-09-10', '00:28:00', '07:00:00', 392, 3434, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4208', 21, 10515, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1991, 5, 1, '2022-09-11', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4208', 30, 15016, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1992, 5, 2, '2022-09-11', '15:00:00', '22:37:00', 457, 3434, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4208', 29, 14522, 385, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1993, 5, 2, '2022-09-11', '22:37:00', '22:47:00', 10, 3629, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4208', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1994, 5, 2, '2022-09-11', '22:47:00', '23:00:00', 13, 3625, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4208', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1995, 5, 3, '2022-09-11', '23:00:00', '00:06:00', 66, 3625, '', 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4208', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1996, 5, 3, '2022-09-11', '00:06:00', '00:10:00', 4, 3641, '', 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4209', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1997, 5, 3, '2022-09-11', '00:10:00', '00:20:00', 10, 3630, '', 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4209', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1998, 5, 3, '2022-09-11', '00:20:00', '07:00:00', 400, 3434, '', 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4209', 22, 11017, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(1999, 5, 1, '2022-09-12', '07:00:00', '15:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4209', 30, 15013, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2000, 5, 2, '2022-09-12', '15:00:00', '22:20:00', 440, 3434, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4209', 29, 14509, 195, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2001, 5, 2, '2022-09-12', '22:20:00', '22:30:00', 10, 3629, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4209', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2002, 5, 2, '2022-09-12', '22:30:00', '23:00:00', 30, 3625, '', 'NSA', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4209', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2003, 5, 3, '2022-09-12', '23:00:00', '23:49:00', 49, 3625, '', 'NHS', 'KSD2-IACKS001-R1', 'CHIL KID SOYA BASE POWDER (KMI)', 'PD-4209', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2004, 5, 3, '2022-09-12', '23:49:00', '23:53:00', 4, 3641, '', 'NHS', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4210', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2005, 5, 3, '2022-09-12', '23:53:00', '00:03:00', 10, 3630, '', 'NHS', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4210', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2006, 5, 3, '2022-09-12', '00:03:00', '03:33:00', 210, 3434, '', 'NHS', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4210', 13, 5885, 210, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2007, 5, 3, '2022-09-12', '03:33:00', '03:43:00', 10, 3434, '', 'NHS', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4210', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2008, 5, 3, '2022-09-12', '03:43:00', '05:02:00', 79, 3625, '', 'NHS', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4210', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2009, 5, 3, '2022-09-12', '05:02:00', '05:06:00', 4, 3641, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4211', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2010, 5, 3, '2022-09-12', '05:06:00', '05:16:00', 10, 3630, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4211', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2011, 5, 3, '2022-09-12', '05:16:00', '07:00:00', 104, 3434, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4211', 4, 2002, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2012, 5, 1, '2022-09-13', '07:00:00', '10:13:00', 193, 3434, '', 'YHI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4211', 14, 6415, 220, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2013, 5, 1, '2022-09-13', '10:13:00', '10:23:00', 10, 3629, '', 'YHI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4211', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2014, 5, 1, '2022-09-13', '10:23:00', '11:42:00', 79, 3625, '', 'YHI', 'KSD2-IACMS001-R1', 'CHIL MIL SOYA BASE POWDER (KMI)', 'PD-4211', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2015, 5, 1, '2022-09-13', '11:42:00', '11:55:00', 13, 3641, 'Menunggu release Buffertank', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2016, 5, 1, '2022-09-13', '11:55:00', '12:05:00', 10, 3630, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2017, 5, 1, '2022-09-13', '12:05:00', '15:00:00', 175, 3434, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 7, 3004, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2018, 5, 2, '2022-09-13', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 30, 14707, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2019, 5, 3, '2022-09-13', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 31, 15517, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2020, 5, 1, '2022-09-14', '07:00:00', '09:54:00', 174, 3434, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 13, 6205, 175, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2021, 5, 1, '2022-09-14', '09:54:00', '10:14:00', 20, 3631, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2022, 5, 1, '2022-09-14', '10:14:00', '15:00:00', 286, 3441, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2023, 5, 2, '2022-09-14', '15:00:00', '23:00:00', 480, 3441, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2024, 5, 3, '2022-09-14', '23:00:00', '07:00:00', 480, 3441, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2025, 5, 1, '2022-09-15', '07:00:00', '15:00:00', 480, 3435, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2026, 5, 2, '2022-09-15', '15:00:00', '23:00:00', 480, 3435, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2027, 5, 3, '2022-09-15', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2028, 5, 1, '2022-09-16', '07:00:00', '15:00:00', 480, 3435, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2029, 5, 2, '2022-09-16', '15:00:00', '23:00:00', 480, 3435, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2030, 5, 3, '2022-09-16', '23:00:00', '07:00:00', 480, 3435, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4212', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2031, 5, 1, '2022-09-17', '07:00:00', '09:53:00', 173, 3642, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4213', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2032, 5, 1, '2022-09-17', '09:53:00', '09:57:00', 4, 3641, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4213', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2033, 5, 1, '2022-09-17', '09:57:00', '10:07:00', 10, 3630, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4213', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2034, 5, 1, '2022-09-17', '10:07:00', '10:45:00', 38, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4213', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2035, 5, 1, '2022-09-17', '10:45:00', '11:39:00', 54, 3492, 'Piston No 1 (dari kanan) bocor karena seal piston rusak', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4213', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2036, 5, 1, '2022-09-17', '11:39:00', '15:00:00', 201, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4213', 11, 6260, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2037, 5, 2, '2022-09-17', '15:00:00', '23:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4213', 27, 17597, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2038, 5, 3, '2022-09-17', '23:00:00', '07:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4213', 27, 17586, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2039, 5, 1, '2022-09-18', '07:00:00', '10:28:00', 208, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4213', 14, 8704, 170, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2040, 5, 1, '2022-09-18', '10:28:00', '10:38:00', 10, 3629, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4213', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2041, 5, 1, '2022-09-18', '10:38:00', '11:57:00', 79, 3625, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4213', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2042, 5, 1, '2022-09-18', '11:57:00', '13:11:00', 74, 3642, ' Vaccum evap tinggi susah turunnya dan valve bt 01 4201seret tdk mau buka.', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4214', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2043, 5, 1, '2022-09-18', '13:11:00', '13:15:00', 4, 3641, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4214', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2044, 5, 1, '2022-09-18', '13:15:00', '13:25:00', 10, 3630, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4214', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2045, 5, 1, '2022-09-18', '13:25:00', '15:00:00', 95, 3434, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4214', 3, 2101, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2046, 5, 2, '2022-09-18', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4214', 24, 16325, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2047, 5, 3, '2022-09-18', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4214', 24, 16813, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2048, 5, 1, '2022-09-19', '07:00:00', '09:00:00', 120, 3434, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4214', 9, 5870, 120, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2049, 5, 1, '2022-09-19', '09:00:00', '09:10:00', 10, 3629, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4214', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2050, 5, 1, '2022-09-19', '09:10:00', '10:29:00', 79, 3625, '', 'NSA', 'KSD2-IACMP006', 'CHIL MIL PLATINUM BASE POWDER (R21) KMI', 'PD-4214', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2051, 5, 1, '2022-09-19', '10:29:00', '10:37:00', 8, 3642, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2052, 5, 1, '2022-09-19', '10:37:00', '10:41:00', 4, 3641, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2053, 5, 1, '2022-09-19', '10:41:00', '10:51:00', 10, 3630, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2054, 5, 1, '2022-09-19', '10:51:00', '15:00:00', 249, 3434, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 8, 5204, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2055, 5, 2, '2022-09-19', '15:00:00', '23:00:00', 480, 3434, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 22, 15416, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2056, 5, 3, '2022-09-19', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 21, 14013, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2057, 5, 1, '2022-09-20', '07:00:00', '10:55:00', 235, 3434, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 12, 7979, 230, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2058, 5, 1, '2022-09-20', '10:55:00', '11:15:00', 20, 3631, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2059, 5, 1, '2022-09-20', '11:15:00', '15:00:00', 225, 3441, '', 'NSA', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2060, 5, 2, '2022-09-20', '15:00:00', '23:00:00', 480, 3441, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2061, 5, 3, '2022-09-20', '23:00:00', '07:00:00', 480, 3442, '', 'YHI', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2062, 5, 1, '2022-09-21', '07:00:00', '15:00:00', 480, 3442, '', 'RNT', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2063, 5, 2, '2022-09-21', '15:00:00', '16:30:00', 90, 3442, '', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2064, 5, 2, '2022-09-21', '16:30:00', '18:30:00', 120, 3646, 'Drying out awal minggu', 'NHS', 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4215', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2065, 5, 2, '2022-09-21', '18:30:00', '19:39:00', 69, 3641, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4216', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2066, 5, 2, '2022-09-21', '19:39:00', '19:49:00', 10, 3630, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4216', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2067, 5, 2, '2022-09-21', '19:49:00', '23:00:00', 191, 3434, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4216', 9, 4511, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2068, 5, 3, '2022-09-21', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4216', 30, 15019, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2069, 5, 1, '2022-09-22', '07:00:00', '15:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4216', 30, 15015, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2070, 5, 2, '2022-09-22', '15:00:00', '17:22:00', 142, 3434, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4216', 11, 5508, 272, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2071, 5, 2, '2022-09-22', '17:22:00', '17:32:00', 10, 3629, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4216', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2072, 5, 2, '2022-09-22', '17:32:00', '18:51:00', 79, 3625, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4216', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2073, 5, 2, '2022-09-22', '18:51:00', '19:40:00', 49, 3641, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4217', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2074, 5, 2, '2022-09-22', '19:40:00', '19:50:00', 10, 3630, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4217', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2075, 5, 2, '2022-09-22', '19:50:00', '23:00:00', 190, 3434, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4217', 9, 4506, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2076, 5, 3, '2022-09-22', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4217', 29, 14515, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2077, 5, 1, '2022-09-23', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4217', 30, 15008, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2078, 5, 2, '2022-09-23', '15:00:00', '17:37:00', 157, 3434, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4217', 11, 5513, 225, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2079, 5, 2, '2022-09-23', '17:37:00', '17:47:00', 10, 3629, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4217', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2080, 5, 2, '2022-09-23', '17:47:00', '19:06:00', 79, 3625, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4217', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2081, 5, 2, '2022-09-23', '19:06:00', '19:10:00', 4, 3641, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4218', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2082, 5, 2, '2022-09-23', '19:10:00', '19:20:00', 10, 3630, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4218', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2083, 5, 2, '2022-09-23', '19:20:00', '23:00:00', 220, 3434, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4218', 11, 5508, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2084, 5, 3, '2022-09-23', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4218', 30, 11511, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2085, 5, 1, '2022-09-24', '07:00:00', '15:00:00', 480, 3434, '', 'SMI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4218', 31, 15506, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2086, 5, 2, '2022-09-24', '15:00:00', '16:50:00', 110, 3434, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4218', 9, 4503, 240, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2087, 5, 2, '2022-09-24', '16:50:00', '17:00:00', 10, 3629, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4218', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2088, 5, 2, '2022-09-24', '17:00:00', '18:19:00', 79, 3625, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4218', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2089, 5, 2, '2022-09-24', '18:19:00', '18:23:00', 4, 3641, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4219', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2090, 5, 2, '2022-09-24', '18:23:00', '18:33:00', 10, 3630, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4219', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2091, 5, 2, '2022-09-24', '18:33:00', '23:00:00', 267, 3434, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4219', 14, 7008, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2092, 5, 3, '2022-09-24', '23:00:00', '07:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4219', 30, 15016, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2093, 5, 1, '2022-09-25', '07:00:00', '15:00:00', 480, 3434, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4219', 30, 15023, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2094, 5, 2, '2022-09-25', '15:00:00', '16:27:00', 87, 3434, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4219', 6, 3003, 145, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2095, 5, 2, '2022-09-25', '16:27:00', '16:37:00', 10, 3629, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4219', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2096, 5, 2, '2022-09-25', '16:37:00', '17:56:00', 79, 3625, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4219', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2097, 5, 2, '2022-09-25', '17:56:00', '18:00:00', 4, 3641, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4220', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2098, 5, 2, '2022-09-25', '18:00:00', '18:10:00', 10, 3630, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4220', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2099, 5, 2, '2022-09-25', '18:10:00', '23:00:00', 290, 3434, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4220', 16, 8009, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2100, 5, 3, '2022-09-25', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4220', 30, 15008, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2101, 5, 1, '2022-09-26', '07:00:00', '08:04:00', 64, 3434, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4220', 6, 2620, 260, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2102, 5, 1, '2022-09-26', '08:04:00', '08:24:00', 20, 3631, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4220', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2103, 5, 1, '2022-09-26', '08:24:00', '15:00:00', 396, 3441, '', 'NHS', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4220', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2104, 5, 2, '2022-09-26', '15:00:00', '23:00:00', 480, 3441, '', 'YHI', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4220', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2105, 5, 3, '2022-09-26', '23:00:00', '04:50:00', 350, 3441, 'Pemasangan RV 530 susah aa gesekan saat pengchekan', 'NSA', 'KSD2-IACKS002', 'CHIL KID SOYA BASE R22 POWDER (KMI)', 'PD-4220', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2106, 5, 3, '2022-09-26', '04:50:00', '06:50:00', 120, 3646, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4221', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2107, 5, 3, '2022-09-26', '06:50:00', '07:00:00', 10, 3641, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4221', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2108, 5, 1, '2022-09-27', '07:00:00', '08:17:00', 77, 3641, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4221', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2109, 5, 1, '2022-09-27', '08:17:00', '08:27:00', 10, 3630, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4221', 0, 0, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2110, 5, 1, '2022-09-27', '08:27:00', '15:00:00', 393, 3434, '', 'NHS', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4221', 20, 12562, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2111, 5, 2, '2022-09-27', '15:00:00', '23:00:00', 480, 3434, '', 'YHI', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4221', 25, 16269, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2112, 5, 3, '2022-09-27', '23:00:00', '07:00:00', 480, 3434, '', 'NSA', 'KSD2-IACKP001', 'CHIL KID PLATINUM BASE POWDER (R21) KMI', 'PD-4221', 28, 18213, 0, NULL, 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0),
(2113, 5, 1, '2022-10-01', '07:00:00', '07:40:00', 40, 3434, 'Lancar', 'JCK - YHI', 'KSD2-IABRE007', 'BMT REGULER BASE POWDER (R21) KMI', 'PD-4250', 5, 5, NULL, NULL, NULL, NULL, 'Abdur', NULL, NULL, NULL, NULL, NULL, NULL),
(2114, 5, 1, '2022-10-02', '07:00:00', '07:50:00', 50, 3625, NULL, NULL, 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4251', NULL, NULL, 10, 'SIEVER DRIER', NULL, 10, 'Mamat', 20, NULL, NULL, NULL, NULL, 5),
(2115, 5, 1, '2022-10-03', '07:00:00', '07:20:00', 20, 3624, 'ABCDEF', 'APPS', 'KSD2-IABPL005', 'BMT BASE POWDER (R21)', 'PD-5000', 5, 5, 5, 'SIEVER DRIER', 5, 10, 'Abdel', 10, 10, 'Fastener', 'Machine Weakness', 'AM', 3),
(2116, 5, 1, '2022-09-28', '07:00:00', '07:10:00', 10, 3435, 'sss', NULL, 'KSD2-IABPL005', 'BMT PLATINUM BASE POWDER (R21) KMI', 'PD-4252', 23, 2322, 12, 'BAG STATION DRIER', 13, 12, 'Pamil', 12, 23, 'Lubrication', 'Machine Weakness', 'PM', 12),
(2117, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2118, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2119, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2120, 5, NULL, NULL, '07:40:00', '08:20:00', 40, 3446, NULL, 'AHR - ANR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2121, 5, NULL, NULL, '07:40:00', '08:20:00', 40, 3446, NULL, 'AHR - ANR', 'KSD2-IACMR009', 'CHIL MIL REGULER-RVT 21 BASE POWDER (KMI)', 'PD-4251', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2122, 5, 1, '2022-10-01', '07:40:00', '08:30:00', 50, 3447, NULL, 'AHR - ANR', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `submenu`
--

CREATE TABLE `submenu` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `txturl` varchar(64) NOT NULL,
  `txttitle` varchar(64) NOT NULL,
  `txtroute` varchar(64) NOT NULL,
  `txticon` varchar(64) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `submenu`
--

INSERT INTO `submenu` (`id`, `menu_id`, `txturl`, `txttitle`, `txtroute`, `txticon`, `created_at`, `updated_at`) VALUES
(1, 2, '/admin/line', 'Line Process', 'manage.line.index', 'fa-solid fa-house-signal', '2022-09-30 09:12:13', '2022-09-30 09:12:13'),
(2, 2, '/admin/machines', 'Machines', 'manage.machine.index', 'fas fa-cog', '2022-09-30 09:12:47', '2022-09-30 09:12:47'),
(3, 2, '/admin/product', 'Products', 'manage.product.index', 'fa-brands fa-product-hunt', '2022-09-30 09:13:40', '2022-09-30 09:13:40'),
(4, 2, '/admin/users', 'Management Users', 'manage.user.index', 'fa-solid fa-users', '2022-09-30 09:15:34', '2022-09-30 09:15:34'),
(5, 3, '/admin/shift', 'Shift Code', 'manage.shift.index', 'fas fa-user-clock', '2022-09-30 11:06:29', '2022-09-30 11:06:29'),
(6, 3, '/admin/machines', 'Daily Activites', 'manage.machine.index', 'fas fa-stopwatch', '2022-09-30 11:06:52', '2022-09-30 11:06:52'),
(7, 4, '/admin/planning', 'Work Order', 'manage.planning.index', 'fas fa-user-clock', '2022-09-30 14:06:30', '2022-09-30 14:06:30'),
(9, 14, '/admin/achievementoee', 'OEE', 'view.achievement.oee', 'fas fa-table', '2022-10-09 11:43:43', '2022-10-09 11:46:12'),
(10, 14, '/admin/achievementpoe', 'POE', 'view.achievement.poe', 'fas fa-table', '2022-10-09 11:44:11', '2022-10-09 11:46:16'),
(11, 2, '/admin/levels', 'Levels', 'manage.level.index', 'fas fa-user-tag', '2022-10-22 19:41:16', '2022-10-22 19:41:16'),
(12, 28, '/admin/server', 'Server MQTT', 'manage.server.index', 'fas fa-server', '2022-10-29 06:52:52', '2022-10-29 07:19:07'),
(13, 28, '/admin/topic', 'Manage Topic', 'manage.topic.index', 'fas fa-key', '2022-10-29 07:02:47', '2022-10-29 07:19:17'),
(14, 28, '/admin/topic-results', 'Topic Results', 'view.topic.result', 'fas fa-poll-h', '2022-11-01 18:53:04', '2022-11-01 18:53:04'),
(15, 4, '/ppic/planorder', 'Manage Plan Order', 'manage.planorder.index', 'fas fa-calendar', '2022-11-15 23:38:28', '2022-11-15 23:38:28');

-- --------------------------------------------------------

--
-- Table structure for table `tr_dailyactivity`
--

CREATE TABLE `tr_dailyactivity` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `working_id` bigint(20) UNSIGNED NOT NULL,
  `activity_id` bigint(20) UNSIGNED NOT NULL,
  `tmstart` time NOT NULL,
  `tmfinish` time NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tr_kpi`
--

CREATE TABLE `tr_kpi` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `kpi_id` bigint(20) UNSIGNED NOT NULL,
  `line_id` bigint(20) UNSIGNED NOT NULL,
  `ar` float NOT NULL,
  `pr` float NOT NULL,
  `qr` float NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_kpi`
--

INSERT INTO `tr_kpi` (`id`, `kpi_id`, `line_id`, `ar`, `pr`, `qr`, `created_at`, `updated_at`) VALUES
(1, 5, 1, 80, 84.5, 90, '2022-10-05 19:30:20', '2022-10-05 19:34:09'),
(4, 6, 1, 87.5, 88.6, 95, '2022-10-05 19:35:52', '2022-10-05 19:35:52');

-- --------------------------------------------------------

--
-- Table structure for table `tr_topic`
--

CREATE TABLE `tr_topic` (
  `topic_id` bigint(20) UNSIGNED NOT NULL,
  `txtname` varchar(64) NOT NULL,
  `txttopic` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tr_topic`
--

INSERT INTO `tr_topic` (`topic_id`, `txtname`, `txttopic`) VALUES
(13, 'COUNTING', 'topic/suspension/counting'),
(13, 'REJECTOR', 'topic/suspension/rejector'),
(14, 'COUNTING', 'topic/d03/counting'),
(14, 'STATUS', 'topic/d03/status');

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_calc_poe`
-- (See below for the actual view)
--
CREATE TABLE `v_calc_poe` (
`id` bigint(20) unsigned
,`line_id` bigint(20) unsigned
,`tanggal` date
,`shift_id` bigint(20)
,`okp` varchar(128)
,`product` varchar(128)
,`std_speed` float
,`actual_speed` decimal(12,2)
,`speed_loss` decimal(10,2)
,`defect_loss` decimal(10,2)
,`downtime_loss` decimal(35,0)
,`total_mi` decimal(32,0)
,`total_sh` decimal(32,0)
,`total_downtime` decimal(34,0)
,`working_time` decimal(32,0)
,`loading_time` decimal(33,0)
,`operating_time` decimal(32,0)
,`net_optime` decimal(35,2)
,`value_adding` double
,`ar` decimal(10,2)
,`pr` decimal(10,2)
,`qr` decimal(10,2)
,`oee` decimal(10,2)
,`total_output` decimal(10,2)
,`utilization_rate` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_daily_poe`
-- (See below for the actual view)
--
CREATE TABLE `v_daily_poe` (
`tanggal` date
,`line_id` bigint(20) unsigned
,`total_output` decimal(32,2)
,`sum_total` decimal(10,2)
,`ar` decimal(10,2)
,`pr` decimal(10,2)
,`qr` decimal(10,2)
,`oee` decimal(10,2)
,`percent` decimal(10,2)
,`hasil` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_downtime_day`
-- (See below for the actual view)
--
CREATE TABLE `v_downtime_day` (
`tanggal` date
,`line_id` bigint(20) unsigned
,`durasi` decimal(32,0)
,`activity_id` bigint(20) unsigned
,`txtactivitycode` char(16)
,`txtcategory` char(100)
,`txtdescription` text
,`remark` text
,`frequency` bigint(21)
,`detail` json
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_downtime_month`
-- (See below for the actual view)
--
CREATE TABLE `v_downtime_month` (
`tanggal` date
,`month` varchar(9)
,`line_id` bigint(20) unsigned
,`durasi` decimal(32,0)
,`activity_id` bigint(20) unsigned
,`txtactivitycode` char(16)
,`txtcategory` char(100)
,`txtdescription` text
,`remark` text
,`frequency` bigint(21)
,`detail` json
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_downtime_shift`
-- (See below for the actual view)
--
CREATE TABLE `v_downtime_shift` (
`tanggal` date
,`shift` varchar(39)
,`line_id` bigint(20) unsigned
,`durasi` decimal(32,0)
,`activity_id` bigint(20) unsigned
,`txtactivitycode` char(16)
,`txtcategory` char(100)
,`txtdescription` text
,`remark` text
,`frequency` bigint(21)
,`detail` json
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_downtime_week`
-- (See below for the actual view)
--
CREATE TABLE `v_downtime_week` (
`tanggal` date
,`week` varchar(14)
,`line_id` bigint(20) unsigned
,`durasi` decimal(32,0)
,`activity_id` bigint(20) unsigned
,`txtactivitycode` char(16)
,`txtcategory` char(100)
,`txtdescription` text
,`remark` text
,`frequency` bigint(21)
,`detail` json
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_drier_daily`
-- (See below for the actual view)
--
CREATE TABLE `v_drier_daily` (
`id` bigint(20) unsigned
,`line_id` bigint(20) unsigned
,`tanggal` date
,`shift_id` bigint(20)
,`okp_drier` varchar(128)
,`product` varchar(128)
,`working_time` decimal(32,0)
,`downtime_loss` decimal(35,0)
,`loading_time` decimal(33,0)
,`operating_time` decimal(32,0)
,`net_optime` decimal(10,2)
,`total_output` decimal(10,2)
,`standar_speed` float
,`actual_speed` decimal(10,2)
,`speed_loss` decimal(10,2)
,`defect` decimal(10,2)
,`total_mi` decimal(32,0)
,`total_sh` decimal(32,0)
,`total_downtime` decimal(34,0)
,`value_adding` decimal(10,2)
,`ar` decimal(10,2)
,`pr` decimal(10,2)
,`qr` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_month_poe`
-- (See below for the actual view)
--
CREATE TABLE `v_month_poe` (
`tanggal` date
,`line_id` bigint(20) unsigned
,`total_output` decimal(32,2)
,`sum_total` decimal(10,2)
,`ar` decimal(10,2)
,`pr` decimal(10,2)
,`qr` decimal(10,2)
,`oee` decimal(10,2)
,`percent` decimal(10,4)
,`hasil` decimal(10,2)
,`utilization_rate` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_oee_daily`
-- (See below for the actual view)
--
CREATE TABLE `v_oee_daily` (
`id` bigint(20) unsigned
,`okp_packing` varchar(128)
,`tanggal` date
,`line_id` bigint(20) unsigned
,`shift_id` bigint(20)
,`produk` varchar(128)
,`floatstdspeed` float
,`actual_speed` decimal(10,0)
,`speed_loss` decimal(10,2)
,`defect_loss` decimal(10,2)
,`working_time` decimal(32,0)
,`downtime_loss` decimal(35,0)
,`total_mi` decimal(32,0)
,`operating_time` decimal(32,0)
,`total_sh` decimal(32,0)
,`net_optime` decimal(35,2)
,`value_adding` double
,`loading_time` decimal(33,0)
,`total_downtime` decimal(34,0)
,`total_reject` decimal(10,1)
,`fg` decimal(42,0)
,`qc_sample` decimal(32,0)
,`rework` decimal(40,4)
,`defect` decimal(41,4)
,`total_output` decimal(49,4)
,`output_kg` decimal(10,2)
,`avaibility_rate` decimal(10,2)
,`performance_rate` decimal(10,2)
,`quality_rate` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_oee_shift`
-- (See below for the actual view)
--
CREATE TABLE `v_oee_shift` (
`id` bigint(20) unsigned
,`okp_packing` varchar(128)
,`tanggal` date
,`line_id` bigint(20) unsigned
,`shift_id` bigint(20)
,`produk` varchar(128)
,`floatstdspeed` float
,`actual_speed` decimal(10,0)
,`speed_loss` decimal(10,2)
,`defect_loss` decimal(10,2)
,`working_time` decimal(32,0)
,`downtime_loss` decimal(35,0)
,`total_mi` decimal(32,0)
,`operating_time` decimal(32,0)
,`total_sh` decimal(32,0)
,`net_optime` decimal(35,2)
,`value_adding` double
,`loading_time` decimal(33,0)
,`total_downtime` decimal(34,0)
,`total_reject` decimal(10,1)
,`fg` decimal(42,0)
,`qc_sample` decimal(32,0)
,`rework` decimal(40,4)
,`defect` decimal(41,4)
,`total_output` decimal(49,4)
,`output_kg` decimal(10,2)
,`avaibility_rate` decimal(10,2)
,`performance_rate` decimal(10,2)
,`quality_rate` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_percent_poe`
-- (See below for the actual view)
--
CREATE TABLE `v_percent_poe` (
`tanggal` date
,`line_id` bigint(20) unsigned
,`total` decimal(32,2)
,`oee` decimal(10,2)
,`sum_total` decimal(32,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_week_poe`
-- (See below for the actual view)
--
CREATE TABLE `v_week_poe` (
`week` int(2)
,`month` varchar(9)
,`year` int(4)
,`line_id` bigint(20) unsigned
,`total_output` decimal(32,2)
,`sum_total` decimal(10,2)
,`ar` decimal(10,2)
,`pr` decimal(10,2)
,`qr` decimal(10,2)
,`oee` decimal(10,2)
,`percent` decimal(10,2)
,`hasil` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_year_poe`
-- (See below for the actual view)
--
CREATE TABLE `v_year_poe` (
`tanggal` date
,`line_id` bigint(20) unsigned
,`total_output` decimal(32,2)
,`sum_total` decimal(10,2)
,`ar` decimal(10,2)
,`pr` decimal(10,2)
,`qr` decimal(10,2)
,`oee` decimal(10,2)
,`percent` decimal(10,4)
,`hasil` decimal(10,2)
,`utilization_rate` decimal(10,2)
);

-- --------------------------------------------------------

--
-- Structure for view `v_calc_poe`
--
DROP TABLE IF EXISTS `v_calc_poe`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_calc_poe`  AS   (select `poe`.`id` AS `id`,`poe`.`line_id` AS `line_id`,`poe`.`tanggal` AS `tanggal`,`poe`.`shift_id` AS `shift_id`,`poe`.`okp` AS `okp`,`poe`.`product` AS `product`,`poe`.`std_speed` AS `std_speed`,`poe`.`actual_speed` AS `actual_speed`,`poe`.`speed_loss` AS `speed_loss`,`poe`.`defect_loss` AS `defect_loss`,`poe`.`downtime_loss` AS `downtime_loss`,`poe`.`total_mi` AS `total_mi`,`poe`.`total_sh` AS `total_sh`,`poe`.`total_downtime` AS `total_downtime`,`poe`.`working_time` AS `working_time`,`poe`.`loading_time` AS `loading_time`,`poe`.`operating_time` AS `operating_time`,`poe`.`net_optime` AS `net_optime`,`poe`.`value_adding` AS `value_adding`,`poe`.`ar` AS `ar`,`poe`.`pr` AS `pr`,`poe`.`qr` AS `qr`,`poe`.`oee` AS `oee`,`poe`.`total_output` AS `total_output`,cast(((`poe`.`loading_time` / `poe`.`working_time`) * 100) as decimal(10,2)) AS `utilization_rate` from (select `v_drier_daily`.`id` AS `id`,`v_drier_daily`.`line_id` AS `line_id`,`v_drier_daily`.`tanggal` AS `tanggal`,`v_drier_daily`.`shift_id` AS `shift_id`,`v_drier_daily`.`okp_drier` AS `okp`,`v_drier_daily`.`product` AS `product`,`v_drier_daily`.`standar_speed` AS `std_speed`,`v_drier_daily`.`actual_speed` AS `actual_speed`,`v_drier_daily`.`speed_loss` AS `speed_loss`,`v_drier_daily`.`defect` AS `defect_loss`,`v_drier_daily`.`downtime_loss` AS `downtime_loss`,`v_drier_daily`.`total_mi` AS `total_mi`,`v_drier_daily`.`total_sh` AS `total_sh`,`v_drier_daily`.`total_downtime` AS `total_downtime`,`v_drier_daily`.`working_time` AS `working_time`,`v_drier_daily`.`loading_time` AS `loading_time`,`v_drier_daily`.`operating_time` AS `operating_time`,`v_drier_daily`.`net_optime` AS `net_optime`,`v_drier_daily`.`value_adding` AS `value_adding`,`v_drier_daily`.`ar` AS `ar`,`v_drier_daily`.`pr` AS `pr`,`v_drier_daily`.`qr` AS `qr`,cast(((((`v_drier_daily`.`ar` / 100) * (`v_drier_daily`.`pr` / 100)) * (`v_drier_daily`.`qr` / 100)) * 100) as decimal(10,2)) AS `oee`,cast(`v_drier_daily`.`total_output` as decimal(10,2)) AS `total_output` from `v_drier_daily` union all select `v_oee_daily`.`id` AS `id`,`v_oee_daily`.`line_id` AS `line_id`,`v_oee_daily`.`tanggal` AS `tanggal`,`v_oee_daily`.`shift_id` AS `shift_id`,`v_oee_daily`.`okp_packing` AS `okp`,`v_oee_daily`.`produk` AS `product`,`v_oee_daily`.`floatstdspeed` AS `std_speed`,`v_oee_daily`.`actual_speed` AS `actual_speed`,`v_oee_daily`.`speed_loss` AS `speed_loss`,`v_oee_daily`.`defect_loss` AS `defect_loss`,`v_oee_daily`.`downtime_loss` AS `downtime_loss`,`v_oee_daily`.`total_mi` AS `total_mi`,`v_oee_daily`.`total_sh` AS `total_sh`,`v_oee_daily`.`total_downtime` AS `total_downtime`,`v_oee_daily`.`working_time` AS `working_time`,`v_oee_daily`.`loading_time` AS `loading_time`,`v_oee_daily`.`operating_time` AS `operating_time`,`v_oee_daily`.`net_optime` AS `net_optime`,`v_oee_daily`.`value_adding` AS `value_adding`,`v_oee_daily`.`avaibility_rate` AS `ar`,`v_oee_daily`.`performance_rate` AS `pr`,`v_oee_daily`.`quality_rate` AS `qr`,cast(((((`v_oee_daily`.`avaibility_rate` / 100) * (`v_oee_daily`.`performance_rate` / 100)) * (`v_oee_daily`.`quality_rate` / 100)) * 100) as decimal(10,2)) AS `oee`,cast((`v_oee_daily`.`output_kg` / 1000) as decimal(10,2)) AS `total_output` from `v_oee_daily`) `poe`)  ;

-- --------------------------------------------------------

--
-- Structure for view `v_daily_poe`
--
DROP TABLE IF EXISTS `v_daily_poe`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_daily_poe`  AS   (select `vcp`.`tanggal` AS `tanggal`,`vcp`.`line_id` AS `line_id`,sum(`vcp`.`total_output`) AS `total_output`,cast((select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (`v_calc_poe`.`tanggal` = `vcp`.`tanggal`) group by `v_calc_poe`.`tanggal`) as decimal(10,2)) AS `sum_total`,cast(((sum(`vcp`.`operating_time`) / sum(`vcp`.`loading_time`)) * 100) as decimal(10,2)) AS `ar`,cast(((sum(`vcp`.`net_optime`) / sum(`vcp`.`operating_time`)) * 100) as decimal(10,2)) AS `pr`,cast(((sum(`vcp`.`value_adding`) / sum(`vcp`.`net_optime`)) * 100) as decimal(10,2)) AS `qr`,cast(((((sum(`vcp`.`operating_time`) / sum(`vcp`.`loading_time`)) * (sum(`vcp`.`net_optime`) / sum(`vcp`.`operating_time`))) * (sum(`vcp`.`value_adding`) / sum(`vcp`.`net_optime`))) * 100) as decimal(10,2)) AS `oee`,cast((sum(`vcp`.`total_output`) / cast((select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (`v_calc_poe`.`tanggal` = `vcp`.`tanggal`) group by `v_calc_poe`.`tanggal`) as decimal(10,2))) as decimal(10,2)) AS `percent`,cast(((sum(`vcp`.`total_output`) / cast((select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (`v_calc_poe`.`tanggal` = `vcp`.`tanggal`) group by `v_calc_poe`.`tanggal`) as decimal(10,2))) * ((((sum(`vcp`.`operating_time`) / sum(`vcp`.`loading_time`)) * (sum(`vcp`.`net_optime`) / sum(`vcp`.`operating_time`))) * (sum(`vcp`.`value_adding`) / sum(`vcp`.`net_optime`))) * 100)) as decimal(10,2)) AS `hasil` from `v_calc_poe` `vcp` group by `vcp`.`tanggal`,`vcp`.`line_id`)  ;

-- --------------------------------------------------------

--
-- Structure for view `v_downtime_day`
--
DROP TABLE IF EXISTS `v_downtime_day`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_downtime_day`  AS   (select `downtime`.`tanggal` AS `tanggal`,`downtime`.`line_id` AS `line_id`,`downtime`.`durasi` AS `durasi`,`downtime`.`activity_id` AS `activity_id`,`downtime`.`txtactivitycode` AS `txtactivitycode`,`downtime`.`txtcategory` AS `txtcategory`,`downtime`.`txtdescription` AS `txtdescription`,`downtime`.`remark` AS `remark`,`downtime`.`frequency` AS `frequency`,`downtime`.`detail` AS `detail` from (select `oee`.`tanggal` AS `tanggal`,`oee`.`shift_id` AS `shift_id`,`oee`.`line_id` AS `line_id`,sum(`oee`.`lamakejadian`) AS `durasi`,`oee`.`activity_id` AS `activity_id`,`mact`.`txtactivitycode` AS `txtactivitycode`,`mact`.`txtcategory` AS `txtcategory`,`mact`.`txtdescription` AS `txtdescription`,`oee`.`remark` AS `remark`,count(`mact`.`txtactivitycode`) AS `frequency`,json_arrayagg(json_object('act_code',`mact`.`txtactivitycode`,'start',cast(`oee`.`start` as char charset utf8),'finish',cast(`oee`.`finish` as char charset utf8),'okp',`oee`.`okp_packing`,'produk',`oee`.`produk`,'remark',`oee`.`remark`)) AS `detail` from (`oee` join (select `mactivitycode`.`id` AS `id`,`mactivitycode`.`line_id` AS `line_id`,`mactivitycode`.`txtactivitycode` AS `txtactivitycode`,`mactivitycode`.`txtcategory` AS `txtcategory`,`mactivitycode`.`txtactivityname` AS `txtactivityname`,`mactivitycode`.`txtactivityitem` AS `txtactivityitem`,`mactivitycode`.`txtdescription` AS `txtdescription`,`mactivitycode`.`created_at` AS `created_at`,`mactivitycode`.`updated_at` AS `updated_at` from `mactivitycode` where (`mactivitycode`.`txtcategory` <> 'pr')) `mact` on((`mact`.`id` = `oee`.`activity_id`))) group by `oee`.`tanggal`,`oee`.`line_id`,`mact`.`txtactivitycode` union all select `oee_drier`.`tanggal` AS `tanggal`,`oee_drier`.`shift_id` AS `shift_id`,`oee_drier`.`line_id` AS `line_id`,sum(`oee_drier`.`lamakejadian`) AS `durasi`,`oee_drier`.`activity_id` AS `activity_id`,`mact`.`txtactivitycode` AS `txtactivitycode`,`mact`.`txtcategory` AS `txtcategory`,`mact`.`txtdescription` AS `txtdescription`,`oee_drier`.`remark` AS `remark`,count(`mact`.`txtactivitycode`) AS `frequency`,json_arrayagg(json_object('act_code',`mact`.`txtactivitycode`,'start',cast(`oee_drier`.`start` as char charset utf8),'finish',cast(`oee_drier`.`finish` as char charset utf8),'okp',`oee_drier`.`okp_drier`,'produk',`oee_drier`.`produk`,'remark',`oee_drier`.`remark`)) AS `detail` from (`oee_drier` join (select `mactivitycode`.`id` AS `id`,`mactivitycode`.`line_id` AS `line_id`,`mactivitycode`.`txtactivitycode` AS `txtactivitycode`,`mactivitycode`.`txtcategory` AS `txtcategory`,`mactivitycode`.`txtactivityname` AS `txtactivityname`,`mactivitycode`.`txtactivityitem` AS `txtactivityitem`,`mactivitycode`.`txtdescription` AS `txtdescription`,`mactivitycode`.`created_at` AS `created_at`,`mactivitycode`.`updated_at` AS `updated_at` from `mactivitycode` where (`mactivitycode`.`txtcategory` <> 'pr')) `mact` on((`mact`.`id` = `oee_drier`.`activity_id`))) group by `oee_drier`.`tanggal`,`oee_drier`.`line_id`,`mact`.`txtactivitycode`) `downtime` group by `downtime`.`tanggal`,`downtime`.`line_id`,`downtime`.`txtactivitycode` order by `downtime`.`tanggal`,`downtime`.`line_id`)  ;

-- --------------------------------------------------------

--
-- Structure for view `v_downtime_month`
--
DROP TABLE IF EXISTS `v_downtime_month`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_downtime_month`  AS   (select `downtime`.`tanggal` AS `tanggal`,monthname(`downtime`.`tanggal`) AS `month`,`downtime`.`line_id` AS `line_id`,`downtime`.`durasi` AS `durasi`,`downtime`.`activity_id` AS `activity_id`,`downtime`.`txtactivitycode` AS `txtactivitycode`,`downtime`.`txtcategory` AS `txtcategory`,`downtime`.`txtdescription` AS `txtdescription`,`downtime`.`remark` AS `remark`,`downtime`.`frequency` AS `frequency`,`downtime`.`detail` AS `detail` from (select `oee`.`tanggal` AS `tanggal`,`oee`.`shift_id` AS `shift_id`,`oee`.`line_id` AS `line_id`,sum(`oee`.`lamakejadian`) AS `durasi`,`oee`.`activity_id` AS `activity_id`,`mact`.`txtactivitycode` AS `txtactivitycode`,`mact`.`txtcategory` AS `txtcategory`,`mact`.`txtdescription` AS `txtdescription`,`oee`.`remark` AS `remark`,count(`mact`.`txtactivitycode`) AS `frequency`,json_arrayagg(json_object('act_code',`mact`.`txtactivitycode`,'start',cast(`oee`.`start` as char charset utf8),'finish',cast(`oee`.`finish` as char charset utf8),'okp',`oee`.`okp_packing`,'produk',`oee`.`produk`,'remark',`oee`.`remark`)) AS `detail` from (`oee` join (select `mactivitycode`.`id` AS `id`,`mactivitycode`.`line_id` AS `line_id`,`mactivitycode`.`txtactivitycode` AS `txtactivitycode`,`mactivitycode`.`txtcategory` AS `txtcategory`,`mactivitycode`.`txtactivityname` AS `txtactivityname`,`mactivitycode`.`txtactivityitem` AS `txtactivityitem`,`mactivitycode`.`txtdescription` AS `txtdescription`,`mactivitycode`.`created_at` AS `created_at`,`mactivitycode`.`updated_at` AS `updated_at` from `mactivitycode` where (`mactivitycode`.`txtcategory` <> 'pr')) `mact` on((`mact`.`id` = `oee`.`activity_id`))) group by month(`oee`.`tanggal`),`oee`.`line_id`,`mact`.`txtactivitycode` union all select `oee_drier`.`tanggal` AS `tanggal`,`oee_drier`.`shift_id` AS `shift_id`,`oee_drier`.`line_id` AS `line_id`,sum(`oee_drier`.`lamakejadian`) AS `durasi`,`oee_drier`.`activity_id` AS `activity_id`,`mact`.`txtactivitycode` AS `txtactivitycode`,`mact`.`txtcategory` AS `txtcategory`,`mact`.`txtdescription` AS `txtdescription`,`oee_drier`.`remark` AS `remark`,count(`mact`.`txtactivitycode`) AS `frequency`,json_arrayagg(json_object('act_code',`mact`.`txtactivitycode`,'start',cast(`oee_drier`.`start` as char charset utf8),'finish',cast(`oee_drier`.`finish` as char charset utf8),'okp',`oee_drier`.`okp_drier`,'produk',`oee_drier`.`produk`,'remark',`oee_drier`.`remark`)) AS `detail` from (`oee_drier` join (select `mactivitycode`.`id` AS `id`,`mactivitycode`.`line_id` AS `line_id`,`mactivitycode`.`txtactivitycode` AS `txtactivitycode`,`mactivitycode`.`txtcategory` AS `txtcategory`,`mactivitycode`.`txtactivityname` AS `txtactivityname`,`mactivitycode`.`txtactivityitem` AS `txtactivityitem`,`mactivitycode`.`txtdescription` AS `txtdescription`,`mactivitycode`.`created_at` AS `created_at`,`mactivitycode`.`updated_at` AS `updated_at` from `mactivitycode` where (`mactivitycode`.`txtcategory` <> 'pr')) `mact` on((`mact`.`id` = `oee_drier`.`activity_id`))) group by month(`oee_drier`.`tanggal`),`oee_drier`.`line_id`,`mact`.`txtactivitycode`) `downtime` group by month(`downtime`.`tanggal`),`downtime`.`line_id`,`downtime`.`txtactivitycode` order by `downtime`.`tanggal`,`downtime`.`line_id`)  ;

-- --------------------------------------------------------

--
-- Structure for view `v_downtime_shift`
--
DROP TABLE IF EXISTS `v_downtime_shift`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_downtime_shift`  AS   (select `downtime`.`tanggal` AS `tanggal`,concat(`downtime`.`tanggal`,' - SHIFT ',`downtime`.`shift_id`) AS `shift`,`downtime`.`line_id` AS `line_id`,`downtime`.`durasi` AS `durasi`,`downtime`.`activity_id` AS `activity_id`,`downtime`.`txtactivitycode` AS `txtactivitycode`,`downtime`.`txtcategory` AS `txtcategory`,`downtime`.`txtdescription` AS `txtdescription`,`downtime`.`remark` AS `remark`,`downtime`.`frequency` AS `frequency`,`downtime`.`detail` AS `detail` from (select `oee`.`tanggal` AS `tanggal`,`oee`.`shift_id` AS `shift_id`,`oee`.`line_id` AS `line_id`,sum(`oee`.`lamakejadian`) AS `durasi`,`oee`.`activity_id` AS `activity_id`,`mact`.`txtactivitycode` AS `txtactivitycode`,`mact`.`txtcategory` AS `txtcategory`,`mact`.`txtdescription` AS `txtdescription`,`oee`.`remark` AS `remark`,count(`mact`.`txtactivitycode`) AS `frequency`,json_arrayagg(json_object('act_code',`mact`.`txtactivitycode`,'start',cast(`oee`.`start` as char charset utf8),'finish',cast(`oee`.`finish` as char charset utf8),'okp',`oee`.`okp_packing`,'produk',`oee`.`produk`,'remark',`oee`.`remark`)) AS `detail` from (`oee` join (select `mactivitycode`.`id` AS `id`,`mactivitycode`.`line_id` AS `line_id`,`mactivitycode`.`txtactivitycode` AS `txtactivitycode`,`mactivitycode`.`txtcategory` AS `txtcategory`,`mactivitycode`.`txtactivityname` AS `txtactivityname`,`mactivitycode`.`txtactivityitem` AS `txtactivityitem`,`mactivitycode`.`txtdescription` AS `txtdescription`,`mactivitycode`.`created_at` AS `created_at`,`mactivitycode`.`updated_at` AS `updated_at` from `mactivitycode` where (`mactivitycode`.`txtcategory` <> 'pr')) `mact` on((`mact`.`id` = `oee`.`activity_id`))) group by `oee`.`tanggal`,`oee`.`shift_id`,`oee`.`line_id`,`mact`.`txtactivitycode` union all select `oee_drier`.`tanggal` AS `tanggal`,`oee_drier`.`shift_id` AS `shift_id`,`oee_drier`.`line_id` AS `line_id`,sum(`oee_drier`.`lamakejadian`) AS `durasi`,`oee_drier`.`activity_id` AS `activity_id`,`mact`.`txtactivitycode` AS `txtactivitycode`,`mact`.`txtcategory` AS `txtcategory`,`mact`.`txtdescription` AS `txtdescription`,`oee_drier`.`remark` AS `remark`,count(`mact`.`txtactivitycode`) AS `frequency`,json_arrayagg(json_object('act_code',`mact`.`txtactivitycode`,'start',cast(`oee_drier`.`start` as char charset utf8),'finish',cast(`oee_drier`.`finish` as char charset utf8),'okp',`oee_drier`.`okp_drier`,'produk',`oee_drier`.`produk`,'remark',`oee_drier`.`remark`)) AS `detail` from (`oee_drier` join (select `mactivitycode`.`id` AS `id`,`mactivitycode`.`line_id` AS `line_id`,`mactivitycode`.`txtactivitycode` AS `txtactivitycode`,`mactivitycode`.`txtcategory` AS `txtcategory`,`mactivitycode`.`txtactivityname` AS `txtactivityname`,`mactivitycode`.`txtactivityitem` AS `txtactivityitem`,`mactivitycode`.`txtdescription` AS `txtdescription`,`mactivitycode`.`created_at` AS `created_at`,`mactivitycode`.`updated_at` AS `updated_at` from `mactivitycode` where (`mactivitycode`.`txtcategory` <> 'pr')) `mact` on((`mact`.`id` = `oee_drier`.`activity_id`))) group by `oee_drier`.`tanggal`,`oee_drier`.`shift_id`,`oee_drier`.`line_id`,`mact`.`txtactivitycode`) `downtime` order by `downtime`.`tanggal`,`downtime`.`line_id`)  ;

-- --------------------------------------------------------

--
-- Structure for view `v_downtime_week`
--
DROP TABLE IF EXISTS `v_downtime_week`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_downtime_week`  AS   (select `downtime`.`tanggal` AS `tanggal`,concat(week(`downtime`.`tanggal`,0),' - ',monthname(`downtime`.`tanggal`)) AS `week`,`downtime`.`line_id` AS `line_id`,`downtime`.`durasi` AS `durasi`,`downtime`.`activity_id` AS `activity_id`,`downtime`.`txtactivitycode` AS `txtactivitycode`,`downtime`.`txtcategory` AS `txtcategory`,`downtime`.`txtdescription` AS `txtdescription`,`downtime`.`remark` AS `remark`,`downtime`.`frequency` AS `frequency`,`downtime`.`detail` AS `detail` from (select `oee`.`tanggal` AS `tanggal`,`oee`.`shift_id` AS `shift_id`,`oee`.`line_id` AS `line_id`,sum(`oee`.`lamakejadian`) AS `durasi`,`oee`.`activity_id` AS `activity_id`,`mact`.`txtactivitycode` AS `txtactivitycode`,`mact`.`txtcategory` AS `txtcategory`,`mact`.`txtdescription` AS `txtdescription`,`oee`.`remark` AS `remark`,count(`mact`.`txtactivitycode`) AS `frequency`,json_arrayagg(json_object('act_code',`mact`.`txtactivitycode`,'start',cast(`oee`.`start` as char charset utf8),'finish',cast(`oee`.`finish` as char charset utf8),'okp',`oee`.`okp_packing`,'produk',`oee`.`produk`,'remark',`oee`.`remark`)) AS `detail` from (`oee` join (select `mactivitycode`.`id` AS `id`,`mactivitycode`.`line_id` AS `line_id`,`mactivitycode`.`txtactivitycode` AS `txtactivitycode`,`mactivitycode`.`txtcategory` AS `txtcategory`,`mactivitycode`.`txtactivityname` AS `txtactivityname`,`mactivitycode`.`txtactivityitem` AS `txtactivityitem`,`mactivitycode`.`txtdescription` AS `txtdescription`,`mactivitycode`.`created_at` AS `created_at`,`mactivitycode`.`updated_at` AS `updated_at` from `mactivitycode` where (`mactivitycode`.`txtcategory` <> 'pr')) `mact` on((`mact`.`id` = `oee`.`activity_id`))) group by week(`oee`.`tanggal`,0),`oee`.`line_id`,`mact`.`txtactivitycode` union all select `oee_drier`.`tanggal` AS `tanggal`,`oee_drier`.`shift_id` AS `shift_id`,`oee_drier`.`line_id` AS `line_id`,sum(`oee_drier`.`lamakejadian`) AS `durasi`,`oee_drier`.`activity_id` AS `activity_id`,`mact`.`txtactivitycode` AS `txtactivitycode`,`mact`.`txtcategory` AS `txtcategory`,`mact`.`txtdescription` AS `txtdescription`,`oee_drier`.`remark` AS `remark`,count(`mact`.`txtactivitycode`) AS `frequency`,json_arrayagg(json_object('act_code',`mact`.`txtactivitycode`,'start',cast(`oee_drier`.`start` as char charset utf8),'finish',cast(`oee_drier`.`finish` as char charset utf8),'okp',`oee_drier`.`okp_drier`,'produk',`oee_drier`.`produk`,'remark',`oee_drier`.`remark`)) AS `detail` from (`oee_drier` join (select `mactivitycode`.`id` AS `id`,`mactivitycode`.`line_id` AS `line_id`,`mactivitycode`.`txtactivitycode` AS `txtactivitycode`,`mactivitycode`.`txtcategory` AS `txtcategory`,`mactivitycode`.`txtactivityname` AS `txtactivityname`,`mactivitycode`.`txtactivityitem` AS `txtactivityitem`,`mactivitycode`.`txtdescription` AS `txtdescription`,`mactivitycode`.`created_at` AS `created_at`,`mactivitycode`.`updated_at` AS `updated_at` from `mactivitycode` where (`mactivitycode`.`txtcategory` <> 'pr')) `mact` on((`mact`.`id` = `oee_drier`.`activity_id`))) group by week(`oee_drier`.`tanggal`,0),`oee_drier`.`line_id`,`mact`.`txtactivitycode`) `downtime` group by week(`downtime`.`tanggal`,0),`downtime`.`line_id`,`downtime`.`txtactivitycode` order by `downtime`.`tanggal`,`downtime`.`line_id`)  ;

-- --------------------------------------------------------

--
-- Structure for view `v_drier_daily`
--
DROP TABLE IF EXISTS `v_drier_daily`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_drier_daily`  AS   (select `drier`.`id` AS `id`,`drier`.`line_id` AS `line_id`,`drier`.`tanggal` AS `tanggal`,`drier`.`shift_id` AS `shift_id`,`drier`.`okp_drier` AS `okp_drier`,`prod`.`txtproductname` AS `product`,sum(`drier`.`lamakejadian`) AS `working_time`,(((sum(`drier`.`lamakejadian`) - sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end))) - sum((case when (`mact`.`txtcategory` = 'sh') then `drier`.`lamakejadian` else 0 end))) - sum((case when (`mact`.`txtcategory` = 'mi') then `drier`.`lamakejadian` else 0 end))) AS `downtime_loss`,(sum(`drier`.`lamakejadian`) - sum((case when (`mact`.`txtcategory` = 'sh') then `drier`.`lamakejadian` else 0 end))) AS `loading_time`,sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end)) AS `operating_time`,cast((sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end)) - (((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end))) / 60) - (((sum(`drier`.`output_kg`) + sum(`drier`.`rework`)) + sum(`drier`.`reject`)) / 1000)) / `prod`.`floatstdspeed`) * 60)) as decimal(10,2)) AS `net_optime`,cast((((sum(`drier`.`output_kg`) + sum(`drier`.`rework`)) + sum(`drier`.`reject`)) / 1000) as decimal(10,2)) AS `total_output`,`prod`.`floatstdspeed` AS `standar_speed`,cast((((((sum(`drier`.`output_kg`) + sum(`drier`.`rework`)) + sum(`drier`.`reject`)) / 1000) * 60) / sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end))) as decimal(10,2)) AS `actual_speed`,cast((((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end))) / 60) - (((sum(`drier`.`output_kg`) + sum(`drier`.`rework`)) + sum(`drier`.`reject`)) / 1000)) / `prod`.`floatstdspeed`) * 60) as decimal(10,2)) AS `speed_loss`,cast(((((sum(`drier`.`rework`) + sum(`drier`.`reject`)) / 1000) / `prod`.`floatstdspeed`) * 60) as decimal(10,2)) AS `defect`,sum((case when (`mact`.`txtcategory` = 'mi') then `drier`.`lamakejadian` else 0 end)) AS `total_mi`,sum((case when (`mact`.`txtcategory` = 'sh') then `drier`.`lamakejadian` else 0 end)) AS `total_sh`,((sum(`drier`.`lamakejadian`) - sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end))) - sum((case when (`mact`.`txtcategory` = 'sh') then `drier`.`lamakejadian` else 0 end))) AS `total_downtime`,cast(((sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end)) - (((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end))) / 60) - (((sum(`drier`.`output_kg`) + sum(`drier`.`rework`)) + sum(`drier`.`reject`)) / 1000)) / `prod`.`floatstdspeed`) * 60)) - ((((sum(`drier`.`rework`) + sum(`drier`.`reject`)) / 1000) / `prod`.`floatstdspeed`) * 60)) as decimal(10,2)) AS `value_adding`,cast(((sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end)) / (sum(`drier`.`lamakejadian`) - sum((case when (`mact`.`txtcategory` = 'sh') then `drier`.`lamakejadian` else 0 end)))) * 100) as decimal(10,2)) AS `ar`,cast((((sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end)) - (((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end))) / 60) - (((sum(`drier`.`output_kg`) + sum(`drier`.`rework`)) + sum(`drier`.`reject`)) / 1000)) / `prod`.`floatstdspeed`) * 60)) / sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end))) * 100) as decimal(10,2)) AS `pr`,cast(((((sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end)) - (((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end))) / 60) - (((sum(`drier`.`output_kg`) + sum(`drier`.`rework`)) + sum(`drier`.`reject`)) / 1000)) / `prod`.`floatstdspeed`) * 60)) - ((((sum(`drier`.`rework`) + sum(`drier`.`reject`)) / 1000) / `prod`.`floatstdspeed`) * 60)) / (sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end)) - (((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `drier`.`lamakejadian` else 0 end))) / 60) - (((sum(`drier`.`output_kg`) + sum(`drier`.`rework`)) + sum(`drier`.`reject`)) / 1000)) / `prod`.`floatstdspeed`) * 60))) * 100) as decimal(10,2)) AS `qr` from ((`oee_drier` `drier` join `mactivitycode` `mact` on((`mact`.`id` = `drier`.`activity_id`))) join `mproduct` `prod` on((`drier`.`produk_code` = `prod`.`txtartcode`))) group by `drier`.`tanggal`,`drier`.`shift_id`,`drier`.`okp_drier`)  ;

-- --------------------------------------------------------

--
-- Structure for view `v_month_poe`
--
DROP TABLE IF EXISTS `v_month_poe`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_month_poe`  AS   (select `vcp`.`tanggal` AS `tanggal`,`vcp`.`line_id` AS `line_id`,sum(`vcp`.`total_output`) AS `total_output`,cast((select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (month(`v_calc_poe`.`tanggal`) = month(`vcp`.`tanggal`)) group by month(`v_calc_poe`.`tanggal`)) as decimal(10,2)) AS `sum_total`,cast(((sum(`vcp`.`operating_time`) / sum(`vcp`.`loading_time`)) * 100) as decimal(10,2)) AS `ar`,cast(((sum(`vcp`.`net_optime`) / sum(`vcp`.`operating_time`)) * 100) as decimal(10,2)) AS `pr`,cast(((sum(`vcp`.`value_adding`) / sum(`vcp`.`net_optime`)) * 100) as decimal(10,2)) AS `qr`,cast(((((sum(`vcp`.`operating_time`) / sum(`vcp`.`loading_time`)) * (sum(`vcp`.`net_optime`) / sum(`vcp`.`operating_time`))) * (sum(`vcp`.`value_adding`) / sum(`vcp`.`net_optime`))) * 100) as decimal(10,2)) AS `oee`,cast((sum(`vcp`.`total_output`) / cast((select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (month(`v_calc_poe`.`tanggal`) = month(`vcp`.`tanggal`)) group by month(`v_calc_poe`.`tanggal`)) as decimal(10,2))) as decimal(10,4)) AS `percent`,cast(((sum(`vcp`.`total_output`) / cast((select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (month(`v_calc_poe`.`tanggal`) = month(`vcp`.`tanggal`)) group by month(`v_calc_poe`.`tanggal`)) as decimal(10,2))) * ((((sum(`vcp`.`operating_time`) / sum(`vcp`.`loading_time`)) * (sum(`vcp`.`net_optime`) / sum(`vcp`.`operating_time`))) * (sum(`vcp`.`value_adding`) / sum(`vcp`.`net_optime`))) * 100)) as decimal(10,2)) AS `hasil`,cast(((sum(`vcp`.`loading_time`) / sum(`vcp`.`working_time`)) * 100) as decimal(10,2)) AS `utilization_rate` from `v_calc_poe` `vcp` group by month(`vcp`.`tanggal`),`vcp`.`line_id`)  ;

-- --------------------------------------------------------

--
-- Structure for view `v_oee_daily`
--
DROP TABLE IF EXISTS `v_oee_daily`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_oee_daily`  AS   (select `oee`.`id` AS `id`,`oee`.`okp_packing` AS `okp_packing`,`oee`.`tanggal` AS `tanggal`,`oee`.`line_id` AS `line_id`,`oee`.`shift_id` AS `shift_id`,`oee`.`produk` AS `produk`,`prod`.`floatstdspeed` AS `floatstdspeed`,cast((((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1))) / sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) as decimal(10,0)) AS `actual_speed`,cast((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - ((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)))) / `prod`.`floatstdspeed`) as decimal(10,2)) AS `speed_loss`,cast(((cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) / `prod`.`floatstdspeed`) as decimal(10,2)) AS `defect_loss`,sum(`oee`.`lamakejadian`) AS `working_time`,(((sum(`oee`.`lamakejadian`) - sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - sum((case when (`mact`.`txtcategory` = 'sh') then `oee`.`lamakejadian` else 0 end))) - sum((case when (`mact`.`txtcategory` = 'mi') then `oee`.`lamakejadian` else 0 end))) AS `downtime_loss`,sum((case when (`mact`.`txtcategory` = 'mi') then `oee`.`lamakejadian` else 0 end)) AS `total_mi`,sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) AS `operating_time`,sum((case when (`mact`.`txtcategory` = 'sh') then `oee`.`lamakejadian` else 0 end)) AS `total_sh`,(sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) - cast((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - ((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)))) / `prod`.`floatstdspeed`) as decimal(10,2))) AS `net_optime`,((sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) - cast((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - ((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)))) / `prod`.`floatstdspeed`) as decimal(10,2))) - ((cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) / `prod`.`floatstdspeed`)) AS `value_adding`,(sum(`oee`.`lamakejadian`) - sum((case when (`mact`.`txtcategory` = 'sh') then `oee`.`lamakejadian` else 0 end))) AS `loading_time`,((sum(`oee`.`lamakejadian`) - sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - sum((case when (`mact`.`txtcategory` = 'sh') then `oee`.`lamakejadian` else 0 end))) AS `total_downtime`,cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)) AS `total_reject`,(sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) AS `fg`,sum(`oee`.`qc_sample`) AS `qc_sample`,(sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000)) AS `rework`,(cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) AS `defect`,((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1))) AS `total_output`,cast((((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + (`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000)))) * (`prod`.`intnetfill` / 1000)) as decimal(10,2)) AS `output_kg`,cast(((sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) / (sum(`oee`.`lamakejadian`) - sum((case when (`mact`.`txtcategory` = 'sh') then `oee`.`lamakejadian` else 0 end)))) * 100) as decimal(10,2)) AS `avaibility_rate`,cast((((sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) - cast((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - ((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)))) / `prod`.`floatstdspeed`) as decimal(10,2))) / sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) * 100) as decimal(10,2)) AS `performance_rate`,cast(((((sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) - cast((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - ((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)))) / `prod`.`floatstdspeed`) as decimal(10,2))) - ((cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) / `prod`.`floatstdspeed`)) / (sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) - cast((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - ((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)))) / `prod`.`floatstdspeed`) as decimal(10,2)))) * 100) as decimal(10,2)) AS `quality_rate` from ((`oee` join (select `mactivitycode`.`id` AS `id`,`mactivitycode`.`line_id` AS `line_id`,`mactivitycode`.`txtactivitycode` AS `txtactivitycode`,`mactivitycode`.`txtcategory` AS `txtcategory`,`mactivitycode`.`txtactivityname` AS `txtactivityname`,`mactivitycode`.`txtactivityitem` AS `txtativityitem`,`mactivitycode`.`txtdescription` AS `txtdescription`,`mactivitycode`.`created_at` AS `created_at`,`mactivitycode`.`updated_at` AS `updated_at` from `mactivitycode`) `mact` on((`oee`.`activity_id` = `mact`.`id`))) join `mproduct` `prod` on((`prod`.`txtartcode` = `oee`.`produk_code`))) group by `oee`.`tanggal`,`oee`.`shift_id`,`oee`.`okp_packing`)  ;

-- --------------------------------------------------------

--
-- Structure for view `v_oee_shift`
--
DROP TABLE IF EXISTS `v_oee_shift`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_oee_shift`  AS   (select `oee`.`id` AS `id`,`oee`.`okp_packing` AS `okp_packing`,`oee`.`tanggal` AS `tanggal`,`oee`.`line_id` AS `line_id`,`oee`.`shift_id` AS `shift_id`,`oee`.`produk` AS `produk`,`prod`.`floatstdspeed` AS `floatstdspeed`,cast((((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1))) / sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) as decimal(10,0)) AS `actual_speed`,cast((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - ((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)))) / `prod`.`floatstdspeed`) as decimal(10,2)) AS `speed_loss`,cast(((cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) / `prod`.`floatstdspeed`) as decimal(10,2)) AS `defect_loss`,sum(`oee`.`lamakejadian`) AS `working_time`,(((sum(`oee`.`lamakejadian`) - sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - sum((case when (`mact`.`txtcategory` = 'sh') then `oee`.`lamakejadian` else 0 end))) - sum((case when (`mact`.`txtcategory` = 'mi') then `oee`.`lamakejadian` else 0 end))) AS `downtime_loss`,sum((case when (`mact`.`txtcategory` = 'mi') then `oee`.`lamakejadian` else 0 end)) AS `total_mi`,sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) AS `operating_time`,sum((case when (`mact`.`txtcategory` = 'sh') then `oee`.`lamakejadian` else 0 end)) AS `total_sh`,(sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) - cast((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - ((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)))) / `prod`.`floatstdspeed`) as decimal(10,2))) AS `net_optime`,((sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) - cast((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - ((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)))) / `prod`.`floatstdspeed`) as decimal(10,2))) - ((cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) / `prod`.`floatstdspeed`)) AS `value_adding`,(sum(`oee`.`lamakejadian`) - sum((case when (`mact`.`txtcategory` = 'sh') then `oee`.`lamakejadian` else 0 end))) AS `loading_time`,((sum(`oee`.`lamakejadian`) - sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - sum((case when (`mact`.`txtcategory` = 'sh') then `oee`.`lamakejadian` else 0 end))) AS `total_downtime`,cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)) AS `total_reject`,(sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) AS `fg`,sum(`oee`.`qc_sample`) AS `qc_sample`,(sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000)) AS `rework`,(cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) AS `defect`,((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1))) AS `total_output`,cast((((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + (`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000)))) * (`prod`.`intnetfill` / 1000)) as decimal(10,2)) AS `output_kg`,cast(((sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) / (sum(`oee`.`lamakejadian`) - sum((case when (`mact`.`txtcategory` = 'sh') then `oee`.`lamakejadian` else 0 end)))) * 100) as decimal(10,2)) AS `avaibility_rate`,cast((((sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) - cast((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - ((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)))) / `prod`.`floatstdspeed`) as decimal(10,2))) / sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) * 100) as decimal(10,2)) AS `performance_rate`,cast(((((sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) - cast((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - ((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)))) / `prod`.`floatstdspeed`) as decimal(10,2))) - ((cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) / `prod`.`floatstdspeed`)) / (sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end)) - cast((((`prod`.`floatstdspeed` * sum((case when (`mact`.`txtcategory` = 'pr') then `oee`.`lamakejadian` else 0 end))) - ((((sum(`oee`.`finish_good`) * `prod`.`intpcskarton`) + sum(`oee`.`qc_sample`)) + (sum(`oee`.`rework`) / (`prod`.`intnetfill` / 1000))) + cast((`oee`.`reject_pcs` + (`oee`.`reject` / (`prod`.`intnetfill` / 1000))) as decimal(10,1)))) / `prod`.`floatstdspeed`) as decimal(10,2)))) * 100) as decimal(10,2)) AS `quality_rate` from ((`oee` join (select `mactivitycode`.`id` AS `id`,`mactivitycode`.`line_id` AS `line_id`,`mactivitycode`.`txtactivitycode` AS `txtactivitycode`,`mactivitycode`.`txtcategory` AS `txtcategory`,`mactivitycode`.`txtactivityname` AS `txtactivityname`,`mactivitycode`.`txtactivityitem` AS `txtativityitem`,`mactivitycode`.`txtdescription` AS `txtdescription`,`mactivitycode`.`created_at` AS `created_at`,`mactivitycode`.`updated_at` AS `updated_at` from `mactivitycode`) `mact` on((`oee`.`activity_id` = `mact`.`id`))) join `mproduct` `prod` on((`prod`.`txtartcode` = `oee`.`produk_code`))) group by `oee`.`shift_id`,`oee`.`tanggal`)  ;

-- --------------------------------------------------------

--
-- Structure for view `v_percent_poe`
--
DROP TABLE IF EXISTS `v_percent_poe`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_percent_poe`  AS   (select `vpoe`.`tanggal` AS `tanggal`,`vpoe`.`line_id` AS `line_id`,sum(`vpoe`.`total_output`) AS `total`,`vpoe`.`oee` AS `oee`,(select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (`v_calc_poe`.`tanggal` = `vpoe`.`tanggal`) group by `v_calc_poe`.`tanggal`) AS `sum_total` from `v_calc_poe` `vpoe` group by `vpoe`.`tanggal`,`vpoe`.`line_id`)  ;

-- --------------------------------------------------------

--
-- Structure for view `v_week_poe`
--
DROP TABLE IF EXISTS `v_week_poe`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_week_poe`  AS   (select week(`vcp`.`tanggal`,0) AS `week`,monthname(`vcp`.`tanggal`) AS `month`,year(`vcp`.`tanggal`) AS `year`,`vcp`.`line_id` AS `line_id`,sum(`vcp`.`total_output`) AS `total_output`,cast((select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (week(`v_calc_poe`.`tanggal`,0) = week(`vcp`.`tanggal`,0)) group by week(`v_calc_poe`.`tanggal`,0)) as decimal(10,2)) AS `sum_total`,cast(((sum(`vcp`.`operating_time`) / sum(`vcp`.`loading_time`)) * 100) as decimal(10,2)) AS `ar`,cast(((sum(`vcp`.`net_optime`) / sum(`vcp`.`operating_time`)) * 100) as decimal(10,2)) AS `pr`,cast(((sum(`vcp`.`value_adding`) / sum(`vcp`.`net_optime`)) * 100) as decimal(10,2)) AS `qr`,cast(((((sum(`vcp`.`operating_time`) / sum(`vcp`.`loading_time`)) * (sum(`vcp`.`net_optime`) / sum(`vcp`.`operating_time`))) * (sum(`vcp`.`value_adding`) / sum(`vcp`.`net_optime`))) * 100) as decimal(10,2)) AS `oee`,cast((sum(`vcp`.`total_output`) / cast((select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (week(`v_calc_poe`.`tanggal`,0) = week(`vcp`.`tanggal`,0)) group by week(`v_calc_poe`.`tanggal`,0)) as decimal(10,2))) as decimal(10,2)) AS `percent`,cast(((sum(`vcp`.`total_output`) / cast((select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (week(`v_calc_poe`.`tanggal`,0) = week(`vcp`.`tanggal`,0)) group by week(`v_calc_poe`.`tanggal`,0)) as decimal(10,2))) * ((((sum(`vcp`.`operating_time`) / sum(`vcp`.`loading_time`)) * (sum(`vcp`.`net_optime`) / sum(`vcp`.`operating_time`))) * (sum(`vcp`.`value_adding`) / sum(`vcp`.`net_optime`))) * 100)) as decimal(10,2)) AS `hasil` from `v_calc_poe` `vcp` group by week(`vcp`.`tanggal`,0),`vcp`.`line_id`)  ;

-- --------------------------------------------------------

--
-- Structure for view `v_year_poe`
--
DROP TABLE IF EXISTS `v_year_poe`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_year_poe`  AS   (select `vcp`.`tanggal` AS `tanggal`,`vcp`.`line_id` AS `line_id`,sum(`vcp`.`total_output`) AS `total_output`,cast((select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (year(`v_calc_poe`.`tanggal`) = year(`vcp`.`tanggal`)) group by year(`v_calc_poe`.`tanggal`)) as decimal(10,2)) AS `sum_total`,cast(((sum(`vcp`.`operating_time`) / sum(`vcp`.`loading_time`)) * 100) as decimal(10,2)) AS `ar`,cast(((sum(`vcp`.`net_optime`) / sum(`vcp`.`operating_time`)) * 100) as decimal(10,2)) AS `pr`,cast(((sum(`vcp`.`value_adding`) / sum(`vcp`.`net_optime`)) * 100) as decimal(10,2)) AS `qr`,cast(((((sum(`vcp`.`operating_time`) / sum(`vcp`.`loading_time`)) * (sum(`vcp`.`net_optime`) / sum(`vcp`.`operating_time`))) * (sum(`vcp`.`value_adding`) / sum(`vcp`.`net_optime`))) * 100) as decimal(10,2)) AS `oee`,cast((sum(`vcp`.`total_output`) / cast((select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (year(`v_calc_poe`.`tanggal`) = year(`vcp`.`tanggal`)) group by year(`v_calc_poe`.`tanggal`)) as decimal(10,2))) as decimal(10,4)) AS `percent`,cast(((sum(`vcp`.`total_output`) / cast((select sum(`v_calc_poe`.`total_output`) from `v_calc_poe` where (year(`v_calc_poe`.`tanggal`) = year(`vcp`.`tanggal`)) group by year(`v_calc_poe`.`tanggal`)) as decimal(10,2))) * ((((sum(`vcp`.`operating_time`) / sum(`vcp`.`loading_time`)) * (sum(`vcp`.`net_optime`) / sum(`vcp`.`operating_time`))) * (sum(`vcp`.`value_adding`) / sum(`vcp`.`net_optime`))) * 100)) as decimal(10,2)) AS `hasil`,cast(((sum(`vcp`.`loading_time`) / sum(`vcp`.`working_time`)) * 100) as decimal(10,2)) AS `utilization_rate` from `v_calc_poe` `vcp` group by year(`vcp`.`tanggal`),`vcp`.`line_id`)  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `level_access`
--
ALTER TABLE `level_access`
  ADD KEY `FK_level_access_level_id_to_level` (`level_id`),
  ADD KEY `FK_level_access_menu_id_to_menu` (`menu_id`);

--
-- Indexes for table `line_users`
--
ALTER TABLE `line_users`
  ADD KEY `fk_line_users_to_user_id` (`user_id`),
  ADD KEY `fk_line_users_to_line_id` (`line_id`);

--
-- Indexes for table `loghistory`
--
ALTER TABLE `loghistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_loghistory_machine_id_to_mmachine` (`machine_id`);

--
-- Indexes for table `mactivitycode`
--
ALTER TABLE `mactivitycode`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_mactivity_line_to_mline` (`line_id`);

--
-- Indexes for table `mbroker`
--
ALTER TABLE `mbroker`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mdailyactivities`
--
ALTER TABLE `mdailyactivities`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_daily_line_id_to_mline` (`line_id`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mkpi`
--
ALTER TABLE `mkpi`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mlevels`
--
ALTER TABLE `mlevels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mline`
--
ALTER TABLE `mline`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mmachines`
--
ALTER TABLE `mmachines`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_mmachines_line_to_mline` (`line_id`);

--
-- Indexes for table `mplanorder`
--
ALTER TABLE `mplanorder`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_planorder_line_id_to_mline` (`line_id`),
  ADD KEY `FK_planorder_product_id_to_mproduct` (`product_id`);

--
-- Indexes for table `mproduct`
--
ALTER TABLE `mproduct`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_mproduct_line_to_mline` (`line_id`);

--
-- Indexes for table `mtopic`
--
ALTER TABLE `mtopic`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_mtopic_broker_id_to_mbroker` (`broker_id`),
  ADD KEY `FK_mtopic_machine_id_to_mmachines` (`machine_id`);

--
-- Indexes for table `musers`
--
ALTER TABLE `musers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_users_level_to_mlevels` (`level_id`);

--
-- Indexes for table `mworkingtime`
--
ALTER TABLE `mworkingtime`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oee`
--
ALTER TABLE `oee`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oee_drier`
--
ALTER TABLE `oee_drier`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `submenu`
--
ALTER TABLE `submenu`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_submenu_menu_id_to_Menu` (`menu_id`);

--
-- Indexes for table `tr_dailyactivity`
--
ALTER TABLE `tr_dailyactivity`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_daily_to_working_id` (`working_id`),
  ADD KEY `fk_daily_to_activity_id` (`activity_id`);

--
-- Indexes for table `tr_kpi`
--
ALTER TABLE `tr_kpi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_tr_kpi_to_mkpi_id` (`kpi_id`),
  ADD KEY `Fk_tr_kpi_line_to_mline_id` (`line_id`);

--
-- Indexes for table `tr_topic`
--
ALTER TABLE `tr_topic`
  ADD KEY `FK_tr_topic_id_to_mtopic` (`topic_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `loghistory`
--
ALTER TABLE `loghistory`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mactivitycode`
--
ALTER TABLE `mactivitycode`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=874;

--
-- AUTO_INCREMENT for table `mbroker`
--
ALTER TABLE `mbroker`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mdailyactivities`
--
ALTER TABLE `mdailyactivities`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `mkpi`
--
ALTER TABLE `mkpi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `mlevels`
--
ALTER TABLE `mlevels`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `mline`
--
ALTER TABLE `mline`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `mmachines`
--
ALTER TABLE `mmachines`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `mplanorder`
--
ALTER TABLE `mplanorder`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mproduct`
--
ALTER TABLE `mproduct`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `mtopic`
--
ALTER TABLE `mtopic`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `musers`
--
ALTER TABLE `musers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=48;

--
-- AUTO_INCREMENT for table `mworkingtime`
--
ALTER TABLE `mworkingtime`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `oee`
--
ALTER TABLE `oee`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oee_drier`
--
ALTER TABLE `oee_drier`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2123;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submenu`
--
ALTER TABLE `submenu`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `tr_dailyactivity`
--
ALTER TABLE `tr_dailyactivity`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tr_kpi`
--
ALTER TABLE `tr_kpi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `level_access`
--
ALTER TABLE `level_access`
  ADD CONSTRAINT `FK_level_access_level_id_to_level` FOREIGN KEY (`level_id`) REFERENCES `mlevels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_level_access_menu_id_to_menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `line_users`
--
ALTER TABLE `line_users`
  ADD CONSTRAINT `fk_line_users_to_line_id` FOREIGN KEY (`line_id`) REFERENCES `mline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_line_users_to_user_id` FOREIGN KEY (`user_id`) REFERENCES `musers` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `loghistory`
--
ALTER TABLE `loghistory`
  ADD CONSTRAINT `FK_loghistory_machine_id_to_mmachine` FOREIGN KEY (`machine_id`) REFERENCES `mmachines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mactivitycode`
--
ALTER TABLE `mactivitycode`
  ADD CONSTRAINT `FK_mactivity_line_to_mline` FOREIGN KEY (`line_id`) REFERENCES `mline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mdailyactivities`
--
ALTER TABLE `mdailyactivities`
  ADD CONSTRAINT `FK_daily_line_id_to_mline` FOREIGN KEY (`line_id`) REFERENCES `mline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mmachines`
--
ALTER TABLE `mmachines`
  ADD CONSTRAINT `FK_mmachines_line_to_mline` FOREIGN KEY (`line_id`) REFERENCES `mline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mplanorder`
--
ALTER TABLE `mplanorder`
  ADD CONSTRAINT `FK_planorder_line_id_to_mline` FOREIGN KEY (`line_id`) REFERENCES `mline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_planorder_product_id_to_mproduct` FOREIGN KEY (`product_id`) REFERENCES `mproduct` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mproduct`
--
ALTER TABLE `mproduct`
  ADD CONSTRAINT `FK_mproduct_line_to_mline` FOREIGN KEY (`line_id`) REFERENCES `mline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mtopic`
--
ALTER TABLE `mtopic`
  ADD CONSTRAINT `FK_mtopic_broker_id_to_mbroker` FOREIGN KEY (`broker_id`) REFERENCES `mbroker` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_mtopic_machine_id_to_mmachines` FOREIGN KEY (`machine_id`) REFERENCES `mmachines` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `musers`
--
ALTER TABLE `musers`
  ADD CONSTRAINT `FK_users_level_to_mlevels` FOREIGN KEY (`level_id`) REFERENCES `mlevels` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `submenu`
--
ALTER TABLE `submenu`
  ADD CONSTRAINT `FK_submenu_menu_id_to_Menu` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tr_dailyactivity`
--
ALTER TABLE `tr_dailyactivity`
  ADD CONSTRAINT `fk_daily_to_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `mactivitycode` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_daily_to_working_id` FOREIGN KEY (`working_id`) REFERENCES `mworkingtime` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tr_kpi`
--
ALTER TABLE `tr_kpi`
  ADD CONSTRAINT `FK_tr_kpi_to_mkpi_id` FOREIGN KEY (`kpi_id`) REFERENCES `mkpi` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Fk_tr_kpi_line_to_mline_id` FOREIGN KEY (`line_id`) REFERENCES `mline` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tr_topic`
--
ALTER TABLE `tr_topic`
  ADD CONSTRAINT `FK_tr_topic_id_to_mtopic` FOREIGN KEY (`topic_id`) REFERENCES `mtopic` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
