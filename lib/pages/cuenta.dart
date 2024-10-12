// Importa la biblioteca de Flutter para crear interfaces de usuario
import 'package:flutter/material.dart';
// Importa la página de inicio de sesión
import 'login.dart';
// Define la clase CuentaPage que extiende StatelessWidget
class CuentaPage extends StatelessWidget {
    // Datos del usuario que se mostrarán en la página
  final Map<String, dynamic> userData;
 // Constructor que recibe los datos del usuario
  CuentaPage({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuenta'),
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
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.person, size: 50),
                    title: Text('${userData['nombre']} ${userData['apellido']}',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    // Muestra la dirección y el email del usuario
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text('Dirección: ${userData['direccion']}'),
                        Text('Email: ${userData['email']}'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // Barra de navegación inferior con un botón para cerrar sesión
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueGrey[700],
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
            style: ElevatedButton.styleFrom(),
            child: Text('Cerrar sesión'),
          ),
        ),
      ),
    );
  }
}
