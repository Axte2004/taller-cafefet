"""Adaptación de scripts/comun.py del kit FET. Misma configuración controlada."""
import os
from ollama import Client, ResponseError
cliente=Client(host=os.getenv('OLLAMA_HOST','http://127.0.0.1:11435'),timeout=900)
def preguntar(contenido, modelo='qwen3.5:4b', formato=None, num_predict=450):
    args=dict(model=modelo,messages=[{'role':'user','content':contenido}],
              options={'temperature':0,'seed':42,'num_predict':num_predict,'num_ctx':4096})
    if formato is not None: args['format']=formato
    try: return cliente.chat(think=False,**args)
    except ResponseError as e:
        if 'think' in str(e).lower(): return cliente.chat(**args)
        raise
