# Reto 4: razonamiento y contexto

## Parte A: dos respuestas de Phi

Las dos preguntas usaron el mismo código y los mismos datos: saldo 1000, productos de 1200 y 300, hora 10, y ambos productos disponibles. La primera pidió una respuesta breve. La segunda pidió mostrar cada condición. Se usó phi-demo sin `--think=false`, como indica la guía.

| Condición | Cálculo correcto | Resultado |
|---|---|---|
| `len(productos) > 6` | `2 > 6` | Falso: no entra al primer `return` |
| `saldo - suma < -1000` | `1000 - 1500 = -500`; `-500 < -1000` | Falso: no entra al segundo `return` |
| `7 <= hora <= 18` | `7 <= 10 <= 18` | Verdadero: la función acepta |

El pedido debería rechazarse porque cuesta 1500 y el saldo es 1000. La condición que lo deja pasar es el límite de -1000: la regla real no permite ningún saldo negativo.

La respuesta breve culpó a la falta de revisión de productos agotados. Esa comprobación sí falta, pero no explica este ejemplo: dijimos que los dos productos estaban disponibles. La respuesta con traza marcó como verdaderas las dos comparaciones que dan falso y luego se contradijo sobre si la función acepta el pedido. También mencionó día y agotados; la cancelación y el reembolso requieren otro proceso.

| Qué revisamos | Respuesta breve | Respuesta con traza |
|---|---:|---:|
| Encuentra la causa de este caso | No | No |
| Detecta falta de validación de agotados | Sí | Sí |
| Detecta falta de validación del día | No | Sí |
| Calcula correctamente las dos condiciones | No se muestra | 0 de 2 |

La traza hizo más fácil ver dónde se equivocó, pero no le ayudó a encontrar la causa. Comprobamos cada operación aparte y conservamos la respuesta original.

## Parte B: una regla en el chat

Abrimos qwen-demo con `--think=false` y configuramos `num_ctx 512`. Primero dimos la regla «Empieza SIEMPRE tu respuesta con VEREDICTO:.» como un mensaje normal. Después de `/clear`, la pusimos en system y repetimos las mismas dos preguntas largas.

| Dónde estaba la regla | Pregunta 1 | Pregunta 2 | Palabras |
|---|---|---|---|
| Mensaje normal | Conserva VEREDICTO: | Pierde el prefijo | 544 / 513 |
| System prompt | Conserva VEREDICTO: | Conserva VEREDICTO: | 550 / 515 |

Contamos las palabras separando el texto por espacios. Las cuatro respuestas superaron 400 palabras y llegaron al límite de generación; algunas quedaron a mitad de frase. La única diferencia que queríamos observar era la ubicación de la regla. Se mantuvieron las mismas preguntas, temperatura 0, semilla 42 y límite de 700 tokens. Revisamos los parámetros con `/show parameters`.

La regla del mensaje normal no apareció en la segunda respuesta. Una explicación probable es que el historial previo ya no estaba dentro del contexto que recibió el modelo. La regla de system sí apareció en las dos respuestas. Esto coincide con la práctica 14B, aunque no demuestra que system tenga memoria ilimitada ni que siempre se obedezca.

Pedimos `num_ctx=512`, pero el registro interno de esta versión mostró una reserva de 2048 tokens. La reserva por sí sola no dice qué historial llegó al modelo. En los cinco turnos, las entradas registradas tenían 31, 117, 61, 74 y 79 tokens. La segunda pregunta de A llegó con una entrada breve pese a la respuesta anterior de 544 palabras. Eso es consistente con el recorte del historial. Las transcripciones se guardaron con `/save` y se limpiaron de caracteres de control de la terminal.
