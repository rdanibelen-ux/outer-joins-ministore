-- ══════════════════════════════════════════
-- RetailChain — UNION y UNION ALL
-- Autor: Daniela
-- Fecha: Septiembre 2026
-- ══════════════════════════════════════════

-- ── CONSULTA 1: UNION ────────────────────
-- Reporte de Catálogo Unificado
-- Pregunta de negocio: ¿Qué productos únicos comercializa
-- la empresa en toda su red de sucursales?
-- Operador: UNION (elimina filas completamente duplicadas)

-- [Tu consulta aquí]
SELECT 
id_producto, nombre_producto, categoria FROM inventario_sucursal_sur 
UNION
SELECT 
id_producto, nombre_producto, categoria FROM inventario_sucursal_norte

-- ── CONSULTA 2: UNION ALL ────────────────
-- Auditoría de Stock Total
-- Pregunta de negocio: ¿Cuántos registros físicos de stock
-- existen en total entre ambas sucursales?
-- Operador: UNION ALL (mantiene todos los registros incluyendo duplicados)

-- [Tu consulta aquí]

SELECT 
id_producto, nombre_producto, categoria, stock FROM inventario_sucursal_norte
UNION ALL
SELECT 
id_producto, nombre_producto, categoria, stock FROM inventario_sucursal_sur;

-- ── CONSULTA 3: COMPARACIÓN DE RESULTADOS ─
-- Ejecutá estas dos consultas para comparar cuántas filas
-- devuelve cada operador y explicá la diferencia en tu README

-- ── CONSULTA 3: COMPARACIÓN DE RESULTADOS ─
-- Ejecutá estas dos consultas para comparar cuántas filas
-- devuelve cada operador y explicá la diferencia en tu README

SELECT COUNT(*) AS filas_union FROM (
    SELECT id_producto, nombre_producto, categoria FROM inventario_sucursal_sur 
    UNION
    SELECT id_producto, nombre_producto, categoria FROM inventario_sucursal_norte
) AS resultado_union;

SELECT COUNT(*) AS filas_union_all FROM (
    SELECT id_producto, nombre_producto, categoria, stock FROM inventario_sucursal_norte
    UNION ALL
    SELECT id_producto, nombre_producto, categoria, stock FROM inventario_sucursal_sur
) AS resultado_union_all;
