CAMBIOS REQUERIDOS

Hallazgos:
- Línea 2: La regla de "máximo 5 productos" se incumple al permitir hasta 6. Corrección: cambiar `> 6` por `> 5`.
- Línea 3: La validación del saldo es incorrecta y contradice la regla de "saldo nunca negativo". La expresión `est.saldo - sum(...) < -1000` permite saldos negativos (ejemplo: si el saldo es 100 y el pedido cuesta 200, la resta es -100, que no es menor que -1000, por lo tanto devuelve True aunque se deudoren). Corrección: verificar que `est.saldo >= sum(...)`.
- Línea 4: Se valida solo el rango horario (7-18), pero falta validar si la hora actual está dentro del periodo de recepción (lunes a sábado). Además, no se comprueba si los productos existen o están agotados.

Pruebas que faltan:
- No se prueba la condición de días de semana (falta verificar el día de la semana en `est`).
- No se valida el estado de stock de los productos individuales.
- No se verifica la lógica exacta del saldo para evitar deudas, solo un umbral arbitrario de -1000 que no cumple la regla de negocio.

