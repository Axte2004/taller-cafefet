# Taller de ingeniería de prompts — CafeFET

Integrantes: Carlos Rubio, Michell Fierro y Fabian Cabrera. Caso: CafeFET. Fecha del trabajo: 23 de octubre de 2026.

En este paquete están los cuatro retos y el bonus. Guardamos las respuestas de Ollama como salieron y separamos de ellas nuestros comentarios y correcciones. El informe resumido está en `Taller_CafeFET_Completo.pdf`. Este repositorio también contiene los prompts y las respuestas completas.

## Archivos

- `reto1/`: prompts, respuestas y comparación.
- `reto2/`: revisiones, Modelfiles, ataques y tabla de resultados.
- `reto3/`: prompts encadenados, correcciones y referencia revisada.
- `reto4/`: transcripciones y análisis de las dos partes.
- `bonus/`: scripts, resultados JSON y comparación A/B.
- `ejecuciones.jsonl` y `modelos.json`: registro de las pruebas.
- `reproducibilidad.md` y `fuentes.md`: comandos y materiales usados.

Repositorio público: https://github.com/Axte2004/taller-cafefet

## Resultado del bonus

| Modelo | Prompt | Aciertos | Fallos |
|---|---|---:|---|
| qwen3.5:4b | v1 | 7/10 | E4, E5, E7 |
| qwen3.5:4b | v2 | 8/10 | E5, E7 |
| qwen3.5:0.8b | v1 | 4/10 | E2, E3, E6, E7, E8, E10 |
| qwen3.5:0.8b | v2 | 5/10 | E2, E3, E6, E7, E8 |

## Reflexión

Lo que más nos sirvió fue escribir las reglas del negocio antes de pedirle código al modelo. En la primera revisión, sin ese contexto, qwen-demo inventó que se podía dejar el saldo en negativo. Cuando pusimos las reglas del CafeFET, los revisores detectaron los dos límites mal puestos en la función. Aun así, la versión más estricta rechazó una revisión que sí podía hacer. Reforzar las instrucciones ayudó, pero también tuvo ese costo.

Si tuviéramos que pedir una función nueva, primero aclararíamos las reglas que no aparecen en el enunciado. Después haríamos la historia, los criterios y las pruebas por separado, revisando cada salida antes de usarla en el siguiente paso. Probaríamos casos concretos: saldo justo, saldo insuficiente, un producto agotado, domingo y una solicitud a la que le falte información.

También vimos que una respuesta ordenada puede estar equivocada. Phi puso mal los valores de dos condiciones; una tabla afirmó cubrir un caso que no estaba en sus filas; y el JSON pasó la validación aunque perdió datos del mensaje. Nos funcionó guardar las respuestas como salieron y contrastarlas con los datos del ejercicio, en vez de confiar en que el modelo sonara seguro.

