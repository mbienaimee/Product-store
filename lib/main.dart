import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'theme.dart';
import 'product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkTheme = false;

  void toggleTheme() {
    setState(() {
      isDarkTheme = !isDarkTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: isDarkTheme ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: CatalogPage(toggleTheme: toggleTheme), // Pass the toggleTheme function
    );
  }
}

class CatalogPage extends StatelessWidget {
  final VoidCallback toggleTheme; // Change type to VoidCallback

  CatalogPage({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    final List<Product> products = [
      Product(name: 'Product 1', imageUrl: 'assets/product1.jpg', price: 29.99),
      Product(name: 'Product 2', imageUrl: 'assets/product2.jpg', price: 39.99),
      Product(name: 'Product 3', imageUrl: 'assets/product3.jpg', price: 19.99),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Store'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: toggleTheme, // This now matches the expected type
          ),
        ],
      ),
      body: ProductGrid(products: products),
    );
  }
}

class ProductGrid extends StatelessWidget {
  final List<Product> products;

  ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(milliseconds: 300),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(products[index].name),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(products[index].imageUrl, height: 100, width: 100),
                      SizedBox(height: 8),
                      Text('Price: \$${products[index].price.toStringAsFixed(2)}'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            child: Card(
              child: Column(
                children: [
                  Image.asset(products[index].imageUrl, height: 100, width: 100),
                  SizedBox(height: 8),
                  Text(products[index].name),
                  Text('\$${products[index].price.toStringAsFixed(2)}'),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
