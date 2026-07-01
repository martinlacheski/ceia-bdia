-- ============================================================
-- Script 03
-- Consultas básicas.
--
-- Este script cubre:
-- - SELECT
-- - WHERE
-- - ORDER BY
-- - LIMIT
-- - UPDATE
-- - DELETE
--
-- También incluye algunas consultas con JOIN al final,
-- solo como anticipo para responder preguntas del caso guía.
-- ============================================================

-- ============================================================
-- 1. SELECT
-- Obtener información de una tabla.
-- ============================================================

SELECT nombre, email
FROM usuarios;

SELECT nombre, fuente
FROM datasets;

-- ============================================================
-- 2. SELECT *
-- Ver todas las columnas de una tabla.
-- ============================================================

SELECT *
FROM usuarios;

SELECT *
FROM datasets;

-- ============================================================
-- 3. WHERE
-- Filtrar resultados.
-- ============================================================

SELECT *
FROM datasets
WHERE fuente = 'IoT';

SELECT nombre, fuente, cantidad_registros
FROM datasets
WHERE cantidad_registros > 10000;

-- ============================================================
-- 4. ORDER BY
-- Ordenar resultados.
-- ============================================================

SELECT nombre, fecha_creacion
FROM datasets
ORDER BY fecha_creacion DESC;

SELECT nombre, cantidad_registros
FROM datasets
ORDER BY cantidad_registros DESC;

-- ============================================================
-- 5. LIMIT
-- Limitar la cantidad de resultados.
-- ============================================================

SELECT *
FROM datasets
ORDER BY fecha_creacion DESC
LIMIT 5;

SELECT nombre, cantidad_registros
FROM datasets
ORDER BY cantidad_registros DESC
LIMIT 2;

-- ============================================================
-- 6. UPDATE
-- Modificar registros existentes.
--
-- Importante:
-- WHERE indica qué registro se modifica.
-- Un UPDATE sin WHERE puede modificar toda la tabla.
-- ============================================================

UPDATE datasets
SET fuente = 'Sensores IoT'
WHERE id = 1;

-- Verificamos el cambio.

SELECT *
FROM datasets
WHERE id = 1;

-- ============================================================
-- 7. DELETE
-- Eliminar registros.
--
-- Para no romper el caso principal, primero insertamos
-- un registro de prueba y después lo eliminamos.
-- ============================================================

INSERT INTO datasets(usuario_id, nombre, fuente, cantidad_registros)
VALUES (1, 'Dataset temporal', 'Prueba', 10);

-- Verificamos que se insertó.

SELECT *
FROM datasets
WHERE nombre = 'Dataset temporal';

-- Eliminamos solo el dataset temporal.

DELETE FROM datasets
WHERE nombre = 'Dataset temporal';

-- Verificamos que ya no está.

SELECT *
FROM datasets
WHERE nombre = 'Dataset temporal';

-- ============================================================
-- 8. Consultas del caso guía
-- Anticipo mínimo de JOIN.
--
-- Estas consultas responden las preguntas de la práctica:
-- - ¿Qué datasets cargó cada usuario?
-- - ¿Qué experimentos usan un dataset determinado?
-- - ¿Qué métricas obtuvo cada experimento?
-- - ¿Qué modelos fueron evaluados?
--
-- No hace falta profundizar todavía en JOIN.
-- Eso puede retomarse en la próxima clase.
-- ============================================================

-- ¿Qué datasets cargó cada usuario?

SELECT
    usuarios.nombre AS usuario,
    datasets.nombre AS dataset,
    datasets.fuente
FROM usuarios
JOIN datasets
    ON datasets.usuario_id = usuarios.id;

-- ¿Qué experimentos usan cada dataset?

SELECT
    datasets.nombre AS dataset,
    experimentos.nombre AS experimento,
    experimentos.finalizado
FROM datasets
JOIN experimentos
    ON experimentos.dataset_id = datasets.id;

-- ¿Qué métricas obtuvo cada experimento?

SELECT
    experimentos.nombre AS experimento,
    metricas.nombre AS metrica,
    metricas.valor
FROM experimentos
JOIN metricas
    ON metricas.experimento_id = experimentos.id;

-- ¿Qué modelos fueron evaluados en cada experimento?

SELECT
    experimentos.nombre AS experimento,
    modelos.nombre AS modelo,
    modelos.tipo
FROM experimentos
JOIN experimentos_modelos
    ON experimentos_modelos.experimento_id = experimentos.id
JOIN modelos
    ON modelos.id = experimentos_modelos.modelo_id;