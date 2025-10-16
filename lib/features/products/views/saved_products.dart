import 'package:e_commerce/core/models/saved_item_model.dart';
import 'package:e_commerce/core/repository/saved_repository.dart';
import 'package:flutter/material.dart';

class SavedProductsView extends StatelessWidget {
  const SavedProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = SavedRepository();
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Products'), centerTitle: true),
      body: StreamBuilder<List<SavedItemModel>>(
        stream: repo.savedStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data ?? const <SavedItemModel>[];
          if (items.isEmpty) {
            return const Center(child: Text('No saved products yet.'));
          }
          return ListView.separated(
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                leading: item.imageUrl.isEmpty
                    ? const Icon(Icons.image_outlined)
                    : Image.network(
                        item.imageUrl,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                title: Text(item.name),
                subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () async {
                    await repo.removeSaved(item.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
