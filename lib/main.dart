import 'package:flutter/material.dart';

// --- Colores Personalizados ---
const Color kPetshopOrange = Color(
  0xFFF09A4D,
); // Naranja principal del banner y botones
const Color kLightBackground = Color(
  0xFFFFEAD0,
); // Fondo de color crema/naranja claro
const Color kDarkText = Color(
  0xFF333333,
); // Color oscuro para los textos principales

void main() {
  runApp(const PetShopApp());
}

class PetShopApp extends StatelessWidget {
  const PetShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetShop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor:
            kLightBackground, // Establece el color de fondo
        useMaterial3: true,
      ),
      home: const PetShopHome(),
    );
  }
}

// --- WIDGET PRINCIPAL DE LA PANTALLA ---
class PetShopHome extends StatelessWidget {
  const PetShopHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      // El SingleChildScrollView permite que toda la pantalla sea deslizable
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: SearchBarWidget(), // Barra de búsqueda
            ),
            _buildDiscountBanner(), // Banner de descuento
            const SizedBox(height: 20),
            _buildPopularProductsTitle(), // Títulos de la sección
            const SizedBox(height: 10),
            _buildProductSection(), // Lista horizontal de productos
          ],
        ),
      ),
    );
  }

  // --- 1. AppBar (Barra Superior) ---
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: kLightBackground,
      elevation: 0,
      title: Row(
        children: const [
          Icon(Icons.pets, color: kPetshopOrange, size: 30),
          SizedBox(width: 8),
          Text(
            'PetShop',
            style: TextStyle(
              color: kDarkText,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ],
      ),
      actions: const [
        // Ícono de Carrito
        IconButton(
          icon: Icon(Icons.shopping_cart, color: kDarkText),
          onPressed: null,
        ),
        // Ícono de Perfil
        IconButton(icon: Icon(Icons.person, color: kDarkText), onPressed: null),
      ],
    );
  }

  // --- 3. Banner de Descuento ---
  Widget _buildDiscountBanner() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(
          0xFFF98B35,
        ), // Naranja un poco más oscuro que el botón
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '20% Descuento en la comprra de comida para gato.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w900,
              height: 1.1,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Cortesía de Gato barato, "Le dura un buen rato".',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // --- 4. Títulos de Sección ---
  Widget _buildPopularProductsTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: const [
          Text(
            'Productos',
            style: TextStyle(
              color: kDarkText,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 15), // Espacio horizontal entre los títulos
          Text(
            'Populares',
            style: TextStyle(
              color: kDarkText,
              fontSize: 22,
              fontWeight:
                  FontWeight.normal, // Un poco menos de énfasis en "Populares"
            ),
          ),
        ],
      ),
    );
  }

  // --- 5. Lista Horizontal de Productos ---
  Widget _buildProductSection() {
    // Datos de ejemplo
    final List<Map<String, dynamic>> products = [
      {'name': 'Fancy pets', 'price': '120.50', 'imagePlaceholder': Icons.toys},
      {
        'name': 'Shampoo para Mascotas',
        'price': '120.50',
        'imagePlaceholder': Icons.shower,
      },
      {
        'name': 'Comida Premium',
        'price': '350.99',
        'imagePlaceholder': Icons.fastfood,
      },
      {
        'name': 'Collar de Lujo',
        'price': '85.00',
        'imagePlaceholder': Icons.style,
      },
    ];

    return SizedBox(
      height: 260, // Altura fija para la lista horizontal
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(
            name: products[index]['name'] as String,
            price: products[index]['price'] as String,
            icon: products[index]['imagePlaceholder'] as IconData,
          );
        },
      ),
    );
  }
}

// --- WIDGET REUTILIZABLE PARA LA BARRA DE BÚSQUEDA ---
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          // Ícono de Menú (Hamburguesa)
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(Icons.menu, color: Colors.grey),
          ),
          // Campo de Texto de Búsqueda
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscador...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
              ),
            ),
          ),
          // Ícono de Búsqueda
          IconButton(
            icon: const Icon(Icons.search, color: Colors.grey),
            onPressed: () {
              // Lógica de búsqueda
            },
          ),
        ],
      ),
    );
  }
}

// --- WIDGET REUTILIZABLE PARA LA TARJETA DE PRODUCTO ---
class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final IconData icon; // Usamos un icono como placeholder de imagen

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(left: 16.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder de Imagen
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Icon(icon, size: 50, color: kPetshopOrange),
            ),
          ),
          const SizedBox(height: 10),
          // Nombre del Producto
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: kDarkText,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          // Precio
          Text(
            '\$$price',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: kDarkText,
            ),
          ),
          const Spacer(), // Empuja el botón hacia abajo
          // Botón "Ver más"
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Acción al presionar el botón
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPetshopOrange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              child: const Text('Ver más', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      ),
    );
  }
}
