import '../pages/pages.dart';
// Define una clase StatefulWidget para la página principal.
class PrincipalPage extends StatefulWidget {
  // Datos del usuario, representados como un mapa con claves y valores dinámicos.
  final Map<String, dynamic> userData;
// Constructor que requiere los datos del usuario.
  PrincipalPage({required this.userData});

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}
// Estado asociado a la clase PrincipalPage.
class _PrincipalPageState extends State<PrincipalPage> {
  int _selectedIndex = 0;
 // Lista de productos en el carrito.
  List<Map<String, dynamic>> _carrito = []; // Lista de productos en el carrito
 // Controlador para el campo de texto de búsqueda.
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Muestra el campo de búsqueda si el índice seleccionado es 0, de lo contrario muestra un texto vacío.
        title: _selectedIndex == 0 ? _buildSearchField() : Text(''),
      ),
      body: _selectedIndex == 0
          ? ListaProductos(
              agregarProductoAlCarrito: _agregarProductoAlCarrito,
              searchTerm: _searchController.text,
            )
          : _selectedIndex == 1
              ? CarritoPage(carrito: _carrito)
              : CuentaPage(userData: widget.userData),
       // Barra de navegación inferior con tres elementos.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrito',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Cuenta',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
 // Construye el campo de búsqueda.
  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
        hintText: 'Buscar productos...',
      ),
       // Actualiza el estado cuando el texto de búsqueda cambia.
      onChanged: (value) {
        setState(() {});
      },
    );
  }
  // Actualiza el índice seleccionado cuando se toca un elemento de la barra de navegación.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
// Agrega un producto al carrito.
  void _agregarProductoAlCarrito(Map<String, dynamic> producto) {
    setState(() {
      _carrito.add(producto);
    });
  }
}
