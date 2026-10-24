# Comparación de las tres ejecuciones

## Lo que el primer prompt dejó abierto

La frase original no decía en qué lenguaje escribir, qué datos recibir, qué debía devolver la función ni qué reglas del CafeFET aplicar. qwen-demo eligió JavaScript, creó una clase Pedido y un arreglo global, inventó precios y añadió funciones auxiliares. El prompt no pedía esas decisiones.

## Qué cambió en las respuestas

| Aspecto | Prompt malo | Prompt con cinco bloques | Variante sin restricciones |
|---|---|---|---|
| Lenguaje | JavaScript | Python | Python |
| Día y horario | No valida | Revisa día y hora, pero contradice el cierre | Revisa día y hora; excluye el cierre |
| Máximo de 5 unidades | No valida | `len(productos) > 5` | `len(lista_productos) > 5` |
| Saldo suficiente | No valida | `total > saldo` | `saldo < total_costo` |
| Productos agotados | No valida | Rechaza los marcados como agotados | Rechaza los marcados como agotados |
| Cancelación y reembolso | No aparecen | Deja un comentario y supone cuándo empieza el reloj | La condición no se puede alcanzar; no reembolsa |
| Valor de retorno | Objeto Pedido | Tupla cuyo tercer valor no coincide con el contrato | Diccionario sin total |
| Salida completa | Ejemplo cortado | Salida cortada | Salida cortada |

## Qué mejoró y qué quedó mal

Con el prompt completo aparecieron cuatro reglas que no estaban en la primera respuesta. Aun así, el texto dice que las 18:00 cuentan como hora válida, pero el código las rechaza. El enunciado no aclara ese punto, así que no escogimos una regla por nuestra cuenta.

La respuesta también fija el inicio de los 30 minutos en `fecha_hora`, aunque el prompt pedía no suponerlo. En los errores, la función devuelve el saldo en la tercera posición cuando el contrato pedía el total; además, anota una tupla de tipos que no coincide con el booleano que devuelve.

Al quitar únicamente el bloque de restricciones, la variante pierde el total en el retorno y añade una condición de vencimiento que nunca se ejecuta. También mezcla el horario de atención con el tiempo para recoger el pedido, y no hace el reembolso.

Las tres respuestas llegaron al límite de 700 tokens. Las dejamos completas hasta donde llegaron. La comparación se hizo leyendo las funciones y siguiendo sus condiciones; no se ejecutó una aplicación CafeFET.
