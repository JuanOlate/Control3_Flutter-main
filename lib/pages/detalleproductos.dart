import 'package:flutter/material.dart';
// Define la clase DetalleProductos que extiende StatelessWidget
class DetalleProductos extends StatelessWidget {
  final Map<String, dynamic> producto;
  final Function(Map<String, dynamic>) agregarProductoAlCarrito;
// Constructor que recibe los datos del producto y la función para agregar al carrito
  DetalleProductos(
      {required this.producto, required this.agregarProductoAlCarrito});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de la aplicación con el título 'Detalles del Producto'
      appBar: AppBar(
        title: Text('Detalles del Producto'),
      ),
      // Cuerpo de la página con un fondo degradado
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey[800]!, Colors.blueGrey[300]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // Contenido centrado en la página
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  producto['foto1'],
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
             // Descripción del producto
              Text(
                producto['descripProd'],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
             // Precio del producto
              Text(
                'Precio: \$${producto['precio']}',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
             // Stock del producto
              Text(
                'Stock: ${producto['stock']}',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Crea una copia del producto con la cantidad establecida en 1
                  final productoConCantidad =
                      Map<String, dynamic>.from(producto);
                  productoConCantidad['cantidad'] = 1;
                 // Llama a la función para agregar el producto al carrito
                  agregarProductoAlCarrito(productoConCantidad);
                },
                style: ElevatedButton.styleFrom(),
                child: Text('Agregar al Carrito'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
