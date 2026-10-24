# El caso y cómo lo trabajamos

Trabajamos con CafeFET, un sistema ficticio de pedidos anticipados. El taller propone estas reglas: se reciben pedidos de lunes a sábado entre las 7:00 y las 18:00; cada pedido puede tener hasta cinco productos; el pago sale del saldo del carné, que no puede quedar negativo; no se piden productos agotados; y un pedido sin recoger en 30 minutos se cancela y se reembolsa.

Hicimos los cuatro retos obligatorios y también el bonus. Las ejecuciones se realizaron localmente el 23 de octubre de 2026. Guardamos las respuestas de los modelos tal como salieron; los comentarios y las correcciones del informe se añadieron después.

## Equipo y modelos

Se usó un equipo Windows x64 con Intel Core i5-11400H, 16 GB de RAM y una NVIDIA GeForce GTX 1650 de 4 GB. Ollama era la versión 0.33.2. El bonus se ejecutó con Python 3.11.9 y uv 0.12.3; las dependencias están fijadas en uv.lock.

qwen-demo y phi-demo se crearon con los Modelfiles del curso. Se usó temperatura 0, semilla 42 y un límite de 700 tokens. Para los revisores v1 y v2 se mantuvieron los mismos pesos qwen3.5:4b y los mismos parámetros; el cambio principal fue el bloque de seguridad. En el bonus se compararon qwen3.5:4b y qwen3.5:0.8b. Los hashes de los modelos están en modelos.json.

Los retos 1 a 4 se hicieron desde la CLI de Ollama y el chat interactivo. Python se usó para el bonus y para preparar los archivos del informe. Quedaron registradas 21 ejecuciones de archivos, cinco respuestas del chat de contexto, seis extracciones JSON y cuarenta clasificaciones: 72 respuestas en total.

## Lo que encontramos

| Parte | Resultado |
|---|---|
| Reto 1 | El prompt con reglas añadió comprobaciones, aunque el código todavía tuvo contradicciones y quedó cortado. |
| Reto 2 | La revisión sin contexto no encontró los dos errores de límite; los dos revisores sí los encontraron. V2 rechazó uno de los códigos que debía revisar. |
| Reto 3 | Hubo que corregir la cadena dos veces. El primer error de los criterios se propagó a los casos de prueba. |
| Reto 4 | Pedir una traza hizo más visibles los cálculos equivocados de Phi. La regla de formato se conservó mejor cuando se puso en el system prompt. |
| Bonus JSON | Los seis resultados cumplieron el esquema, pero algunos perdieron o cambiaron datos del mensaje. |

| Modelo | Prompt | Aciertos | Casos que falló |
|---|---|---:|---|
| qwen3.5:4b | v1 | 7/10 | E4, E5, E7 |
| qwen3.5:4b | v2 | 8/10 | E5, E7 |
| qwen3.5:0.8b | v1 | 4/10 | E2, E3, E6, E7, E8, E10 |
| qwen3.5:0.8b | v2 | 5/10 | E2, E3, E6, E7, E8 |

No reemplazamos una respuesta incorrecta por una ideal. Cuando el enunciado deja algo sin definir, lo señalamos como una decisión pendiente. Los casos de prueba del reto 3 son propuestas; no implementamos una aplicación de pedidos.
