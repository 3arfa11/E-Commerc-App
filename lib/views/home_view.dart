import 'package:e_commerce/views/categories_view.dart';
import 'package:flutter/material.dart';

import '../core/models/product_model.dart';
import '../core/services/firebase_services.dart';
import '../core/services/product_services.dart';
import '../core/utils/constants.dart';
import '../core/widgets/home_drawer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key, this.userInfo});
  final Map<String, dynamic>? userInfo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Constants.primaryColor,
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () async {}),
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
        ],
        // leading: Builder(
        //   builder: (context) {
        //     return IconButton(
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //       icon: const Icon(Icons.menu, color: Colors.white),
        //     );
        //   },
        // ),
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
                            onTap: () {
                              // Handle tap on the product
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Tapped on ${products[index].title}',
                                  ),
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
