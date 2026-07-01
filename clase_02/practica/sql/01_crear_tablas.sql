-- ============================================================
-- Script 01
-- Crear tablas principales del caso guía.
--
-- Clase 2 - Modelado de Datos y Lenguaje SQL
-- Caso: Sistema simple de gestión de experimentos de IA
--
-- Este script cubre:
-- - CREATE TABLE
-- - Tipos de datos básicos: INTEGER, NUMERIC, TEXT, BOOLEAN,
--   DATE y TIMESTAMP
-- - PRIMARY KEY
-- - FOREIGN KEY
-- - NOT NULL
-- - UNIQUE
-- - CHECK
-- ============================================================

-- Eliminamos las tablas si ya existen.
-- Se eliminan en orden inverso a las dependencias.

DROP TABLE IF EXISTS metricas;
DROP TABLE IF EXISTS experimentos_modelos;
DROP TABLE IF EXISTS experimentos;
DROP TABLE IF EXISTS modelos;
DROP TABLE IF EXISTS datasets;
DROP TABLE IF EXISTS usuarios;

-- ============================================================
-- Tabla: usuarios
--
-- Ejemplo principal de CREATE TABLE.
-- Cada usuario tiene un identificador único, nombre, email
-- y una fecha de alta.
-- ============================================================

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    activo BOOLEAN NOT NULL DEFAULT TRUE,
    fecha_alta TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Tabla: datasets
--
-- Un usuario puede cargar muchos datasets.
-- Cada dataset pertenece a un usuario.
--
-- Relación:
-- usuarios 1:N datasets
--
-- La clave foránea usuario_id conecta esta tabla con usuarios.
-- ============================================================

CREATE TABLE datasets (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL REFERENCES usuarios(id),
    nombre TEXT NOT NULL,
    fuente TEXT,
    cantidad_registros INTEGER,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Tabla: modelos
--
-- Un usuario puede registrar muchos modelos.
-- Cada modelo pertenece a un usuario.
--
-- Relación:
-- usuarios 1:N modelos
-- ============================================================

CREATE TABLE modelos (
    id SERIAL PRIMARY KEY,
    usuario_id INTEGER NOT NULL REFERENCES usuarios(id),
    nombre TEXT NOT NULL,
    tipo TEXT NOT NULL,
    version TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- Tabla: experimentos
--
-- Un experimento usa un dataset.
-- Un dataset puede usarse en varios experimentos.
--
-- Relación:
-- datasets 1:N experimentos
-- ============================================================

CREATE TABLE experimentos (
    id SERIAL PRIMARY KEY,
    dataset_id INTEGER NOT NULL REFERENCES datasets(id),
    nombre TEXT NOT NULL,
    descripcion TEXT,
    fecha DATE DEFAULT CURRENT_DATE,
    finalizado BOOLEAN DEFAULT FALSE
);

-- ============================================================
-- Tabla: experimentos_modelos
--
-- Resuelve la relación muchos a muchos entre experimentos
-- y modelos.
--
-- Un experimento puede evaluar varios modelos.
-- Un modelo puede participar en varios experimentos.
--
-- Relación:
-- experimentos N:M modelos
-- ============================================================

CREATE TABLE experimentos_modelos (
    experimento_id INTEGER NOT NULL REFERENCES experimentos(id),
    modelo_id INTEGER NOT NULL REFERENCES modelos(id),
    parametros TEXT,
    resultado TEXT,

    PRIMARY KEY (experimento_id, modelo_id)
);

-- ============================================================
-- Tabla: metricas
--
-- Un experimento puede generar muchas métricas.
-- Cada métrica pertenece a un experimento.
--
-- Relación:
-- experimentos 1:N metricas
-- ============================================================

CREATE TABLE metricas (
    id SERIAL PRIMARY KEY,
    experimento_id INTEGER NOT NULL REFERENCES experimentos(id),
    nombre TEXT NOT NULL,
    valor NUMERIC NOT NULL CHECK (valor >= 0),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);