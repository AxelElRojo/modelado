CREATE TABLE Colonia (
  id        SERIAL PRIMARY KEY,
  nombre    VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Propiedad (
  id            SERIAL PRIMARY KEY,
  titulo        VARCHAR(255),
  direccion     VARCHAR(255),
  idColonia     BIGINT UNSIGNED REFERENCES Colonia(id),
  precio        DOUBLE(12,2),
  area          DOUBLE(8,2),
  recamaras     INT,
  mantenimiento DOUBLE(12,2),
  fechaCreacion DATETIME
);

CREATE TABLE Amenidad (
  id      SERIAL PRIMARY KEY,
  nombre  VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE AmenidadPropiedad (
  idPropiedad BIGINT UNSIGNED REFERENCES Propiedad(id),
  idAmenidad  BIGINT UNSIGNED REFERENCES Amenidad(id),
  PRIMARY KEY (idPropiedad, idAmenidad)
);