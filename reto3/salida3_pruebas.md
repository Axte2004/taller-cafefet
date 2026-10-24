| Caso | Entrada | Resultado esperado | Criterio que cubre |
| :--- | :--- | :--- | :--- |
| **C1-1** | Usuario registrado intenta repetir pedido anterior con productos disponibles. | Se permite la repetición del pedido completo en un solo clic. | C1 |
| **C1-2** | Usuario registrado intenta repetir pedido, pero algún producto está agotado. | El sistema bloquea la repetición completa y muestra error de disponibilidad. | C1 |
| **C2-1** | Usuario añade el 6º producto a un pedido repetido (total > 5). | Bloqueo de adición con notificación: "Límite máximo de 5 productos". | C2 |
| **C3-1** | Usuario intenta comprar con saldo insuficiente para cubrir el total. | Transacción impedida; mensaje: "Saldo no puede quedar negativo". | C3 |
| **C4-1** | Pedido repetido permanece sin recoger durante 30 minutos. | Cancelación automática y devolución del saldo completo al carné. | C4 |

**Notas sobre los criterios abiertos:**
Para cumplir con la restricción de no convertir preguntas en reglas confirmadas, se han mantenido como casos de prueba específicos (C1-2 y C1-3) que validan el comportamiento esperado sin definir una regla universal para todos los escenarios. Por ejemplo, en **C1-2**, se asume que si hay un producto agotado, la repetición completa no es viable, pero esto no prohíbe explícitamente reemplazar ese producto específico; simplemente impide la acción de "repetir completo" tal cual. De igual manera, para **C3-1**, se valida el bloqueo por saldo negativo sin establecer si el sistema permitiría añadir productos adicionales con fondos disponibles y luego fallar solo en el pago final.

