-- ══════════════════════════════════════════
-- RetailPro — Módulo 5: Consultas con JOINs
-- Autor: Daniela Rodriguez
-- Fecha: Septiembre 2026
-- ══════════════════════════════════════════

-- Consulta 1 - Vista base del proyecto (INNER JOIN)

USE Ventas_Tech_DB
GO

SELECT   v.fecha_venta, 
         c.nombre,
         p.nombre_producto,
         cat.nombre_categoria ,
         v.cantidad *
         v. precio_unitario AS
         total_venta
FROM ventas v
INNER JOIN clientes c 
ON c.id_cliente = v.id_cliente
INNER JOIN productos p 
ON p.id_producto = v.id_producto
INNER JOIN categorias cat 
ON p.id_categoria = cat.id_categoria;

-- Consulta 2 - Clientes sin ventas (LEFT JOIN)

SELECT nombre,
       email,
       fecha_registro
FROM clientes c
LEFT JOIN ventas v
ON c.id_cliente = v.id_cliente
WHERE v.id_cliente IS NULL;

-- Consulta 3 — Productos sin ventas (LEFT JOIN)

SELECT 
    p.nombre_producto,
    cat.nombre_categoria, 
    p.precio
FROM productos p
INNER JOIN categorias cat 
    ON p.id_categoria = cat.id_categoria 
LEFT JOIN ventas v 
    ON p.id_producto = v.id_producto
WHERE v.id_producto IS NULL; 


--Consulta 4 — Consolidado por canal (UNION ALL)

SELECT 
    canal,
    SUM(total_venta) AS total_facturado
FROM (
    SELECT 
        fecha_venta, 
        (cantidad * precio_unitario) AS total_venta, 
        'Presencial' AS canal 
    FROM ventas 
    WHERE DAY(fecha_venta) <= 10

    UNION ALL 

    SELECT 
        fecha_venta, 
        (cantidad * precio_unitario) AS total_venta, 
        'Online' AS canal 
    FROM ventas 
    WHERE DAY(fecha_venta) > 10
) AS subquery_canales
GROUP BY canal;
