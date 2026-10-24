# Reproducción de la parte A
Ejecutar A_breve.txt y A_paso_a_paso.txt con ollama run phi-demo, sin --think=false. Las respuestas reales están en salida_A_breve.md y salida_A_paso_a_paso.md.

# Reproducción de la parte B
Abrir ollama run qwen-demo --think=false --nowordwrap. Escribir /set parameter num_ctx 512. Enviar «Regla: empieza SIEMPRE tu respuesta con VEREDICTO:. ¿Entendido?». Enviar B_pregunta1.txt y después B_pregunta2.txt. Guardar con /save cafefet-contexto-a.
Ejecutar /clear. Ejecutar /set system Empieza SIEMPRE tu respuesta con VEREDICTO:. Repetir las mismas dos preguntas, guardar con /save cafefet-contexto-b y salir con /bye.
Los historiales exactos están en sesion_A.md y sesion_B.md; los JSON originales de Ollama conservan los mensajes. configuracion_interactiva.txt registra los parámetros efectivos consultados en el chat. Los modelos guardados sirven para conservar el historial, no para sustituir qwen-demo al repetir el experimento.
