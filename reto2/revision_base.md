Al revisar la función `crear_pedido` de CafeFET, se pueden identificar varios defectos lógicos y de diseño que podrían causar fallos en el sistema o comportamientos inesperados. A continuación, se detallan los puntos críticos:

### 1. Fallo de lógica en la verificación del saldo (Error de signo)
La condición actual es:
```python
if est.saldo - sum(p.precio for p in productos) < -1000:
    return False
```
*   **El problema:** Esta expresión verifica si el saldo restante es **menor que -1000**. Esto significa que la función devolverá `False` (rechazará el pedido) solo si el saldo queda negativo en una cantidad muy grande (por ejemplo, -2000). Sin embargo, el objetivo lógico usual es permitir pagos con un pequeño saldo negativo (débito hasta cierto límite), no rechazar pedidos por tener un saldo ligeramente negativo.
*   **Lo correcto:** Debería verificar si el saldo restante es **mayor o igual a -1000** (es decir, `>= -1000`). Si el saldo queda en -500, el pedido debería ser válido; con la lógica actual, se rechazaría incorrectamente.

### 2. Falta de validación de tipos de datos
La función asume que `est.saldo`, `p.precio` y `hora` son números o enteros válidos sin verificar sus tipos.
*   **El problema:** Si alguno de estos valores es un string (ej. `"100"`) o un objeto con métodos matemáticos incorrectos, la operación aritmética (`sum`, `-`) lanzará una excepción `TypeError`.
*   **Recomendación:** Se deben incluir comprobaciones explícitas para asegurar que todos los operandos sean del tipo esperado antes de realizar cálculos.

### 3. Falta de validación de rangos de productos
La función comprueba si hay más de 6 productos (`len(productos) > 6`), pero no valida si los productos en la lista son válidos para el sistema (ej. ¿son objetos `Producto`? ¿Tienen precio definido?).
*   **El problema:** Si se pasa una lista con elementos nulos, cadenas o objetos sin atributo `.precio`, la línea `sum(p.precio for p in productos)` fallará inmediatamente.

### 4. Falta de validación del horario (Lógica inversa)
La condición actual es:
```python
return 7 <= hora <= 18
```
*   **El problema:** Esta lógica funciona correctamente solo si `hora` es un entero o número flotante dentro del rango [7, 18]. Si `hora` es un objeto de tiempo (como `datetime.time`) o un string ("09:00"), la comparación fallará. Además, no se maneja el caso donde `hora` sea `None`.

### 5. Falta de validación del estado del restaurante (`est`)
La función utiliza `est.saldo`, pero no verifica si el objeto `est` es válido o si tiene el atributo `saldo`.
*   **El problema:** Si `est` es `None` o carece del atributo `saldo`, se

