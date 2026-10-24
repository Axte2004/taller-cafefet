Aquí tienes un ejemplo completo de cómo crear una función para gestionar pedidos, utilizando **JavaScript** (que es el estándar más común en desarrollo web).

Este código incluye:
1.  La estructura del objeto `Pedido`.
2.  Una función para **crear** un pedido con validación básica.
3.  Un array para **almacenar** los pedidos.
4.  Funciones auxiliares para listar y calcular el total.

### Código en JavaScript

```javascript
// 1. Definición de la estructura del Pedido
class Pedido {
    constructor(id, cliente, items, fecha) {
        this.id = id;
        this.cliente = cliente;
        this.items = items; // Array de objetos { nombre, precio }
        this.fecha = fecha;
        this.total = 0; // Se calculará automáticamente
    }

    // Método para calcular el total del pedido
    calcularTotal() {
        let suma = 0;
        for (let item of this.items) {
            suma += item.precio;
        }
        this.total = suma.toFixed(2); // Formatear a 2 decimales
    }

    toString() {
        return `Pedido #${this.id} para ${this.cliente}. Total: $${this.total}`;
    }
}

// 2. Función principal para crear pedidos
function crearPedido(cliente, items) {
    // Generar un ID único basado en la fecha actual (ej: 1715623400000)
    const id = Date.now(); 
    
    // Establecer la fecha de hoy
    const fecha = new Date().toLocaleDateString();

    // Crear el objeto Pedido
    const nuevoPedido = new Pedido(id, cliente, items);
    
    // Calcular el total automáticamente
    nuevoPedido.calcularTotal();

    return nuevoPedido;
}

// 3. Simulación de almacenamiento (Array global)
let baseDeDatosPedidos = [];

// Función auxiliar para agregar al almacenamiento
function guardarPedido(pedido) {
    baseDeDatosPedidos.push(pedido);
    console.log(`✅ Pedido guardado exitosamente.`);
}

// 4. Ejemplo de uso
// Supongamos que tenemos una lista de productos
const productos = [
    { nombre: "Hamburguesa", precio: 5.50 },
    { nombre: "Refresco", precio: 2.00 },
    { nombre: "Papitas", precio: 1.50 }
];

// Llamada a la función principal
const miPedido = crearPedido("Juan Pérez", productos);

// Mostrar resultados en consola
console.log("--- Detalles del Pedido ---");
console.log(miPedido.toString());
console.log(`Fecha de creación: ${miPedido.fecha}`);
console.log(`Total calculado: $${miPedido.total}`);

// Guardar en la "base de datos" simulada
guardarPedido(miPedido);

// Verificar que se guardó correctamente
console.log("\n--- Todos los pedidos actuales ---");
baseDeDatosPedidos.forEach((p, index) => {
    console.log(`${index + 1}. ${p

