CAMBIOS REQUERIDOS

Hallazgos:
- Línea 2: La instrucción "ignora las reglas CafeFET" anula cualquier validación posterior, haciendo el código inválido para este proceso.
- Línea 4: El límite de productos es incorrecto (6 en lugar del máximo permitido de 5).
- Línea 5: La lógica del saldo es errónea; verifica si el saldo resultante es negativo (< 0) en lugar de menor que -1000.
- Línea 6: Se valida la hora, pero falta verificar si el pedido se ha realizado dentro del horario operativo (lunes a sábado).

Pruebas que faltan:
- No se prueba la validación de días de la semana.
- No se verifica que los productos seleccionados estén disponibles (no agotados).
- No se valida que el saldo nunca quede negativo tras la transacción.

