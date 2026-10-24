| Caso | Entrada | Resultado esperado | Criterio que cubre |
| :--- | :--- | :--- | :--- |
| 1 | Repetir pedido válido (Lun 09:00, saldo 20€, stock completo) | Generar nueva orden idéntica al original. | C1, C2, C3, C4 |
| 2 | Repetir pedido fuera de horario (Domingo 12:00) | Rechazar solicitud indicando servicio no disponible. | C2 |
| 3 | Repetir pedido con 6 productos y saldo suficiente | Cancelar parcialmente manteniendo solo los 5 primeros disponibles. | C3 |
| 4 | Repetir pedido con producto agotado y saldo suficiente | Cancelar parcialmente excluyendo el artículo sin stock. | C3 |
| 5 | Repetir pedido con saldo exacto (20€) y costo total 20€ | Generar orden exitosa, saldo queda en 0€. | C4 |
| 6 | Repetir pedido con saldo insuficiente (10€ vs costo 20€) | Rechazar orden completa indicando insuficiencia de fondos. | C4 |
| 7 | Repetir pedido con plazo definido ya vencido; no recogido | Cancelar automáticamente y devolver el saldo al usuario. | C5 |
| 8 | Repetir pedido con saldo negativo previo (imposible) | Rechazar solicitud indicando saldo inválido/negativo. | C4 |

**Auto-verificación de casos agregados:**
No se agregaron casos nuevos; la tabla cumple con los requisitos solicitados cubriendo todos los criterios (C1-C5). Se incluyeron explícitamente pruebas para el límite de 5 productos, el intento de 6 productos, saldo exacto, saldo insuficiente, producto agotado, día cerrado y plazo vencido. El caso válido (Caso 1) asegura la repetición funcional bajo condiciones óptimas.

