from datetime import datetime
import json
import os
import re
# Listar los archivos del directorio
def get_files_in_directory(dir_path):
    try:
        files = [os.path.join(dir_path, f) for f in os.listdir(dir_path) if os.path.isfile(os.path.join(dir_path, f))]
        return files
    except FileNotFoundError:
        print(f"Error: Directory not found: {dir_path}")
        return []
    except NotADirectoryError:
        print(f"Error: Not a directory: {dir_path}")
        return []
# Nos retorna todos los archivos en el directorio, en este caso, podemos obtener todos los archivos de manera dinámica
files = get_files_in_directory('json')
# Crear y abrir los CSVs para las tablas
postings = open(os.path.join('csv', 'postingsRaw.csv'), 'w')
postings.write("id|titulo|direccion|idColonia|precio|area|recamaras|mantenimiento|fechaActualizacion")
colonias = open(os.path.join('csv', 'colonias.csv'), 'w')
colonias.write("id|nombre")
amenidades = open(os.path.join('csv', 'amenidades.csv'), 'w')
amenidades.write("id|nombre")
amenidadesPropiedad = open(os.path.join('csv', 'amenidadesPropiedad.csv'), 'w')
amenidadesPropiedad.write("idPropiedad|idAmenidad")
# Crear diccionarios para guardar las llaves foráneas
dicAmenidades = {}
dicColonias = {}
# Loop principal del dumper
idPropiedad = 0
for filename in files:
    with open(filename, 'r') as f:
        data = json.load(f)
        # Leer cada publicación de propiedad
        for posting in data['listPostings']:
            area = None
            recamaras = 1
            idPropiedad += 1
            # Si no hemos guardado la colonia de la propiedad actual la guardamos
            # Es posible que esto nos devuelva resultados duplicados, por lo que probablemente tendremos que limpiar esto más adelante
            colonia = posting['postingLocation']['location']['name']
            if colonia not in dicColonias:
                dicColonias[colonia] = len(dicColonias.values())+1
                colonias.write("\n{}|{}".format(dicColonias[colonia], colonia))
            # Agregar área y recámaras, estas se encuentran dentro de ['mainFeatures'], pero el nombre del objeto varía, por lo que las buscamos mediante un for each.
            for feature in posting['mainFeatures']:
                if re.match("Rec.maras$", posting['mainFeatures'][feature]['label']):
                    recamaras = posting['mainFeatures'][feature]['value']
                elif re.match("Terreno$", posting['mainFeatures'][feature]['label']):
                    area = posting['mainFeatures'][feature]['value']
                elif re.match("Superficie .+da$", posting['mainFeatures'][feature]['label']) and area is None:
                    area = posting['mainFeatures'][feature]['value']
            # Escribir los datos de la propiedad en el archivo correspondiente
            postings.write("\n{}|{}|{}|{}|{}|{}|{}|{}|{}".format(
                idPropiedad,
                posting['title'],
                posting['postingLocation']['address']['name'],
                dicColonias[colonia],
                posting['priceOperationTypes'][0]['prices'][0]['amount'],
                area,
                recamaras,
                0 if posting['expenses'] == None else posting['expenses']['amount'],
                posting['modified_date']
            ))
            # Loop de amenidades, similar a las colonias, guardamos las amenidades en un diccionario y las escribimos en su archivo
            # Igualmente, probablemente encontremos resultados duplicados
            for amenidad in posting['highlightedFeatures']:
                if amenidad not in dicAmenidades:
                    dicAmenidades[amenidad] = len(dicAmenidades.values())+1
                    amenidades.write("\n{}|{}".format(dicAmenidades[amenidad], amenidad))
                amenidadesPropiedad.write("\n{}|{}".format(idPropiedad, dicAmenidades[amenidad]))
# Cerrar archivos
postings.close()
colonias.close()
amenidades.close()
amenidadesPropiedad.close()