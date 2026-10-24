C1: Dado que el usuario solicita repetir un pedido con un clic, entonces se procesa la repetición solo si cumple con recibir pedidos de lunes a sábado entre las 7:00 y las 18:00, hay máximo 5 productos en el historial, los artículos solicitados están disponibles y el saldo del carné es suficiente para cubrir el total.

C2: Dado que la solicitud se realiza fuera del horario establecido (antes de las 7:00 o después de las 18:00, o fuera de lunes a sábado), entonces no se acepta ninguna repetición automática; la selección de alternativas queda pendiente de definición.

C3: Dado que el usuario solicita productos que actualmente están agotados en el inventario, entonces no se confirma el pedido tal como fue solicitado; la selección de alternativas queda pendiente de definición.

C4: Dado que el saldo actual más el valor de los productos solicitados resultaría en un saldo negativo (el saldo final debe ser mayor o igual a cero), entonces no se acepta la transacción; el saldo final exacto de cero está permitido, pero cualquier cantidad negativa es prohibida.

C5: Dado que el pedido no ha sido recogido dentro del plazo de 30 minutos desde su generación, según el hito inicial pendiente de definición, entonces se cancela el pedido y se devuelve el saldo completo al carné.

Preguntas abiertas para definir políticas pendientes:
1. ¿Cuál es la hora exacta de cierre que marca el inicio de los 30 minutos?
2. ¿Cómo se define técnicamente un "último pedido" en el sistema?
3. ¿Qué alternativas se presentan al usuario si faltan productos específicos?
4. ¿Cuál es el hito inicial preciso para iniciar la cuenta regresiva de los 30 minutos?

