# Scraping y Análisis de datos sobre la vivienda en Guadalajara
## Dependencias.
Para utilizar estos scripts necesitas el siguiente software:
- Python.
- MariaDB.
- Neo4J.
- Neo4J Desktop.
  
Además, necesitas las siguientes liberías de Python:
- Selenium.
- Pandas.
## Ejecutar los scripts.
Primero sitúa tu terminal en la raíz del proyecto, el comando específico depende de la ubicación en la que descargaste este repositorio, una vez ahí ejecuta el siguiente comando:
```console
scripts/scrape.sh
```
Esto generará los archivos JSON en la carpeta correspondiente, ahora tenemos que convertirlos a CSV y cargarlos a la base de datos, para ello ejecuta:
```console
sudo scripts/loadSQL.sh <SQLPasswd>
```
Con esto tendrás los datos que descargaste disponibles en SQL.

Este repositorio es acompañamiento de un [artículo que publiqué en LinkedIn](https://www.linkedin.com/pulse/analizando-la-crisis-inmobiliaria-en-guadalajara-con-y-axel-mnrpe). Si quieres una explicación sobre estos scripts te recomiendo que lo leas.
