// Importa todas las páginas desde el archivo 'pages.dart'
import '/pages/pages.dart';
// Función principal que inicia la aplicación Flutter
void main() {
  // Ejecuta la aplicación LoginApp
  runApp(LoginApp());
}
// Clase principal de la aplicación que extiende StatelessWidget
class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}
