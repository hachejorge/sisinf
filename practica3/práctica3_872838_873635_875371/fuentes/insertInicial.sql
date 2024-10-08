INSERT INTO sisinf_db.USUARIO (nombre_usuario, correo_elec, password)
VALUES ('admin', '872838@unizar.es', 'admin');

-- Crear el perfil del Jugador 1
INSERT INTO sisinf_db.USUARIO (nombre_usuario, correo_elec, password)
VALUES ('jugador1', 'jugador1@example.com', 'password1');

-- Crear el perfil del Jugador 2
INSERT INTO sisinf_db.USUARIO (nombre_usuario, correo_elec, password)
VALUES ('jugador2', 'jugador2@example.com', 'password2');

-- Crear el perfil del Jugador 3
INSERT INTO sisinf_db.USUARIO (nombre_usuario, correo_elec, password)
VALUES ('jugador3', 'jugador3@example.com', 'password3');

-- Crear la competición
INSERT INTO sisinf_db.COMPETICION (nombre)
VALUES ('Liga de Ejemplo');

-- Crear el equipo
INSERT INTO sisinf_db.EQUIPO (id_equipo, nombre_equipo, ubicacion, competicion)
VALUES (1, 'Equipo A', 'Ciudad X', 'Liga de Ejemplo');

-- Crear los jugadores
INSERT INTO sisinf_db.JUGADOR (nombre_usuario, nombre_jugador, equipo)
VALUES 
    ('jugador1', 'Jugador 1', 1),  -- Jugador 1
    ('jugador2', 'Jugador 2', 1),  -- Jugador 2
    ('jugador3', 'Jugador 3', 1);  -- Jugador 3
