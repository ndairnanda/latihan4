-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2022 at 04:59 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `selma`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `data_dummy` ()  BEGIN
   DECLARE i, n INT;
   DECLARE jalur INT;
   DECLARE no_pendaftar VARCHAR(20);
   DECLARE nama VARCHAR(100);
   DECLARE nisn VARCHAR(15);
   DECLARE nik VARCHAR(20);
   DECLARE tempat_lahir VARCHAR(60);
   DECLARE tanggal_lahir DATE;
   DECLARE jenis_kelamin VARCHAR(30);
   DECLARE no_hp VARCHAR(20);
   DECLARE id_prodi1 INT;
   DECLARE id_prodi2 INT;
   DECLARE nominal_bayar VARCHAR(15);
   DECLARE id_bank VARCHAR(10);     
   DECLARE is_bayar VARCHAR(10);
   
   DECLARE pendaftar_id INT;
   DECLARE tingkat_prestasi VARCHAR(30);
   DECLARE nama_prestasi VARCHAR(255);
   DECLARE tahun int;
   DECLARE url_dokumen VARCHAR(255);

   SET i = 0;
   
   
   SET n = 100;


   WHILE i < n DO

	SET jalur = (SELECT id_jalur FROM jalur_masuk ORDER BY RAND() LIMIT 1);
        SET no_pendaftar = (SELECT CONCAT('P', YEAR(CURRENT_DATE()), jalur, (i+1)));
        
        SET nama = (SELECT CONCAT('Irnanda Septian Ika Putri', (i+1)));
        SET nisn = (SELECT CONCAT('1234567', (i+1)));
        SET nik  = (SELECT CONCAT('651908120419', (i+1)));
        SET tempat_lahir = 'WAMENA';
    
        SET tanggal_lahir = (SELECT '2002-09-19' - INTERVAL FLOOR(RAND() * 30) DAY);
        SET jenis_kelamin = 'Laki-Laki';
        SET no_hp = (SELECT CONCAT('081217801619', (i+1))); 
               
        SET id_prodi1 = (SELECT id_prodi FROM prodi ORDER BY RAND() LIMIT 1);
        SET id_prodi2 = (SELECT id_prodi FROM prodi ORDER BY RAND() LIMIT 1);
 
        SET nominal_bayar = 150000;
        SET id_bank = (SELECT id_bank FROM bank ORDER BY RAND() LIMIT 1);
        SET is_bayar = 1; 


        IF jalur = 1 THEN
           SET nominal_bayar = null;
           SET id_bank = NULL;
            SET is_bayar = 1; 
        END IF;

        IF (i+1) % 5 = 0 THEN
           SET jenis_kelamin = 'Perempuan';
           SET tempat_lahir = 'Lumajang';
        END IF;

        IF (i+1) % 3 = 0 THEN
           SET is_bayar = '0';
        END IF;
           
		INSERT INTO pendaftar (id_jalur, no_pendaftar, nama,  nisn, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, no_hp, id_prodi1, id_prodi2, nominal_bayar, id_bank, is_bayar)
                VALUES(jalur, no_pendaftar, nama,  nisn, nik, tempat_lahir, tanggal_lahir, jenis_kelamin, no_hp, id_prodi1, id_prodi2, nominal_bayar, id_bank, is_bayar);
                SET pendaftar_id = (SELECT LAST_INSERT_ID());       

        IF jalur = 3 then
           SET tingkat_prestasi = 'NASIONAL';
           SET tahun = (SELECT YEAR(CURRENT_DATE()));

           IF (i+1) % 6 = 0 THEN
            SET tingkat_prestasi = 'INTERNASIONAL';
            SET tahun = ((SELECT YEAR(CURRENT_DATE())) - 1);
           END IF;
           SET nama_prestasi = (SELECT CONCAT('Prestasi', tingkat_prestasi,' ', nama));
           SET url_dokumen = (SELECT CONCAT('public/upload/prestasi/', pendaftar_id));
           INSERT INTO pendaftar_prestasi(id_pendaftar, tingkat_prestasi, nama_prestasi, tahun, url_dokumen)
           VALUES(pendaftar_id, tingkat_prestasi, nama_prestasi, tahun, url_dokumen);
        END IF;           


        SET i = i + 1;
   END WHILE;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `id_bank` int(11) NOT NULL,
  `bank` varchar(60) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`id_bank`, `bank`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 'BCA', '2022-12-05 09:24:54', NULL, NULL, NULL),
(2, 'MANDIRI', '2022-12-05 09:24:54', NULL, NULL, NULL),
(3, 'BNI', '2022-12-05 09:25:23', NULL, NULL, NULL),
(4, 'BRI', '2022-12-05 09:25:23', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `fakultas`
--

CREATE TABLE `fakultas` (
  `id_fakultas` int(11) NOT NULL,
  `id_perguruan_tinggi` int(11) NOT NULL,
  `nama_fakultas` varchar(225) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `fakultas`
--

INSERT INTO `fakultas` (`id_fakultas`, `id_perguruan_tinggi`, `nama_fakultas`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 1, 'TEKNIK & INFORMATIKA', '2022-12-05 09:28:28', NULL, NULL, NULL),
(2, 1, 'KOMUNIKASI & BAHASA', '2022-12-05 09:28:28', NULL, NULL, NULL),
(3, 1, 'EKONOMI & BISNIS', '2022-12-05 09:28:47', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jalur_masuk`
--

CREATE TABLE `jalur_masuk` (
  `id_jalur` int(11) NOT NULL,
  `nama_jalur` varchar(255) NOT NULL,
  `is_tes` enum('1','0') NOT NULL,
  `is_mandiri` enum('1','0') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jalur_masuk`
--

INSERT INTO `jalur_masuk` (`id_jalur`, `nama_jalur`, `is_tes`, `is_mandiri`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 'JALUR SNMPTN', '0', '0', '2022-12-05 09:22:12', NULL, NULL, NULL),
(2, 'JALUR MANDIRI TES', '1', '1', '2022-12-05 09:23:39', NULL, NULL, NULL),
(3, 'JALUR MANDIRI PRESTASI', '0', '1', '2022-12-05 09:23:39', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pendaftar`
--

CREATE TABLE `pendaftar` (
  `id_pendaftar` int(11) NOT NULL,
  `id_jalur` int(11) NOT NULL,
  `no_pendaftar` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nisn` varchar(15) DEFAULT NULL,
  `nik` varchar(20) DEFAULT NULL,
  `tempat_lahir` varchar(60) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jenis_kelamin` varchar(30) DEFAULT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `id_prodi1` int(11) NOT NULL,
  `id_prodi2` int(11) DEFAULT NULL,
  `nominal_bayar` varchar(15) DEFAULT NULL,
  `id_bank` int(11) DEFAULT NULL,
  `is_bayar` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pendaftar`
--

INSERT INTO `pendaftar` (`id_pendaftar`, `id_jalur`, `no_pendaftar`, `nama`, `nisn`, `nik`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `no_hp`, `id_prodi1`, `id_prodi2`, `nominal_bayar`, `id_bank`, `is_bayar`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(210, 1, 'P202211', 'Irnanda Septian Ika Putri1', '12345671', '6519081204191', 'WAMENA', '2002-09-11', 'Laki-Laki', '0812178016191', 7, 12, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(211, 3, 'P202232', 'Irnanda Septian Ika Putri2', '12345672', '6519081204192', 'WAMENA', '2002-09-12', 'Laki-Laki', '0812178016192', 2, 1, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(212, 3, 'P202233', 'Irnanda Septian Ika Putri3', '12345673', '6519081204193', 'WAMENA', '2002-09-01', 'Laki-Laki', '0812178016193', 12, 11, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(213, 3, 'P202234', 'Irnanda Septian Ika Putri4', '12345674', '6519081204194', 'WAMENA', '2002-09-17', 'Laki-Laki', '0812178016194', 9, 5, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(214, 1, 'P202215', 'Irnanda Septian Ika Putri5', '12345675', '6519081204195', 'Lumajang', '2002-09-06', 'Perempuan', '0812178016195', 1, 11, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(215, 3, 'P202236', 'Irnanda Septian Ika Putri6', '12345676', '6519081204196', 'WAMENA', '2002-08-26', 'Laki-Laki', '0812178016196', 6, 11, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(216, 2, 'P202227', 'Irnanda Septian Ika Putri7', '12345677', '6519081204197', 'WAMENA', '2002-09-07', 'Laki-Laki', '0812178016197', 8, 15, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(217, 3, 'P202238', 'Irnanda Septian Ika Putri8', '12345678', '6519081204198', 'WAMENA', '2002-08-21', 'Laki-Laki', '0812178016198', 3, 8, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(218, 1, 'P202219', 'Irnanda Septian Ika Putri9', '12345679', '6519081204199', 'WAMENA', '2002-09-16', 'Laki-Laki', '0812178016199', 9, 13, NULL, NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(219, 2, 'P2022210', 'Irnanda Septian Ika Putri10', '123456710', '65190812041910', 'Lumajang', '2002-08-31', 'Perempuan', '08121780161910', 12, 3, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(220, 2, 'P2022211', 'Irnanda Septian Ika Putri11', '123456711', '65190812041911', 'WAMENA', '2002-09-09', 'Laki-Laki', '08121780161911', 10, 3, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(221, 1, 'P2022112', 'Irnanda Septian Ika Putri12', '123456712', '65190812041912', 'WAMENA', '2002-09-05', 'Laki-Laki', '08121780161912', 5, 8, NULL, NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(222, 1, 'P2022113', 'Irnanda Septian Ika Putri13', '123456713', '65190812041913', 'WAMENA', '2002-09-11', 'Laki-Laki', '08121780161913', 11, 10, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(223, 3, 'P2022314', 'Irnanda Septian Ika Putri14', '123456714', '65190812041914', 'WAMENA', '2002-08-21', 'Laki-Laki', '08121780161914', 7, 10, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(224, 2, 'P2022215', 'Irnanda Septian Ika Putri15', '123456715', '65190812041915', 'Lumajang', '2002-08-22', 'Perempuan', '08121780161915', 10, 6, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(225, 1, 'P2022116', 'Irnanda Septian Ika Putri16', '123456716', '65190812041916', 'WAMENA', '2002-08-29', 'Laki-Laki', '08121780161916', 8, 11, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(226, 3, 'P2022317', 'Irnanda Septian Ika Putri17', '123456717', '65190812041917', 'WAMENA', '2002-08-21', 'Laki-Laki', '08121780161917', 13, 12, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(227, 1, 'P2022118', 'Irnanda Septian Ika Putri18', '123456718', '65190812041918', 'WAMENA', '2002-08-23', 'Laki-Laki', '08121780161918', 12, 5, NULL, NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(228, 1, 'P2022119', 'Irnanda Septian Ika Putri19', '123456719', '65190812041919', 'WAMENA', '2002-08-23', 'Laki-Laki', '08121780161919', 13, 14, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(229, 2, 'P2022220', 'Irnanda Septian Ika Putri20', '123456720', '65190812041920', 'Lumajang', '2002-08-31', 'Perempuan', '08121780161920', 9, 14, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(230, 3, 'P2022321', 'Irnanda Septian Ika Putri21', '123456721', '65190812041921', 'WAMENA', '2002-09-09', 'Laki-Laki', '08121780161921', 3, 15, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(231, 2, 'P2022222', 'Irnanda Septian Ika Putri22', '123456722', '65190812041922', 'WAMENA', '2002-09-19', 'Laki-Laki', '08121780161922', 4, 8, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(232, 1, 'P2022123', 'Irnanda Septian Ika Putri23', '123456723', '65190812041923', 'WAMENA', '2002-09-12', 'Laki-Laki', '08121780161923', 7, 6, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(233, 3, 'P2022324', 'Irnanda Septian Ika Putri24', '123456724', '65190812041924', 'WAMENA', '2002-08-28', 'Laki-Laki', '08121780161924', 4, 14, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(234, 2, 'P2022225', 'Irnanda Septian Ika Putri25', '123456725', '65190812041925', 'Lumajang', '2002-09-01', 'Perempuan', '08121780161925', 11, 7, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(235, 3, 'P2022326', 'Irnanda Septian Ika Putri26', '123456726', '65190812041926', 'WAMENA', '2002-08-30', 'Laki-Laki', '08121780161926', 10, 10, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(236, 1, 'P2022127', 'Irnanda Septian Ika Putri27', '123456727', '65190812041927', 'WAMENA', '2002-09-18', 'Laki-Laki', '08121780161927', 8, 7, NULL, NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(237, 3, 'P2022328', 'Irnanda Septian Ika Putri28', '123456728', '65190812041928', 'WAMENA', '2002-09-01', 'Laki-Laki', '08121780161928', 3, 14, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(238, 3, 'P2022329', 'Irnanda Septian Ika Putri29', '123456729', '65190812041929', 'WAMENA', '2002-09-03', 'Laki-Laki', '08121780161929', 1, 8, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(239, 2, 'P2022230', 'Irnanda Septian Ika Putri30', '123456730', '65190812041930', 'Lumajang', '2002-09-09', 'Perempuan', '08121780161930', 9, 8, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(240, 1, 'P2022131', 'Irnanda Septian Ika Putri31', '123456731', '65190812041931', 'WAMENA', '2002-09-05', 'Laki-Laki', '08121780161931', 11, 4, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(241, 2, 'P2022232', 'Irnanda Septian Ika Putri32', '123456732', '65190812041932', 'WAMENA', '2002-09-17', 'Laki-Laki', '08121780161932', 8, 11, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(242, 1, 'P2022133', 'Irnanda Septian Ika Putri33', '123456733', '65190812041933', 'WAMENA', '2002-09-02', 'Laki-Laki', '08121780161933', 10, 3, NULL, NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(243, 2, 'P2022234', 'Irnanda Septian Ika Putri34', '123456734', '65190812041934', 'WAMENA', '2002-09-15', 'Laki-Laki', '08121780161934', 8, 5, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(244, 2, 'P2022235', 'Irnanda Septian Ika Putri35', '123456735', '65190812041935', 'Lumajang', '2002-08-31', 'Perempuan', '08121780161935', 10, 3, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(245, 3, 'P2022336', 'Irnanda Septian Ika Putri36', '123456736', '65190812041936', 'WAMENA', '2002-08-24', 'Laki-Laki', '08121780161936', 12, 10, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(246, 1, 'P2022137', 'Irnanda Septian Ika Putri37', '123456737', '65190812041937', 'WAMENA', '2002-09-06', 'Laki-Laki', '08121780161937', 8, 4, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(247, 2, 'P2022238', 'Irnanda Septian Ika Putri38', '123456738', '65190812041938', 'WAMENA', '2002-08-28', 'Laki-Laki', '08121780161938', 8, 5, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(248, 2, 'P2022239', 'Irnanda Septian Ika Putri39', '123456739', '65190812041939', 'WAMENA', '2002-08-26', 'Laki-Laki', '08121780161939', 7, 6, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(249, 2, 'P2022240', 'Irnanda Septian Ika Putri40', '123456740', '65190812041940', 'Lumajang', '2002-08-22', 'Perempuan', '08121780161940', 1, 12, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(250, 3, 'P2022341', 'Irnanda Septian Ika Putri41', '123456741', '65190812041941', 'WAMENA', '2002-08-22', 'Laki-Laki', '08121780161941', 7, 12, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(251, 3, 'P2022342', 'Irnanda Septian Ika Putri42', '123456742', '65190812041942', 'WAMENA', '2002-09-09', 'Laki-Laki', '08121780161942', 1, 1, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(252, 3, 'P2022343', 'Irnanda Septian Ika Putri43', '123456743', '65190812041943', 'WAMENA', '2002-09-11', 'Laki-Laki', '08121780161943', 3, 10, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(253, 1, 'P2022144', 'Irnanda Septian Ika Putri44', '123456744', '65190812041944', 'WAMENA', '2002-09-04', 'Laki-Laki', '08121780161944', 1, 4, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(254, 3, 'P2022345', 'Irnanda Septian Ika Putri45', '123456745', '65190812041945', 'Lumajang', '2002-09-05', 'Perempuan', '08121780161945', 9, 6, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(255, 3, 'P2022346', 'Irnanda Septian Ika Putri46', '123456746', '65190812041946', 'WAMENA', '2002-09-19', 'Laki-Laki', '08121780161946', 5, 2, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(256, 1, 'P2022147', 'Irnanda Septian Ika Putri47', '123456747', '65190812041947', 'WAMENA', '2002-09-15', 'Laki-Laki', '08121780161947', 6, 12, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(257, 3, 'P2022348', 'Irnanda Septian Ika Putri48', '123456748', '65190812041948', 'WAMENA', '2002-08-26', 'Laki-Laki', '08121780161948', 4, 4, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(258, 1, 'P2022149', 'Irnanda Septian Ika Putri49', '123456749', '65190812041949', 'WAMENA', '2002-08-22', 'Laki-Laki', '08121780161949', 9, 9, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(259, 3, 'P2022350', 'Irnanda Septian Ika Putri50', '123456750', '65190812041950', 'Lumajang', '2002-09-13', 'Perempuan', '08121780161950', 15, 5, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(260, 3, 'P2022351', 'Irnanda Septian Ika Putri51', '123456751', '65190812041951', 'WAMENA', '2002-08-30', 'Laki-Laki', '08121780161951', 8, 11, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(261, 3, 'P2022352', 'Irnanda Septian Ika Putri52', '123456752', '65190812041952', 'WAMENA', '2002-09-01', 'Laki-Laki', '08121780161952', 6, 13, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(262, 1, 'P2022153', 'Irnanda Septian Ika Putri53', '123456753', '65190812041953', 'WAMENA', '2002-09-08', 'Laki-Laki', '08121780161953', 6, 11, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(263, 3, 'P2022354', 'Irnanda Septian Ika Putri54', '123456754', '65190812041954', 'WAMENA', '2002-08-22', 'Laki-Laki', '08121780161954', 10, 2, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(264, 3, 'P2022355', 'Irnanda Septian Ika Putri55', '123456755', '65190812041955', 'Lumajang', '2002-08-30', 'Perempuan', '08121780161955', 12, 14, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(265, 1, 'P2022156', 'Irnanda Septian Ika Putri56', '123456756', '65190812041956', 'WAMENA', '2002-09-13', 'Laki-Laki', '08121780161956', 1, 9, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(266, 1, 'P2022157', 'Irnanda Septian Ika Putri57', '123456757', '65190812041957', 'WAMENA', '2002-08-28', 'Laki-Laki', '08121780161957', 3, 5, NULL, NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(267, 3, 'P2022358', 'Irnanda Septian Ika Putri58', '123456758', '65190812041958', 'WAMENA', '2002-09-14', 'Laki-Laki', '08121780161958', 12, 15, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(268, 2, 'P2022259', 'Irnanda Septian Ika Putri59', '123456759', '65190812041959', 'WAMENA', '2002-08-31', 'Laki-Laki', '08121780161959', 14, 7, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(269, 3, 'P2022360', 'Irnanda Septian Ika Putri60', '123456760', '65190812041960', 'Lumajang', '2002-09-02', 'Perempuan', '08121780161960', 4, 9, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(270, 3, 'P2022361', 'Irnanda Septian Ika Putri61', '123456761', '65190812041961', 'WAMENA', '2002-09-10', 'Laki-Laki', '08121780161961', 9, 8, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(271, 2, 'P2022262', 'Irnanda Septian Ika Putri62', '123456762', '65190812041962', 'WAMENA', '2002-09-06', 'Laki-Laki', '08121780161962', 12, 1, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(272, 3, 'P2022363', 'Irnanda Septian Ika Putri63', '123456763', '65190812041963', 'WAMENA', '2002-09-15', 'Laki-Laki', '08121780161963', 14, 12, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(273, 2, 'P2022264', 'Irnanda Septian Ika Putri64', '123456764', '65190812041964', 'WAMENA', '2002-09-04', 'Laki-Laki', '08121780161964', 13, 4, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(274, 3, 'P2022365', 'Irnanda Septian Ika Putri65', '123456765', '65190812041965', 'Lumajang', '2002-09-04', 'Perempuan', '08121780161965', 2, 9, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(275, 3, 'P2022366', 'Irnanda Septian Ika Putri66', '123456766', '65190812041966', 'WAMENA', '2002-08-31', 'Laki-Laki', '08121780161966', 11, 12, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(276, 3, 'P2022367', 'Irnanda Septian Ika Putri67', '123456767', '65190812041967', 'WAMENA', '2002-09-19', 'Laki-Laki', '08121780161967', 4, 3, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(277, 3, 'P2022368', 'Irnanda Septian Ika Putri68', '123456768', '65190812041968', 'WAMENA', '2002-09-17', 'Laki-Laki', '08121780161968', 8, 15, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(278, 1, 'P2022169', 'Irnanda Septian Ika Putri69', '123456769', '65190812041969', 'WAMENA', '2002-08-22', 'Laki-Laki', '08121780161969', 15, 1, NULL, NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(279, 2, 'P2022270', 'Irnanda Septian Ika Putri70', '123456770', '65190812041970', 'Lumajang', '2002-08-26', 'Perempuan', '08121780161970', 7, 6, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(280, 2, 'P2022271', 'Irnanda Septian Ika Putri71', '123456771', '65190812041971', 'WAMENA', '2002-08-30', 'Laki-Laki', '08121780161971', 11, 1, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(281, 1, 'P2022172', 'Irnanda Septian Ika Putri72', '123456772', '65190812041972', 'WAMENA', '2002-08-29', 'Laki-Laki', '08121780161972', 1, 14, NULL, NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(282, 1, 'P2022173', 'Irnanda Septian Ika Putri73', '123456773', '65190812041973', 'WAMENA', '2002-09-15', 'Laki-Laki', '08121780161973', 10, 14, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(283, 1, 'P2022174', 'Irnanda Septian Ika Putri74', '123456774', '65190812041974', 'WAMENA', '2002-08-28', 'Laki-Laki', '08121780161974', 11, 7, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(284, 2, 'P2022275', 'Irnanda Septian Ika Putri75', '123456775', '65190812041975', 'Lumajang', '2002-09-17', 'Perempuan', '08121780161975', 14, 13, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(285, 3, 'P2022376', 'Irnanda Septian Ika Putri76', '123456776', '65190812041976', 'WAMENA', '2002-09-10', 'Laki-Laki', '08121780161976', 5, 12, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(286, 1, 'P2022177', 'Irnanda Septian Ika Putri77', '123456777', '65190812041977', 'WAMENA', '2002-09-12', 'Laki-Laki', '08121780161977', 4, 13, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(287, 1, 'P2022178', 'Irnanda Septian Ika Putri78', '123456778', '65190812041978', 'WAMENA', '2002-09-18', 'Laki-Laki', '08121780161978', 10, 2, NULL, NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(288, 1, 'P2022179', 'Irnanda Septian Ika Putri79', '123456779', '65190812041979', 'WAMENA', '2002-08-23', 'Laki-Laki', '08121780161979', 15, 1, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(289, 2, 'P2022280', 'Irnanda Septian Ika Putri80', '123456780', '65190812041980', 'Lumajang', '2002-09-06', 'Perempuan', '08121780161980', 7, 13, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(290, 3, 'P2022381', 'Irnanda Septian Ika Putri81', '123456781', '65190812041981', 'WAMENA', '2002-09-12', 'Laki-Laki', '08121780161981', 7, 10, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(291, 1, 'P2022182', 'Irnanda Septian Ika Putri82', '123456782', '65190812041982', 'WAMENA', '2002-08-26', 'Laki-Laki', '08121780161982', 12, 3, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(292, 1, 'P2022183', 'Irnanda Septian Ika Putri83', '123456783', '65190812041983', 'WAMENA', '2002-08-27', 'Laki-Laki', '08121780161983', 14, 10, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(293, 2, 'P2022284', 'Irnanda Septian Ika Putri84', '123456784', '65190812041984', 'WAMENA', '2002-08-25', 'Laki-Laki', '08121780161984', 3, 1, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(294, 2, 'P2022285', 'Irnanda Septian Ika Putri85', '123456785', '65190812041985', 'Lumajang', '2002-08-26', 'Perempuan', '08121780161985', 1, 11, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(295, 3, 'P2022386', 'Irnanda Septian Ika Putri86', '123456786', '65190812041986', 'WAMENA', '2002-09-12', 'Laki-Laki', '08121780161986', 9, 2, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(296, 3, 'P2022387', 'Irnanda Septian Ika Putri87', '123456787', '65190812041987', 'WAMENA', '2002-09-08', 'Laki-Laki', '08121780161987', 4, 5, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(297, 1, 'P2022188', 'Irnanda Septian Ika Putri88', '123456788', '65190812041988', 'WAMENA', '2002-09-09', 'Laki-Laki', '08121780161988', 6, 10, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(298, 3, 'P2022389', 'Irnanda Septian Ika Putri89', '123456789', '65190812041989', 'WAMENA', '2002-09-03', 'Laki-Laki', '08121780161989', 5, 14, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(299, 1, 'P2022190', 'Irnanda Septian Ika Putri90', '123456790', '65190812041990', 'Lumajang', '2002-08-27', 'Perempuan', '08121780161990', 6, 7, NULL, NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(300, 2, 'P2022291', 'Irnanda Septian Ika Putri91', '123456791', '65190812041991', 'WAMENA', '2002-08-25', 'Laki-Laki', '08121780161991', 4, 8, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(301, 3, 'P2022392', 'Irnanda Septian Ika Putri92', '123456792', '65190812041992', 'WAMENA', '2002-09-09', 'Laki-Laki', '08121780161992', 13, 5, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(302, 3, 'P2022393', 'Irnanda Septian Ika Putri93', '123456793', '65190812041993', 'WAMENA', '2002-09-15', 'Laki-Laki', '08121780161993', 7, 5, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(303, 3, 'P2022394', 'Irnanda Septian Ika Putri94', '123456794', '65190812041994', 'WAMENA', '2002-09-06', 'Laki-Laki', '08121780161994', 10, 7, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(304, 2, 'P2022295', 'Irnanda Septian Ika Putri95', '123456795', '65190812041995', 'Lumajang', '2002-08-30', 'Perempuan', '08121780161995', 7, 1, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(305, 1, 'P2022196', 'Irnanda Septian Ika Putri96', '123456796', '65190812041996', 'WAMENA', '2002-09-02', 'Laki-Laki', '08121780161996', 7, 10, NULL, NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(306, 3, 'P2022397', 'Irnanda Septian Ika Putri97', '123456797', '65190812041997', 'WAMENA', '2002-09-04', 'Laki-Laki', '08121780161997', 14, 5, '150000', NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(307, 1, 'P2022198', 'Irnanda Septian Ika Putri98', '123456798', '65190812041998', 'WAMENA', '2002-08-27', 'Laki-Laki', '08121780161998', 1, 15, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL),
(308, 2, 'P2022299', 'Irnanda Septian Ika Putri99', '123456799', '65190812041999', 'WAMENA', '2002-09-01', 'Laki-Laki', '08121780161999', 2, 12, '150000', NULL, 0, '2022-12-09 03:55:35', NULL, NULL, NULL),
(309, 1, 'P20221100', 'Irnanda Septian Ika Putri100', '1234567100', '651908120419100', 'Lumajang', '2002-09-08', 'Perempuan', '081217801619100', 8, 8, NULL, NULL, 1, '2022-12-09 03:55:35', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pendaftar_prestasi`
--

CREATE TABLE `pendaftar_prestasi` (
  `id` int(11) NOT NULL,
  `id_pendaftar` int(11) NOT NULL DEFAULT 0,
  `tingkat_prestasi` enum('Nasional','Internasional') NOT NULL DEFAULT 'Nasional',
  `nama_prestasi` varchar(255) NOT NULL,
  `tahun` int(11) NOT NULL,
  `url_dokumen` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pendaftar_prestasi`
--

INSERT INTO `pendaftar_prestasi` (`id`, `id_pendaftar`, `tingkat_prestasi`, `nama_prestasi`, `tahun`, `url_dokumen`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(70, 211, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri2', 2022, 'public/upload/prestasi/211', '2022-12-09 03:55:35', NULL, NULL, NULL),
(71, 212, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri3', 2022, 'public/upload/prestasi/212', '2022-12-09 03:55:35', NULL, NULL, NULL),
(72, 213, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri4', 2022, 'public/upload/prestasi/213', '2022-12-09 03:55:35', NULL, NULL, NULL),
(73, 215, 'Internasional', 'PrestasiINTERNASIONAL Irnanda Septian Ika Putri6', 2021, 'public/upload/prestasi/215', '2022-12-09 03:55:35', NULL, NULL, NULL),
(74, 217, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri8', 2022, 'public/upload/prestasi/217', '2022-12-09 03:55:35', NULL, NULL, NULL),
(75, 223, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri14', 2022, 'public/upload/prestasi/223', '2022-12-09 03:55:35', NULL, NULL, NULL),
(76, 226, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri17', 2022, 'public/upload/prestasi/226', '2022-12-09 03:55:35', NULL, NULL, NULL),
(77, 230, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri21', 2022, 'public/upload/prestasi/230', '2022-12-09 03:55:35', NULL, NULL, NULL),
(78, 233, 'Internasional', 'PrestasiINTERNASIONAL Irnanda Septian Ika Putri24', 2021, 'public/upload/prestasi/233', '2022-12-09 03:55:35', NULL, NULL, NULL),
(79, 235, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri26', 2022, 'public/upload/prestasi/235', '2022-12-09 03:55:35', NULL, NULL, NULL),
(80, 237, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri28', 2022, 'public/upload/prestasi/237', '2022-12-09 03:55:35', NULL, NULL, NULL),
(81, 238, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri29', 2022, 'public/upload/prestasi/238', '2022-12-09 03:55:35', NULL, NULL, NULL),
(82, 245, 'Internasional', 'PrestasiINTERNASIONAL Irnanda Septian Ika Putri36', 2021, 'public/upload/prestasi/245', '2022-12-09 03:55:35', NULL, NULL, NULL),
(83, 250, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri41', 2022, 'public/upload/prestasi/250', '2022-12-09 03:55:35', NULL, NULL, NULL),
(84, 251, 'Internasional', 'PrestasiINTERNASIONAL Irnanda Septian Ika Putri42', 2021, 'public/upload/prestasi/251', '2022-12-09 03:55:35', NULL, NULL, NULL),
(85, 252, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri43', 2022, 'public/upload/prestasi/252', '2022-12-09 03:55:35', NULL, NULL, NULL),
(86, 254, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri45', 2022, 'public/upload/prestasi/254', '2022-12-09 03:55:35', NULL, NULL, NULL),
(87, 255, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri46', 2022, 'public/upload/prestasi/255', '2022-12-09 03:55:35', NULL, NULL, NULL),
(88, 257, 'Internasional', 'PrestasiINTERNASIONAL Irnanda Septian Ika Putri48', 2021, 'public/upload/prestasi/257', '2022-12-09 03:55:35', NULL, NULL, NULL),
(89, 259, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri50', 2022, 'public/upload/prestasi/259', '2022-12-09 03:55:35', NULL, NULL, NULL),
(90, 260, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri51', 2022, 'public/upload/prestasi/260', '2022-12-09 03:55:35', NULL, NULL, NULL),
(91, 261, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri52', 2022, 'public/upload/prestasi/261', '2022-12-09 03:55:35', NULL, NULL, NULL),
(92, 263, 'Internasional', 'PrestasiINTERNASIONAL Irnanda Septian Ika Putri54', 2021, 'public/upload/prestasi/263', '2022-12-09 03:55:35', NULL, NULL, NULL),
(93, 264, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri55', 2022, 'public/upload/prestasi/264', '2022-12-09 03:55:35', NULL, NULL, NULL),
(94, 267, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri58', 2022, 'public/upload/prestasi/267', '2022-12-09 03:55:35', NULL, NULL, NULL),
(95, 269, 'Internasional', 'PrestasiINTERNASIONAL Irnanda Septian Ika Putri60', 2021, 'public/upload/prestasi/269', '2022-12-09 03:55:35', NULL, NULL, NULL),
(96, 270, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri61', 2022, 'public/upload/prestasi/270', '2022-12-09 03:55:35', NULL, NULL, NULL),
(97, 272, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri63', 2022, 'public/upload/prestasi/272', '2022-12-09 03:55:35', NULL, NULL, NULL),
(98, 274, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri65', 2022, 'public/upload/prestasi/274', '2022-12-09 03:55:35', NULL, NULL, NULL),
(99, 275, 'Internasional', 'PrestasiINTERNASIONAL Irnanda Septian Ika Putri66', 2021, 'public/upload/prestasi/275', '2022-12-09 03:55:35', NULL, NULL, NULL),
(100, 276, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri67', 2022, 'public/upload/prestasi/276', '2022-12-09 03:55:35', NULL, NULL, NULL),
(101, 277, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri68', 2022, 'public/upload/prestasi/277', '2022-12-09 03:55:35', NULL, NULL, NULL),
(102, 285, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri76', 2022, 'public/upload/prestasi/285', '2022-12-09 03:55:35', NULL, NULL, NULL),
(103, 290, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri81', 2022, 'public/upload/prestasi/290', '2022-12-09 03:55:35', NULL, NULL, NULL),
(104, 295, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri86', 2022, 'public/upload/prestasi/295', '2022-12-09 03:55:35', NULL, NULL, NULL),
(105, 296, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri87', 2022, 'public/upload/prestasi/296', '2022-12-09 03:55:35', NULL, NULL, NULL),
(106, 298, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri89', 2022, 'public/upload/prestasi/298', '2022-12-09 03:55:35', NULL, NULL, NULL),
(107, 301, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri92', 2022, 'public/upload/prestasi/301', '2022-12-09 03:55:35', NULL, NULL, NULL),
(108, 302, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri93', 2022, 'public/upload/prestasi/302', '2022-12-09 03:55:35', NULL, NULL, NULL),
(109, 303, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri94', 2022, 'public/upload/prestasi/303', '2022-12-09 03:55:35', NULL, NULL, NULL),
(110, 306, 'Nasional', 'PrestasiNASIONAL Irnanda Septian Ika Putri97', 2022, 'public/upload/prestasi/306', '2022-12-09 03:55:35', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `perguruan_tinggi`
--

CREATE TABLE `perguruan_tinggi` (
  `id_perguruan_tinggi` int(15) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  `updated_by` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `perguruan_tinggi`
--

INSERT INTO `perguruan_tinggi` (`id_perguruan_tinggi`, `nama`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(1, 'AMD ACADEMY', '2022-12-05 09:27:01', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `prodi`
--

CREATE TABLE `prodi` (
  `id_prodi` int(11) NOT NULL,
  `id_fakultas` int(11) NOT NULL,
  `nama_prodi` varchar(255) NOT NULL,
  `jenjang` enum('S1','S2') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `prodi`
--

INSERT INTO `prodi` (`id_prodi`, `id_fakultas`, `nama_prodi`, `jenjang`, `created_at`, `created_by`, `updated_by`, `updated_at`) VALUES
(1, 1, 'SISTEM INFORMASI', 'S1', '2022-12-05 09:30:55', NULL, NULL, NULL),
(2, 1, 'TEKNOLOGI INFORMASI', 'S1', '2022-12-05 09:30:55', NULL, NULL, NULL),
(3, 1, 'REKAYASA PERANGKAT LUNAK', 'S1', '2022-12-05 09:32:34', NULL, NULL, NULL),
(4, 1, 'ILMU KOMPUTER', 'S1', '2022-12-05 09:32:34', NULL, NULL, NULL),
(5, 2, 'ILMU KOMUNIKASI', 'S1', '2022-12-05 09:33:32', NULL, NULL, NULL),
(6, 2, 'SASTRA INGGRIS', 'S1', '2022-12-05 09:33:32', NULL, NULL, NULL),
(7, 3, 'MANAJEMEN', 'S1', '2022-12-05 09:34:14', NULL, NULL, NULL),
(8, 3, 'AKUNTANSI', 'S1', '2022-12-05 09:34:14', NULL, NULL, NULL),
(9, 3, 'PERHOTELAN', 'S1', '2022-12-05 09:35:02', NULL, NULL, NULL),
(10, 1, 'SISTEM INFORMASI', 'S2', '2022-12-05 09:36:00', NULL, NULL, NULL),
(11, 1, 'TEKNOLOGI KOMPUTER', 'S2', '2022-12-05 09:36:00', NULL, NULL, NULL),
(12, 2, 'PUBLIC RELATIONS', 'S2', '2022-12-05 09:36:36', NULL, NULL, NULL),
(13, 2, 'BAHASA INGGRIS', 'S2', '2022-12-05 09:36:36', NULL, NULL, NULL),
(14, 3, 'MANAJEMEN PAJAK', 'S2', '2022-12-05 09:37:31', NULL, NULL, NULL),
(15, 3, 'ADMINISTRASI PERKANTORAN', 'S2', '2022-12-05 09:37:31', NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id_bank`);

--
-- Indexes for table `fakultas`
--
ALTER TABLE `fakultas`
  ADD PRIMARY KEY (`id_fakultas`),
  ADD KEY `id_perguruan_tinggi` (`id_perguruan_tinggi`);

--
-- Indexes for table `jalur_masuk`
--
ALTER TABLE `jalur_masuk`
  ADD PRIMARY KEY (`id_jalur`);

--
-- Indexes for table `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD PRIMARY KEY (`id_pendaftar`),
  ADD UNIQUE KEY `no_pendaftar` (`no_pendaftar`),
  ADD KEY `id_prodi1` (`id_prodi1`),
  ADD KEY `id_prodi2` (`id_prodi2`),
  ADD KEY `id_jalur` (`id_jalur`),
  ADD KEY `id_bank` (`id_bank`);

--
-- Indexes for table `pendaftar_prestasi`
--
ALTER TABLE `pendaftar_prestasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_pendaftar` (`id_pendaftar`);

--
-- Indexes for table `perguruan_tinggi`
--
ALTER TABLE `perguruan_tinggi`
  ADD PRIMARY KEY (`id_perguruan_tinggi`);

--
-- Indexes for table `prodi`
--
ALTER TABLE `prodi`
  ADD PRIMARY KEY (`id_prodi`),
  ADD KEY `id_fakultas` (`id_fakultas`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bank`
--
ALTER TABLE `bank`
  MODIFY `id_bank` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `fakultas`
--
ALTER TABLE `fakultas`
  MODIFY `id_fakultas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `jalur_masuk`
--
ALTER TABLE `jalur_masuk`
  MODIFY `id_jalur` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pendaftar`
--
ALTER TABLE `pendaftar`
  MODIFY `id_pendaftar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=310;

--
-- AUTO_INCREMENT for table `pendaftar_prestasi`
--
ALTER TABLE `pendaftar_prestasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `perguruan_tinggi`
--
ALTER TABLE `perguruan_tinggi`
  MODIFY `id_perguruan_tinggi` int(15) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `prodi`
--
ALTER TABLE `prodi`
  MODIFY `id_prodi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `fakultas`
--
ALTER TABLE `fakultas`
  ADD CONSTRAINT `fakultas_ibfk_1` FOREIGN KEY (`id_perguruan_tinggi`) REFERENCES `perguruan_tinggi` (`id_perguruan_tinggi`) ON UPDATE CASCADE;

--
-- Constraints for table `pendaftar`
--
ALTER TABLE `pendaftar`
  ADD CONSTRAINT `pendaftar_ibfk_1` FOREIGN KEY (`id_prodi1`) REFERENCES `prodi` (`id_prodi`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pendaftar_ibfk_2` FOREIGN KEY (`id_prodi2`) REFERENCES `prodi` (`id_prodi`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pendaftar_ibfk_3` FOREIGN KEY (`id_jalur`) REFERENCES `jalur_masuk` (`id_jalur`) ON UPDATE CASCADE,
  ADD CONSTRAINT `pendaftar_ibfk_4` FOREIGN KEY (`id_bank`) REFERENCES `bank` (`id_bank`) ON UPDATE CASCADE;

--
-- Constraints for table `pendaftar_prestasi`
--
ALTER TABLE `pendaftar_prestasi`
  ADD CONSTRAINT `pendaftar_prestasi_ibfk_1` FOREIGN KEY (`id_pendaftar`) REFERENCES `pendaftar` (`id_pendaftar`) ON UPDATE CASCADE;

--
-- Constraints for table `prodi`
--
ALTER TABLE `prodi`
  ADD CONSTRAINT `prodi_ibfk_1` FOREIGN KEY (`id_fakultas`) REFERENCES `fakultas` (`id_fakultas`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
