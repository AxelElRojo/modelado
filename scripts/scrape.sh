#!/bin/sh
echo "> Ejecutando run_scraper.sh"
scripts/run_scraper.sh
echo "> JSONs extraídos"
echo "> Ejecutando sqlizer.py"
python scripts/sqlizer.py
echo "> CSVs generados"
echo "> Ejecutando cleaner.py"
python scripts/cleaner.py
echo "> CSVs listos para carga a DB"