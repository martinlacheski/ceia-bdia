-- ============================================================
-- Script 02
-- Insertar datos de ejemplo.
--
-- Este script cubre:
-- - INSERT INTO
-- - Inserción de varios registros
-- - Respeto del orden de las relaciones
--
-- Importante:
-- Primero deben existir los datos referenciados.
-- Por eso insertamos en este orden:
-- 1. usuarios
-- 2. datasets
-- 3. modelos
-- 4. experimentos
-- 5. experimentos_modelos
-- 6. metricas
-- ============================================================

-- ============================================================
-- 1. Insertar usuarios
-- ============================================================

INSERT INTO usuarios(nombre, email)
VALUES
    ('Ana Pérez', 'ana@example.com'),
    ('Luis Gómez', 'luis@example.com'),
    ('María Torres', 'maria@example.com');

-- ============================================================
-- 2. Insertar datasets
--
-- usuario_id referencia a usuarios(id).
-- Por eso los usuarios deben existir antes.
-- ============================================================

INSERT INTO datasets(usuario_id, nombre, fuente, cantidad_registros)
VALUES
    (1, 'Sensores ambientales', 'IoT', 15000),
    (1, 'Imágenes de cultivos', 'Visión computacional', 5000),
    (2, 'Histórico de ventas', 'Sistema transaccional', 25000),
    (3, 'Comentarios de usuarios', 'Aplicación web', 8000);

-- ============================================================
-- 3. Insertar modelos
-- ============================================================

INSERT INTO modelos(usuario_id, nombre, tipo, version)
VALUES
    (1, 'Clasificador de lluvia', 'Clasificación', 'v1'),
    (1, 'Detector de cultivos', 'Visión computacional', 'v1'),
    (2, 'Predicción de demanda', 'Regresión', 'v1'),
    (3, 'Análisis de sentimiento', 'Clasificación', 'v1');

-- ============================================================
-- 4. Insertar experimentos
--
-- dataset_id referencia a datasets(id).
-- ============================================================

INSERT INTO experimentos(dataset_id, nombre, descripcion, finalizado)
VALUES
    (
        1,
        'Experimento lluvia v1',
        'Primer experimento para predecir lluvia usando sensores ambientales.',
        TRUE
    ),
    (
        2,
        'Experimento cultivos v1',
        'Primer experimento para clasificar imágenes de cultivos.',
        TRUE
    ),
    (
        3,
        'Experimento demanda v1',
        'Prueba inicial para predecir demanda con datos históricos.',
        FALSE
    );

-- ============================================================
-- 5. Asociar experimentos con modelos
--
-- Esta tabla representa la relación muchos a muchos.
-- ============================================================

INSERT INTO experimentos_modelos(experimento_id, modelo_id, parametros, resultado)
VALUES
    (1, 1, 'max_depth=5', 'Resultado inicial aceptable'),
    (2, 2, 'epochs=10', 'Buen desempeño inicial'),
    (3, 3, 'test_size=0.2', 'Modelo en evaluación');

-- ============================================================
-- 6. Insertar métricas
--
-- experimento_id referencia a experimentos(id).
-- ============================================================

INSERT INTO metricas(experimento_id, nombre, valor)
VALUES
    (1, 'accuracy', 0.82),
    (1, 'precision', 0.79),
    (1, 'recall', 0.75),
    (2, 'accuracy', 0.91),
    (2, 'f1_score', 0.88),
    (3, 'mae', 12.45);