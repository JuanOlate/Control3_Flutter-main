import '../pages/pages.dart';
// Define una clase StatefulWidget para la página de pago.
class PagoPage extends StatefulWidget {
   // Lista de productos en el carrito, cada uno representado como un mapa con claves y valores dinámicos.
  final List<Map<String, dynamic>> carrito;
// Constructor que requiere la lista del carrito.
  PagoPage({required this.carrito});

  @override
  _PagoPageState createState() => _PagoPageState();
}
// Estado asociado a la clase PagoPage.
class _PagoPageState extends State<PagoPage> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
   // Libera los recursos del controlador cuando el widget se elimina.
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   // Calcula el total del carrito sumando el precio total de cada producto.
    int totalCarrito = widget.carrito.fold(
      0,
      (previousValue, producto) =>
          previousValue +
          (int.tryParse(producto['cantidad'].toString()) ?? 0) *
              (int.tryParse(producto['precio'].toString()) ?? 0),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Pago'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico',
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Total a Pagar: \$${totalCarrito.toString()}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 20),
             // Botón para realizar el pago y enviar el correo electrónico.
            ElevatedButton(
              onPressed: () async {
                await _enviarCorreo(context, _emailController.text);
              },
              child: Text('Pagar'),
            ),
          ],
        ),
      ),
    );
  }
// Función para enviar el correo electrónico de confirmación de compra.
  Future<void> _enviarCorreo(BuildContext context, String destinatario) async {
    const String username = 'soporte@sande.cl';
    const String password = 'Sande1771';
// Configuración del servidor SMTP de Gmail.
    final smtpServer = gmail(username, password);
// Cuerpo del correo electrónico con la lista de productos comprados.
    String cuerpoCorreo = 'Productos comprados:\n\n';
    for (var producto in widget.carrito) {
      cuerpoCorreo += '${producto['descripProd']} - \$${producto['precio']}\n';
    }
// Configuración del mensaje de correo electrónico.
    final message = Message()
      ..from = Address(username)
      ..recipients.add(Address(destinatario))
      ..subject = 'Confirmación de compra'
      ..text = cuerpoCorreo;

    try {
     // Envía el correo electrónico.
      final sendReport = await send(message, smtpServer);
      print('Correo electrónico enviado: ${sendReport.toString()}');

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Mensaje enviado'),
            content: Text('Correo electrónico enviado con éxito'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  // Actualiza el stock de productos y navega a la página de inicio de sesión.
                  await ApiService.actualizarStockProductos(widget.carrito);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginApp()),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } catch (e) {
     // Muestra un mensaje de error si el envío del correo falla.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al enviar el correo electrónico: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
