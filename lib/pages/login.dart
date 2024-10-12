import 'package:flutter/material.dart';
// Importa las páginas necesarias, asegurándote de que RegistroPage esté incluida
import '../pages/pages.dart'; 
// Define la clase LoginPage que extiende StatefulWidget
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
// Estado de la clase LoginPage
class _LoginPageState extends State<LoginPage> {
  TextEditingController _userController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
 // Variable para mostrar un mensaje de error
  bool _showError = false;
 // Método para manejar el inicio de sesión
  void _login() async {
    try {
      final usuario = _userController.text;
      final pass = _passwordController.text;
// Llama al servicio para buscar el usuario
      final userData = await ApiService.buscarUsuario(usuario, pass);
// Verifica si el usuario es válido
      if (userData['valido'] == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => PrincipalPage(userData: userData)),
        );
      } else {
      // Verifica si el usuario es válido
        setState(() {
          _showError = true;
        });
      }
    } catch (e) {
     // Maneja cualquier error que ocurra durante el inicio de sesión
      print('Error en inicio de sesión: $e');
      setState(() {
        _showError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // Barra de la aplicación con el título 'Acceso clientes'
      appBar: AppBar(
        title: const Text('Acceso clientes'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey[800]!, Colors.blueGrey[300]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _userController,
                  decoration: const InputDecoration(
                    labelText: 'Rut / email',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Iniciar sesión'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistroPage()),
                    );
                  },
                  child: Text('Nuevo Usuario'),
                ),
                _showError
                    ? const Text(
                        'Usuario o contraseña incorrectos',
                        style: TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
