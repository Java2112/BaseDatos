-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 02-12-2024 a las 01:38:42
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `grafosdb`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarCiudad` (IN `id` INT, IN `nuevo_nombre` VARCHAR(100))   BEGIN
    UPDATE Ciudades SET nombre = nuevo_nombre WHERE id_ciudad = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ActualizarConexion` (IN `id` INT, IN `nueva_distancia` INT)   BEGIN
    UPDATE Conexiones SET distancia = nueva_distancia WHERE id_conexion = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearCiudad` (IN `nombre_ciudad` VARCHAR(100))   BEGIN
    INSERT INTO Ciudades (nombre) VALUES (nombre_ciudad);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CrearConexion` (IN `origen` VARCHAR(100), IN `destino` VARCHAR(100), IN `distancia` INT)   BEGIN
    DECLARE id_origen INT;
    DECLARE id_destino INT;
    
    SELECT id_ciudad INTO id_origen FROM Ciudades WHERE nombre = origen;
    SELECT id_ciudad INTO id_destino FROM Ciudades WHERE nombre = destino;
    
    INSERT INTO Conexiones (ciudad_origen_id, ciudad_destino_id, distancia)
    VALUES (id_origen, id_destino, distancia);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarCiudad` (IN `id` INT)   BEGIN
    DELETE FROM Conexiones WHERE ciudad_origen_id = id OR ciudad_destino_id = id;
    DELETE FROM Ciudades WHERE id_ciudad = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarConexion` (IN `id` INT)   BEGIN
    DELETE FROM Conexiones WHERE id_conexion = id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LeerCiudades` ()   BEGIN
    SELECT * FROM Ciudades;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `LeerConexiones` ()   BEGIN
    SELECT c1.nombre AS Ciudad_Origen, c2.nombre AS Ciudad_Destino, con.distancia
    FROM Conexiones con
    JOIN Ciudades c1 ON con.ciudad_origen_id = c1.id_ciudad
    JOIN Ciudades c2 ON con.ciudad_destino_id = c2.id_ciudad;
END$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
