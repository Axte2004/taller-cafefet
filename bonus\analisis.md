# Bonus: mensajes y clasificación

## A. Extraer datos en JSON

Adaptamos `reporte_json.py` del curso para CafeFET. El esquema tiene la acción, los productos, la hora de recogida y las observaciones; Pydantic limita las acciones posibles y deja usar `null` o una lista vacía cuando falta información. Probamos seis mensajes en qwen3.5:4b, incluidos dos incompletos o ambiguos.

| Caso | ¿Pasó el esquema? | Campos exactos | Qué ocurrió |
|---|---|---:|---|
| J1 | Sí | 2/4 | Confundió pedir con repetir; también cambió mayúsculas y puntuación. |
| J2 | Sí | 3/4 | Perdió la hora explícita 12:15. |
| J3 | Sí | 4/4 | Registró la cancelación sin inventar datos. |
| J4 | Sí | 4/4 | Dejó la cantidad vacía porque el mensaje no la decía. |
| J5 | Sí | 3/4 | No inventó una hora, pero perdió la cantidad «un». |
| J6 | Sí | 4/4 | Marcó repetir y dejó vacíos el pedido y la hora desconocidos. |

Los seis JSON cumplieron el formato. Al comparar cuatro campos por mensaje, coincidieron exactamente 20 de 24. Esa cifra también cuenta como error algunos cambios de mayúsculas y puntuación, así que no mide solo el significado. J1 cambió la intención; J2 y J5 perdieron información explícita.

Cuando faltaban datos, el modelo dejó la hora o los productos vacíos en J5 y J6. En J2 también usó `null`, pero allí la hora sí estaba en el mensaje. Un esquema válido ayuda a controlar la forma de los datos; no confirma que se hayan copiado bien. Esta extracción no se conectó con cobros reales.

## B. Comparar dos prompts

Adaptamos `evalua.py` con tres etiquetas: BUG, MEJORA y DUDA. Marcamos diez mensajes antes de ejecutar y consideramos ambiguos E4, E6, E7 y E8. Probamos una versión sin ejemplos (v1) y otra con definiciones y ejemplos (v2), con los modelos qwen3.5:4b y qwen3.5:0.8b. En total fueron cuarenta respuestas.

| Modelo | Versión | Aciertos | Fallos |
|---|---|---:|---|
| qwen3.5:4b | v1 | 7/10 | E4, E5, E7 |
| qwen3.5:4b | v2 | 8/10 | E5, E7 |
| qwen3.5:0.8b | v1 | 4/10 | E2, E3, E6, E7, E8, E10 |
| qwen3.5:0.8b | v2 | 5/10 | E2, E3, E6, E7, E8 |

En el modelo 4B, v2 corrigió E4. En el modelo pequeño corrigió E10. Ninguno perdió un acierto al pasar a v2. E5 (saldo negativo) siguió siendo difícil para ambos; qwen3.5:4b también siguió llamando MEJORA al rechazo de seis productos, aunque el máximo permitido es cinco.

Las etiquetas de referencia se fijaron así: lentitud en E4 es BUG; pedir una función nueva en E6 es MEJORA; preguntar por el límite de seis productos o por un producto agotado (E7 y E8) es DUDA. E5 es BUG porque el saldo negativo rompe una regla explícita.

Contamos acierto solo cuando la respuesta fue exactamente la etiqueta. Son diez ejemplos y una ejecución por cada combinación; sirven para comparar estos prompts, no para medir el rendimiento general de los modelos. Los JSON guardan cada mensaje, la etiqueta esperada y la respuesta obtenida.
