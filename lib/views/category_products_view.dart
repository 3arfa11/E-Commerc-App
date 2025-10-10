import 'package:flutter/material.dart';

import '../core/services/product_services.dart';

class CategoryProductsView extends StatelessWidget {
  const CategoryProductsView({super.key, required this.category});

  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category), centerTitle: true),
      body: FutureBuilder(
        future: ProductServices().getProductsByCategory(category),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.hasData) {
            List products = asyncSnapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(
                      products[index].imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.fill,
                    ),
                    title: Text(products[index].title),
                    subtitle: Text(
                      '\$${products[index].price.toStringAsFixed(2)}',
                    ),
                    onTap: () {
                      // Handle tap on the product
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Tapped on ${products[index].title}'),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
