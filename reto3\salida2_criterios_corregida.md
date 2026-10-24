C1. **Repetición del pedido**
Dado que el usuario solicita repetir un pedido anterior, cuando se cumplen las reglas de disponibilidad y saldo, entonces se genera una nueva orden idéntica al original para agilizar la compra.

C2. **Validación de día y horario**
Dado que los pedidos solo se aceptan de lunes a sábado entre las 7:00 y las 18:00, cuando el intento de repetición ocurre fuera de este periodo, entonces se rechaza la solicitud indicando que el servicio no está disponible en ese momento.

C3. **Límite de productos y disponibilidad**
Dado que se permite un máximo de 5 productos por pedido y los agotados no pueden solicitarse, cuando la repetición incluye más de 5 ítems o productos sin stock, entonces se cancela parcialmente el pedido manteniendo solo los artículos disponibles dentro del límite.

C4. **Validación de saldo**
Dado que el pago se realiza exclusivamente con el saldo del carné y este nunca puede quedar negativo, cuando la repetición supera el saldo disponible actual, entonces se rechaza la orden completa indicando insuficiencia de fondos.

C5. **Cancelación por vencimiento**
Dado que el plazo de 30 minutos ya vencido según el hito que defina negocio no ha sido respetado para la recogida, cuando el pedido permanece sin recoger tras ese tiempo, entonces se cancela automáticamente y se devuelve el saldo al usuario.

Preguntas abiertas: ¿Qué constituye el "hito" que define el inicio del plazo de 30 minutos? ¿Se permite la repetición parcial si algunos productos están agotados?

