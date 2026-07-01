-- ============================================================
-- Script 04
-- Validar restricciones.
--
-- IMPORTANTE:
-- Algunas sentencias de este archivo deben fallar.
-- Ese es el objetivo de la práctica.
--
-- Ejecutar bloque por bloque desde pgAdmin.
--
-- Este script cubre:
-- - NOT NULL
-- - UNIQUE
-- - FOREIGN KEY
-- - CHECK
-- - PRIMARY KEY compuesta
-- ============================================================

-- ============================================================
-- 1. NOT NULL
--
-- Intentar insertar un usuario sin email.
-- Debe fallar porque email es obligatorio.
-- ============================================================

INSERT INTO usuarios(nombre)
VALUES ('Usuario sin email');

-- Error esperado:
-- null value in column "email" violates not-null constraint

-- ============================================================
-- 2. UNIQUE
--
-- Intentar repetir un email.
-- Debe fallar porque email tiene restricción UNIQUE.
-- ============================================================

INSERT INTO usuarios(nombre, email)
VALUES ('Otra Ana', 'ana@example.com');

-- Error esperado:
-- duplicate key value violates unique constraint

-- ============================================================
-- 3. FOREIGN KEY
--
-- Intentar crear un dataset con usuario inexistente.
-- Debe fallar porque usuario_id = 999 no existe en usuarios.
-- ============================================================

INSERT INTO datasets(usuario_id, nombre, fuente, cantidad_registros)
VALUES (999, 'Dataset inválido', 'IoT', 100);

-- Error esperado:
-- insert or update on table "datasets" violates foreign key constraint

-- ============================================================
-- 4. FOREIGN KEY
--
-- Intentar crear un modelo con usuario inexistente.
-- Debe fallar porque usuario_id = 999 no existe.
-- ============================================================

INSERT INTO modelos(usuario_id, nombre, tipo, version)
VALUES (999, 'Modelo inválido', 'Clasificación', 'v1');

-- ============================================================
-- 5. FOREIGN KEY
--
-- Intentar crear un experimento con dataset inexistente.
-- Debe fallar porque dataset_id = 999 no existe.
-- ============================================================

INSERT INTO experimentos(dataset_id, nombre, descripcion)
VALUES (
    999,
    'Experimento inválido',
    'Este experimento apunta a un dataset inexistente.'
);

-- ============================================================
-- 6. FOREIGN KEY
--
-- Intentar crear una métrica sin experimento válido.
-- Debe fallar porque experimento_id = 999 no existe.
-- ============================================================

INSERT INTO metricas(experimento_id, nombre, valor)
VALUES (999, 'accuracy', 0.90);

-- ============================================================
-- 7. CHECK
--
-- Intentar crear una métrica con valor negativo.
-- Debe fallar porque valor debe ser mayor o igual a cero.
-- ============================================================

INSERT INTO metricas(experimento_id, nombre, valor)
VALUES (1, 'accuracy', -0.50);

-- ============================================================
-- 8. PRIMARY KEY compuesta
--
-- Intentar repetir la misma asociación experimento-modelo.
-- Debe fallar porque la tabla experimentos_modelos tiene
-- PRIMARY KEY (experimento_id, modelo_id).
-- ============================================================

INSERT INTO experimentos_modelos(experimento_id, modelo_id, parametros, resultado)
VALUES (1, 1, 'max_depth=10', 'Intento de repetir la relación');

-- ============================================================
-- 9. DELETE protegido por FOREIGN KEY
--
-- Intentar eliminar un usuario que tiene datasets asociados.
-- Debe fallar porque existen datasets que dependen de ese usuario.
-- ============================================================

DELETE FROM usuarios
WHERE id = 1;

-- ============================================================
-- 10. Caso válido
--
-- Esta inserción sí debería funcionar.
-- Sirve para comparar con los errores anteriores.
-- ============================================================

INSERT INTO usuarios(nombre, email)
VALUES ('Usuario válido', 'usuario.valido@example.com');

SELECT *
FROM usuarios
WHERE email = 'usuario.valido@example.com';