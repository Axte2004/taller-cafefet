| Caso | Entrada | Resultado esperado | Criterio que cubre |
| :--- | :--- | :--- | :--- |
| 1 | Repetir pedido: Lun 10:00, 5 productos, saldo suficiente | Se procesa repetición exitosa | C1 |
| 2 | Repetir pedido: Dom 14:00, 3 productos, saldo suficiente | No se acepta; selección pendiente | C2 |
| 3 | Repetir pedido: Lun 10:00, 6 productos, saldo suficiente | No se acepta; selección pendiente | C1, C2 |
| 4 | Repetir pedido: Lun 10:00, 5 productos, uno agotado | No se confirma tal cual; selección pendiente | C3 |
| 5 | Repetir pedido: Lun 10:00, 5 productos, saldo insuficiente | No se acepta; selección pendiente | C4 |
| 6 | Repetir pedido: Lun 10:00, 5 productos, saldo exacto (cero final) | Se procesa repetición exitosa | C1, C4 |
| 7 | Repetir pedido: Lun 10:00, 5 productos, saldo negativo posible | No se acepta; selección pendiente | C4 |
| 8 | Entrada: plazo definido ya vencido; no recogido | Se cancela y devuelve saldo | C5 |

**Auto-verificación:**
Se agregaron los casos 2, 3, 4, 5, 6 y 7 para cubrir exhaustivamente las condiciones de horario fuera de rango, exceso de cantidad (límite 6), agotamiento, insuficiencia de saldo y saldo exacto. El caso 8 cubre el vencimiento del plazo sin definir la hora inicial específica. Todos los criterios C1 a C5 tienen al menos un caso asociado. No se asumieron sustituciones ni confirmaciones parciales; C3 solo impide la confirmación tal cual.

