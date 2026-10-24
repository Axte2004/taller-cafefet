# Cadena de prompts

Usamos el requisito «Que el estudiante pueda repetir su último pedido con un solo clic» y añadimos dos ejemplos propios. qwen-demo produjo esta historia: «Como estudiante, quiero repetir mi último pedido con un solo clic, para agilizar mi proceso de compra». Esa frase pasó al segundo prompt y los criterios de ese paso pasaron al tercero. Las entradas y salidas están guardadas en esta carpeta.

## Dónde apareció el primer error

La historia no añadió funciones. El primer problema salió al pedir los criterios: el modelo exigió que el usuario estuviera registrado, propuso agregar productos y dejó por fuera el día y el horario. También relacionó los 30 minutos con una espera de confirmación, aunque no sabemos cuándo empieza ese plazo.

La primera tabla heredó parte de esos problemas. Incluyó un sexto producto y mencionó un caso C1-3 que no existía en las filas. Tampoco indicó cantidades para comprobar el saldo o el límite de cinco productos. La instrucción de auto-verificación no detectó esas fallas.

## Primer ajuste

Repetimos desde el paso 2 y pedimos incluir el horario, no agregar edición de pedidos y dejar sin resolver el inicio de los 30 minutos. La nueva salida agregó el horario, pero propuso cancelar parcialmente el pedido y quedarse con los productos disponibles. La tabla incluso eligió los cinco primeros productos sin que el enunciado lo autorizara.

También afirmó que había probado el límite de cinco, aunque la fila correspondiente solo decía «stock completo» y no indicaba cuántos productos había.

## Segundo ajuste

En el segundo intento prohibimos la sustitución y la confirmación parcial. La conclusión quedó limitada a no confirmar el pedido tal como fue solicitado. La tabla final tuvo ocho casos: saldo exacto e insuficiente, productos agotados, domingo, cinco y seis productos, y el vencimiento.

Todavía quedaron errores. Los criterios omitieron la parte «Cuando» en un caso y describieron sumar el valor al saldo, cuando el pago debe restarlo. El criterio del plazo volvió a hablar de los 30 minutos «desde su generación». En la cobertura, el caso de seis productos quedó asociado también al criterio de horario.

## Referencia revisada

Dejamos una versión revisada de los criterios y ocho casos de prueba en `referencia_revisada.md`. Es nuestra revisión de la cadena; no es una salida de Ollama. Las dos correcciones muestran que cambiar el prompt ayudó en algunos puntos, pero no limpió todos los errores. Las decisiones que el enunciado no define siguen abiertas.
