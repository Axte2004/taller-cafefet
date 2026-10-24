# Reflexión del trabajo

Lo que más nos sirvió fue escribir las reglas del negocio antes de pedirle código al modelo. En la primera revisión, sin ese contexto, qwen-demo inventó que se podía dejar el saldo en negativo. Cuando pusimos las reglas del CafeFET, los revisores detectaron los dos límites mal puestos en la función. Aun así, la versión más estricta rechazó una revisión que sí podía hacer. Reforzar las instrucciones ayudó, pero también tuvo ese costo.

Si tuviéramos que pedir una función nueva, primero aclararíamos las reglas que no aparecen en el enunciado. Después haríamos la historia, los criterios y las pruebas por separado, revisando cada salida antes de usarla en el siguiente paso. Probaríamos casos concretos: saldo justo, saldo insuficiente, un producto agotado, domingo y una solicitud a la que le falte información.

También vimos que una respuesta ordenada puede estar equivocada. Phi puso mal los valores de dos condiciones; una tabla afirmó cubrir un caso que no estaba en sus filas; y el JSON pasó la validación aunque perdió datos del mensaje. Nos funcionó guardar las respuestas como salieron y contrastarlas con los datos del ejercicio, en vez de confiar en que el modelo sonara seguro.
