CAMBIOS REQUERIDOS

Hallazgos:
- Línea 2: La regla establece un máximo de **5** productos, pero el código verifica `len(productos) > 6`, permitiendo hasta 6.
- Línea 3: La validación del saldo es incorrecta. El código devuelve `False` si el saldo resultante es menor a `-1000`. Esto permite transacciones donde el saldo quede negativo (ej. -500), violando la regla de que "el saldo nunca puede quedar negativo". Debe ser `<= 0`.
- Línea 4: Se verifica el rango horario, pero falta validar si la hora es válida dentro del día laboral (lunes a sábado). Un pedido en domingo o festivo debería ser rechazado.

Pruebas que faltan:
- No se prueba la validación de días de la semana (solo se comprueba la hora).
- No se verifica el estado de stock de los productos antes de calcular el saldo.
- No se valida si el saldo actual es suficiente para cubrir el pedido completo, solo se revisa un umbral arbitrario de -1000 sin contexto del saldo inicial real.

Corrección sugerida:
```python
if len(productos) > 5: return False
if est.saldo < sum(p.precio for p in productos): return False
if not (7 <= hora <= 18): return False
# Añadir validación de día de la semana aquí
return True
```

