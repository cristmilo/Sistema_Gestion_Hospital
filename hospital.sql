-- ============================================================
--  BASE DE DATOS HOSPITAL
--  Ejecuta este script completo en MySQL Workbench
-- ============================================================

CREATE DATABASE IF NOT EXISTS hospital;
USE hospital;

-- ============================================================
--  TABLAS (ALTER para agregar columnas nuevas si ya existen)
-- ============================================================

CREATE TABLE IF NOT EXISTS pacientes (
    id_paciente INT PRIMARY KEY,
    nombre      VARCHAR(50),
    apellido    VARCHAR(50),
    telefono    VARCHAR(20),
    email       VARCHAR(100),
    foto        LONGBLOB
);

-- Si la tabla ya existía sin email/foto, agrega las columnas:
ALTER TABLE pacientes
    ADD COLUMN IF NOT EXISTS email VARCHAR(100),
    ADD COLUMN IF NOT EXISTS foto  LONGBLOB;

CREATE TABLE IF NOT EXISTS medicos (
    id_medico    INT PRIMARY KEY,
    nombre       VARCHAR(50),
    especialidad VARCHAR(50),
    email        VARCHAR(100),
    foto         LONGBLOB
);

ALTER TABLE medicos
    ADD COLUMN IF NOT EXISTS email VARCHAR(100),
    ADD COLUMN IF NOT EXISTS foto  LONGBLOB;

CREATE TABLE IF NOT EXISTS medicamentos (
    id_medicamento INT PRIMARY KEY,
    nombre         VARCHAR(100),
    categoria      VARCHAR(50),
    stock          INT,
    foto           LONGBLOB
);

CREATE TABLE IF NOT EXISTS citas (
    id_cita     INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    id_medico   INT,
    fecha       VARCHAR(20),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_medico)   REFERENCES medicos(id_medico)
);


-- ============================================================
--  ELIMINAR SPs VIEJOS (evita el error "already exists")
-- ============================================================

DROP PROCEDURE IF EXISTS sp_registrar_paciente;
DROP PROCEDURE IF EXISTS sp_actualizar_paciente;
DROP PROCEDURE IF EXISTS sp_eliminar_paciente;
DROP PROCEDURE IF EXISTS sp_mostrar_pacientes;

DROP PROCEDURE IF EXISTS sp_registrar_medico;
DROP PROCEDURE IF EXISTS sp_actualizar_medico;
DROP PROCEDURE IF EXISTS sp_eliminar_medico;
DROP PROCEDURE IF EXISTS sp_mostrar_medicos;

DROP PROCEDURE IF EXISTS sp_registrar_cita;
DROP PROCEDURE IF EXISTS sp_agendar_cita;
DROP PROCEDURE IF EXISTS sp_eliminar_cita;
DROP PROCEDURE IF EXISTS sp_mostrar_citas;

DROP PROCEDURE IF EXISTS sp_registrar_medicamento;
DROP PROCEDURE IF EXISTS sp_actualizar_medicamento;
DROP PROCEDURE IF EXISTS sp_eliminar_medicamento;
DROP PROCEDURE IF EXISTS sp_mostrar_medicamentos;


-- ============================================================
--  STORED PROCEDURES - PACIENTES
-- ============================================================

DELIMITER //

CREATE PROCEDURE sp_registrar_paciente(
    IN p_id       INT,
    IN p_nombre   VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_email    VARCHAR(100),
    IN p_foto     LONGBLOB
)
BEGIN
    INSERT INTO pacientes VALUES (p_id, p_nombre, p_apellido, p_telefono, p_email, p_foto);
END //

CREATE PROCEDURE sp_actualizar_paciente(
    IN p_id       INT,
    IN p_nombre   VARCHAR(50),
    IN p_apellido VARCHAR(50),
    IN p_telefono VARCHAR(20),
    IN p_email    VARCHAR(100),
    IN p_foto     LONGBLOB
)
BEGIN
    UPDATE pacientes
    SET nombre=p_nombre, apellido=p_apellido, telefono=p_telefono,
        email=p_email, foto=p_foto
    WHERE id_paciente=p_id;
END //

DROP PROCEDURE IF EXISTS sp_eliminar_paciente;



CREATE PROCEDURE sp_eliminar_paciente(IN p_id INT)
BEGIN
    -- Primero elimina las citas asociadas al paciente
    DELETE FROM citas WHERE id_paciente = p_id;
    -- Luego elimina al paciente
    DELETE FROM pacientes WHERE id_paciente = p_id;
END //





CREATE PROCEDURE sp_mostrar_pacientes()
BEGIN
    SELECT id_paciente, nombre, apellido, telefono, email FROM pacientes;
END //


-- ============================================================
--  STORED PROCEDURES - MEDICOS
-- ============================================================

CREATE PROCEDURE sp_registrar_medico(
    IN p_id           INT,
    IN p_nombre       VARCHAR(50),
    IN p_especialidad VARCHAR(50),
    IN p_email        VARCHAR(100),
    IN p_foto         LONGBLOB
)
BEGIN
    INSERT INTO medicos VALUES (p_id, p_nombre, p_especialidad, p_email, p_foto);
END //

CREATE PROCEDURE sp_actualizar_medico(
    IN p_id           INT,
    IN p_nombre       VARCHAR(50),
    IN p_especialidad VARCHAR(50),
    IN p_email        VARCHAR(100),
    IN p_foto         LONGBLOB
)
BEGIN
    UPDATE medicos
    SET nombre=p_nombre, especialidad=p_especialidad,
        email=p_email, foto=p_foto
    WHERE id_medico=p_id;
END //

DROP PROCEDURE IF EXISTS sp_eliminar_medico;



CREATE PROCEDURE sp_eliminar_medico(IN p_id INT)
BEGIN
    -- Primero elimina las citas asociadas al médico
    DELETE FROM citas WHERE id_medico = p_id;
    -- Luego elimina al médico
    DELETE FROM medicos WHERE id_medico = p_id;
END //



CREATE PROCEDURE sp_mostrar_medicos()
BEGIN
    SELECT id_medico, nombre, especialidad, email FROM medicos;
END //


-- ============================================================
--  STORED PROCEDURES - CITAS
-- ============================================================

CREATE PROCEDURE sp_registrar_cita(
    IN p_paciente INT,
    IN p_medico   INT,
    IN p_fecha    VARCHAR(20)
)
BEGIN
    INSERT INTO citas(id_paciente, id_medico, fecha)
    VALUES (p_paciente, p_medico, p_fecha);
END //

CREATE PROCEDURE sp_eliminar_cita(IN p_id INT)
BEGIN
    DELETE FROM citas WHERE id_cita=p_id;
END //

CREATE PROCEDURE sp_mostrar_citas()
BEGIN
    SELECT c.id_cita,
           p.nombre,
           p.apellido,
           m.nombre AS medico,
           c.fecha
    FROM citas c
    INNER JOIN pacientes p ON c.id_paciente = p.id_paciente
    INNER JOIN medicos   m ON c.id_medico   = m.id_medico;
END //


-- ============================================================
--  STORED PROCEDURES - MEDICAMENTOS
-- ============================================================

CREATE PROCEDURE sp_registrar_medicamento(
    IN p_id        INT,
    IN p_nombre    VARCHAR(100),
    IN p_categoria VARCHAR(50),
    IN p_stock     INT,
    IN p_foto      LONGBLOB
)
BEGIN
    INSERT INTO medicamentos VALUES (p_id, p_nombre, p_categoria, p_stock, p_foto);
END //

CREATE PROCEDURE sp_actualizar_medicamento(
    IN p_id        INT,
    IN p_nombre    VARCHAR(100),
    IN p_categoria VARCHAR(50),
    IN p_stock     INT,
    IN p_foto      LONGBLOB
)
BEGIN
    UPDATE medicamentos
    SET nombre=p_nombre, categoria=p_categoria, stock=p_stock, foto=p_foto
    WHERE id_medicamento=p_id;
END //

CREATE PROCEDURE sp_eliminar_medicamento(IN p_id INT)
BEGIN
    DELETE FROM medicamentos WHERE id_medicamento=p_id;
END //

CREATE PROCEDURE sp_mostrar_medicamentos()
BEGIN
    SELECT id_medicamento, nombre, categoria, stock FROM medicamentos;
END //

DELIMITER ;



