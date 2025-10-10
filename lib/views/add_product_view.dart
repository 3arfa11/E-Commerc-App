import 'package:flutter/material.dart';

import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_text_field.dart';

class AddProductView extends StatelessWidget {
  const AddProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            CustomTextField(),
            SizedBox(height: 16),
            Text(
              "Description",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            CustomTextField(),
            SizedBox(height: 16),
            Text(
              "Price",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            CustomTextField(),
            SizedBox(height: 16),
            Text(
              "Category",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 8),
            DropdownMenu(
              width: double.infinity,
              dropdownMenuEntries: [
                DropdownMenuEntry<String>(
                  value: 'Electronics',
                  label: 'Electronics',
                ),
                DropdownMenuEntry<String>(
                  value: "men's clothing",
                  label: "men's clothing",
                ),
                DropdownMenuEntry<String>(
                  value: "women's clothing",
                  label: "women's clothing",
                ),
                DropdownMenuEntry<String>(value: 'jewelery', label: 'jewelery'),
              ],
            ),
            SizedBox(height: 16),
            CustomButton(text: 'Add Product'),
          ],
        ),
      ),
    );
  }
}
