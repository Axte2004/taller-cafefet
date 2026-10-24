"""Adaptación CafeFET de scripts/evalua.py del curso. Etiquetas fijadas antes de ejecutar.
uv run evalua.py --modelo qwen3.5:4b
uv run evalua.py --modelo qwen3.5:0.8b
"""
import argparse,json
from pathlib import Path
from datetime import datetime
from comun import preguntar

CASOS=[
 ('E1','La app descontó mi saldo, pero el pedido no aparece.','BUG',False),
 ('E2','Sería útil guardar mis productos favoritos.','MEJORA',False),
 ('E3','¿Hasta qué hora puedo hacer pedidos?','DUDA',False),
 ('E4','Repetir el pedido tarda dos minutos, ¿es normal?','BUG',True),
 ('E5','Me dejaron el saldo en menos quinientos pesos.','BUG',False),
 ('E6','¿Podrían agregar un aviso cuando el pedido esté listo?','MEJORA',True),
 ('E7','No me deja pedir seis productos, ¿por qué?','DUDA',True),
 ('E8','Intenté pedir un producto que aparece agotado y no me dejó, ¿es un error?','DUDA',True),
 ('E9','Hoy martes a las 10, con saldo suficiente y productos disponibles, crear pedido da error 500.','BUG',False),
 ('E10','¿Cuánto tiempo tengo para recoger un pedido?','DUDA',False),
]
V1="""Clasifica el reporte de un usuario de CafeFET en UNA categoría: BUG, MEJORA o DUDA.
Responde solo con la categoría.
<reporte>{reporte}</reporte>"""
V2="""Clasifica el reporte de un usuario de CafeFET en UNA categoría.
BUG: una falla respecto de las reglas o una lentitud anormal, aunque se describa como pregunta.
MEJORA: una función nueva solicitada, aunque se pida en forma de pregunta.
DUDA: consulta de reglas/uso o rechazo correcto según una regla, sin falla real.
Reglas: lunes a sábado de 7:00 a 18:00; máximo 5 productos; saldo no negativo; no pedir agotados; cancelación y devolución si no se recoge en 30 minutos.
Ejemplos propios diferentes de los evaluados:
"La pantalla se congela cada vez que confirmo, ¿qué pasa?" -> BUG
"¿Pueden permitir exportar mis compras?" -> MEJORA
"Es domingo y no puedo pedir, ¿por qué?" -> DUDA
Responde solo con BUG, MEJORA o DUDA.
<reporte>{reporte}</reporte>"""

def main():
    p=argparse.ArgumentParser();p.add_argument('--modelo',default='qwen3.5:4b');a=p.parse_args()
    filas=[]
    filename='resultados_eval_'+a.modelo.replace(':','_')+'.json'
    for version,plantilla in [('v1',V1),('v2',V2)]:
        for id,texto,esperado,ambiguo in CASOS:
            prompt=plantilla.format(reporte=texto)
            r=preguntar(prompt,modelo=a.modelo,num_predict=12)
            raw=r.message.content
            obtenido=raw.strip() # Puntuación estricta: una etiqueta exacta, sin extraerla de una explicación.
            fila=dict(id=id,texto=texto,esperado=esperado,ambiguo=ambiguo,modelo=a.modelo,version=version,prompt=prompt,
                      respuesta_cruda=raw,obtenido=obtenido,acierto=obtenido==esperado,fecha=datetime.now().astimezone().isoformat())
            filas.append(fila)
            Path(filename).write_text(json.dumps(filas,ensure_ascii=False,indent=2),encoding='utf-8')
            print(json.dumps(fila,ensure_ascii=False),flush=True)
        subset=[x for x in filas if x['version']==version]
        print(f'{a.modelo} {version}: {sum(x["acierto"] for x in subset)}/{len(subset)}',flush=True)
if __name__=='__main__':main()
