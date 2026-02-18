import 'package:flutter/material.dart';

void main() {
  runApp(const DeckTCGApp());
}

class DeckTCGApp extends StatelessWidget {
  const DeckTCGApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeckTCG Store',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. BARRA SUPERIOR (AZUL)
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A76BE), // Color azul similar al boceto
        leading: const Icon(Icons.menu, color: Colors.black, size: 30),
        title: const Text(
          'DeckTCG',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: const Icon(Icons.shopping_cart_outlined, color: Colors.black, size: 30),
          ),
        ],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 2. BANNER PRINCIPAL (Cuadro grande)
            Container(
              margin: const EdgeInsets.all(16.0),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                  image: NetworkImage('https://images.pokemontcg.io/swsh11/logo.png'), 
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // 3. FILA DE FILTRAR Y SELECTOR DE VISTA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Botón Filtrar
                  Row(
                    children: const [
                      Icon(Icons.tune, color: Colors.blueGrey),
                      SizedBox(width: 8),
                      Text("Filtrar", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  // Selector de Vista (Icono de rejilla)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.grid_view_rounded, color: Colors.black),
                        SizedBox(width: 10),
                        Icon(Icons.crop_square, color: Colors.black54),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 4. GRILLA DE PRODUCTOS (Cartas de Pokémon)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                shrinkWrap: true, // Para que funcione dentro de un SingleChildScrollView
                physics: const NeverScrollableScrollPhysics(), 
                crossAxisCount: 2, // Dos columnas como en tu dibujo
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8,
                children: const [
                  ProductCard(imageUrl: 'https://images.pokemontcg.io/base1/4.png'), // Charizard
                  ProductCard(imageUrl: 'https://images.pokemontcg.io/base1/2.png'), // Blastoise
                  ProductCard(imageUrl: 'https://images.pokemontcg.io/swsh1/1.png'),  // Celebi
                  ProductCard(imageUrl: 'https://images.pokemontcg.io/base1/15.png'), // Venusaur
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Widget personalizado para las cartas
class ProductCard extends StatelessWidget {
  final String imageUrl;
  const ProductCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.blueGrey.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          // Indicador de carga mientras baja la imagen
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}