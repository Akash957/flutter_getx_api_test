import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/ProductsModel.dart';
import 'item_view_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<ProductsModel> productsList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      if (response.statusCode == 200) {
        setState(() {
          productsList = (json.decode(response.body) as List)
              .map((data) => ProductsModel.fromJson(data))
              .toList();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products'), centerTitle: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                final product = productsList[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemViewScreen(
                            title: product.title.toString(),
                            category: product.category.toString(),
                            price: product.price?.toInt() ?? 0,
                            description: product.description.toString(),
                            image: product.image.toString(),
                          ),
                        ),
                      );
                    },
                    leading: product.image != null && product.image!.isNotEmpty
                        ? Image.network(product.image!,
                            width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.image, size: 50),
                    title: Text(product.title.toString()),
                  ),
                );
              },
            ),
    );
  }
}
