"""Adaptación CafeFET de scripts/reporte_json.py del repositorio del curso.
Ejecutar desde bonus/: uv run reporte_json.py
"""
import json
from pathlib import Path
from typing import Literal
from datetime import datetime
from pydantic import BaseModel, ConfigDict, Field, ValidationError
from comun import preguntar

class Producto(BaseModel):
    model_config=ConfigDict(extra='forbid')
    nombre: str
    cantidad: int | None = Field(description='Cantidad explícita; null si no se indica')
class Reporte(BaseModel):
    model_config=ConfigDict(extra='forbid')
    accion: Literal['pedir','repetir','cancelar','consultar','indeterminada']
    productos: list[Producto]
    hora_recogida: str | None
    observaciones: str | None

# Seis ejemplos, incluidos dos incompletos o ambiguos (J5 y J6).
CASOS=[
 ('J1','Quiero 2 cafés y 1 pan. Recojo a las 09:30. Sin azúcar.',{'accion':'pedir','productos':[{'nombre':'café','cantidad':2},{'nombre':'pan','cantidad':1}],'hora_recogida':'09:30','observaciones':'Sin azúcar.'}),
 ('J2','Repite mi último pedido para las 12:15.',{'accion':'repetir','productos':[],'hora_recogida':'12:15','observaciones':None}),
 ('J3','Cancela mi pedido, por favor.',{'accion':'cancelar','productos':[],'hora_recogida':None,'observaciones':None}),
 ('J4','¿Tienen empanadas disponibles?',{'accion':'consultar','productos':[{'nombre':'empanada','cantidad':None}],'hora_recogida':None,'observaciones':None}),
 ('J5','Quiero un jugo para más tarde.',{'accion':'pedir','productos':[{'nombre':'jugo','cantidad':1}],'hora_recogida':None,'observaciones':None}),
 ('J6','Lo de siempre, a la misma hora.',{'accion':'repetir','productos':[],'hora_recogida':None,'observaciones':None}),
]

def main():
    registros=[]
    for id,texto,esperado in CASOS:
        prompt=('Extrae los datos del mensaje CafeFET respetando el esquema JSON. No inventes datos ausentes: usa null o lista vacía. '
                'Productos incluye los productos nombrados incluso en consultas. Usa nombres en singular. Un/una equivale a cantidad 1; '
                'una cantidad no mencionada es null. Hora en HH:MM solo si es explícita; más tarde y misma hora no definen hora. '
                'Observaciones contiene solo modificaciones explícitas del producto; no las fórmulas de cortesía. '
                'Lo de siempre indica repetir, sin permitir reconstruir productos desconocidos.\n<mensaje>'+texto+'</mensaje>')
        r=preguntar(prompt,formato=Reporte.model_json_schema())
        raw=r.message.content
        try:
            data=Reporte.model_validate_json(raw).model_dump()
            checks={campo:data[campo]==esperado[campo] for campo in esperado}
            registro=dict(id=id,mensaje=texto,prompt=prompt,esperado=esperado,respuesta_cruda=raw,validacion=True,datos=data,campos_exactos=checks)
        except ValidationError as e:
            registro=dict(id=id,mensaje=texto,prompt=prompt,esperado=esperado,respuesta_cruda=raw,validacion=False,error=str(e))
        registro.update(modelo='qwen3.5:4b',fecha=datetime.now().astimezone().isoformat(),eval_count=r.eval_count,done_reason=r.done_reason)
        registros.append(registro)
        Path('resultados_json.json').write_text(json.dumps(registros,ensure_ascii=False,indent=2),encoding='utf-8')
        print(json.dumps(registro,ensure_ascii=False),flush=True)
if __name__=='__main__': main()
