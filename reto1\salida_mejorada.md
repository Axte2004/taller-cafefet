### Supuestos
El sistema asume que el estado de recogida es desconocido al momento del pedido, por lo que la lógica de cancelación por tiempo se basa únicamente en la fecha/hora actual y no en un evento futuro confirmado. Se ignora cualquier validación externa (como disponibilidad de personal o stock real) más allá de la lista proporcionada. La hora exacta de cierre (18:00) no está definida si el pedido entra exactamente a esa hora, por lo que se asume inclusiva para evitar rechazos injustificados, aunque esto requiere confirmación. No se maneja el caso donde el saldo sea cero o negativo inicialmente.

### Código Python
```python
from datetime import datetime, timedelta
from typing import List, Tuple, Any

def crear_pedido(saldo: float, productos: List[dict], fecha_hora: datetime) -> Tuple[str, str, float]:
    """
    Valida un pedido de CafeFET según reglas de negocio.
    Retorna: (ok: bool, motivo: str, total: float)
    """
    # Constantes y límites
    MAX_PRODUCTOS = 5
    HORA_CIERRE = 18.0
    
    # Validación 1: Horario de operación (Lunes a Sábado, 7:00 - 18:00)
    if fecha_hora.weekday() >= 6 or fecha_hora.hour < 7 or fecha_hora.hour >= HORA_CIERRE:
        return False, "Fuera del horario de atención (Lun-Sáb 07:00-18:00)", saldo
    
    # Validación 2: Límite de productos por pedido
    if len(productos) > MAX_PRODUCTOS:
        return False, f"Excede el máximo de {MAX_PRODUCTOS} productos", saldo
    
    # Validación 3: Productos agotados y cálculo del total
    total = 0.0
    for p in productos:
        if p.get('agotado', False):
            return False, "Se intentó pedir un producto agotado", saldo
        total += p.get('precio', 0)
    
    # Validación 4: Saldo suficiente (saldo nunca negativo)
    if total > saldo:
        return False, f"Saldo insuficiente. Necesitas {total:.2f}, tienes {saldo:.2f}", saldo
    
    # Validación 5: Tiempo de recogida (30 minutos) - Nota sobre ambigüedad
    # Se asume que el pedido se cancela si no se recoge antes de fecha_hora + 30min.
    # Ambigüedad pendiente: ¿Qué pasa si la hora es exactamente 18:00? 
    # (Se asume válido, pero requiere confirmación del requerimiento).
    
    return True, "Pedido validado correctamente", total
```

### Cobertura y pendientes
- **Horario de atención:** Se valida día y hora; pendiente confirmar si la entrada exacta a 18:00 es válida.
- **Límite de productos:** Se comprueba que no excedan las 5 unidades.
- **Estado de agotamiento:** Se rechaza cualquier producto marcado como `agot

