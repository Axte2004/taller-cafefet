**Supuestos**
Se asume que la fecha y hora son válidas en formato ISO. Se ignora el estado de recogida actual del estudiante, suponiendo que es "pendiente" al inicio. No se verifica si el saldo existe en una base de datos externa, solo se usa el valor numérico proporcionado. Se considera que los productos agotados tienen un flag booleano explícito.

```python
def crear_pedido(estudiante, lista_productos, fecha_hora):
    """
    Valida un pedido CafeFET según reglas de negocio.
    
    Args:
        estudiante (dict): Contiene 'saldo'.
        lista_productos (list): Lista de dicts con claves 'precio', 'agotado' y 'nombre'.
        fecha_hora (datetime): Fecha y hora del pedido local.
        
    Returns:
        dict: {'valido': bool, 'mensaje': str}
    """
    valido = True
    mensaje = "Pedido válido."

    # 1. Validar horario de atención (Lunes-Sábado, 7:00-18:00)
    if not (fecha_hora.weekday() < 6 and 7 <= fecha_hora.hour < 18):
        valido = False
        mensaje = "El servicio no está disponible en este horario."

    # 2. Validar límite de productos (Máximo 5)
    if len(lista_productos) > 5:
        valido = False
        mensaje = f"Se excedió el máximo de 5 productos por pedido."

    # 3. Validar saldo negativo (Saldo nunca puede quedar negativo)
    total_costo = sum(p['precio'] for p in lista_productos if not p['agotado'])
    if estudiante['saldo'] < total_costo:
        valido = False
        mensaje = "No hay suficiente saldo en el carné para cubrir el pedido."

    # 4. Validar productos agotados (No se pueden pedir)
    for producto in lista_productos:
        if producto['agotado']:
            valido = False
            mensaje = f"El producto '{producto['nombre']}' está agotado y no puede ser añadido."
            break

    # 5. Validar tiempo de recogida (Si no se recoge en 30 min, cancelar)
    # Nota: Esta regla es condicional futura; aquí solo se registra la ventana válida.
    if valido and fecha_hora.hour >= 18:
        valido = False
        mensaje = "El pedido expira si no se recoge dentro de los 30 minutos siguientes."

    return {'valido': valido, 'mensaje': mensaje}
```

**Cobertura y pendientes**
- **Horario:** Se valida el día (lunes-sábado) y la hora (7:00-18:00), pero no se calcula la fecha límite de cancelación automática.
- **Límite de cantidad:** Se verifica que no superen las 5 unidades, sin embargo, no se penaliza ni registra el pedido si se excede.
- **Saldo:** Se asegura que el saldo final sea no negativo, pero no se actualiza la base de datos del

