import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kategori')),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.fastfood), title: Text('Makanan')),
          ListTile(leading: Icon(Icons.directions_bus), title: Text('Transportasi')),
          ListTile(leading: Icon(Icons.shopping_bag), title: Text('Belanja')),
          ListTile(leading: Icon(Icons.payments), title: Text('Gaji')),
        ],
      ),
    );
  }
}
