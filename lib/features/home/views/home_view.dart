import 'package:e_commerce/core/models/product_model.dart';
import 'package:e_commerce/core/services/product_services.dart';
import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/core/widgets/home_drawer.dart';
import 'package:e_commerce/core/repository/cart_repository.dart';
import 'package:e_commerce/features/cart/views/cart_view.dart';
import 'package:e_commerce/features/products/views/product_details.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.userInfo});
  final Map<String, dynamic>? userInfo;
  @override
  Widget build(BuildContext context) {
    final repo = CartRepository();

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () async {}),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const CartView()));
            },
          ),
        ],
      ),
      drawer: HomeDrawer(userInfo: userInfo),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            Expanded(
              child: FutureBuilder(
                future: ProductServices().getAllProducts(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.hasData) {
                    List<ProductModel> products = asyncSnapshot.data!;
                    return ListView.builder(
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
                            trailing: IconButton(
                              icon: const Icon(Icons.add_shopping_cart),
                              color: Colors.green,
                              onPressed: () async {
                                try {
                                  await repo.addToCart(
                                    productId: products[index].id,
                                    name: products[index].title,
                                    price: products[index].price,
                                    imageUrl: products[index].imageUrl,
                                    quantity: 1,
                                  );

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${products[index].title} added to cart ✅',
                                      ),
                                    ),
                                  );
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Failed to add to cart: $e',
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      ProductDetails(product: products[index]),
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
            ),
          ],
        ),
      ),
    );
  }
}
