import os
import pandas as pd
# Cargamos el csv
df = pd.read_csv(os.path.join('csv', 'postingsRaw.csv'), sep='|')
# Borramos las entradas duplicadas ignorando el id
df_limpio = df.drop_duplicates(subset=['titulo','direccion','idColonia','precio','area','recamaras','mantenimiento'])
df_limpio = df.dropna(subset=['area'])
# Guardamos el df limpio
df_limpio.to_csv('csv/postings.csv', sep='|', index=False)