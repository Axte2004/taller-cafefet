# Cómo repetir las pruebas

Los prompts y las salidas están organizados en reto1/, reto2/, reto3/, reto4/ y bonus/. Los Modelfiles exactos se incluyen en modelfiles/ y reto2/. El registro ejecuciones.jsonl contiene fecha, modelo, archivos, duración y código de salida de las ejecuciones de terminal. Un código 0 acredita que el proceso terminó, no que su respuesta sea correcta.

Para repetir en Windows: iniciar Ollama, descargar qwen3.5:4b, phi4-mini y qwen3.5:0.8b, crear qwen-demo y phi-demo con los Modelfiles incluidos, y ejecutar los archivos de prompts por la terminal. El script ejecutar_principales.ps1 automatiza las ejecuciones de los retos 1 a 3 y la parte A del reto 4. La parte B usa el chat interactivo; sus comandos están en las transcripciones.

Esta ejecución utilizó un servidor local en 127.0.0.1:11435 para permitir la descarga de modelos con los permisos del usuario. Para usar el puerto normal 11434, ajustar OLLAMA_HOST en el script y en el entorno del bonus. No se requiere servicio remoto de inferencia.

Desde la carpeta CafeFET, ejecutar uv sync. Desde bonus/, ejecutar uv run reporte_json.py, uv run evalua.py --modelo qwen3.5:4b y uv run evalua.py --modelo qwen3.5:0.8b. Los resultados JSON incluyen cada entrada, el resultado esperado y la respuesta cruda; las etiquetas de evaluación están definidas antes de llamar al modelo.

Se entrega el informe en PDF y el proyecto reproducible en ZIP. La consigna original también solicita un repositorio público: los archivos están preparados para subirlos, pero no se ha publicado una dirección de GitHub desde esta sesión.
