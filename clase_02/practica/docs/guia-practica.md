# Guía práctica PostgreSQL y pgAdmin

Esta guía resume el flujo recomendado para trabajar con PostgreSQL y pgAdmin en Docker.

## 1. Preparar el entorno

Creá el archivo `.env` local a partir de la plantilla:

```bash
cp .env.example .env
```

En Windows PowerShell podés usar:

```powershell
Copy-Item .env.example .env
```

## 2. Levantar Docker

Abrí Docker Desktop y verificá que esté iniciado. Luego, desde la carpeta del proyecto, ejecutá:

```bash
docker compose up -d
```

Este comando levanta PostgreSQL y pgAdmin.

## 3. Entrar a pgAdmin

Abrí el navegador en:

<http://localhost:8080>

Ingresá con:

- Usuario: `admin@bdia.com`
- Contraseña: `admin`

## 4. Conectarse a PostgreSQL

En pgAdmin, registrá un nuevo servidor:

- Name: `BDIA PostgreSQL`
- Host name/address: `postgres`
- Port: `5432`
- Maintenance database: `bdia_clase2`
- Username: `bdia_user`
- Password: `bdia_pass`

Dentro de Docker, el host es `postgres`, no `localhost`.

## 5. Crear tablas

Abrí **Query Tool** y ejecutá:

```text
sql/01_crear_tablas.sql
```

## 6. Insertar datos

Ejecutá el script:

```text
sql/02_insertar_datos.sql
```

## 7. Ejecutar consultas

Ejecutá el script:

```text
sql/03_consultas_basicas.sql
```

Usá estas consultas para practicar `SELECT`, `WHERE`, `ORDER BY` y `LIMIT`.

## 8. Probar restricciones

Ejecutá el script:

```text
sql/04_validar_restricciones.sql
```

Este paso permite comprobar que el modelo rechaza datos inválidos según sus restricciones.

## 9. Detener el entorno

Para detener los contenedores sin borrar datos:

```bash
docker compose down
```

Para detener y borrar datos persistentes:

```bash
docker compose down -v
```

> Usá `docker compose down -v` solo si querés reiniciar el entorno desde cero.
