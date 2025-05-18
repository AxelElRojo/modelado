#!/bin/sh
set -e
echo "> Creando modelo de base de datos relacional"
mariadb -u root --password='$1' -e 'DROP DATABASE IF EXISTS modelado'
mariadb -u root --password='$1' -e 'CREATE DATABASE modelado'
mariadb -u root --password='$1' -D modelado < schemas/relational.sql
echo "> Modelo relacional creado"
echo "> Cargando datos"
echo "> Cargando colonias"
mariadb -u root --password='$1' -e "LOAD DATA LOCAL INFILE 'csv/colonias.csv' INTO TABLE Colonia FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' IGNORE 1 ROWS;" -D modelado
echo "> Colonias cargadas"
echo "> Cargando amenidades"
mariadb -u root --password='$1' -e "LOAD DATA LOCAL INFILE 'csv/amenidades.csv' INTO TABLE Amenidad FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' IGNORE 1 ROWS;" -D modelado
echo "> Amenidades cargadas"
echo "> Cargando publicaciones"
mariadb -u root --password='$1' -e "LOAD DATA LOCAL INFILE 'csv/postings.csv' INTO TABLE Propiedad FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' IGNORE 1 ROWS;" -D modelado
echo "> Publicaciones cargadas"
echo "> Cargando las amenidades de cada propiedad"
mariadb -u root --password='$1' -e "LOAD DATA LOCAL INFILE 'csv/amenidadesPropiedad.csv' INTO TABLE AmenidadPropiedad FIELDS TERMINATED BY '|' LINES TERMINATED BY '\n' IGNORE 1 ROWS;" -D modelado
echo "> Amenidades de cada propiedad cargadas"