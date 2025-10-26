-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 25-10-2025 a las 20:51:56
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistemaventas`
--
CREATE DATABASE IF NOT EXISTS `sistemaventas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `sistemaventas`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `categorias`
--

DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nombre` varchar(80) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `categorias`
--

INSERT INTO `categorias` (`id`, `nombre`) VALUES
(1, 'Bebidas'),
(5, 'Comida'),
(3, 'Limpieza'),
(6, 'Ropa');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras`
--

DROP TABLE IF EXISTS `compras`;
CREATE TABLE `compras` (
  `id` int(11) NOT NULL,
  `id_proveedor` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `total` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras`
--

INSERT INTO `compras` (`id`, `id_proveedor`, `id_usuario`, `fecha`, `total`) VALUES
(10, 1, 1, '2025-10-23 14:57:04', '10.00'),
(11, 1, 1, '2025-10-23 14:57:23', '10.00'),
(12, 1, 1, '2025-10-23 14:58:12', '20.00'),
(13, 1, 1, '2025-10-23 14:59:47', '10.00'),
(14, 1, 1, '2025-10-23 15:01:52', '10.00'),
(15, 1, 1, '2025-10-23 15:08:22', '10.00'),
(16, 1, 1, '2025-10-23 20:28:45', '10.00'),
(17, 1, 1, '2025-10-23 20:28:58', '10.00'),
(18, 1, 1, '2025-10-23 22:56:57', '10.00'),
(19, 1, 1, '2025-10-24 12:25:57', '25.00'),
(20, 1, 1, '2025-10-24 23:49:23', '10.00'),
(21, 3, 1, '2025-10-25 11:17:09', '250.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `compras_detalle`
--

DROP TABLE IF EXISTS `compras_detalle`;
CREATE TABLE `compras_detalle` (
  `id` int(11) NOT NULL,
  `id_compra` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_compra` decimal(10,2) NOT NULL,
  `subtotal` decimal(12,2) GENERATED ALWAYS AS (`cantidad` * `precio_compra`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `compras_detalle`
--

INSERT INTO `compras_detalle` (`id`, `id_compra`, `id_producto`, `cantidad`, `precio_compra`) VALUES
(1, 10, 2, 10, '1.00'),
(2, 11, 2, 10, '1.00'),
(3, 12, 2, 10, '2.00'),
(4, 13, 2, 10, '1.00'),
(5, 14, 2, 10, '1.00'),
(6, 15, 2, 10, '1.00'),
(7, 16, 2, 10, '1.00'),
(8, 17, 2, 10, '1.00'),
(9, 18, 2, 10, '1.00'),
(10, 19, 2, 25, '1.00'),
(11, 20, 5, 10, '1.00'),
(12, 21, 7, 10, '25.00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `id_categoria` int(11) DEFAULT NULL,
  `precio_compra` decimal(10,2) NOT NULL DEFAULT 0.00,
  `precio_venta` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `stock_minimo` int(11) NOT NULL DEFAULT 0,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id`, `nombre`, `id_categoria`, `precio_compra`, `precio_venta`, `stock`, `stock_minimo`, `activo`) VALUES
(2, 'coca cola', 1, '1.00', '1.00', 0, 10, 1),
(3, 'pan', 1, '100.00', '1.00', 87, 10, 1),
(5, 'papas', 5, '200.00', '1.00', 109, 10, 1),
(6, 'Queso', 5, '100.00', '1.00', 90, 10, 1),
(7, 'Requezon', 5, '25.00', '1.00', 53, 10, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `proveedores`
--

DROP TABLE IF EXISTS `proveedores`;
CREATE TABLE `proveedores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `contacto` varchar(120) DEFAULT NULL,
  `telefono` varchar(30) DEFAULT NULL,
  `correo` varchar(120) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `proveedores`
--

INSERT INTO `proveedores` (`id`, `nombre`, `contacto`, `telefono`, `correo`) VALUES
(1, 'pepsi', 'amilcar', '5555-2211', 'giovanni.ruano.2006@gmail.com'),
(3, 'Constancia', 'Erika', '2222-3333', 'constancia@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `nombre`) VALUES
(1, 'ADMIN'),
(2, 'VENDEDOR');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nombre_completo` varchar(100) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `username`, `password`, `nombre_completo`, `id_rol`, `activo`) VALUES
(1, 'admin', 'admin', 'Administrador', 1, 1),
(2, 'vendedor', '1234', 'Vendedor General', 2, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas`
--

DROP TABLE IF EXISTS `ventas`;
CREATE TABLE `ventas` (
  `id` int(11) NOT NULL,
  `numero_factura` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `metodo_pago` varchar(30) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL DEFAULT 0.00,
  `iva` decimal(12,2) NOT NULL DEFAULT 0.00,
  `total` decimal(12,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas`
--

INSERT INTO `ventas` (`id`, `numero_factura`, `id_usuario`, `fecha`, `metodo_pago`, `subtotal`, `iva`, `total`) VALUES
(1, 1, 1, '2025-10-23 21:02:44', 'Efectivo', '10.00', '10.00', '10.00'),
(2, 2, 1, '2025-10-23 21:34:28', 'Efectivo', '5.00', '0.65', '5.65'),
(3, 3, 1, '2025-10-23 21:35:12', 'Efectivo', '7.00', '0.91', '7.91'),
(4, 4, 1, '2025-10-23 21:37:26', 'Tarjeta', '5.00', '0.65', '5.65'),
(5, 5, 1, '2025-10-23 22:04:18', 'Tarjeta', '2.00', '0.26', '2.26'),
(6, 6, 1, '2025-10-23 22:17:16', 'Efectivo', '3.00', '0.39', '3.39'),
(7, 7, 1, '2025-10-24 12:26:57', 'Tarjeta', '5.00', '0.65', '5.65'),
(8, 8, 1, '2025-10-24 17:35:42', 'Efectivo', '6.00', '0.78', '6.78'),
(9, 9, 1, '2025-10-25 00:17:24', 'Tarjeta', '5.00', '0.65', '5.65'),
(10, 10, 1, '2025-10-25 00:19:25', 'Efectivo', '1.00', '0.13', '1.13'),
(11, 11, 1, '2025-10-25 11:25:29', 'Efectivo', '2.00', '0.26', '2.26'),
(12, 12, 1, '2025-10-25 11:33:38', 'Efectivo', '10.00', '1.30', '11.30'),
(13, 13, 1, '2025-10-25 11:45:54', 'Tarjeta', '5.00', '0.65', '5.65');

--
-- Disparadores `ventas`
--
DROP TRIGGER IF EXISTS `trg_ventas_numero_factura`;
DELIMITER $$
CREATE TRIGGER `trg_ventas_numero_factura` BEFORE INSERT ON `ventas` FOR EACH ROW BEGIN
  IF NEW.numero_factura IS NULL OR NEW.numero_factura = 0 THEN
    SET NEW.numero_factura = COALESCE(
      (SELECT MAX(v.numero_factura) FROM ventas v), 0
    ) + 1;
  END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ventas_detalle`
--

DROP TABLE IF EXISTS `ventas_detalle`;
CREATE TABLE `ventas_detalle` (
  `id` int(11) NOT NULL,
  `id_venta` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio_venta` decimal(10,2) NOT NULL,
  `subtotal` decimal(12,2) GENERATED ALWAYS AS (`cantidad` * `precio_venta`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ventas_detalle`
--

INSERT INTO `ventas_detalle` (`id`, `id_venta`, `id_producto`, `cantidad`, `precio_venta`) VALUES
(1, 1, 2, 5, '10.00'),
(2, 2, 2, 5, '1.00'),
(3, 3, 2, 5, '1.00'),
(4, 3, 3, 2, '1.00'),
(5, 4, 2, 5, '1.00'),
(6, 5, 3, 2, '1.00'),
(7, 6, 3, 3, '1.00'),
(8, 7, 2, 5, '1.00'),
(9, 8, 2, 6, '1.00'),
(10, 9, 3, 2, '1.00'),
(11, 9, 2, 3, '1.00'),
(12, 10, 5, 1, '1.00'),
(13, 11, 7, 2, '1.00'),
(14, 12, 6, 10, '1.00'),
(15, 13, 7, 5, '1.00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_proveedor` (`id_proveedor`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `compras_detalle`
--
ALTER TABLE `compras_detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_compra` (`id_compra`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_categoria` (`id_categoria`);

--
-- Indices de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nombre` (`nombre`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `id_rol` (`id_rol`);

--
-- Indices de la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `numero_factura` (`numero_factura`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `ventas_detalle`
--
ALTER TABLE `ventas_detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_venta` (`id_venta`),
  ADD KEY `id_producto` (`id_producto`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `compras`
--
ALTER TABLE `compras`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `compras_detalle`
--
ALTER TABLE `compras_detalle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ventas`
--
ALTER TABLE `ventas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `ventas_detalle`
--
ALTER TABLE `ventas_detalle`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`id_proveedor`) REFERENCES `proveedores` (`id`),
  ADD CONSTRAINT `compras_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `compras_detalle`
--
ALTER TABLE `compras_detalle`
  ADD CONSTRAINT `compras_detalle_ibfk_1` FOREIGN KEY (`id_compra`) REFERENCES `compras` (`id`),
  ADD CONSTRAINT `compras_detalle_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`);

--
-- Filtros para la tabla `productos`
--
ALTER TABLE `productos`
  ADD CONSTRAINT `productos_ibfk_1` FOREIGN KEY (`id_categoria`) REFERENCES `categorias` (`id`);

--
-- Filtros para la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `roles` (`id`);

--
-- Filtros para la tabla `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `ventas_detalle`
--
ALTER TABLE `ventas_detalle`
  ADD CONSTRAINT `ventas_detalle_ibfk_1` FOREIGN KEY (`id_venta`) REFERENCES `ventas` (`id`),
  ADD CONSTRAINT `ventas_detalle_ibfk_2` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
