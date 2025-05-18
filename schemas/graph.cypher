LOAD CSV WITH HEADERS FROM 'file:///colonias.csv' AS row
FIELDTERMINATOR '|'
MERGE (c:Colonia {id: toInteger(row.id)})
SET c.nombre = row.nombre;

LOAD CSV WITH HEADERS FROM 'file:///propiedades.csv' AS row
FIELDTERMINATOR '|'
MATCH (c:Colonia {id: toInteger(row.idColonia)})
MERGE (p:Propiedad {id: toInteger(row.id)})
SET p.titulo = row.titulo,
    p.direccion = row.direccion,
    p.precio = toFloat(row.precio),
    p.area = toFloat(row.area),
    p.recamaras = toInteger(row.recamaras),
    p.mantenimiento = toFloat(row.mantenimiento),
    p.fechaCreacion = datetime(row.fechaCreacion)
MERGE (p)-[:UBICADA_EN]->(c);

LOAD CSV WITH HEADERS FROM 'file:///amenidades.csv' AS row
FIELDTERMINATOR '|'
MERGE (a:Amenidad {id: toInteger(row.id)})
SET a.nombre = row.nombre;

LOAD CSV WITH HEADERS FROM 'file:///amenidad_propiedad.csv' AS row
FIELDTERMINATOR '|'
MATCH (p:Propiedad {id: toInteger(row.idPropiedad)})
MATCH (a:Amenidad {id: toInteger(row.idAmenidad)})
MERGE (p)-[:TIENE_AMENIDAD]->(a);

CREATE CONSTRAINT propiedad_id_unique IF NOT EXISTS
FOR (p:Propiedad)
REQUIRE p.id IS UNIQUE;

CREATE CONSTRAINT colonia_id_unique IF NOT EXISTS
FOR (c:Colonia)
REQUIRE c.id IS UNIQUE;

CREATE CONSTRAINT amenidad_id_unique IF NOT EXISTS
FOR (a:Amenidad)
REQUIRE a.id IS UNIQUE;