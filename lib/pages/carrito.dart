// Importa la biblioteca de Flutter para crear interfaces de usuario
import 'package:flutter/material.dart';
// Importa la página de pago
import 'pago.dart';
// Define la clase CarritoPage que extiende StatefulWidget
class CarritoPage extends StatefulWidget {
  final List<Map<String, dynamic>> carrito;
// Constructor que recibe la lista de productos
  CarritoPage({required this.carrito});

  @override
  _CarritoPageState createState() => _CarritoPageState();
}
// Estado de la clase CarritoPage
class _CarritoPageState extends State<CarritoPage> {
  int totalCarrito = 0;

  @override
  void initState() {
    super.initState();
    // Actualiza el total del carrito al iniciar el estado
    actualizarTotalCarrito();
  }
// Método para actualizar el total del carrito
  void actualizarTotalCarrito() {
    setState(() {
      totalCarrito = widget.carrito.fold(
        0,
        (previousValue, producto) =>
            previousValue +
            (int.tryParse(producto['cantidad'].toString()) ?? 0) *
                (int.tryParse(producto['precio'].toString()) ?? 0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de la aplicación con el título 'Carrito'
      appBar: AppBar(
        title: Text('Carrito'),
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
             // Lista de productos en el carrito
        child: ListView.builder(
          itemCount: widget.carrito.length,
          itemBuilder: (context, index) {
            final producto = widget.carrito[index];
            final precioProducto =
                double.tryParse(producto['precio'].toString()) ?? 0;
            final cantidad = int.tryParse(producto['cantidad'].toString()) ?? 1;
            final totalProducto = cantidad * precioProducto;
            return ListTile(
              // Imagen del producto o un contenedor gris si no hay imagen
              leading: producto['foto1'] != ''
                  ? Image.network(producto['foto1'])
                  : Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(color: Colors.grey[300])),
              // Descripción del producto            
              title: Text(producto['descripProd'],
                  style: TextStyle(color: Colors.white)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Stock: ${producto['stock']}',
                      style: TextStyle(color: Colors.white70)),
                  Text('Precio: \$${precioProducto.toString()}',
                      style: TextStyle(color: Colors.white70)),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (cantidad > 1) {
                              producto['cantidad'] = cantidad - 1;
                              actualizarTotalCarrito();
                            }
                          });
                        },
                      ),
                      Text('$cantidad', style: TextStyle(color: Colors.white)),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white),
                        onPressed: () {
                          setState(() {
                            if (cantidad < producto['stock']) {
                              producto['cantidad'] = cantidad + 1;
                              actualizarTotalCarrito();
                            }
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            widget.carrito.removeAt(index);
                            actualizarTotalCarrito();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Total: \$${totalProducto.toString()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey[800],
        child: Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Carrito: \$${totalCarrito.toString()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PagoPage(carrito: widget.carrito)),
                  );
                },
                style: ElevatedButton.styleFrom(),
                child: Text('Pagar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
