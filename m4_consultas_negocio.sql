-- ══════════════════════════════════════════
-- RetailPro — Módulo 4: Consultas de Negocio
-- Autor: Daniela Rodriguez
-- Fecha: Septiembre 2026
-- ══════════════════════════════════════════

-- Seleccionar la base de datos de trabajo
USE Ventas_Tech_DB;
GO 
-- Consulta 1 — Resumen ejecutivo mensual
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) / COUNT(*) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes ASC;

-- Consulta 2 — Ranking de productos (Top 5)
SELECT TOP 5
    id_producto, 
    SUM(cantidad) AS unidades_vendidas, 
    SUM(cantidad * precio_unitario) AS total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;

-- Consulta 3 — Clientes recurrentes
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

-- Consulta 4 — Meses por encima/por debajo del promedio
SELECT 
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    CASE 
        WHEN SUM(cantidad * precio_unitario) > (
            SELECT AVG(total_mensual) 
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_mensual 
                FROM ventas 
                GROUP BY MONTH(fecha_venta)
            ) AS subquery
        ) THEN 'Por encima'
        ELSE 'Por debajo'
    END AS rendimiento
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes ASC;

-- ==========================================================================
-- CONCLUSIONES Y HALLAZGOS DE NEGOCIO
-- ==========================================================================
-- 1. Concentración de Ingresos: El id_producto 1 (Laptop Pro 15) es el que más dinero genera en la tienda, liderando el ranking de facturación total.
-- 2. Clientes Recurrentes: Los clientes con id_cliente 1, 2, 3, 4 y 5 muestran recurrencia realizando más de un pedido, lo que demuestra una alta tasa de recompra en este set de datos.
