from selenium import webdriver
from selenium.webdriver.common.by import By
import regex as re
import time, sys, json
num = sys.argv[1]
driver = webdriver.Chrome()
driver.get("view-source:https://www.inmuebles24.com/departamentos-en-venta-en-guadalajara-o-zapopan-o-san-pedro-tlaquepaque-desde-2-hasta-3-recamaras-pagina-{}.html".format(num))
time.sleep(3)
script = driver.page_source
driver.close()
data = json.loads(re.search(r'window\.__PRELOADED_STATE__\s*=\s*(\{.*?\});', script).group(0).split(' = ', 1)[1][:-1])
print(json.dumps(data['listStore'], indent=4))