# Referencia revisada por el equipo técnico

Esta sección es una corrección editorial independiente de las salidas del modelo. No se atribuye a Ollama. Sirve como referencia para evaluar la cadena y conserva abiertas las decisiones que el taller no define.

## Criterios de aceptación revisados
### C1. Repetición válida
Dado un último pedido identificado, dentro del día y horario permitido, de máximo 5 unidades disponibles y con saldo suficiente.
Cuando el estudiante solicita repetirlo con un clic.
Entonces se permite generar el nuevo pedido y pagar con el saldo del carné sin dejarlo negativo.

### C2. Día y horario
Dado que el intento ocurre en domingo o fuera del horario de 7:00 a 18:00.
Cuando el estudiante solicita repetir el pedido.
Entonces no se acepta la solicitud en ese momento.

### C3. Cantidad y disponibilidad
Dado que la solicitud contiene más de 5 productos o al menos un producto agotado.
Cuando se valida el pedido a repetir.
Entonces no se confirma el pedido tal como fue solicitado. La sustitución, selección parcial o forma de corregirlo queda pendiente de definición.

### C4. Saldo
Dado que el costo del pedido es mayor que el saldo disponible.
Cuando se intenta realizar el pago del pedido repetido.
Entonces se rechaza la operación sin debitar el saldo. Si costo y saldo son iguales, la regla de no negatividad permite pagar y dejar saldo cero.

### C5. Cancelación y devolución
Dado un pedido no recogido cuyo plazo de 30 minutos ya venció según el evento inicial que defina negocio.
Cuando el proceso de seguimiento detecta el vencimiento.
Entonces cancela el pedido y devuelve el importe cobrado al carné.

## Tabla revisada de casos de prueba
| Caso | Entrada | Resultado esperado | Criterio que cubre |
|---|---|---|---|
| T01 | Martes 10:00; último pedido 5 unidades disponibles; total 10000; saldo 10000; un clic | Nuevo pedido permitido; tras pagar, saldo 0 | C1, C3, C4 |
| T02 | Domingo 10:00; pedido disponible; saldo suficiente | Solicitud no aceptada por día | C2 |
| T03 | Lunes 06:59; pedido disponible; saldo suficiente | Solicitud no aceptada por hora | C2 |
| T04 | Martes 12:00; 6 unidades disponibles; saldo suficiente | No confirmar tal como solicitado; no elegir automáticamente 5 | C3 |
| T05 | Martes 12:00; 2 unidades, una agotada; saldo suficiente | No confirmar tal como solicitado; alternativa por definir | C3 |
| T06 | Martes 12:00; total 1000; saldo 999; 1 unidad disponible | Rechazo por saldo; conserva 999 | C4 |
| T07 | Cobro previo 1500; no recogido; plazo de 30 minutos ya vencido | Cancelar y devolver 1500 | C5 |
| T08 | Cobro previo 1500; no recogido; plazo aún no vencido | No cancelar por esta causa todavía | C5 |

Cobertura verificada por inspección: C1=T01; C2=T02/T03; C3=T01/T04/T05; C4=T01/T06; C5=T07/T08. Se incluye expresamente el límite válido de 5, además del inválido de 6, que la primera tabla corregida del modelo no concretó. No se ejecutó una aplicación CafeFET: son casos de aceptación, como pide el reto.

Siguen abiertas cuatro decisiones de negocio: qué transacción es el último pedido, tratamiento de las 18:00 exactas, alternativa cuando falta un producto e inicio del plazo de recogida. No se resuelven inventando una política.
