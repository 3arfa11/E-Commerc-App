import 'package:e_commerce/core/models/cart_item_model.dart';
import 'package:e_commerce/core/repository/cart_repository.dart';
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final CartRepository repo = CartRepository();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () async {
              await repo.clearCart();
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Cart cleared')));
            },
          ),
        ],
      ),
      body: StreamBuilder<List<CartItemModel>>(
        stream: repo.cartStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data ?? const <CartItemModel>[];
          if (items.isEmpty) {
            return const Center(child: Text('Your cart is empty.'));
          }
          final double total = items.fold(
            0.0,
            (sum, i) => sum + (i.price * i.quantity),
          );
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 0),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ListTile(
                      leading: item.imageUrl.isEmpty
                          ? const Icon(Icons.image_not_supported)
                          : Image.network(
                              item.imageUrl,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                            ),
                      title: Text(item.name),
                      subtitle: Text('Price: ${item.price.toStringAsFixed(2)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () async {
                              await repo.updateQuantity(
                                item.id,
                                item.quantity - 1,
                              );
                            },
                          ),
                          Text(item.quantity.toString()),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () async {
                              await repo.updateQuantity(
                                item.id,
                                item.quantity + 1,
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () async {
                              await repo.removeFromCart(item.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: ${total.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Checkout not implemented'),
                          ),
                        );
                      },
                      child: const Text('Checkout'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
