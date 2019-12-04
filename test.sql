-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- 主機： 127.0.0.1
-- 產生時間： 
-- 伺服器版本： 10.4.6-MariaDB
-- PHP 版本： 7.3.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- 資料庫： `test`
--

-- --------------------------------------------------------

--
-- 資料表結構 `供應商`
--

CREATE TABLE `供應商` (
  `供應商編號` char(5) NOT NULL,
  `供應商` varchar(40) NOT NULL,
  `聯絡人` varchar(30) DEFAULT NULL,
  `聯絡人職稱` varchar(30) DEFAULT NULL,
  `聯絡人性別` char(1) DEFAULT NULL,
  `郵遞區號` varchar(10) DEFAULT NULL,
  `地址` varchar(60) DEFAULT NULL,
  `電話` varchar(24) DEFAULT NULL
) ;

--
-- 傾印資料表的資料 `供應商`
--

INSERT INTO `供應商` (`供應商編號`, `供應商`, `聯絡人`, `聯絡人職稱`, `聯絡人性別`, `郵遞區號`, `地址`, `電話`) VALUES
('S0005', '??', '???', '???', '?', '900', '???????23?27?', '(08)598-7654');

-- --------------------------------------------------------

--
-- 資料表結構 `員工`
--

CREATE TABLE `員工` (
  `員工編號` char(7) NOT NULL,
  `姓名` varchar(20) NOT NULL,
  `職稱` varchar(30) DEFAULT NULL,
  `性別` char(1) DEFAULT NULL,
  `出生日期` datetime DEFAULT NULL,
  `任用日期` datetime DEFAULT NULL,
  `區域號碼` varchar(10) DEFAULT NULL,
  `地址` varchar(60) DEFAULT NULL,
  `分機號碼` varchar(4) DEFAULT NULL,
  `報告人` char(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 資料表結構 `客戶`
--

CREATE TABLE `客戶` (
  `客戶編號` char(5) NOT NULL,
  `公司名稱` varchar(40) NOT NULL,
  `聯絡人` varchar(30) DEFAULT NULL,
  `聯絡人職稱` varchar(30) DEFAULT NULL,
  `聯絡人性別` char(1) DEFAULT NULL,
  `地址` varchar(60) DEFAULT NULL,
  `電話` varchar(24) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 資料表結構 `產品資料`
--

CREATE TABLE `產品資料` (
  `產品編號` int(11) NOT NULL,
  `類別編號` int(11) DEFAULT NULL,
  `供應商編號` char(5) DEFAULT NULL,
  `產品名稱` varchar(40) DEFAULT NULL,
  `建議單價` int(11) DEFAULT NULL,
  `庫存量` int(11) DEFAULT 0,
  `安全存量` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- 傾印資料表的資料 `產品資料`
--

INSERT INTO `產品資料` (`產品編號`, `類別編號`, `供應商編號`, `產品名稱`, `建議單價`, `庫存量`, `安全存量`) VALUES
(13, 8, 'S0005', '??', 35, 0, 30);

-- --------------------------------------------------------

--
-- 資料表結構 `產品類別`
--

CREATE TABLE `產品類別` (
  `類別編號` int(11) NOT NULL,
  `類別名稱` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- 傾印資料表的資料 `產品類別`
--

INSERT INTO `產品類別` (`類別編號`, `類別名稱`) VALUES
(8, '???');

-- --------------------------------------------------------

--
-- 資料表結構 `訂單`
--

CREATE TABLE `訂單` (
  `訂單編號` char(8) NOT NULL,
  `員工編號` char(7) DEFAULT NULL,
  `客戶編號` char(5) DEFAULT NULL,
  `訂單日期` datetime DEFAULT NULL,
  `付款方式` varchar(50) DEFAULT NULL,
  `交貨方式` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- 資料表結構 `訂單明細`
--

CREATE TABLE `訂單明細` (
  `訂單編號` char(8) NOT NULL,
  `產品編號` int(11) NOT NULL,
  `實際單價` int(11) DEFAULT NULL,
  `數量` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- 已傾印資料表的索引
--

--
-- 資料表索引 `供應商`
--
ALTER TABLE `供應商`
  ADD PRIMARY KEY (`供應商編號`);

--
-- 資料表索引 `員工`
--
ALTER TABLE `員工`
  ADD PRIMARY KEY (`員工編號`);

--
-- 資料表索引 `客戶`
--
ALTER TABLE `客戶`
  ADD PRIMARY KEY (`客戶編號`);

--
-- 資料表索引 `產品資料`
--
ALTER TABLE `產品資料`
  ADD PRIMARY KEY (`產品編號`),
  ADD KEY `類別編號` (`類別編號`),
  ADD KEY `供應商編號` (`供應商編號`);

--
-- 資料表索引 `產品類別`
--
ALTER TABLE `產品類別`
  ADD PRIMARY KEY (`類別編號`);

--
-- 資料表索引 `訂單`
--
ALTER TABLE `訂單`
  ADD PRIMARY KEY (`訂單編號`),
  ADD KEY `員工編號` (`員工編號`),
  ADD KEY `客戶編號` (`客戶編號`);

--
-- 資料表索引 `訂單明細`
--
ALTER TABLE `訂單明細`
  ADD PRIMARY KEY (`訂單編號`,`產品編號`),
  ADD KEY `產品編號` (`產品編號`);

--
-- 已傾印資料表的限制式
--

--
-- 資料表的限制式 `產品資料`
--
ALTER TABLE `產品資料`
  ADD CONSTRAINT `產品資料_ibfk_1` FOREIGN KEY (`類別編號`) REFERENCES `產品類別` (`類別編號`),
  ADD CONSTRAINT `產品資料_ibfk_2` FOREIGN KEY (`供應商編號`) REFERENCES `供應商` (`供應商編號`);

--
-- 資料表的限制式 `訂單`
--
ALTER TABLE `訂單`
  ADD CONSTRAINT `訂單_ibfk_1` FOREIGN KEY (`員工編號`) REFERENCES `員工` (`員工編號`),
  ADD CONSTRAINT `訂單_ibfk_2` FOREIGN KEY (`客戶編號`) REFERENCES `客戶` (`客戶編號`);

--
-- 資料表的限制式 `訂單明細`
--
ALTER TABLE `訂單明細`
  ADD CONSTRAINT `訂單明細_ibfk_1` FOREIGN KEY (`訂單編號`) REFERENCES `訂單` (`訂單編號`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `訂單明細_ibfk_2` FOREIGN KEY (`產品編號`) REFERENCES `產品資料` (`產品編號`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
