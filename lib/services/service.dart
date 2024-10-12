import 'dart:convert';
import 'package:http/http.dart' as http;
// Define la clase ApiService que contiene métodos estáticos para interactuar con la API
class ApiService {
  static Future<void> actualizarStockProductos(
     // Método para actualizar el stock de productos
      List<Map<String, dynamic>> productos) async {
    // URL de la API para actualizar el stock de productos
    var url = Uri.parse(
        'https://sandeonline.cl:2082/taskfocus/multimedia/api/Registro/GrabarActualizaStockproductos');
    // Mapea la lista de productos para crear una lista con el formato requerido por la API
    List<Map<String, dynamic>> productosParaActualizar =
        productos.map((producto) {
      return {
        "codigo": producto['codigoProd'],
        "cantidad": int.tryParse(producto['cantidad'].toString()) ?? 0
      };
    }).toList();

    try {
      // Realiza una solicitud POST a la API con los datos de los productos
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(productosParaActualizar),
      );
      // Verifica si la respuesta no es exitosa (código diferente de 200)
      if (response.statusCode != 200) {
        throw Exception(
            'Falló la actualización de stock. Código de respuesta: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al actualizar stock: $e');
      throw Exception('Error al actualizar stock: $e');
    }
  }
   // Método para buscar un usuario en la API
  static Future<Map<String, dynamic>> buscarUsuario(
      String usuario, String pass) async {
    final url =
        'https://sandeonline.cl:2082/taskfocus/multimedia/api/Registro/BusquedaUsuario?usuario=$usuario&pass=$pass';
    // Realiza una solicitud GET a la API
    final response = await http.get(Uri.parse(url));
     // Decodifica la respuesta JSON y devuelve el primer elemento
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return jsonData[0];
    } else {
      throw Exception('Error al buscar usuario: ${response.reasonPhrase}');
    }
  }
  // Método para obtener la lista de productos desde la API
  static Future<List<dynamic>> obtenerListaProductos() async {
    final response = await http.get(Uri.parse(
        'https://sandeonline.cl:2082/taskfocus/multimedia/api/Registro/listaProductos'));
  // Verifica si la respuesta es exitosa (código 200)
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener la lista de productos');
    }
  }
  // Método para crear un nuevo usuario en la API
  static Future<void> crearNuevoUsuario(Map<String, dynamic> userData) async {
    var url = Uri.parse(
        'https://sandeonline.cl:2082/taskfocus/multimedia/api/Registro/GrabarNuevoUsuario');

    var payload = json.encode([
      {
        "nombre": userData['nombre'],
        "apellido": userData['apellido'],
        "direccion": userData['direccion'],
        "email": userData['email'],
        "rut": userData['rut'],
        "pass": userData['pass'],
      }
    ]);

    try {
      var response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: payload,
      );
   // Verifica si la respuesta no es exitosa (código diferente de 200)
      if (response.statusCode != 200) {
        throw Exception(
            'Falló la creación del usuario. Código de respuesta: ${response.statusCode}. Detalles: ${response.body}');
      } else {
        print('Usuario creado exitosamente.');
      }
    } catch (e) {
      print('Error al crear usuario: $e');
      throw Exception('Error al crear usuario: $e');
    }
  }
}
